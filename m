Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F28A6BF92C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 10:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCRJIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 05:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCRJIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 05:08:31 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6A124BC8;
        Sat, 18 Mar 2023 02:08:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B36285C016C;
        Sat, 18 Mar 2023 05:08:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 18 Mar 2023 05:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1679130492; x=1679216892; bh=sqGrH9AvBNgztCnhiLWyU9ykzV8JgafnPoz
        z27BeCm8=; b=r6PoI9GbafoXODI5wpFQtvhqCYIbdZWhsk0Z7ElJJTUKsBQpYn2
        Ode+YilJeVD+54bk7RO9iqKKs4BCOTDBLtiFlzwsXuUjZJ4lw238xQwiczmAdJzN
        zG4URauxC33obSxz/QufokFjViTwcpkAE0f3p1MWhipXrmHBvaMIbwysY1HEkQJP
        gt8UVK2vJabDrD08skXIAitomdPGfiGZfVmk6YG64AabzxdQtMNARqvvM8/7Vuc6
        LFDFQE1kS0jfbsnDOePr5upmmY+LOTfdB1D+ChYqO4m0bMJGE8gAc20lbo4vWlm7
        9HBfGHqkL4lSHKNU4riX9/SMIgLDK5qpErA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679130492; x=1679216892; bh=sqGrH9AvBNgztCnhiLWyU9ykzV8JgafnPoz
        z27BeCm8=; b=ALgAwfVlw0rg1LJolgBO63qcgsx6OFhNW/qpu/yH0WuxTh/zFVW
        hz4XsUN+BPsmsevMcQx5/Y+j3moRBXQZvh+OGY/ZFHZxu5gwa52fQOGDhhne+JBC
        yopVZXTAmeI5KWGh/YQRlvy6gjNjt6Rj7UEgDglpG5O1iJma72Ee6MYleu9WzBKO
        mxcyOz/H9uLYeBpkYFWgESy7SY+utKfcs6CLSEl9pOGSLV/zYaDzHVfqfcQSzpud
        saM/JcZ5vZd1wSioPrhBMKW7X4tkpWS+R1fuVLB084DJW5pQWd9qINeGWWiKdqNP
        0rVUg5z3fjfASWX6Q4s5543bd2fT6LWPEMw==
X-ME-Sender: <xms:e38VZGShd-0DmUZZL2czFGIVU6cNCQLHXas-jamhZDGtEiohZ-5uqA>
    <xme:e38VZLyrFV_amNuf4kGeRmBPFpSwQh6aY-3_6YXpn7SZDlJ31iNJ8tMWIwwi2ls3V
    avtWbBks-vzGnMqtm8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeffedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeu
    feefieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:e38VZD1fNUWFvFSbebieEMt9jjii7BSrdlXHfW39Vr3AZW5BOrhwDA>
    <xmx:e38VZCDHaWJBBexLNNZjXswKto_iKoYKFybnUKa1px71KrBs64Wnhg>
    <xmx:e38VZPhMtH33aj5xLjWV7vpbamm_R99NGv3irS1neUGf_wFPC8YIGg>
    <xmx:fH8VZKTgzOFS_XrKE3c73tP9vZTgE_Qyl0wb2H3NlciLVfmYh87-nA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CD0BEB60086; Sat, 18 Mar 2023 05:08:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <adf72f73-23c9-4260-b649-755af4068a02@app.fastmail.com>
In-Reply-To: <f21df56b-43b8-a48e-ab8f-e0cf2b163976@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <f2699aa1-4d8a-48c0-b332-484db0b04252@app.fastmail.com>
 <1a1277ac-4ae5-eaab-01c3-0242c12be76b@gmail.com>
 <6ed7e89f-2d2c-4134-9c6f-a9d18e2fc8a8@app.fastmail.com>
 <a90fc6f6-df95-3a4f-da5b-ebdafbe7dd34@linaro.org>
 <f21df56b-43b8-a48e-ab8f-e0cf2b163976@gmail.com>
Date:   Sat, 18 Mar 2023 10:07:50 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH 00/15] Introduce Nuvoton ma35d1 SoC
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023, at 04:07, Jacky Huang wrote:
> On 2023/3/18 =E4=B8=8A=E5=8D=88 12:06, Krzysztof Kozlowski wrote:
>> On 17/03/2023 14:21, Arnd Bergmann wrote:
>>> I only now saw that you had already submitted this several times
>>> at the beginning of last year, and this is technically 'v5'
>>> of the series, and it would make sense to add 'v6' to the subject
>>> next time and link back to the previous [1] and this[2] submission
>>> on lore.kernel.org.
>> ... and address previous feedback. Or at least make it clear in
>> changelog that you addressed it, so our review was not ignored.
>>
>
> Of course, I will add back the changelog.
>
> And, I have a question. If subsequent modifications made to a patch,=20
> should the
>
> "Reviewed-by" still be valid? Can we keep it?

In general yes, but it's a bit of a grey area and you have
to apply common sense. Examples where I would drop the
Reviewed-by tag are

- if you changed something based on feedback from a reviewer and
  they provided a Reviewed-by tag based on that changed, but then
  another person asked you change the same thing differently, or
  back to the original version

- if you combine a patch with another one that was not also
  reviewed by the same person.

      Arnd

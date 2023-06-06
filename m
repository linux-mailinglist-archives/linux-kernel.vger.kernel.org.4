Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F1F72373B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjFFGJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjFFGIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:08:50 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D9C83;
        Mon,  5 Jun 2023 23:08:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D9E75C01FC;
        Tue,  6 Jun 2023 02:08:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 02:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686031729; x=1686118129; bh=jWnd+Tu93Ydyd0XWIfSLCz4ZEAGnqPSE7yv
        GS7uwiVk=; b=SSoZ+7I0c9Fwv2n5Hn515aFeknC06tGYFxgzpP1yl+fz4c4+cfz
        685JrWK/U9/LC0FTpCnJg20SeaYXRFSKBIim3AY8EE6zoHfGvAhBnALYYvYRKIq3
        qbi2MIa4tR7v72JR6JDzblr8WLQvqRqpfhytNZ2YjSY72XguwvR9QR/YlNZye8iH
        uZF6vvrKihuAuyM37QhIjvY+kHKYctuTI9XSH1VFoPZ6q+BIAVcx7KF0T+71S6zu
        dZogg9CxBSwUsL9uqpDALybi1q15TZJsyF/DFRQHrtKVEMotcb1EJxJhUiBXphXS
        ITwi9nnJJDmNg6sigEUd2p5fogCx+JqkjcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686031729; x=1686118129; bh=jWnd+Tu93Ydyd0XWIfSLCz4ZEAGnqPSE7yv
        GS7uwiVk=; b=eYsVkHkjsOb7rRAyl98E0Jcwr8/9bmekhSRQ8hv9jldeDtxXBrL
        mtQ1zNy6Gk6YjffscBlEiUrsHktliRFYzGP+CwvkTsQz7GgA9o1+F+jmiFlfL+kn
        7cQWGecJkl2Gr7mIn/JF/luqhuhlyZXQ+XRou0etPp3mrcYSDovzShCch8iMwHiE
        HDz9CzpFqxDlExv++HYgqSiTbJMe3Njhj0S0PIYoXxzyPaIqAhv2SIflF28V4oZj
        IZ6yhmC3jjbi3tIU2ZkV3zCBaQEB0jYteN5+Q2m3q5YeVmyWO6LQjcdWuW693CKj
        8BpjJTNpuZ4HkDVxAG0sJAf9cT3YTAXCslg==
X-ME-Sender: <xms:cM1-ZIIwjYF1VFsJK7COwEnOuf67AdF6Fw4SpR1SWTedqOz6jIYqnw>
    <xme:cM1-ZIKPgL7wM-O7vXlSfBRo9AThdEPpx7OIB1PjY4KGBP5PmyMwwiJeBbkMp8ntF
    hxR9WPfAL41op40bj0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cM1-ZIs-5JwC2kaEVBxOYGJuU0ODDRl3q7w8BCh3mQ_aVh1UJQD8lg>
    <xmx:cM1-ZFbvZlSVBfwhmLps7V0XV2lVrMaAAE8G_91IOG1thZ5-tClb0g>
    <xmx:cM1-ZPbvZt6NWfUJFC9cZBG0Aqn0GJ18m18X8TLAMShrXceHc2TycQ>
    <xmx:cc1-ZMSRFsAbeEkqS__3eaSeemwET6EzJI8YKz11xBNnI-ai0-fBNg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 38310B60086; Tue,  6 Jun 2023 02:08:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <4f85ea74-5788-471d-bf3f-01402652a6b8@app.fastmail.com>
In-Reply-To: <c57453ce-341c-ef89-5e71-58ad63466b11@gmail.com>
References: <20230605040749.67964-1-ychuang570808@gmail.com>
 <9dc45c49-02aa-4e63-a176-97e3536f14f4@app.fastmail.com>
 <c57453ce-341c-ef89-5e71-58ad63466b11@gmail.com>
Date:   Tue, 06 Jun 2023 08:08:27 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Tomer Maimon" <tmaimon77@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, soc@kernel.org, schung@nuvoton.com,
        mjchen@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH v13 00/10] Introduce Nuvoton ma35d1 SoC
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023, at 02:22, Jacky Huang wrote:
> On 2023/6/5 =E4=B8=8B=E5=8D=88 08:00, Arnd Bergmann wrote:
>> On Mon, Jun 5, 2023, at 06:07, Jacky Huang wrote:
>
> I'm glad to see that these patches have finally been accepted.
> Thank you very much for all the assistance you have provided.
> Once the device tree is merged, we will start submitting drivers
> such as pinctrl, gpio, rtc, and so on.

I think you can start submitting all the drivers to their
respective maintainers now, just mention that the SoC support
is currently in linux-next in case they get confused about the
dependencies.

     Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53A8714B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjE2OEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjE2OE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:04:27 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4AE19F;
        Mon, 29 May 2023 07:04:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6D0693200976;
        Mon, 29 May 2023 10:03:30 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 29 May 2023 10:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685369010; x=1685455410; bh=nvqrlHPnnrFfgBtplfsIN8YSU9SAn7OIOxJ
        dEW6JUUw=; b=kn61Jo3stjP6LminfFKgeDnaf0b48DUFYk+akJRWF+wBEfuC1xp
        go5XlwQ+87GxAORySg/c0E21RALfrA56B9HkDYqxwB8ktnOsakQiJHXCqBVqqsx0
        e1enloHeoopjwOJGuCV7m7MScKa4woFIbBzH/ZLbV+PiIzuSD2CRGzrWqyywGh/r
        /kFhFCbtIvz3ZmRPbdn8HBEXuGOM8rKUiwaiAEEdRlomynk3IF2/8xH9bGuuYYDI
        s7qGDg/MwekDBZoVyKT8+tKlHjzMwOo8cWT44dHzKpMmfiTkysRxiTAJRsA+dcBR
        UUMqFimNViXNoopYz8EAwLrYnZMvqy3qwWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685369010; x=1685455410; bh=nvqrlHPnnrFfgBtplfsIN8YSU9SAn7OIOxJ
        dEW6JUUw=; b=ckTrPuoJHVnbe6revg6NpkA+JuGbnnKYCSYUrNihx66eEONsLyU
        beIkM5oVZi0U+KMOfMfN/3pU1YUd9jF6fxe/LOYA1cMrNibqx0aFzinDCJVnNHXR
        HIE7W/R+WW23y6GU7553jk1TVouUnIHbeRJCv/vkjsUUDcf3JJD7+mEf66dEMBXj
        4XZncuF07Z2vZE6uXiI4hXjue5ErnXXYDWuzhts5BRiXElKeBiR3jzg2lYoiXZQO
        tdz/63Mp1OmQY9HU2gUox2w/OI86t/KUISXfvOpFJ3MAaXcp050qtRK4h1/HeZA/
        u7nKR9jW26F1lGp6XgVD6AGjfKc3E/jhdsw==
X-ME-Sender: <xms:sbB0ZFPPADSqHAdXobUx9dm7AtzZnWsDLCwvjyHseNhOKsMnj3oPgw>
    <xme:sbB0ZH_0FkFN3rJ8-WZQusQ5Lw46RnN6-nEoyp0GYd5sbZOpcp0hHY7TqPMo80F5R
    NheYSfh8lBfZ0bH8yc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:sbB0ZESM5NRp3ADjISCwNOhm3pulIQ1Abz0Ve3EfUMu2TAZVdQZLIQ>
    <xmx:sbB0ZBs96Ibxj7XA7sFazKv29EsluhoNat1s2IyBOBzXbXkzorjjag>
    <xmx:sbB0ZNcK8BLDLaoj1qTo6aXXAEenA03WmSi2tYYKE0NjmDzvwCv4FQ>
    <xmx:srB0ZOr7il7a_URGfqGH4v92w0rXo8jK7yXana217QBUm6HbybrSHw>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7C020C60091; Mon, 29 May 2023 10:03:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <f69305de-b3f1-46ee-b8b5-a20729c8c1bb@app.fastmail.com>
In-Reply-To: <27c7824e-ec90-c68f-3e76-92525ed7e393@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
 <20230526171658.3886-5-mpearson-lenovo@squebb.ca>
 <27c7824e-ec90-c68f-3e76-92525ed7e393@linux.intel.com>
Date:   Mon, 29 May 2023 10:03:02 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] platform/x86: think-lmi: mutex protection around multiple
 WMI calls
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

On Mon, May 29, 2023, at 8:23 AM, Ilpo J=C3=A4rvinen wrote:
> On Fri, 26 May 2023, Mark Pearson wrote:
>
>> Add mutex protection around cases where an operation needs multiple
>> WMI calls - e.g. setting password.
>
> So you need this feature already for Patch 1/5? If that's the case, yo=
u=20
> should reorder the patches and put it before 1/5.

You're right....I was being lazy and just adding it to the end of the se=
ries as it was easier. I can re-order.

As a side note, the chances of two people changing things on a system at=
 the same time is rather unlikely - it just doesn't make sense as it's s=
omething done by an administrator. But a fix is a fix.

>
> That "e.g. setting password" sounds vague enough that I'm left to wond=
er=20
> if there are other cases in the driver which need locking too. It woul=
d be=20
> useful to be precise with wording here. It will help immensely when=20
> somebody looks this changelog 5 years from now if you explain all case=
s=20
> that need locking up front.

OK. There are two cases and I can list both cases explicitly.

>
> So, is this needed also for some existing code, then Fixes tag might b=
e in=20
> order? (I'm looking e.g. that cert auth block in current_value_store()=20
> which also does more than one call).

True - I can add that.=20

Thanks for the review. I'll hold off a couple of days before making thos=
e changes in case there is any feedback

Mark

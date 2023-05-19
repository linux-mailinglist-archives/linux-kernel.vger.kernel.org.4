Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E9A70A224
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjESVwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjESVwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:52:08 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB371730;
        Fri, 19 May 2023 14:51:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1FA023200998;
        Fri, 19 May 2023 17:51:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 19 May 2023 17:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684533076; x=1684619476; bh=Swpo4gUk6xVGAujZkHWBnImzkqnYkyRI2qy
        um8DHZXw=; b=ppK7/DGLIequAjDx/8H8T0JGT5Jpmz6WPC6jYQM5dQsLsrEic7K
        eK98aWQONrLPIPoAghZSIP7W3v4HTpPXB6E53h34qtx1hKqmrN3sb074cpWM3OcD
        6+oSm8YCGQcjfKhIFcv9OudS4NqMPkCoCj+ycwh3Pqd2WbUCM5RRmxSgzHtrsfcU
        vbUD7OgOqe7mdJoTSjMg+ghoCw1vBYqR8AjT0879yEGzk9RqrrCjkfUAM7pvy/WI
        WbHoOLPAMSZ93RvNLgziQLCbbE0S4OXwUstqVr4lqMGjWpU/fJBpKgsb6vaaec+H
        0/FLBoKo/xGies1TvEUi2ct8onXjiARz5/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684533076; x=1684619476; bh=Swpo4gUk6xVGAujZkHWBnImzkqnYkyRI2qy
        um8DHZXw=; b=t1g71FeOZc4MvfkUamJxEqiMBO3X/3I8Gu2WuShThD+opjiy4vb
        Bn9re+3mbTKm3mtB4PdJAB+vJKc3Buq3J0dvjdmA4z5hjepasoBp9yaONtH/3nSU
        5yS6epXvKblGMt60cxvH+gr3Pq0Oi8Vups6MyoFCSeg7vGcC4Rybgc7vWKZKY3ph
        L0iEM0e3gKWsRSDIsdr0BuYLQ/WXIVqRkGG8tYHtgchYhjELHM8sc+W2KbTbt2j6
        E8IOz69FEvDhM5VMFg8ukfIHVQhu9fH0ZSXE5cvp+Mrx6wDY9ku9wW+Z79WwCZ25
        E23TcdI2S+5n8fn4UMlER6xPMrBAtO8kDBw==
X-ME-Sender: <xms:VO9nZP2qDnQlSrXHYjZtszO0KIR7p2KoW2VAbgDCPZn7ilqeEW_Q3w>
    <xme:VO9nZOE3EOekc6uH8YQEcBbjD05ZUaeA5mbjY0wZdlqsutZAaEofNTLJ76TVEHPjG
    ZDGbBReDMluWizbyFc>
X-ME-Received: <xmr:VO9nZP5I6IxXTDUbmS6G73seWF8b9FlH6UdsC7dWncXRYV8AUIsRaHxHd3YrmSaMOgKO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiiedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:VO9nZE20hoN3q4E124vsNYlbizWgS0wXSHJtOblhZuoEJt2WS6Owbw>
    <xmx:VO9nZCG3lz_tVwiHCteGCu2Xje54QSBoh-MielZ-1Pl_NfLEwmNVJw>
    <xmx:VO9nZF87c1NHDYyxQ1aGE62bsXDKeW0CHr5mlX58x3FZKdxGaGfCOg>
    <xmx:VO9nZHQn3CAWH03xgc7WjMiRJFrvGe20ni5Qnly-neZnFmJPLK3Ghg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 May 2023 17:51:15 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/3] MIPS: Introduce WAR_4KC_LLSC config option
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <alpine.DEB.2.21.2305192117230.50034@angie.orcam.me.uk>
Date:   Fri, 19 May 2023 22:51:04 +0100
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <53043C18-7C75-4D5F-A15E-86D981D19CA8@flygoat.com>
References: <20230519164753.72065-1-jiaxun.yang@flygoat.com>
 <20230519164753.72065-2-jiaxun.yang@flygoat.com>
 <alpine.DEB.2.21.2305192117230.50034@angie.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B45=E6=9C=8819=E6=97=A5 21:23=EF=BC=8CMaciej W. Rozycki =
<macro@orcam.me.uk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, 19 May 2023, Jiaxun Yang wrote:
>=20
>> diff --git a/arch/mips/kernel/cpu-probe.c =
b/arch/mips/kernel/cpu-probe.c
>> index 6d15a398d389..fd452e68cd90 100644
>> --- a/arch/mips/kernel/cpu-probe.c
>> +++ b/arch/mips/kernel/cpu-probe.c
>> @@ -152,6 +152,13 @@ static inline void check_errata(void)
>> struct cpuinfo_mips *c =3D &current_cpu_data;
>>=20
>> switch (current_cpu_type()) {
>> + case CPU_4KC:
>> + if ((c->processor_id & PRID_REV_MASK) < PRID_REV_4KC_V1_0) {
>> + c->options &=3D ~MIPS_CPU_LLSC;
>> + if (!IS_ENABLED(CONFIG_WAR_4K_LLSC))
>> + pr_err("CPU have LLSC errata, please enable CONFIG_WAR_4K_LLSC");
>=20
> Given the circumstances I think this should be `panic'.  You don't =
want=20
> to continue with a system that can randomly lock up.

I just checked how other architectures handle such situation, it seems =
like
TAINT_CPU_OUT_OF_SPEC is a better option.

Panic in cpu_probe can be frustrating for users as it is earlier than =
initialisation
of consoles so the panic message can never be read by users.

>=20
> Also "CPU has LLSC erratum, [...]" as both are singular.

Thanks for the tip :-)
- Jiaxun

>=20
>  Maciej


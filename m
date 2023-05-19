Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB61870A2A3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjESWDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjESWDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:03:32 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F80F10EC;
        Fri, 19 May 2023 15:03:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 49A16320091A;
        Fri, 19 May 2023 18:03:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 19 May 2023 18:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684533779; x=1684620179; bh=jIqJL/NnQpehuADJQuVaM4SynqOfVffT2Cc
        4DfmU6kM=; b=uAlCQIBMuYeeFwcf/oKb2FwHhhVPqFvEewLKMTG4U9VHboY9y4V
        Q56qik0vKZdaAOv/snedAoYYqaVP0gbM6FIMcMFGIRWyomQNG18+30wVGXelg3Nc
        YPX54DJnovQPXbP8blFSUQ70YfQRmGXUSwozUseusDeOuHjlDbCunqhUy2ZSRBL3
        ZF7U7QrDFqsEbmooIbLmOgEh/hcym4nv6H/MZnU8t1MJh/FD48UGRwJvfmPPK2Ge
        g90Clsp+SoFSVp/LMC3zYU6k1Rw7R7uyDptlcoVNK2FVWjW5/AQh/aFezG9eG+Y8
        Vc07MqFLg27b5BgO5UWd1Yryd9NhP/8hRaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684533779; x=1684620179; bh=jIqJL/NnQpehuADJQuVaM4SynqOfVffT2Cc
        4DfmU6kM=; b=Ajp0awkzr9rPoBGX5nlwRBH66sZo7ZLbKy/0JGwZVp2w4kV/ITo
        mrStE/NCCXXtTM1FmvnTzkf190kh3fcGDQCUUfMz1G9intGx1KwmJ/8MuOqstIv/
        G24BrIerw69QIqG2c13DtI4Y64USGZJ8+lQhXfsXmzxcRHNC756+2F2EWKCCXmYw
        LGWvKQfUN1iagsNZCnBnAKUaSp9C5yOYVrPdNtfCxQiTOoUh1HnvlcEuoHNBaoot
        GF5YLdeBmULL7QqE7a+oxAYziLP9H7/ecCSkb31P5r7zqmP4FalsPtoVq+P5UitI
        Jpv2JS/pGFMZo3PQSK6qmdyomhUUaErzQ2Q==
X-ME-Sender: <xms:E_JnZCvaBD0kAEPKoYVGQPpc6mFiRj2zhf3Jj5Y8HbpHSDPTrMve4g>
    <xme:E_JnZHeirQhfcks7ZfzRIImr86kkgP780XxIjsYPktI7jzYQJrVrrX1nA534L2JC_
    Z49gsgi7KaPLkgDMwg>
X-ME-Received: <xmr:E_JnZNxu-aAIQCuye-VzJngY6j0qhq2zJcAV8Y7F8NquEVTSSTIjfCfT25q6NTXlJ12H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:E_JnZNNHgePKL4I82PoFcylcHYNvX2CjpuGwNEw3xOXoDgVCOoag-Q>
    <xmx:E_JnZC_rWnF9bvYlivHNIYIkboVc70Wn5lvCaCixRvwwft07FuzSoQ>
    <xmx:E_JnZFX5PAXk9MxV50Fhlq_P8MUEdby8xfICSjRq3W5Ft0v6ImvD3Q>
    <xmx:E_JnZEKPYADbuIP7pcjk0Kz_uvXKH1m7gbUJseg_jZ6B1kcCafobEA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 May 2023 18:02:58 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH] MIPS: Fix MIPS_O32_FP64_SUPPORT for 64bit CPUs before R2
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <alpine.DEB.2.21.2305192033550.50034@angie.orcam.me.uk>
Date:   Fri, 19 May 2023 23:02:47 +0100
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1676532-0051-43D7-82D8-1E5697407C70@flygoat.com>
References: <20230519163023.70542-1-jiaxun.yang@flygoat.com>
 <alpine.DEB.2.21.2305192033550.50034@angie.orcam.me.uk>
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



> 2023=E5=B9=B45=E6=9C=8819=E6=97=A5 21:10=EF=BC=8CMaciej W. Rozycki =
<macro@orcam.me.uk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, 19 May 2023, Jiaxun Yang wrote:
>=20
>> MIPS_O32_FP64_SUPPORT enables possibility of using all 32 FPRs on =
32bit
>> kernel in case CPU implemented FR1. As FR1 is present on all 64bit =
CPUs
>> following R4000's priviliged spec, there is no reason to limit such =
support
>> to R2+ CPUs.
>=20
> I guess one can do it and still run FPXX software, but I fail to see =
what=20
> gain it provides.  For FP32 it breaks things as accesses to =
odd-numbered=20
> FPRs will no longer get at the high part of a double value and for =
FP64=20
> there are no MTHC1/MFHC1 instructions required to access the high =
part.

Actually software may access the high part by SDC1/LDC1.
FP32 binaries are still going to run at FR0 mode.

>=20
> What problem are you trying to solve?  And how did you verify this =
patch?

Was trying to deal a proprietary JIT software who want to enable FR1 via =
prctl
on Loongson-2F with 32 bit kernel.

>=20
>> --- a/arch/mips/kernel/fpu-probe.c
>> +++ b/arch/mips/kernel/fpu-probe.c
>> @@ -289,6 +289,23 @@ void cpu_set_fpu_opts(struct cpuinfo_mips *c)
>> c->options |=3D MIPS_CPU_FRE;
>> }
>>=20
>> + /* Fix up FIR for FPU earlier than R2 */
>> + if (!cpu_has_mips_r2_r6) {
>> + c->fpu_id |=3D MIPS_FPIR_S;
>> +#ifdef CONFIG_CPU_R4K_FPU
>> + /* All known R4000 class FPU implemented double */
>> + c->fpu_id |=3D MIPS_FPIR_D;
>> +#endif
>=20
> Currently all FPUs we support implement double and we require that, so =
no=20
> need to make this piece conditional (I would use IS_ENABLED otherwise, =
so=20
> as not to clutter the source with #ifdef), but `c->fpu_id' is also =
exposed=20
> to the user via ptrace(2), so this has to reflect hardware and not =
give a=20
> synthesized value.

Alas, I thought R2030 class FPU does not have double? Since MIPS-IV spec
says SDC1 is introduced in MIPS II.

Thanks
Jiaxun

>=20
>  Maciej


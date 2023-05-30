Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D8C716114
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjE3NHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjE3NHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:07:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974A992;
        Tue, 30 May 2023 06:07:14 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D709C5C0154;
        Tue, 30 May 2023 08:57:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 May 2023 08:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685451471; x=1685537871; bh=/vngq095dMysS+VQMtZnh+O7OIzkDlS3aNu
        +O6rzhPE=; b=O0MGN6+EIEinJG8m8aHuQe4WKepJbOGM2WgIvnMr052EKTYpHob
        6xWjFcXm9dZaxW8gk2DNluYy1dpk2k/AU5T3PVvv0xNP3WnNwbwLqYbgVuKjjZom
        0pwd/L69SmQTKslO/aJOirchlXpZIHXpXsGWI5vtwxTfJ0Qw3CpuyXLl8ght/9y5
        2xfD5MqAWxJvj1+wunfu664Rg5ShcgC4nfqlsQMno4cJZTcwlmuExxaa35CSSF2/
        Alao5kPhckY8xJcvDSBwN7AUVJTaoMTxt6BtVrXs834j9usukgqtD1GaDv5IDZLh
        WZm7kEnZ7TqROxe1Q76dxc/wkNZNju5T9wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685451471; x=1685537871; bh=/vngq095dMysS+VQMtZnh+O7OIzkDlS3aNu
        +O6rzhPE=; b=E2JYlRp+jiwOQVGCHZRqJZWsLf2VC3olZc+Kp4S/vbmKfcOAs5y
        AHn/i9i/WiM6E4eYuTyOY2hwYEjLBaIuk0/fKX9UA9otFP+iZbUUylxf0EfZVQyI
        q8FYSS0KVBaLlEjgAW5TsJ8dackyKvE1gj3zBBsa0fA8eJtuFmAZpQ1T1tEE8bvX
        sQ5LdhCOtgo0YWbx201d/VJkK64uxn3kqF4vQnoh9pqz1fgtF1WUkd1mKaHVG/wg
        pSjryfxxnYKZomHUYy4FUClvVFxmRf2H3n4Kjl9SlL5hICMoaA1n6BR8Oc3Ftx4g
        HVmFN8BRySzL+ZNXol/rjdRB/L54p+qEgCg==
X-ME-Sender: <xms:z_J1ZJbeFpPQu7FyXMhjUHT95HKEzhSwkDb6t9LMIRtMuOCggrvc7Q>
    <xme:z_J1ZAam9bpTHbNY1q1BHYMQ5Hf8vJagYOHpp1wva1pweqQ6DA441wtF7UxifAldB
    BEJip471Tz0LHBIAzg>
X-ME-Received: <xmr:z_J1ZL9sqYbmmlwnK57zI7suQzLBE-LaTESBd_gglnm3KyVZoaqMYG-4tAKFz6acqVc2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:z_J1ZHpTzrR-5hV2-OLYk00s1az84i83oXBnejnVDIn4CmdflQQ6kg>
    <xmx:z_J1ZErrlFelpHlffg-VG9DJm2dIAGjWM4nvgazmCcLxlvxN8ZH-Nw>
    <xmx:z_J1ZNRG66oE-Ck1llyOdLqRi7w48jSgWAJ6y0nina7jThizzh0jFw>
    <xmx:z_J1ZNlvk9jdo0e-9U1DTgW7kAd49BmodPXowZc94Ry1EypcLeiz_w>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 08:57:50 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and M5150
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230530125100.bd626syvkbfv7zhv@mobilestation>
Date:   Tue, 30 May 2023 13:57:39 +0100
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9BBD5835-ACD8-48BD-AED9-E23473237FAD@flygoat.com>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
 <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk>
 <684C1A48-C743-4045-AF12-B0846FCE8EBE@flygoat.com>
 <alpine.DEB.2.21.2305301152080.42601@angie.orcam.me.uk>
 <BCECE3BF-7A4D-43BF-8AA8-2232D974CD71@flygoat.com>
 <alpine.DEB.2.21.2305301315120.42601@angie.orcam.me.uk>
 <20230530124127.z5rr5vauw43rafrt@mobilestation>
 <20230530125100.bd626syvkbfv7zhv@mobilestation>
To:     Serge Semin <fancer.lancer@gmail.com>
X-Mailer: Apple Mail (2.3731.500.231)
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



> 2023=E5=B9=B45=E6=9C=8830=E6=97=A5 13:51=EF=BC=8CSerge Semin =
<fancer.lancer@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, May 30, 2023 at 03:41:30PM +0300, Serge Semin wrote:
>> On Tue, May 30, 2023 at 01:16:32PM +0100, Maciej W. Rozycki wrote:
>>> On Tue, 30 May 2023, Jiaxun Yang wrote:
>>>=20
>>>>> Sure, but this change is not needed for it.  You just need to =
declare=20
>>>>> which ISA revisions your platform supports and leave =
`__get_cpu_type'=20
>>>>> alone.  It has worked like that for a decade now.
>>>>=20
>>>> I=E2=80=99m afraid it won=E2=80=99t work as you expected.
>>>>=20
>>>> Actually I ran into a problem that `case CPU_P5600` in c-r4k.c is =
optimised out
>>>> by compiler, because the codepath is marked as unreachable.
>>>=20
>>> Maybe there's a bug elsewhere then.  Send me your .config and I'll =
try to=20
>>> reproduce it.
>>=20
>> I may have misunderstood something, but it seems like there is no =
such
>> problem on my P5600 system:
>>=20
>> [fancer@mobilestation] kernel $ grep -r P5600 -B2 -A2 =
arch/mips/mm/c-r4k.c=20
>>        case CPU_1004K:
>>        case CPU_INTERAPTIV:
>>        case CPU_P5600:
>>        case CPU_PROAPTIV:
>>        case CPU_M5150:
>> --
>>        case CPU_P6600:
>>        case CPU_M6250:
>>                pr_info("MIPS P5600 is here\n");
>>                if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
>>                    (c->icache.waysize > PAGE_SIZE))
>>=20
>> Log:
>> [    0.000000] Linux version 6.4.0-rc1-bt1-00235-gf9efd6b74b12-dirty =
(fancer@mobilestation) (mipsel-baikal-linux-gcc (GCC) 7.3.0, GNU ld (GNU =
Binutils) 2.30.0.20180208) #1
>> 275 SMP PREEMPT Tue May 30 15:30:48 MSK 2023
>> [    0.000000] CPU0 revision is: 0001a830 (MIPS P5600)
>> [    0.000000] FPU revision is: 30f30320
>> [    0.000000] MSA revision is: 00000320
>> ...
>> [    0.000000] VPE topology {1,1} total 2
>> [    0.000000] MIPS P5600 is here
>> ...
>=20
> Here is the CPU-related kernel configs:
> root@msbt2:~# cat /proc/config.gz | gunzip | grep CPU_MIPS
> # CONFIG_CPU_MIPS32_R2 is not set
> # CONFIG_CPU_MIPS32_R5 is not set
> # CONFIG_CPU_MIPS32_3_5_FEATURES is not set
> CONFIG_CPU_MIPS32_R5_FEATURES=3Dy
> CONFIG_CPU_MIPS32_R5_XPA=3Dy
> CONFIG_SYS_HAS_CPU_MIPS32_R2=3Dy
> CONFIG_SYS_HAS_CPU_MIPS32_R3_5=3Dy
> CONFIG_SYS_HAS_CPU_MIPS32_R5=3Dy
> CONFIG_CPU_MIPS32=3Dy
> CONFIG_CPU_MIPSR5=3Dy
> CONFIG_CPU_MIPSR2_IRQ_VI=3Dy
> CONFIG_CPU_MIPSR2_IRQ_EI=3Dy

I was trying to run kernel compiled with CONFIG_CPU_MIPS32_R2 on P5600.

Thanks
- Jiaxun

>=20
> -Serge(y)
>=20
>>=20
>> -Serge(y)
>>=20
>>>=20
>>>  Maciej



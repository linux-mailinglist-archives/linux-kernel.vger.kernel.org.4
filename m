Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBD05B3F34
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiIITEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIITEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:04:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B61A5A3F7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:04:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b5so4386113wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=pKUha8KPeXhipsOQ5xtfWdepBcWzrEN7wq95Ka7WsLo=;
        b=Cz31QytU1QsjnJJn8X8BLIOOskEjB11J65qBwAk1qWhP4jZKat84rlSLWDg+u26uQf
         3QcSlXC5tofl7XtpLytxNY+SPWv4eMDMC7CUDTvBuqQ270re+jlbOdSmdpK7l/9eWbuj
         1LwCGsA7kG6q6aY2sYVoRLwrHDa8fmapoGVJkeNJMtDPKo17p808Hb5tAm03QCCs1Pl4
         vwDb+A67HZFdRW+cMVyr/eA2iinX1CzT54D35Tl0q6PFnYhSgshWsyH2HklP7kkzTR82
         +UzpcHWXKsUQsDQ5rrWhb6OIleF1Oa+9Qx684a6aUPOP9gbkJnFqQRKAes6kf6gedSw5
         fWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pKUha8KPeXhipsOQ5xtfWdepBcWzrEN7wq95Ka7WsLo=;
        b=KHGcEluuotZN3CYU5raa8Wy7eCern1zpfzoTtXvjh5z6n7x+awZk5s1nONBOhae91J
         lCO7yxD5+9/hC0+mBIv7wZcUOJINKMcxKRwdYu9DPJsoO8vxVTMPgQiGfbOsJgoN6izG
         eT4/IpgKkDmRLKS82rMW7J6VYUvcISqK62bIB58XRj9yF8LcVGudt/mWqAABBdfpDO6K
         2KH0DF5Z7dKP0VYonaza0Za7ohnohBix8VrvAfi6XIvxPpHoDj8c6ouYfDeBLjjJFjYA
         IyH5Rb6MHXE4A4NKJiUdfJG3MuC8K+T8Q1VaC2CRqgzwjRNLL9VnPxMwpfjfwm2i/T7Z
         tYRQ==
X-Gm-Message-State: ACgBeo0HJ+w2o5dxElGn8OSCGGwOx7oxpmxJ2ynUt/Nrn/PK1qbehq9n
        vxzaQ/uVlGMK21OwR4KG8gJLXjiLZcLEg8g3
X-Google-Smtp-Source: AA6agR4l4brO8ikaIINZSOF+InPTKxeLv1Ydx1twqMU5rtBcqinD3ZOU61suidSBYZGeFV2c2TaYSg==
X-Received: by 2002:adf:ea4a:0:b0:228:635a:d491 with SMTP id j10-20020adfea4a000000b00228635ad491mr9083471wrn.137.1662750243964;
        Fri, 09 Sep 2022 12:04:03 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.n-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id b8-20020adfe308000000b00228de351fc0sm1144987wrj.38.2022.09.09.12.04.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Sep 2022 12:04:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 07/12] riscv: dts: allwinner: Add Allwinner D1 Nezha
 devicetree
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <3687587.6M6d0yLqnL@diego>
Date:   Fri, 9 Sep 2022 20:04:02 +0100
Cc:     Samuel Holland <samuel@sholland.org>, Conor.Dooley@microchip.com,
        devicetree <devicetree@vger.kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jernej.skrabec@gmail.com, Chen-Yu Tsai <wens@csie.org>,
        robh+dt@kernel.org, palmer@dabbelt.com,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <F27C6531-E91E-4311-B64D-D26FE12086CA@jrtc27.com>
References: <20220815050815.22340-1-samuel@sholland.org>
 <8a2194bf-93bd-de4d-8d39-0cd72aabb0a9@sholland.org>
 <52217b50-c22f-5a21-e509-05d178e4a173@microchip.com>
 <3687587.6M6d0yLqnL@diego>
To:     =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Sept 2022, at 09:11, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>=20
> Am Freitag, 9. September 2022, 09:18:40 CEST schrieb =
Conor.Dooley@microchip.com:
>> On 09/09/2022 05:37, Samuel Holland wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>> know the content is safe
>>>=20
>>> Hi Conor,
>>>=20
>>> On 8/19/22 5:10 PM, Conor.Dooley@microchip.com wrote:
>>>> Finally got around to giving this a go with the fix for loading=20
>>>> modules which is mostly what was blocking me before..
>>>>=20
>>>> On 15/08/2022 06:08, Samuel Holland wrote:
>>>>> "D1 Nezha" is Allwinner's first-party development board for the
>>>>> D1 SoC. It was shipped with 512M, 1G, or 2G of DDR3. It supports
>>>>> onboard audio,
>>>>=20
>>>> I am really not keen on the way you have things, with the memory=20
>>>> nodes removed from the device tree. I know your preferred flow for
>>>> booting these things might be to pass the dtb up from U-Boot, but I
>>>> think the devicetree in the kernel should be usable in a standalone
>>>> manner, even if that is the barest-minimum memory config.
>>>=20
>>> That is simply not possible to guarantee. As an obvious example,
>>> consider the MangoPi MQ-Pro board with socketed DRAM:
>>=20
>> Yeah, I knew in my heart-of-hearts that this probably was a non
>> runner.
>>=20
>>>=20
>>> https://twitter.com/mangopi_sbc/status/1516225559214583808
>>>=20
>>> But focusing on the /memory node misses the bigger picture. The DTB
>>> is passed through _all_ of the firmware stages, and gets patched by
>>> every one of them:
>>>=20
>>> - SPL/boot0 adds the /memory node with the detected DRAM size. If =
the
>>> in-tree DTS has a "minimum memory config" (which for a board with
>>> socketed DRAM means the smallest possible die), I guarantee people
>>> will use it and complain about missing DRAM.
>>=20
>> True, but they are also complaining about missing DRAM as is ;)
>> No possibility of winning here unfortunately.
>>=20
>>> - The SBI implementation reserves memory for itself and any possible
>>> secure partitions. Right now, booting happens to work without the
>>> reserved-memory node because the SBI implementation is loaded at the
>>> beginning of RAM, and Linux ignores RAM below the kernel load
>>> address.
>>=20
>> Surely this sort of thing is a common problem though, it's not like
>> any of us are doing something unique here are we? At least if there
>> was a arch wide policy about the validity of the upstream DTS in the
>> face of the SBI etc inflicting changes there'd be something to point
>> to. I am just looking at this from a "everyone else has a usable dts
>> in the kernel, but the D1 boards wont have" point of view.
>=20
> Not sure if this would fly, but what about having an sbi call for
> "modify this dtb for me as well"?
>=20
> I'll just assume that spl/boot0 + main uboot come in some sort
> of package so moving the memory node over should be in uboot's
> scope, but for the sbi part just have a call pointing to the
> new dtb in memory and have it modify it in the same way as the
> original one?

There=E2=80=99s an EFI protocol for it.

Jess

> Heiko
>=20
>=20
>=20
>>> However, memory-constrained devices (e.g. D1s) will need to get =
those
>>> 2 MiB back by loading the kernel at the start of DRAM and SBI at the
>>> end of DRAM. Then the reserved-memory node becomes quite important.
>>>=20
>>> It also adds nodes for CPU idle states, since the available states
>>> and their latencies depend on the SBI implementation.
>>>=20
>>> It also reserves devices used by it or by a secure partition. And it
>>> is responsible for extracting data (e.g. MAC addresses) from =
"secure"
>>> eFuses which the OS may not have access to.
>>>=20
>>> - U-Boot adds other information, like boot arguments, the address of
>>> the initramfs and framebuffer, etc. These are less of a concern
>>> because of course U-Boot can patch these in to a DTB loaded from
>>> disk, but they are relevant if you want to load a DTB from a later
>>> bootloader like GRUB.
>>>=20
>>> If you load a DTB from disk, you lose all of the changes made by the
>>> earlier firmware stages. On ARM, U-Boot tries to work around this by
>>> copying a few specific bits of information from the firmware DTB to
>>> the DTB loaded from disk. But this misses the point that the SBI
>>> implementation can modify *any* part of the DTB. (So in practice
>>> U-Boot on ARM already loses CPU idle states and reserved memory =
nodes
>>> that were added by the PSCI implementation.)
>>=20
>> All of these things are valid, but they are reasons why your flow in
>> your bootloaders etc are the way they are more than a reason why the
>> upstream dts will not work for someone who is not interested in that
>> flow. At the end of the day, I only care so much about this as it is
>> not me that has to deal with any confusion from either approach. I'll
>> continue to modify my dts in U-Boot so I can test things without me
>> having to re-program the world. /shrug
>>=20
>>> As an extreme example, consider paravirtualization, where only a
>>> small subset of DRAM and peripherals may be made available to any =
one
>>> OS partition.
>>=20
>> Or AMP - though not likely that that is a problem for the D1..
>>=20
>>> Fundamentally, I reserve the right to make arbitrary changes to the
>>> DTB in the SBI implementation, and thus I cannot condone using the
>>> DTBs generated from the Linux source tree for any purpose other than
>>> validation.
>>=20
>> Fundamentally, I reserve the right to complain that the upstream dts
>> cannot be entirely validated as it does not work out-of-the-box ;)
>>=20
>> Either way, I am only going to complain so much about something that
>> triggers my OCD about keeping things the same, you have a
>> Tested-by: Conor Dooley <conor.dooley@microchip.com>
>> already and once the other issues are cleaned up an R-b too. Not =
trying
>> make an issue out of this, just expressing my dislike for the
>> inconsistency between the D1 stuff and vendors - partly in the hopes
>> that the "higher powers" get involved. I can't imagine that this is
>> the last time something like this comes up.
>>=20
>> Thanks,
>> Conor.
>>=20
>>=20
>>=20
>>=20
>>=20
>>=20
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


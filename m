Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA44A6B21D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCIKsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCIKsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:48:24 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00844C6FF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:48:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id da10so5226346edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678358899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXTLVKonq145fe0ytXdOtgCPf7KTsG27A4IaoSc+Vu0=;
        b=RhuYXi/vwq0tgS5GhFnoNC8LMoV5+GTnZzhggDxNiDUfvUTEwHjXH1QFdCwwWjE+G1
         e0/S+kYLzRP6l1fYv2oTVChyZ92RZ9jv3ZjVCC5abcHsLGtNPVh5F+wjvYAlFL2eFG3p
         Hf6be/kM1yWovX+Gxbt5XypEX0RGI51I9b/zn/41TNhfusLsWJ173XcR2JmECfLbnJKg
         Ph+KR9/Xt5aa86kOYksjU75n5VXBllhrOrOX3JpZ59U+D60EIS0T2trte2YoUV5XtW85
         U25kVOxsfFpHo0lQa0dpIUezA/Jl2MXlIAnxlnVOps2JcsYm2FxHgyZEDW95eHKdTei/
         b8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXTLVKonq145fe0ytXdOtgCPf7KTsG27A4IaoSc+Vu0=;
        b=ed824i+ecNf40ioKZV8kzgMGZHrObO3wir5moszmPGbn98Zvt00rzFbWMxokKi0p7l
         DLVxd/nnwZwWJZMWcqc7jQE9oD8ZgXTxPiuXpw0Nuden5ERTqvkswp856KAm0IIE8Ct3
         1G7UMdhrlADCwb/lj/ykxFsSS12/xB/AsJQUrxLt+Xda2h2X8eeSrBaMxdblO+oyfe3Y
         YeTi5oRdu42EJbRU44nuNFnUzY005BJMUE04NBWeKnp1tFaFhUlLnRQw/0mn8lrxPFYD
         lkUIBIVkikC6Cw4bhYBMbaUiX5S6I2f0viMbWygwBSV3X8jtT8lb1lwva/RgoZrVte07
         OYqQ==
X-Gm-Message-State: AO0yUKXoAssVR0P43Bbn/9/pmS9osiOZyoyiWi5w4rjGCmEqF5MsJnCz
        7TN5kiiB40gxAcAYPMX3iMq8EQvfJFx5WlvRyNFoKg==
X-Google-Smtp-Source: AK7set8OJIO98YFS8R5gs+1Y4ruIuk2NfbZOxptFzB7tMyH1e5MDNlprG5ONb0fZqQq4CxO53p4GZ4Hhr1rIMNPEkRo=
X-Received: by 2002:a17:906:338b:b0:879:e5b2:e12d with SMTP id
 v11-20020a170906338b00b00879e5b2e12dmr9882276eja.13.1678358899375; Thu, 09
 Mar 2023 02:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20230307163413.143334-1-bchihi@baylibre.com> <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
In-Reply-To: <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Thu, 9 Mar 2023 11:47:43 +0100
Message-ID: <CAGuA+ooi7Kx05gagLzXAN3upDiSqDUNOM_djYdGftw6ogVx5gw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add LVTS support for mt8192
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

On Thu, Mar 9, 2023 at 6:04=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> On Wed, Mar 8, 2023 at 12:34=E2=80=AFAM <bchihi@baylibre.com> wrote:
> >
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add full LVTS support (MCU thermal domain + AP thermal domain) to Media=
Tek MT8192 SoC.
> >
> > This series is a continuation of the previous series "Add LVTS Thermal =
Architecture" v14 :
> >     https://patchwork.kernel.org/project/linux-pm/cover/20230209105628.=
50294-1-bchihi@baylibre.com/
> > and "Add LVTS's AP thermal domain support for mt8195" :
> >     https://patchwork.kernel.org/project/linux-pm/cover/20230307154524.=
118541-1-bchihi@baylibre.com/
> >
> > Based on top of thermal/linux-next :
> >     base-commit: 6828e402d06f7c574430b61c05db784cd847b19f
> >
> > Depends on these patches as they are not yet applyied to thermal/linux-=
next branch :
> >     [1/4] dt-bindings: thermal: mediatek: Add AP domain to LVTS thermal=
 controllers for mt8195
> >     https://patchwork.kernel.org/project/linux-pm/patch/20230307154524.=
118541-2-bchihi@baylibre.com/
> >     [2/4] thermal/drivers/mediatek/lvts_thermal: Add AP domain for mt81=
95
> >     https://patchwork.kernel.org/project/linux-pm/patch/20230307154524.=
118541-3-bchihi@baylibre.com/
> >
> > Balsam CHIHI (4):
> >   dt-bindings: thermal: mediatek: Add LVTS thermal controller definitio=
n
> >     for mt8192
> >   thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
> >   arm64: dts: mediatek: mt8192: Add thermal zones and thermal nodes
> >   arm64: dts: mediatek: mt8192: Add temperature mitigation threshold
>
> I tried this on my Hayato. As soon as lvts_ap probes and its thermal zone=
s
> are registered, a "critical temperature reached" warning is immediately
> triggered for all the zones, a reboot is forced. A NULL pointer dereferen=
ce
> is also triggered somewhere. I filtered out all the interspersed "critica=
l
> temperature" messages:
>

Thank you very much for testing!
It seems like interrupts on mt8192 and mt8195 do not behave the same way.
I am investigating the issues.

> [    2.943847] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000600
> [    2.958818] Mem abort info:
> [    2.965996]   ESR =3D 0x0000000096000005
> [    2.973765] SMCCC: SOC_ID: ID =3D jep106:0426:8192 Revision =3D 0x0000=
0000
> [    2.975442]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    2.987305]   SET =3D 0, FnV =3D 0
> [    2.995521]   EA =3D 0, S1PTW =3D 0
> [    3.004265]   FSC =3D 0x05: level 1 translation fault
> [    3.014365] Data abort info:
> [    3.017344]   ISV =3D 0, ISS =3D 0x00000005
> [    3.021279]   CM =3D 0, WnR =3D 0
> [    3.022124] GACT probability NOT on
> [    3.024277] [0000000000000600] user address but active_mm is swapper
> [    3.034190] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> [    3.044738] Modules linked in:
> [    3.044745] CPU: 0 PID: 97 Comm: irq/273-1100b00 Not tainted
> 6.3.0-rc1-next-20230308-01996-g3c0b9a61a3e5-dirty #575
> c7b94096b594a95f18217c2ad4a2bd6d2c431108
> [    3.044751] Hardware name: Google Hayato rev1 (DT)
> [    3.044755] pstate: 60000009 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    3.052055] pc : __mutex_lock+0x60/0x438
> [    3.052066] lr : __mutex_lock+0x54/0x438
> [    3.052070] sp : ffffffc008883c60
> [    3.070822] x29: ffffffc008883c60 x28: ffffff80c281a880 x27: 000881f00=
009001f
> [    3.070830] x26: 1fc0000000247c00 x25: ffffff80c281a900 x24: 000000000=
0000000
> [    3.070837] x23: 0000000000000000 x22: ffffffe5ae5d45f4 x21: 000000000=
0000002
> [    3.086211] x20: 0000000000000000 x19: 00000000000005a0 x18: fffffffff=
fffffff
> [    3.086218] x17: 6568636165722065 x16: 727574617265706d x15: 000000000=
0000028
> [    3.097773] x14: 0000000000000000 x13: 0000000000003395 x12: ffffffe5a=
f7f6ff0
> [    3.097780] x11: 65706d655428206e x10: 0000000000000000 x9 : ffffffe5a=
dcf4b08
> [    3.097787] x8 : ffffffe5afe03230 x7 : 00000000000261b0 x6 : ffffff80c=
2b86600
> [    3.105609] x5 : 0000000000000000 x4 : ffffff80c2b86600 x3 : 000000000=
0000000
> [    3.112565] x2 : ffffff9b505f6000 x1 : 0000000000000000 x0 : 000000000=
0000000
> [    3.127593] Call trace:
> [    3.127595]  __mutex_lock+0x60/0x438
> [    3.127600]  mutex_lock_nested+0x34/0x48
> [    3.141844]  thermal_zone_device_update+0x34/0x80
> [    3.152879]  lvts_irq_handler+0xbc/0x158
> [    3.152886]  irq_thread_fn+0x34/0xb8
> [    3.161489]  irq_thread+0x19c/0x298
> [    3.161494]  kthread+0x11c/0x128
> [    3.175152]  ret_from_fork+0x10/0x20
> [    3.175163] Code: 97ccbb7c 9000bea0 b9411400 35000080 (f9403260)
> [    3.189402] ---[ end trace 0000000000000000 ]---
> [    3.193417] Kernel panic - not syncing: Oops: Fatal exception
> [    3.201255] Kernel Offset: 0x25a5c00000 from 0xffffffc008000000
> [    3.201257] PHYS_OFFSET: 0x40000000
> [    3.201259] CPU features: 0x600000,01700506,3200720b
> [    3.201263] Memory Limit: none
> [    3.376838] Rebooting in 30 seconds..
>
>
[...]

Best regards,
Balsam

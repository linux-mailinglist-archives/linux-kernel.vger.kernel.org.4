Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C642A6DDA14
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjDKLuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjDKLum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:50:42 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08867C9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:50:41 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id o2so5423056uao.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1681213840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ABpILrsve0qKJe1rMKA0UqVkX+F1EsDxDxKGNDuqxY=;
        b=KVatqVw52IhcfqXAGvQ6AjlQ/yo8uGrRN9sI3RW602XortnUT2neEdIsKww/J3pESI
         q8VyhEI9l83LXxWinWmRr2Dx1rwUD+CP60tV4liiCOxXohXH8BKmR34+FG7Crskv7VfT
         g0Br2FHi6ZEibqFxCokZ7e/WzFa25EuCF7XjU8DhOUGz2Ph1oRQ4SfJIIq2/ughG0yWu
         syNKBSbZ8oJFgvETJXmEIuanWIcayd4ojVs2bXyfHs2mXGaWTl2KvVLF7YK8Xv2V64xc
         GhoGH4ZmPPueePCpALN0ihgV5WxrHR7/8xz15A7FhAKBvTLPChGltfHBwlobxsKZQOzo
         /AOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681213840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ABpILrsve0qKJe1rMKA0UqVkX+F1EsDxDxKGNDuqxY=;
        b=sBJOQ+Ty+xevSA8C80J0WWMaP80Gy6G1SYTlQ+CGyuGmxOg/N7Qwe4uys9p35dTQYs
         R9Id3BrobMpugqmTvwzHalTT2+VaM/x77FhklQnTwOgVfAUFxMAJyiFUkqEzExqRLm8+
         TXztT3CEsfkZirstLvslJfX+ojWjce/edDSyU9ngdIbMjA+i46ZYrDgatDayvitD81MB
         juFzsrZzO498Zmo6QkIPxjiJyMmJWQdqwpMxzhZfD2wjtpVzxPZNheU5vS4S39kwi1pq
         tWjkr+6lOuSFcaZw7ZX1ynSZPQIG++BcZT+2KSk9bKNtOTrdZR+bt9lUhfVJZQgULw9D
         50LQ==
X-Gm-Message-State: AAQBX9eIds5x/Mc9lfjvry2ZSVOYb/Imb6XBXV1u0LDbggzbL5aCW0YK
        R0YxS7rk8AgEr327paSpVxt1PSBMcVL6fXpD/EEJBw==
X-Google-Smtp-Source: AKy350ag+4vkSjC293eEA+Ezldj6pBfYQecQW+ykIdx4osj27F89whguE2mB4gHKphxIOhL2WeYzVkfq7A9AKhhY7TY=
X-Received: by 2002:a9f:3014:0:b0:68a:6c1e:1aab with SMTP id
 h20-20020a9f3014000000b0068a6c1e1aabmr8693102uab.2.1681213840148; Tue, 11 Apr
 2023 04:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230406200723.552644-1-brgl@bgdev.pl> <20230406200723.552644-6-brgl@bgdev.pl>
 <20230410201145.6e2qsl5gtwh7n3k7@echanude>
In-Reply-To: <20230410201145.6e2qsl5gtwh7n3k7@echanude>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 11 Apr 2023 13:50:29 +0200
Message-ID: <CAMRc=MdSTqO0bW1=_it43K_pn7EuBWRPvBF29N1gdqsh3TpAcg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: sa8775p: add the pcie smmu node
To:     Eric Chanudet <echanude@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:11=E2=80=AFPM Eric Chanudet <echanude@redhat.com=
> wrote:
>
> On Thu, Apr 06, 2023 at 10:07:21PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add the PCIe SMMU node for sa8775p platforms.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 74 +++++++++++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dt=
s/qcom/sa8775p.dtsi
> > index 2343df7e0ea4..9ab630c7d81b 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > @@ -809,6 +809,80 @@ apps_smmu: iommu@15000000 {
> >                                    <GIC_SPI 891 IRQ_TYPE_LEVEL_HIGH>;
> >               };
> >
> > +             pcie_smmu: iommu@15200000 {
> > +                     compatible =3D "qcom,sa8775p-smmu-500", "qcom,smm=
u-500", "arm,mmu-500";
> > +                     reg =3D <0x0 0x15200000 0x0 0x800000>;
>
> Testing on the board, applying on next-20230406:
> [    1.041869] arm-smmu 15200000.iommu: SMMU address space size (0x80000)=
 differs from mapped region size (0x800000)!
>
> In the downstream sources, the size is 0x80000[1].
>
> On reboot, I also get a synchronous abort, but the second line, from the
> following output on the serial, could indicate the hypervisor is behind
> it:
>
> [   26.906206] arm-smmu 15200000.iommu: disabling translation
> 3      33.244434 Injecting instruction/data abort to VM 3, original ESR_E=
L2 =3D 0x93800047, fault VA =3D 0xffff80000a380000, fault IPA =3D 0x1520000=
0, ELR_EL2 =3D 0xffffd064f70c9de8
> [   26.942083] Internal error: synchronous external abort: 00000000960000=
10 [#1] PREEMPT SMP
> [   26.948506] Modules linked in: nvmem_qcom_spmi_sdam qcom_pon spi_geni_=
qcom nvmem_reboot_mode crct10dif_ce i2c_qcom_geni phy_qcom_qmp_ufs gpucc_sa=
8775p ufs_qcom socinfo fuse ipv6
> [   26.966702] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted 6.3.0-rc5-=
next-20230406-00019-g9d08a3c17f54-dirty #134
> [   26.977315] Hardware name: Qualcomm SA8775P Ride (DT)
> [   26.982505] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   26.989651] pc : arm_smmu_device_shutdown+0x88/0x1d8
> [   26.994773] lr : arm_smmu_device_shutdown+0x70/0x1d8
> [   26.999875] sp : ffff80000805bbf0
> [   27.003283] x29: ffff80000805bbf0 x28: ffff0e69400a0000 x27: 000000000=
0000000
> [   27.010608] x26: ffffd064f8130f38 x25: 0000000000000001 x24: ffffd064f=
8eac028
> [   27.017932] x23: ffff0e6940eeb490 x22: ffffd064f8f24f80 x21: ffff0e694=
0eeb410
> [   27.025254] x20: ffff0e6940808c80 x19: ffff0e6940eeb410 x18: 000000000=
0000006
> [   27.032579] x17: 0000000000000001 x16: 0000000000000014 x15: ffff80000=
805b5c0
> [   27.039903] x14: 0000000000000000 x13: ffffd064f8ac19a8 x12: 000000000=
0000606
> [   27.047226] x11: 0000000000000202 x10: ffffd064f8b199a8 x9 : ffffd064f=
8ac19a8
> [   27.054549] x8 : 00000000ffffefff x7 : ffffd064f8b199a8 x6 : 80000000f=
ffff000
> [   27.061872] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 000000000=
0000000
> [   27.069195] x2 : 0000000000000000 x1 : ffff80000a380000 x0 : 000000000=
0000001
> [   27.076520] Call trace:
> [   27.079041]  arm_smmu_device_shutdown+0x88/0x1d8
> [   27.083787]  platform_shutdown+0x24/0x34
> [   27.087825]  device_shutdown+0x150/0x258
> [   27.091859]  kernel_restart+0x40/0xc0
> [   27.095632]  __do_sys_reboot+0x1f0/0x274
> [   27.099664]  __arm64_sys_reboot+0x24/0x30
> [   27.103786]  invoke_syscall+0x48/0x114
> [   27.107644]  el0_svc_common+0x40/0xf4
> [   27.111410]  do_el0_svc+0x3c/0x9c
> [   27.114822]  el0_svc+0x2c/0x84
> [   27.117969]  el0t_64_sync_handler+0xf4/0x120
> [   27.122357]  el0t_64_sync+0x190/0x194
> [   27.126126] Code: f9400404 b50008e4 f9400681 52800020 (b9000020)
> [   27.132385] ---[ end trace 0000000000000000 ]---
>

Adding Shazad

Eric: This is supposedly gone in the latest meta but I thought you're
already on the most recent release?

Shazad, what version exactly should Eric test this on?

Bart

> [1] https://git.codelinaro.org/clo/la/kernel/ark-5.14/-/blob/ES2/arch/arm=
64/boot/dts/qcom/lemans.dtsi#L3498
>
> > +                     #iommu-cells =3D <2>;
> > +                     #global-interrupts =3D <2>;
> > +
> > +                     interrupts =3D <GIC_SPI 920 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 921 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 925 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 926 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 927 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 928 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 950 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 951 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 952 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 953 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 954 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 955 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 956 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 957 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 958 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 885 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 886 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 887 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 888 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 842 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 843 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 844 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 845 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 847 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 802 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 803 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 804 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 805 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 806 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 807 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 808 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 809 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 810 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 812 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 813 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 814 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 837 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 838 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 839 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 854 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 855 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 790 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 793 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 794 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 795 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 796 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH>;
> > +             };
> > +
> >               intc: interrupt-controller@17a00000 {
> >                       compatible =3D "arm,gic-v3";
> >                       reg =3D <0x0 0x17a00000 0x0 0x10000>,     /* GICD=
 */
> > --
> > 2.37.2
> >
>
> --
> Eric Chanudet
>

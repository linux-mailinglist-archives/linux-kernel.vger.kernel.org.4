Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2976A7210
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCAR3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCAR3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:29:31 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AA42686F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 09:29:29 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id d12so4263997uak.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 09:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zSa8/jDUCOeEFvmxZxNTRNY4B340Gn/Sgv7llYfD0o=;
        b=VohMWAsyx/Btb65bq/onOhQZUzkseeJOlayB+YzRL8Z5Tf4SYnV+HtCyUHBOLMSfKu
         /Ppht/5hhBtpMviKMdo7jawEnrL7hErzhoqa8qyZwCmkoMKgEHt+i60JpO3bts2Qcz0G
         2qb4Vv5brGU6tkMJBWD5XkmHx55s48rHH47Nn6yrL2AHZA9cZWiS3k8yZscYeHcF9Lbl
         EP5Ovwe1PS1CMFEV8el6aR29JfCmwkxt5Am0KCzvVUq0Pob3jxnaAT+E4YcBtyVBoDpr
         uBbfZaq9eXarzVG0m6kEwiODaIt/hzXEPZInk3jmtY7+W27S5SEDszKtpNnqEJh2i/xw
         jw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zSa8/jDUCOeEFvmxZxNTRNY4B340Gn/Sgv7llYfD0o=;
        b=Dp5VSlEXNZqWKfHqYlMjQJ6PRWhtJom9m9ymTV5UkBVuMDk/dVMuF4o2bY+tU/R4Zm
         IZ5IQX63cOoo3nv/RxWW9nz3UuL5iO2oOqKZfCfYjrtb2NS7IwAQucUzzP4fJVM4cErD
         p9O0V+lB2xaN1QZ5yfgnGg1l72VBhKoz6RxtRaQjsFplnjwLBDzCbQEO0wL7f9L88wBY
         YCq3aBaOI8HMIc/JwEKPlepWCdtlL/Iuoc7skdCNOVxNRNxhkpZmBVWphSEsaNsukkKm
         I9gOU21UxIlyg6n5NClqUUtKYV9sjBvQ4JQGw6UjmmyTKxNw4rJnJ53hHUB219FqHNbV
         hR+A==
X-Gm-Message-State: AO0yUKX8p2HvkkqLPPiA/5SrCdqZtFnkFVS8ERz9uwY43AEIF0t27qYD
        11d6xK4s7m7pSnhHPczP5Ej8YpC+UR/OIyml+pmVEg==
X-Google-Smtp-Source: AK7set+D6dsvzBgrOvDnT+VtMRD9YqtcnKD2oAVBnXRf/+vzA3eELxnEHh1SarXNKzbBJjIvIWtMhoS6lND/6sKcbcw=
X-Received: by 2002:a05:6122:656:b0:401:8898:ea44 with SMTP id
 h22-20020a056122065600b004018898ea44mr3968343vkp.3.1677691768586; Wed, 01 Mar
 2023 09:29:28 -0800 (PST)
MIME-Version: 1.0
References: <c534c2a458a3bf94ccdae8abc6edc3d45a689c30.1649777295.git.robin.murphy@arm.com>
 <CAJ+vNU3+rz50MRQQsz39Jfbspy2ig9tqzb_yg1RFooxGutCM+g@mail.gmail.com>
 <86lekhl6i6.wl-maz@kernel.org> <410c8561-a7e3-6a3f-b634-08adaa806111@arm.com>
In-Reply-To: <410c8561-a7e3-6a3f-b634-08adaa806111@arm.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 1 Mar 2023 09:29:16 -0800
Message-ID: <CAJ+vNU1bBLnJ2_mLmdW-JSysK1YDXsdS01SEB9+BUNytNGMhOA@mail.gmail.com>
Subject: Re: [RFC PATCH] irqchip/gic-v3: Claim iomem resources
To:     Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, Mar 1, 2023 at 8:13=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 2023-02-28 23:22, Marc Zyngier wrote:
> > On Tue, 28 Feb 2023 23:11:15 +0000,
> > Tim Harvey <tharvey@gateworks.com> wrote:
> >>
> >> I have bisected a kernel issue where octeontx (CN803x) will hang on
> >> reboot caused by commit c0db06fd0993 ("mmc: core: Disable card detect
> >> during shutdown"). This commit made it into 5.16 and stable kernels.
> >> I've found that the patch here which is commit 2b2cd74a06c3 resolves
> >> this hang but I'm not entirely clear why.
> >>
> >> Does anyone have a good explanation of why the hang occurs in the
> >> first place and why this resolves it? I would like to get the proper
> >> fix into the affected stable branches.
> >
> > Wild guess: the reservation prevents some other driver from probing
> > because the firmware describes overlapping ranges, and that driver is
> > what is causing your above hang.
>
> Indeed, according to [1], the GIC appears to overlap one of the "PCIe"
> windows of &ecam0, which conveniently appears to be the parent of the
> MMC controller as well.
>
> Robin.
>
> [1]
> https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/cn81xx=
-linux.dtsi

Robin and Marc,

Thanks! Yes, this patch exposes an issue in my dt which ends up
killing off ecam0 thus hiding the original 'hang on reboot' issue I
was trying to find related to mmc with a quick bisect.

As you expected ecam0 fails probe:
[    0.977514] pci-host-generic: probe of 848000000000.pci failed with erro=
r -12

Cavium/Marvell never mainlined their cn81xx device-tree and their
latest SDK appears to still have this issue. It looks to me like the
first mem range in ecam0 is just wrong and needs to be removed:
@@ -226,8 +226,7 @@ ecam0: pci@848000000000 {
                        u-boot,dm-pre-reloc;
                        dma-coherent;
                        reg =3D <0x8480 0x00000000 0 0x02000000>;  /*
Configuration space
 */
-                       ranges =3D <0x03000000 0x8010 0x00000000 0x8010
0x00000000 0x080
0x00000000>, /* mem ranges */
-                                <0x03000000 0x8100 0x00000000 0x8100
0x00000000 0x80
0x00000000>, /* SATA */
+                       ranges =3D <0x03000000 0x8100 0x00000000 0x8100
0x00000000 0x80
0x00000000>, /* SATA */
                                 <0x03000000 0x8680 0x00000000 0x8680
0x00000000 0x160
0x28000000>, /* UARTs */
                                 <0x03000000 0x87e0 0x2c000000 0x87e0
0x2c000000 0x000
0x94000000>, /* PEMs */
                                 <0x03000000 0x8400 0x00000000 0x8400
0x00000000 0x010
0x00000000>, /* RNM */

This results in:
[    0.911162] pci-host-generic 848000000000.pci: host bridge
/soc@0/pci@848000000000 ranges:
[    0.919506] pci-host-generic 848000000000.pci:      MEM
0x810000000000..0x817fffffffff -> 0x810000000000
[    0.929018] pci-host-generic 848000000000.pci:      MEM
0x868000000000..0x87e027ffffff -> 0x868000000000
[    0.938531] pci-host-generic 848000000000.pci:      MEM
0x87e02c000000..0x87e0bfffffff -> 0x87e02c000000
[    0.948039] pci-host-generic 848000000000.pci:      MEM
0x840000000000..0x840fffffffff -> 0x840000000000
[    0.957543] pci-host-generic 848000000000.pci:      MEM
0x843000000000..0x8431ffffffff -> 0x843000000000
[    0.967054] pci-host-generic 848000000000.pci:      MEM
0x87e0c6000000..0x87ffffffffff -> 0x87e0c6000000
[    0.976562] pci-host-generic 848000000000.pci: Memory resource size
exceeds max for 32 bits
[    0.984923] pci-host-generic 848000000000.pci: Memory resource size
exceeds max for 32 bits
[    0.993284] pci-host-generic 848000000000.pci: Memory resource size
exceeds max for 32 bits
[    1.001645] pci-host-generic 848000000000.pci: Memory resource size
exceeds max for 32 bits
[    1.010008] pci-host-generic 848000000000.pci: Memory resource size
exceeds max for 32 bits
[    1.018404] pci-host-generic 848000000000.pci: ECAM at [mem
0x848000000000-0x848001ffffff] for [bus 00-1f]
[    1.028240] pci-host-generic 848000000000.pci: PCI host bridge to bus 00=
00:00
[    1.035412] pci_bus 0000:00: root bus resource [bus 00-1f]
[    1.040907] pci_bus 0000:00: root bus resource [mem
0x810000000000-0x817fffffffff]
[    1.048488] pci_bus 0000:00: root bus resource [mem
0x868000000000-0x87e027ffffff]
[    1.056070] pci_bus 0000:00: root bus resource [mem
0x87e02c000000-0x87e0bfffffff]
[    1.063652] pci_bus 0000:00: root bus resource [mem
0x840000000000-0x840fffffffff]
[    1.071232] pci_bus 0000:00: root bus resource [mem
0x843000000000-0x8431ffffffff]
[    1.078815] pci_bus 0000:00: root bus resource [mem
0x87e0c6000000-0x87ffffffffff]

and all of the PCI devices appear to work fine. Is there an additional
issue I need to work on regarding the 'Memory resource size exceeds
max for 32 bits' warning above?

Best Regards,

Tim

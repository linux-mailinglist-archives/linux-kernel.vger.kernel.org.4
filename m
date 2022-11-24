Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0C6637DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKXQkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:40:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CF4122942
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:40:14 -0800 (PST)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0ACD53F221
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669308011;
        bh=rFBx8o9ACr2aE3UXlk16oilIXDTZ3TK8L+Ksy/y90RU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=b2hIghAdfhN+u1QlWRhqvH49RiP3lpueoPPYUViLjmuWE0Al+czHFB3IQnWqgH1e4
         3Kuj+RqM3hAxbjlThDt2atBTSGcqINNsRKiAaRXT7Et9kUbUABoTWyHX9tgxqqyJ4h
         zLF/C6XbBalqzA3L42ogy5LI20gK/qjDliYBeLrWUTGSz8NRGZQaejSlnpEX2r0YJf
         3uR9Rl+Erbvjs9Gh9NvVEhDHdTtQ8Cp5HQzMgGK7j80ySnkOTt+ww+3fMCJbrpgjIM
         abtRqx8Q2fglJuPIeKb0oG20qd0fizYjUtSSJu17I81ShF+yWduw1O4a/R+5x1dWQW
         tSVXNiAB8JUmQ==
Received: by mail-il1-f197.google.com with SMTP id s4-20020a056e02216400b003021b648144so1435015ilv.19
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFBx8o9ACr2aE3UXlk16oilIXDTZ3TK8L+Ksy/y90RU=;
        b=whHuq5i+YNWMOf0oZc1zSp9FGA0D/OP6PsBWm0qILmgVmFRnXzSeXR7ozObuqLmQLG
         L/0BCM4mBn/1wjsQRxlJ2ed85v0yCc3XdEvXVCGmMrCDf3dS0FzOcYpgISOSsRoQmVTB
         P5QYqj45NNLZ+3og7b5h9ITEJYNC/Q9IddI0MiSOnZcoeQHvTx3QfG7/bN81btJA+T+/
         y6btOq1amjZf/FvCPxucyyFf8buwTN2w43pVLM8MLmsHIYsYCKRCGwjo+zcUJIKW//VM
         byaf/92FEqzhpLVkaQuphx16j4Yfaj27QBkCTYczgRxh0VEewQfGV9tFZbOYH5ThXscb
         le/g==
X-Gm-Message-State: ANoB5pk/pUtKO/HCkwDSJLl4lv/JNXhiL4oGaVCvAyGk+qZ2YO0bk0IZ
        XkQQucioH3zc2K2+S+bkkOZIimk0wFyGcw29cqyOuy2OUNEFigMoG5HX3IZpRSiTRuH67IFuF7C
        OWbD1zVqOEzAL18F2k9FPF1l5QCy1fBicJUNCBentqxJ5mEkv+ANA/jx5Wg==
X-Received: by 2002:a6b:5904:0:b0:6af:ed54:1c81 with SMTP id n4-20020a6b5904000000b006afed541c81mr8426721iob.106.1669308009795;
        Thu, 24 Nov 2022 08:40:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6aovE2/ZA6S/DsuJGYDElLduwKMbC8q/hMU3FEu6WeD0yAmkdGpz22Y9xg5ahZfk76UnYd5HasZD8Lb1aFD9U=
X-Received: by 2002:a6b:5904:0:b0:6af:ed54:1c81 with SMTP id
 n4-20020a6b5904000000b006afed541c81mr8426709iob.106.1669308009474; Thu, 24
 Nov 2022 08:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20221103021822.308586-1-david.e.box@linux.intel.com>
 <5c766840-e092-45ea-0664-7bbdb78b933a@canonical.com> <17b05a72d2db1074cef9d5e9f85b347850f171d5.camel@linux.intel.com>
In-Reply-To: <17b05a72d2db1074cef9d5e9f85b347850f171d5.camel@linux.intel.com>
From:   You-Sheng Yang <vicamo.yang@canonical.com>
Date:   Fri, 25 Nov 2022 00:39:58 +0800
Message-ID: <CA+rHWA+7KudasAMnO=dCUSQWb76Eu=DALA=1eLd_jjLw0dEMkA@mail.gmail.com>
Subject: Re: [PATCH V8 0/4] PCI: vmd: Enable PCIe ASPM and LTR on select hardware
To:     david.e.box@linux.intel.com
Cc:     michael.a.bottini@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@adhityamohan.in,
        rafael@kernel.org, hch@infradead.org, robh@kernel.org,
        bhelgaas@google.com, kw@linux.com, lorenzo.pieralisi@arm.com,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 12:09 AM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Hi You-Sheng,
>
> On Wed, 2022-11-23 at 18:27 +0800, You-Sheng Yang wrote:
> > Hi David,
> >
> > On 11/3/22 10:18, David E. Box wrote:
> > > This series adds a work around for enabling PCIe ASPM and for setting PCIe
> > > LTR values on VMD reserved root ports on select platforms. While
> > > configuration of these capabilities is usually done by BIOS, on these
> > > platforms these capabilities will not be configured because the ports are
> > > not visible to BIOS. This was part of an initial design that expected the
> > > driver to completely handle the ports, including power management. However
> > > on Linux those ports are still managed by the PCIe core, which has the
> > > expectation that they adhere to device standards including BIOS
> > > configuration, leading to this problem.
> > >
> > > The target platforms are Tiger Lake, Alder Lake, and Raptor Lake though the
> > > latter has already implemented support for configuring the LTR values.
> > > Meteor Lake is expected add BIOS ASPM support, eliminating the future need
> > > for this work around.
> >
> >
> > It appears to me that this patch series works only on Tiger Lake. We
> > have tried to revert our current work-arounds in Ubuntu kernels
> > generic-5.15/oem-5.17/oem-6.0/unstable-6.1 and apply this series, the
> > prebuilt kernels can be found in:
> >
> >    https://launchpad.net/~vicamo/+archive/ubuntu/ppa-1996620
> >
> > However, only TGL can still enter PC10 as before.
> >
> >
> > ADL-M, RPL platforms will stay in PC3 with vmd LTR set, but ASPM
> > disabled.
>
> For the patch to work BIOS must allow the OS to control ASPM. If this is not the
> case then you will see the message "ACPI FADT declares the system doesn't
> support PCIe ASPM, so disable it". Please check for this on the systems that
> don't work. If so the only option is a BIOS change to enable it.

Thank you. It's exactly what you said. The ADL-M/RPL platforms I have
do not support OS PCIe ASPM.

> David
>
> >  i915 RC6 blocked, too:
> >
> > $ sudo cat /sys/kernel/debug/dri/
> >
> > 0/i915_dmc_info
> > ...
> > DC3CO count: 0
> > DC3 -> DC5 count: 100
> > DC5 -> DC6 count: 0
> >
> >
> > > Note, the driver programs the LTRs because BIOS would also normally do this
> > > for devices that do not set them by default. Without this, SoC power
> > > management would be blocked on those platform. This SoC specific value is
> > > the maximum latency required to allow the SoC to enter the deepest power
> > > state.
> > >
> > > This patch addresses the following open bugzillas on VMD enabled laptops
> > > that cannot enter low power states.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=212355
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215063
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=213717
> > >
> > > David E. Box (3):
> > >    PCI: vmd: Use PCI_VDEVICE in device list
> > >    PCI: vmd: Create feature grouping for client products
> > >    PCI: vmd: Add quirk to configure PCIe ASPM and LTR
> > >
> > > Michael Bottini (1):
> > >    PCI/ASPM: Add pci_enable_link_state()
> > >
> > >   drivers/pci/controller/vmd.c | 96 ++++++++++++++++++++++++++----------
> > >   drivers/pci/pcie/aspm.c      | 54 ++++++++++++++++++++
> > >   include/linux/pci.h          |  7 +++
> > >   3 files changed, 131 insertions(+), 26 deletions(-)
> > >
> > >
> > > base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
> >
> >
> > Regards,
> > You-Sheng Yang
> >
>


-- 
Regards,
You-Sheng Yang

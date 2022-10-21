Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FA2607B71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiJUPrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiJUPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:47:31 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90435814D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:46:50 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id r3so3802766yba.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RXItDXJ/Ml3IUjXg4GmR8kWvZb6b9L0vGRz8r8mXDs=;
        b=Q1uHvIr/Me3XlWSUlN3kNiSLqHDIBgh3dc2YVpZhOmViER/b8asp6FMQohe7f8O5rK
         OPjoOtF/SGmlPYNYXmoq8zrmMvlkTyBZL3LJ4JTaVI1VuWlFeG+6hRQeeZC9kqfgtW3A
         h3HFHnsrTiX6Sf2gr9+Be2OtRQd2fDkWMISvvNHPAX5whlKbzFapUX/fwOR7uqXb/F5A
         bjLhiM1yj9bJjJ6LUCT6009WQWoBOd61vxpXCt/BBmshvD2jUZilKE9K8qAhDPYECmPD
         pvYND6ECYnNRV3KSMfQb5YDuprTnJcp2ilIrILQ9+xxc2zx5v64o9l3gAJzgzS5e9osP
         ZpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RXItDXJ/Ml3IUjXg4GmR8kWvZb6b9L0vGRz8r8mXDs=;
        b=OJr/5Z1POzkhvMtNIoS9SUyvQjGWUVg2lBxv2fCzSD9XqKu9UQY0IIA9JrAEJgtWvj
         jqH/xG5HrIMo+ZruYFuIJ+4H/BqL4nfCEGNyn84epGhLmxqsb7g63MUbswX/Sm8tXAbs
         8d2Ep23PlYjpSoeubAHEK+vgBnsrbetXx322ANSA9t/FQKgI1EfZ3cEnoK+cBCLq3Aia
         RGWNaTFqVPAN/vxGqEekEONJ1qKulv1YCQBNiXwZh8+dHQp6GqVnMaroYi3gCc4qR3ST
         aJ/9H1n/i+Dv6l+JKICXKiJTlZqEoA0iv1cf53Vic8azlS0Js+6baDIn1l1PGhTSAeZg
         KQ7A==
X-Gm-Message-State: ACrzQf3ZfgGMkFgqrkN8mSSyGV/V4YqiWrHtAlZsC5qVM8fnQWHjHh88
        hHwaRgkZ90wKqsyLk1V+wdM+8S9M05BKsRIybdYHsw==
X-Google-Smtp-Source: AMsMyM4wHAFcilTO9hMOnlaVMmagzB5Km/M7N/n/4pRk22LaNUomks0PkJLBB1nKN/aBXBVWjOyzl78un5ODX9VIyGA=
X-Received: by 2002:a05:6902:705:b0:6bd:3822:78c3 with SMTP id
 k5-20020a056902070500b006bd382278c3mr17271586ybt.225.1666366847425; Fri, 21
 Oct 2022 08:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAFJ_xbq0cxcH-cgpXLU4Mjk30+muWyWm1aUZGK7iG53yaLBaQg@mail.gmail.com>
 <20221021111935.GB28729@wunner.de> <CAFJ_xboDuFiACjECO0UmYz5y9TCz4rTRPmrxeVMup7r9816dTg@mail.gmail.com>
 <CAOs-w0KRYh-=gTb0Ed5iYAMs92AYtV_oEei5OgezgKGfwfiBYg@mail.gmail.com>
In-Reply-To: <CAOs-w0KRYh-=gTb0Ed5iYAMs92AYtV_oEei5OgezgKGfwfiBYg@mail.gmail.com>
From:   =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Date:   Fri, 21 Oct 2022 17:40:31 +0200
Message-ID: <CAOs-w0KNvzfT9tSzXUZeoRthMBt1rgDf-arXY6uvkNJpNBrxBQ@mail.gmail.com>
Subject: Re: [BUG] Intel Apollolake: PCIe bridge "loses" capabilities after
 entering D3Cold state
To:     Lukasz Majczak <lma@semihalf.com>, Vidya Sagar <vidyas@nvidia.com>
Cc:     Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
        Rajat Jain <rajatja@google.com>, upstream@semihalf.com,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> pt., 21 pa=C5=BA 2022 o 13:19 Lukas Wunner <lukas@wunner.de> napisa=C5=
=82(a):
>> >
>> > On Fri, Oct 21, 2022 at 12:17:35PM +0200, Lukasz Majczak wrote:
>> > > While working with Vidya???s patch I have noticed that after
>> > > suspend/resume cycle on my Chromebook (Apollolake) PCIe bridge loses
>> > > its capabilities - the missing part is:
>> > >
>> > > Capabilities: [200 v1] L1 PM Substates
>> > > L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Subs=
tates+
>> > >   PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D10us
>> > > L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>> > >    T_CommonMode=3D40us LTR1.2_Threshold=3D98304ns
>> > > L1SubCtl2: T_PwrOn=3D60us
>> > >
>> > > Digging more I???ve found out that entering D3Cold state causes this
>> >
>> > You mean the capability is gone from lspci after D3cold?
>> >
>> > My understanding is that BIOS is responsible for populating config spa=
ce.
>> > So this sounds like a BIOS bug.  What's the BIOS vendor and version?
>> > (dmesg | grep DMI)
>> >
>> > Thanks,
>> >
>> > Lukas
>>
>> Hi Lukasz
>>
>> here is the DMI
>>
>> localhost ~ # dmesg | grep DMI
>> [    0.000000] DMI: Google Coral/Coral, BIOS Google_Coral.10068.81.0 11/=
27/2018
>> [    0.155420] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
>> [    0.447820] [drm] DMI info: DMI_BIOS_VENDOR coreboot
>> [    0.447828] [drm] DMI info: DMI_BIOS_VERSION Google_Coral.10068.81.0
>> [    0.447832] [drm] DMI info: DMI_BIOS_DATE 11/27/2018
>> [    0.447835] [drm] DMI info: DMI_BIOS_RELEASE 4.0
>> [    0.447838] [drm] DMI info: DMI_SYS_VENDOR Google
>> [    0.447841] [drm] DMI info: DMI_PRODUCT_NAME Coral
>> [    0.447844] [drm] DMI info: DMI_PRODUCT_VERSION rev3
>> [    0.447848] [drm] DMI info: DMI_PRODUCT_FAMILY Google_Coral
>>
>> Yes, you are right and in our internal discussion the vendor (Intel)
>> has proposed a firmware patch, although I couldn't verified that the
>> issue is limited only to the given firmware/bios, so decided to send
>> this email.
>>
>> Best regards,
>> Lukasz

Lukasz, Vidya, is the change in behaviour in V4 intentional fix for
mentioned problems with missing devices after D3cold or unintentional
side effects.
Or from another angle, can we base on this behaviour as a hotfix for
problems with missing devices?

As far as I understand we probably still should update FW in the fleet
of devices, right?

ps: Sorry for top-posting in the previous email, I forgot to switch my
gmail client.

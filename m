Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDAF69AAF5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBQMDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBQMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:02:58 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705BE1714C;
        Fri, 17 Feb 2023 04:02:55 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cp18so2843106pjb.0;
        Fri, 17 Feb 2023 04:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlC9SWlLABAMwArc0MJlg7/y7YUv0bRTg7vz1NpWh/A=;
        b=GDr7z0Plukjc+zd8dFNvnu6wXv4SF2oKgzSnjOOptwNhX5+lUSfH6RTfi0R9pJLhjV
         soMBs24hdL8v1z5ax02Trhn4IlEnLKKHsgxPCTetamD7Alv/1fYWuHg657NvwEFVvRte
         fN6N5ZfzEQ6RaJrNc6Q2x4QUztytFTuRj1NofZw9Ucco1L3xWxtrI+IzsK9Ecy/7JklK
         aFJX4nAJg+JKS4as+N1Ln0eSlhpPOJhWkdJ9QSBJpA9gPmbixptP+oC0SKgSoEx8BtRM
         wRJ7C/bTAS/nuZE8RsH7u6zTbuTVEos3SY0F7f8iuTCUV/vAQGs4mXK1MwsMoLkDhbGR
         KTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlC9SWlLABAMwArc0MJlg7/y7YUv0bRTg7vz1NpWh/A=;
        b=YqSWi3TQvSsQKz7VDs8yYOmnVxoVqivAJobb1cvFiUfNXu5YWqJ+qE099owtZaffJB
         2YSH4X8VPVgQuyQ9pyXvfGKFq5SD1WfNXq4gB71Ctfzp1bZPQqr1887hHhDDqDfpB2L5
         HkeI4n6ES0xOV03SS1+w6vdtnFdYee6WuklxnbnfY6dUCTqUEduEgIcHkXxhGgLjK8Oc
         L1kE3mE3wM8chZE6Y3V8UIYLaOjypGOy7d0DvYcsiGWVXn52sIr4SftQ1VeF74j5R1VJ
         UdbS7kjCxfN5ckQyJ8AnGHZwLI6VMKG5w9ebkU2rjzqSaVBA0MLUIkZTUmG0OWmfGWic
         DFTg==
X-Gm-Message-State: AO0yUKXA5gKogb2pkhAmcZV2R9JvOgRK+Eiob+jOz/hzwpJ1sIvI1QdG
        1MM8v6X7bkF8VGVmR3TY+Jw=
X-Google-Smtp-Source: AK7set8w4PtK506TF5wq8TDqXYje7+QxOh1XviKloRudMo8pxh4CyVJs+EEVqbSNGAyo4fSu8ubuLA==
X-Received: by 2002:a05:6a20:8416:b0:c7:13bf:3fd0 with SMTP id c22-20020a056a20841600b000c713bf3fd0mr7994874pzd.25.1676635374842;
        Fri, 17 Feb 2023 04:02:54 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id c19-20020a170902849300b0019460ac7c6asm2970171plo.283.2023.02.17.04.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 04:02:54 -0800 (PST)
Date:   Fri, 17 Feb 2023 23:02:46 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v2 4/5] apple-gmux: support MMIO gmux on T2 Macs
Message-ID: <20230217230246.53e3d013@redecorated-mbp>
In-Reply-To: <20230217110531.6d3c07a1@redecorated-mbp>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
        <20230216122342.5918-5-orlandoch.dev@gmail.com>
        <cd6beabe-3026-d84e-63fd-3833948ecc1f@redhat.com>
        <20230217110531.6d3c07a1@redecorated-mbp>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2023 11:05:31 +1100
Orlando Chamberlain <orlandoch.dev@gmail.com> wrote:
> > 
> > Question are we not worried about MacBooks with an "APP000B"
> > ACPI device (with a value IORSOURCE_MEM entry) but which do not
> > actually have a gmux, because they are iGPU only ?  
> 
> It looks like iMac20,1, iMac20,2, and iMacPro1,1 have APP000B:
> 
> apple_gmux: Failed to find gmux I/O resource
> 
> iMac20,2: https://linux-hardware.org/?probe=ec2af584b3&log=dmesg
> iMac20,1: https://linux-hardware.org/?probe=fee7644b9c&log=dmesg
> iMacPro1,1: https://linux-hardware.org/?probe=6c26c9ff8c&log=dmesg
> 
> But I'm not sure if they actually have it or not. I'll see if I can
> get people with those models to test if it's a real gmux. There does
> seem to be a pattern in that those three all have AMD GPU's.

Kerem Karabay managed to find the acpi tables and macOS's ioreg from and
iMacPro1,1:

https://github.com/khronokernel/DarwinDumped/blob/master/iMacPro/iMacPro1%2C1/Darwin%20Dumper/DarwinDumper_3.0.4_30.12_15.30.40_iMacPro1%2C1_Apple_X64_High%20Sierra_17C2120_apple/ACPI%20Tables/DSL/DSDT.dsl#L10423
https://github.com/khronokernel/DarwinDumped/blob/master/iMacPro/iMacPro1%2C1/Darwin%20Dumper/DarwinDumper_3.0.4_30.12_15.30.40_iMacPro1%2C1_Apple_X64_High%20Sierra_17C2120_apple/IORegistry/IOReg.txt#L5096

The DSDT table has the same APP000B device as MacBooks with actual gmux,
while the ioreg has no mention of Apple's driver AppleMuxControl2 being
used for that device.

I think that confirms Apple has not fixed the issue of putting
APP000B's where they don't need to.

Solutions to this I can think of are:

- Use DMI matching to ignore product_names "iMacPro1,1" "iMac20,1",
  "iMac20,2"
- Maybe check if the MMIO region for gmux is filled with 0xff*

*I don't know if this would work or not as I don't have a machine to
check with. On my machine everything surrounding the 16 bytes used for
gmux is 0xff:

# hexdump -n48 -C -s 0xfe0b01f0 /dev/mem
fe0b01f0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
fe0b0200  00 00 3e 4f 00 00 00 00  00 00 00 00 00 00 14 00  |..>O............|
fe0b0210  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|

so maybe on the iMacPro and iMac's, this would all be 0xff.

> 
> I've looked at dmesg or at least lsmod on all the models with the T2
> chip and there wasn't evidence of any other models having that error
> or having apple-gmux loaded on any models that shouldn't have a gmux,
> other than the three mentioned above. Of course I don't know if its
> possible for there to be firmware versions where this isn't the case.
> 
> > 
> > I have learned the hard way (through backlight control regressions
> > in 6.1) that at least some older model MacBooks with an IO resource
> > have an APP000B ACPI device without them actually having a gmux,
> > these get caught by the version check and then do not pass the
> > indexed check so that apple_gmux_detect() properly returns false.
> > 
> > Maybe make gmux_mmio_read32() a static inline inside
> > include/linux/apple-gmux.h and try to read the version here ?  
> 
> For that would we need to ioremap() and iounmap()?
> > 
> > Has this been tested on iGPU only T2 Macs?  
> 
> I don't think so. 
> 
> > 
> > Regards,
> > 
> > Hans
> > 
> >   
> 


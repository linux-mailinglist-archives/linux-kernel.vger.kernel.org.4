Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9369BA0E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 13:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBRMwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 07:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBRMwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 07:52:35 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A079617CE9;
        Sat, 18 Feb 2023 04:52:32 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id y1so417144pgr.7;
        Sat, 18 Feb 2023 04:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/IEWKH4bEBLVMFJRg9tQoFnfuVGCDKYj1urXec8x4s=;
        b=jAHoFspDuM8jhz+XurwOsdzsol5+zqQjTjreraIoEQp5kOLW/PB31Tzu1yxlWHmbVN
         pCzEndxZTkI+Fs/fmrwvhCYfIVppplU5jo1kObTuzXkdelqUQ6phraaJbIEw+c6NOxFX
         GwhIqLuAwV02m1W/jf06YpiNZncl6irXflBydz8yw1mb2TFvUIOF3h2IL8ovea8FOUcg
         CO1ubGkcomSdDMnSQ3ekbIWCmfCcMV2CX2i/OxWYRjzD0kUsCw2nL1rBllnzLLyUg4jU
         a0qYLylHIbnEKB5ot3FVDPTSBQ6jQoTOTURlxzp4z0qRivgEA4VEpQjGM3bX3Dk2b/OE
         yY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/IEWKH4bEBLVMFJRg9tQoFnfuVGCDKYj1urXec8x4s=;
        b=bhA81bU+bpCKJHRAc4md18xR7PjAmW/zj3boRx9Ar09U+JDKrYKmrR2cOxALhYox0G
         gBE8v5lmLcvsAmlugGfpaQ7oGD4p9X0gVZ48VRVcGfMu4lg7u4zWZhcmtGI/SiqHNtJw
         5EYq1LQh0aguChiqo/lWeG5UH5CgrCronevS9CHUhcrRFoJ55trhgljAX9I1ZacmVIIm
         oACt/QPw9wZybyDAGAIQG9ATcaCEl1Q2CbczRPqrFafIqtjQCfNd4Vvs7nmOCBvYsZVx
         878Z8d39y3pb9bmULwt+bFrplio1V9zZASHQm5+EiFrXtCeHJoFiR6ji2pUI1ZLd2uqz
         3c6g==
X-Gm-Message-State: AO0yUKVsL8pvHpBC2OlyyaP7+9qPCH0znlR5z6Mpifo71QBWQKUIP1UP
        hW/tB7iarCZ9/apOEXyC0so=
X-Google-Smtp-Source: AK7set88chkLmx+kb2X5OykVJGsUBfY/nQJggqzBfMt5yyhhh6A0gSKybB+Q2Xugr3DLYEw97MhIXg==
X-Received: by 2002:aa7:978a:0:b0:5a8:8535:18b with SMTP id o10-20020aa7978a000000b005a88535018bmr4143296pfp.11.1676724752048;
        Sat, 18 Feb 2023 04:52:32 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7804c000000b00590ede84b1csm4748819pfm.147.2023.02.18.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 04:52:31 -0800 (PST)
Date:   Sat, 18 Feb 2023 23:52:22 +1100
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
Message-ID: <20230218235222.17983234@redecorated-mbp>
In-Reply-To: <9be4b45a-83cb-b671-e7df-c4c8812b5506@redhat.com>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
        <20230216122342.5918-5-orlandoch.dev@gmail.com>
        <cd6beabe-3026-d84e-63fd-3833948ecc1f@redhat.com>
        <20230217110531.6d3c07a1@redecorated-mbp>
        <20230217230246.53e3d013@redecorated-mbp>
        <9be4b45a-83cb-b671-e7df-c4c8812b5506@redhat.com>
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

On Sat, 18 Feb 2023 11:49:52 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/17/23 13:02, Orlando Chamberlain wrote:
> > On Fri, 17 Feb 2023 11:05:31 +1100
> > Orlando Chamberlain <orlandoch.dev@gmail.com> wrote:  
> >>>
> >>> Question are we not worried about MacBooks with an "APP000B"
> >>> ACPI device (with a value IORSOURCE_MEM entry) but which do not
> >>> actually have a gmux, because they are iGPU only ?    
> >>
> >> It looks like iMac20,1, iMac20,2, and iMacPro1,1 have APP000B:
> >>
> >> apple_gmux: Failed to find gmux I/O resource
> >>
> >> iMac20,2: https://linux-hardware.org/?probe=ec2af584b3&log=dmesg
> >> iMac20,1: https://linux-hardware.org/?probe=fee7644b9c&log=dmesg
> >> iMacPro1,1: https://linux-hardware.org/?probe=6c26c9ff8c&log=dmesg
> >>
> >> But I'm not sure if they actually have it or not. I'll see if I can
> >> get people with those models to test if it's a real gmux. There
> >> does seem to be a pattern in that those three all have AMD GPU's.  
> > 
> > Kerem Karabay managed to find the acpi tables and macOS's ioreg
> > from and iMacPro1,1:
> > 
> > https://github.com/khronokernel/DarwinDumped/blob/master/iMacPro/iMacPro1%2C1/Darwin%20Dumper/DarwinDumper_3.0.4_30.12_15.30.40_iMacPro1%2C1_Apple_X64_High%20Sierra_17C2120_apple/ACPI%20Tables/DSL/DSDT.dsl#L10423
> > https://github.com/khronokernel/DarwinDumped/blob/master/iMacPro/iMacPro1%2C1/Darwin%20Dumper/DarwinDumper_3.0.4_30.12_15.30.40_iMacPro1%2C1_Apple_X64_High%20Sierra_17C2120_apple/IORegistry/IOReg.txt#L5096
> > 
> > The DSDT table has the same APP000B device as MacBooks with actual
> > gmux, while the ioreg has no mention of Apple's driver
> > AppleMuxControl2 being used for that device.
> > 
> > I think that confirms Apple has not fixed the issue of putting
> > APP000B's where they don't need to.
> > 
> > Solutions to this I can think of are:
> > 
> > - Use DMI matching to ignore product_names "iMacPro1,1" "iMac20,1",
> >   "iMac20,2"
> > - Maybe check if the MMIO region for gmux is filled with 0xff*
> > 
> > *I don't know if this would work or not as I don't have a machine to
> > check with. On my machine everything surrounding the 16 bytes used
> > for gmux is 0xff:
> > 
> > # hexdump -n48 -C -s 0xfe0b01f0 /dev/mem
> > fe0b01f0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> > |................| fe0b0200  00 00 3e 4f 00 00 00 00  00 00 00 00
> > 00 00 14 00  |..>O............| fe0b0210  ff ff ff ff ff ff ff ff
> > ff ff ff ff ff ff ff ff  |................|
> > 
> > so maybe on the iMacPro and iMac's, this would all be 0xff.  
> 
> Yes checking for a regular ioread32 returning 0xffffffff sounds
> like it should work. Can you add a check for that in the next version
> please ?  Note this means we still need to do an iomap + unmap as
> you pointed out in another email, but I see no way around that.

I'll check that GMUX_MMIO_COMMAND_SEND (16th byte) is not 0xff, as if
the gmux is present it will reset that to 0x00, unless a command isn't
finished yet, in which case it will be one of 0x1, 0x4, 0x41, or 0x44.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> >   
> >>
> >> I've looked at dmesg or at least lsmod on all the models with the
> >> T2 chip and there wasn't evidence of any other models having that
> >> error or having apple-gmux loaded on any models that shouldn't
> >> have a gmux, other than the three mentioned above. Of course I
> >> don't know if its possible for there to be firmware versions where
> >> this isn't the case. 
> >>>
> >>> I have learned the hard way (through backlight control regressions
> >>> in 6.1) that at least some older model MacBooks with an IO
> >>> resource have an APP000B ACPI device without them actually having
> >>> a gmux, these get caught by the version check and then do not
> >>> pass the indexed check so that apple_gmux_detect() properly
> >>> returns false.
> >>>
> >>> Maybe make gmux_mmio_read32() a static inline inside
> >>> include/linux/apple-gmux.h and try to read the version here ?    
> >>
> >> For that would we need to ioremap() and iounmap()?  
> >>>
> >>> Has this been tested on iGPU only T2 Macs?    
> >>
> >> I don't think so. 
> >>  
> >>>
> >>> Regards,
> >>>
> >>> Hans
> >>>
> >>>     
> >>  
> >   
> 


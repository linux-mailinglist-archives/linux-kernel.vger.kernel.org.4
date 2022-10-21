Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CC36073EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJUJW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiJUJWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:22:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937D7173FD0;
        Fri, 21 Oct 2022 02:22:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z97so3464904ede.8;
        Fri, 21 Oct 2022 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WXeFO3tUDl+b4UBpDrafdYBgxDIIGsV6RGnq49HKvNI=;
        b=hGMYaCIQsODSXmUvaY7dBUd2U2fMUgPvXW4wWk5uDSx1XjF78IynDgvKXOhCLulFBl
         8hXFr2eXM1Zx4OJNqXEkXVYSIhHAizQoeTh/jpsyv8RR4l3NzW63pGBrf42ZXbULdxTu
         S2O5YjTt49V8LazCHhtJvkJ2zVYI45/rFtbvbosZCKi27vi/GX0txr2FgCVjp6FC8uyI
         49MAsnenU1EKvKMcWv8IWfGIpCmXyObx+JdGzZ/7r8V8ZcTknvDVkzPpdCtH/VyqnZHU
         brE0r+V8+EcugxdCWjm5DOpRW45lXk9obU7MuHjbnGPc2BbpjVtF+Dpd3x+t23gdR/KN
         8PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXeFO3tUDl+b4UBpDrafdYBgxDIIGsV6RGnq49HKvNI=;
        b=7kuy4KtMIdplCwgcv77nWGdTZvh6b1Y1ZJrpiHTK8vysOv+C/qXkN62fMn7ZHFSiH7
         TXSc9Ek06MvSbXnnEuADQ29rs13lSqfmgj1eTZmyZrJvNrJnwIhSetqBCIfD6MPLGl/9
         q4JQ16d0X7wYQ/D7z4avMmR1SUX/vgZV2eaixmmVGqApFV7TNJUN64wSNxlpSdZ+N95O
         j2W3KtMnC+S6G31J9Slvz4TjHlRGGa906F86dropXDyNOR5zIvNIHMsvfxu4vMB2o2Bb
         haUGsHdIfxHCHDDDKnK2d03Xrq7XEFjtgGuuQtT9wVCn0Ngguq69flP6nsvVpxgc5K8K
         sgUw==
X-Gm-Message-State: ACrzQf3hTlFjLRlPviglReGW5VsHcBh3xA/+7K5rcfkcxKW4i4FEOVyu
        GpBZ52V5Jp4/4wP9zvw7XzE=
X-Google-Smtp-Source: AMsMyM6kVJkpq4aVxDJwEu5TH4lJhVBGtKdR/DRP6PPqVKrAR+U8WqfRUdPGImQBGmUZTH1RlEwYeg==
X-Received: by 2002:a05:6402:f18:b0:460:cf08:2b41 with SMTP id i24-20020a0564020f1800b00460cf082b41mr6034825eda.400.1666344122646;
        Fri, 21 Oct 2022 02:22:02 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id nb36-20020a1709071ca400b00780f24b797dsm11445031ejc.108.2022.10.21.02.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:22:01 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 97626BE2DE0; Fri, 21 Oct 2022 11:22:00 +0200 (CEST)
Date:   Fri, 21 Oct 2022 11:22:00 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, adi@kriegisch.at
Subject: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
Message-ID: <Y1JkuKTjVYrOWbvm@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We got the following report in Debian after an update from 5.10.140 to
the current 5.10.149. Full quoting below (from
https://bugs.debian.org/1022126). Does this ring some bell about known
regressions?
On Thu, Oct 20, 2022 at 05:21:03PM +0200, Adi Kriegisch wrote:
> Package: linux-image-5.10.0-19-amd64
> Version: 5.10.149-1
> Severity: important
> 
> Dear maintainers,
> 
> with the upgrade to the latest bullseye kernel (5.10.149-1), our xen setup
> is unbootable due to swiotlb buffer errors:
>   | sd 0:0:0:0: scsi_dma_map failed: request for 401408 bytes!
> and
>   | mpt3sas 0000:01:00.0: swiotlb buffer is full (sz: 401408 bytes),
>   |     total 32768 (slots), used 0 (slots)
> (the byte sizes vary between boots).
> 
> After reading bug #850425[1], we also tried to force 32bit mode in the
> mpt3sas driver by specifying a dom0 memory below 4G; this lets the machine
> boot, but almost immediately after that fails with the same error. Notable
> difference is that the used slots are 128.
> 
> Xen commandline:
>   dom0_mem=4096M,max:4096M dom0_max_vcpus=4 dom0_vcpus_pin
>   ucode=scan xpti=dom0=false,domu=true gnttab_max_frames=128
> 
> Using dom0-iommu=map-inclusive in some combinations with swiotlb on the
> kernel commandline gives us some used slots (way below 128) in the error
> message even in 64bit dma mode in the mpt3sas driver.
> 
> The kernel works when booted without xen. We'd be more than happy to get
> pointers on how to fix that issue or patches to test!
> 
> Thanks for your help!
> 
> -- Adi
> 
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=850425

Regards,
Salvatore

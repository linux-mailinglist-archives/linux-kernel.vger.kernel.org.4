Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CE173070B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjFNSGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbjFNSFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:05:06 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E6426B5;
        Wed, 14 Jun 2023 11:04:59 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6666d5f9803so548872b3a.0;
        Wed, 14 Jun 2023 11:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765899; x=1689357899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bfg7Pd8Qi4XV2mpEzR1AaDAP2KYNRF3glqHqxSDiUr8=;
        b=EK0GrTKzHBbYTWp9usma6Nf+LfgCBhR+6T5R33A8OJW/J0oIFUFCsKOowVV9UaNlst
         UWNhXItTM7eS3KhhwsHipRSuygE1rBdcRKMSIbwP0M4GDqGsqyrZXy7J52RPNwlX2L9I
         On1gOyjjfIXAxDHfNu7oYuEh+o8rbC1Vn/Eo8440lTzVfoxq7isntagC4XVGzXzJ7thX
         p4uv6TXWtzKxeVvZehzisjyM0D2I3zylQ3nTRLPlVSWMb+unITO4mnlWQwxKTAZmXk37
         jCbzIMYhyqRa39qOu+sbU6Dy0bvASrr0X14AOOnHU9YNsCuPmCyV/uPXBEMzgGanSWPp
         N7SQ==
X-Gm-Message-State: AC+VfDyt9NSCl5hdQAci5/4MwAD4juiTOe2Ipi9UHHTv78NiTT8ho+zr
        qP18vdvtM1tv+kxir6/WHps=
X-Google-Smtp-Source: ACHHUZ508hquoDPA8b1+rAI5xOdbxD25gvcdJEa+YPdfH/GWCtVoyJJzwmdFY/bbOKj3msllkxqV3A==
X-Received: by 2002:a05:6a20:4424:b0:11a:ce33:563a with SMTP id ce36-20020a056a20442400b0011ace33563amr3161528pzb.15.1686765898436;
        Wed, 14 Jun 2023 11:04:58 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id a12-20020aa780cc000000b0063d24fcc2besm1595325pfn.125.2023.06.14.11.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 11:04:57 -0700 (PDT)
Message-ID: <3f85cb4a-8b14-623f-eb4e-40baab1ed888@acm.org>
Date:   Wed, 14 Jun 2023 11:04:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Fwd: Waking up from resume locks up on sr device
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
 <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com>
 <ZIQ6bkau3j6qGef8@duo.ucw.cz>
 <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com>
 <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
 <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net>
 <84f1c51c-86f9-04b3-0cd1-f685ebee7592@kernel.org>
 <37ed36f0-6f72-115c-85fb-62ef5ad72e76@suse.de>
 <b0fdf454-b2f7-c273-66f5-efe42fbc2807@kernel.org>
 <859f0eda-4984-4489-9851-c9f6ec454a88@rowland.harvard.edu>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <859f0eda-4984-4489-9851-c9f6ec454a88@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 07:26, Alan Stern wrote:
> On Wed, Jun 14, 2023 at 04:35:50PM +0900, Damien Le Moal wrote:
>> Or... Why the heck scsi_rescan_device() is calling device_lock() ? This
>> is the only place in scsi code I can see that takes this lock. I suspect
>> this is to serialize either rescans, or serialize with resume, or both.
>> For serializing rescans, we can use another lock. For serializing with
>> PM, we should wait for PM transitions...
>> Something is not right here.
> 
> Here's what commit e27829dc92e5 ("scsi: serialize ->rescan against
> ->remove", written by Christoph Hellwig) says:
> 
>      Lock the device embedded in the scsi_device to protect against
>      concurrent calls to ->remove.
> 
> That's the commit which added the device_lock() call.

Even if scsi_rescan_device() would use another mechanism for 
serialization against sd_remove() and sr_remove(), we still need to 
solve the issue that the ATA code calls scsi_rescan_device() before 
resuming has finished. scsi_rescan_device() issues I/O. Issuing I/O to a 
device is not allowed before that device has been resumed.

Thanks,

Bart.

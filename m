Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB3461769D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKCGLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKCGLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:11:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9AB19284;
        Wed,  2 Nov 2022 23:11:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so4268379pjc.3;
        Wed, 02 Nov 2022 23:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eA4GksuB6rLjct23PDq9x1BawsvubA/AMzbviihYdGA=;
        b=c0QuQ/HSeKDuNQClJY2Spr9f54KP00jrQvEBvRhIgySy2fe5rAEtZDsKlMeYCD7tVC
         XeJJ2ab/jE9HXcQyMA26gTJcVCC8KkIeEH0dUUFeIGsu/WvDxg28RvCiOoga4XouPwJx
         1k2xRbArCM5xVm1XyVQ8j+zQBnrf3864UYAWFdDLf5it8v5Tk2mHLFr1Gx8Ab9ELhx1n
         +ZxXe2OW7vyjcs6sx04DanSltjxmeNpib7wvSEBriMb9ohdGvJgrXkj1cj3cKd06masu
         AfL24GB2raa/rFMZCFIlYSSOjSMKT7TzCdcRza/u9LIthLdF1TmIXPfwMI8CBJAFCpMi
         BzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eA4GksuB6rLjct23PDq9x1BawsvubA/AMzbviihYdGA=;
        b=zcz8UMnJvj7/yIZo3fWdTt+96QXZAkG4txHALoedTpF9nVF0DgIo322l3hj85EFoem
         L1u0dZP0maAUObt1EwaJuNLajD7Mxlh8D2UdHUmpMxVdCL0BoHPn7pN73cEtqMaKU2cU
         693chNJw8SLgp2s6AUajvCNWfAq4sFp6pulg9FUIhGkhBQOzQMbZ2X+5Xf2I/6vB4Iia
         2gKgRUzo+wOrwifPbEiyJX3HLU5I3oWkZAR5SuFPIQieh0L+iH0vWRlzQmgyctZ+EWmg
         weJuwjen7xJzCaST8QLHTn1nc5z8r+bw+yR5Z/h36ZBoW9ZY6t8xyvZ+TWQWRCW2yjeA
         lesQ==
X-Gm-Message-State: ACrzQf3ZSrzkOkf4zMZrbYF8DhZK5hTqBu8nI18EDi2ChXeMQnXj61dX
        OedbX+WfG4ClLFBi+wLngeztxh33XXk8v28tosQ=
X-Google-Smtp-Source: AMsMyM6HNtTxB5iF3SoMt8Z4Wai6/9c45Rxez5XszoUp/4BjCvKav/qJ/cvaJlAmL6ieoq9T6NZrvA==
X-Received: by 2002:a17:902:ef4f:b0:186:6723:8da5 with SMTP id e15-20020a170902ef4f00b0018667238da5mr27956372plx.6.1667455880927;
        Wed, 02 Nov 2022 23:11:20 -0700 (PDT)
Received: from [10.150.3.61] ([218.150.75.42])
        by smtp.gmail.com with ESMTPSA id o126-20020a625a84000000b0056ba6952e40sm9444589pfb.181.2022.11.02.23.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 23:11:20 -0700 (PDT)
Message-ID: <c5948336-19fc-ddd3-bc34-aba2d1b02302@gmail.com>
Date:   Thu, 3 Nov 2022 15:11:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RESEND PATCH 0/4] Implement File-Based optimization
 functionality
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>
References: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
 <Y2IuhG8nBJj0F1fd@infradead.org>
Content-Language: en-US
From:   Juhyung Park <qkrwngud825@gmail.com>
In-Reply-To: <Y2IuhG8nBJj0F1fd@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/22 17:47, Christoph Hellwig wrote:
> On Wed, Nov 02, 2022 at 01:30:54PM +0800, Jiaming Li wrote:
>> 1) The host let the device know of lba range(s) of interest. Those
>>     ranges are typically associated with a specific file. One can
>>     obtain it from the iNode of the file and some offset calculations.
> 
> This is completely and utter madness.  Files are a logic concept, that
> is non-unique (reflinks, snapshot) and can change at any time
> (defragmentation, GC, dedup).  Whoever came up with this scheme is on
> crack and the it has no business being in the Linux kernel
> 
> NAK.
> 
> 

Is the idea really an utter madness? Majority of regular files that may 
be of interest from the perspective of UFS aren't reflinked or 
snapshotted (let alone the lack of support from ext4 or f2fs).

Device-side fragmentation is a real issue [1] and it makes more than 
enough sense to defrag LBAs of interests to improve performance. This 
was long overdue, unless the block interface itself changes somehow.

The question is how to implement it correctly without creating a mess 
with mismatched/outdated LBAs as you've mentioned, preferably through 
file-system's integration: If the LBAs in questions are indeed 
reflinked, how do we handle it?, If the LBAs are moved/invalidated from 
defrag or GC, how do we make sure that UFS is up-to-date?, etc.

 >
 > From: lijiaming3 <lijiaming3@xiaomi.com>
 >
 > add fbo analysis and defrag function
 >
 > We can send LBA info to the device as a comma separated string. Each
 > adjacent pair represents a range:<open-lba>,<close-lba>.
 > e.g. The LBA range of the file is 0x1234,0x3456;0x4567,0x5678
 > 	echo 0x1234,0x3456,0x4567,0x5678 > fbo_send_lba
 >

Like, ew. Why would we ever want *the userspace* to be able to 
manipulate this directly?

[1] 
https://www.usenix.org/conference/atc17/technical-sessions/presentation/hahn 
- Section 3.3: "For example, even if a file was not fragmented at all in 
the logical space (DoFL=1), if the file had a DoFP value of 0.5, the I/O 
throughput became only 48% of that with DoFP=0."

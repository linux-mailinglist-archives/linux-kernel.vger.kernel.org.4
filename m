Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003A461F7E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiKGPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiKGPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:47:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B158A1A3B4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:47:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A00C61FB;
        Mon,  7 Nov 2022 07:47:13 -0800 (PST)
Received: from [10.57.3.218] (unknown [10.57.3.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60F3E3F534;
        Mon,  7 Nov 2022 07:47:06 -0800 (PST)
Message-ID: <f2bbb902-8447-076a-f290-6a257abc48d9@arm.com>
Date:   Mon, 7 Nov 2022 15:47:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/panfrost: Remove type name from internal struct again
To:     Alyssa Rosenzweig <alyssa@collabora.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221103114036.1581854-1-steven.price@arm.com>
 <Y2kGqIAE7WPYUTKx@maud>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <Y2kGqIAE7WPYUTKx@maud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 13:22, Alyssa Rosenzweig wrote:
> Reviewed-by: Alyssa Rosenzweig <alyssa@collabora.com>

Thanks, pushed to drm-misc-fixes:

c4299907c09a drm/panfrost: Remove type name from internal struct again

Steve

> On Thu, Nov 03, 2022 at 11:40:36AM +0000, Steven Price wrote:
>> Commit 72655fb942c1 ("drm/panfrost: replace endian-specific types with
>> native ones") accidentally reverted part of the parent commit
>> 7228d9d79248 ("drm/panfrost: Remove type name from internal structs")
>> leading to the situation that the Panfrost UAPI header still doesn't
>> compile correctly in C++.
>>
>> Revert the accidental revert and pass me a brown paper bag.
>>
>> Reported-by: Alyssa Rosenzweig <alyssa@collabora.com>
>> Fixes: 72655fb942c1 ("drm/panfrost: replace endian-specific types with native ones")
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>  include/uapi/drm/panfrost_drm.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
>> index 6f93c915cc88..9f231d40a146 100644
>> --- a/include/uapi/drm/panfrost_drm.h
>> +++ b/include/uapi/drm/panfrost_drm.h
>> @@ -254,7 +254,7 @@ struct panfrost_dump_object_header {
>>  			__u64 nbos;
>>  		} reghdr;
>>  
>> -		struct pan_bomap_hdr {
>> +		struct {
>>  			__u32 valid;
>>  			__u64 iova;
>>  			__u32 data[2];
>> -- 
>> 2.34.1
>>


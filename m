Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058AD686A32
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBAPZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBAPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:25:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C533AA8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:25:35 -0800 (PST)
Received: from [192.168.1.27] (cst-prg-44-69.cust.vodafone.cz [46.135.44.69])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tomeu)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 34A226602EDC;
        Wed,  1 Feb 2023 15:25:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675265133;
        bh=acOMPEefioQ7tzvB4jb5ew5NC7LdrItaIQQxTOzMQdE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JK4IN/+FknPit1r4VMHBSjSH1GNHTeQrF24g4e+P29ZOHACCVHioMhMY/DHgHGv2z
         81JNTeiSo79rnSWqvZsgVWfaKMhvP0DzcXyFWy7eYC/IOCaV0GINmPHVDnRwkorKgq
         vTa3WgbjBzQ0zesJWkMStC75FtR3PQZzzNpb4Xo4Q0fUbmnbYROBl9CHZG0tgcTf+T
         IcsL7qCVXLuDqqAQ0w/HZ/abz8WeiSr3H5mTE6bfJjyY5L2+8IHm0O15kdgsdRuNjC
         89i1VaVULP/rzLWL1VkIy2UXiAedCgyge1NBGsff12toBJ/FfTJPbY6vZbiJM60PNf
         M3k4J+VD0H0ZA==
Message-ID: <0f9b65ed-f8f5-44b8-2386-75bbe96395ff@collabora.com>
Date:   Wed, 1 Feb 2023 16:25:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 7/7] drm/etnaviv: add HWDB entry for
 VIPNano-QI.7120.0055
Content-Language: en-US
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     italonicola@collabora.com,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@gmail.com>
References: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
 <20221201103026.53234-8-tomeu.vizoso@collabora.com>
 <b3fe19c040de21da220164955fdd679f9c17d80c.camel@pengutronix.de>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
In-Reply-To: <b3fe19c040de21da220164955fdd679f9c17d80c.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 14:26, Lucas Stach wrote:
> Hi Tomeu,
> 
> Am Donnerstag, dem 01.12.2022 um 11:30 +0100 schrieb Tomeu Vizoso:
>> This is a compute-only module marketed towards AI and vision
>> acceleration. This particular version can be found on the Amlogic A311D
>> SoC.
>>
>> The feature bits are taken from the Khadas downstream kernel driver
>> 6.4.4.3.310723AAA.
>>
> I just noticed that you seem to have dropped the nn_core_count property
> from this HWDB entry when reworking the series according to my
> feedback. I assume that you are fine with me fixing this up in the
> etnaviv tree by using the hunk from your previous patch "[PATCH v4 6/7]
> drm/etnaviv: Add nn_core_count to chip feature struct".
> 
> If you see any issue with that, please let me know.

I have checked and I think you are right.

Thanks!

Tomeu

> Regards,
> Lucas
> 
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 31 ++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
>> index 44df273a5aae..66b8ad6c7d26 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
>> @@ -134,6 +134,37 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>>   		.minor_features10 = 0x90044250,
>>   		.minor_features11 = 0x00000024,
>>   	},
>> +	{
>> +		.model = 0x8000,
>> +		.revision = 0x7120,
>> +		.product_id = 0x45080009,
>> +		.customer_id = 0x88,
>> +		.eco_id = 0,
>> +		.stream_count = 8,
>> +		.register_max = 64,
>> +		.thread_count = 256,
>> +		.shader_core_count = 1,
>> +		.vertex_cache_size = 16,
>> +		.vertex_output_buffer_size = 1024,
>> +		.pixel_pipes = 1,
>> +		.instruction_count = 512,
>> +		.num_constants = 320,
>> +		.buffer_size = 0,
>> +		.varyings_count = 16,
>> +		.features = 0xe0287cac,
>> +		.minor_features0 = 0xc1799eff,
>> +		.minor_features1 = 0xfefbfadb,
>> +		.minor_features2 = 0xeb9d6fbf,
>> +		.minor_features3 = 0xedfffced,
>> +		.minor_features4 = 0xd30dafc7,
>> +		.minor_features5 = 0x7b5ac333,
>> +		.minor_features6 = 0xfc8ee200,
>> +		.minor_features7 = 0x03fffa6f,
>> +		.minor_features8 = 0x00fe0ef0,
>> +		.minor_features9 = 0x0088003c,
>> +		.minor_features10 = 0x108048c0,
>> +		.minor_features11 = 0x00000010,
>> +	},
>>   };
>>   
>>   bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
> 

-- 
Tomeu Vizoso
Consultant Principal Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United 
Kingdom
Registered in England & Wales, no. 5513718

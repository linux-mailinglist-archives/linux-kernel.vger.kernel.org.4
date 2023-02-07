Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7318768CFD2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBGGwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBGGwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:52:08 -0500
Received: from mail-108-mta33.mxroute.com (mail-108-mta33.mxroute.com [136.175.108.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E01117D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:52:05 -0800 (PST)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta33.mxroute.com (ZoneMTA) with ESMTPSA id 1862aa54d32000011e.003
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Tue, 07 Feb 2023 06:52:01 +0000
X-Zone-Loop: 72935d3152837a1841ca316b9fe301d62ec852953ea2
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ahepp.dev;
        s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:
        To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GVj+LEYlI2Qq4xFI1gEBZUt2ynSCfUVqIy8+Bofom5w=; b=lKS+5EjokjHm83/k0rfgTsDYGP
        +WkVBzQb7NHK7vlbbA7knkq7Bi39f2Ci8BoeSwfbaIE8pIOBWEwhuy88zJ9sJynppTT9ElT/RyRTS
        AVeHfaaQCd6o6k2kGQ55kpNhH/ZhAZcbFqsqlYKS+JOpUV4p0P+TZXlvEEpNmABFWlfZ64I923Nmk
        o7ZOO6N+HFjXDOpF6nCqGZDyYXiY5Vw0B2DTkNkqBoR5zxoTVBPLTJifxs77QQRomMfPBKTX8IS98
        MedirkJmnnBEKLs6EjnhHs7jfuMir3sTQqp9XzDISeJlYTxJUyRC8rSyk5lkbqPlHtFbM98CX0Y0Q
        sOS3G2DQ==;
Message-ID: <2a995efa-9eeb-710e-79e6-149fbb356ce1@ahepp.dev>
Date:   Mon, 6 Feb 2023 22:51:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] iio: temperature: Add MCP9600 thermocouple EMF
 converter driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Jonathan Cameron <jic23@kernel.org>
 <20230108234503.2803-1-andrew.hepp@ahepp.dev>
 <20230112190551.4d9ac5f6@jic23-huawei> <20230205152508.778b010a@jic23-huawei>
From:   Andrew Hepp <andrew.hepp@ahepp.dev>
In-Reply-To: <20230205152508.778b010a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: andrew.hepp@ahepp.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/23 7:25 AM, Jonathan Cameron wrote:
> Hi Andrew,
> 
> If you aren't going to get to this sometime soon, feel free to say so and
> I might write binding docs for it if I get time.  I'd rather do that than
> lose a driver over some docs!

Hi Jonathan,

I appreciate the offer! I have been putting this off since I'm not yet 
familiar with binding docs, but I figure it's important to learn. 
Apologies for leaving the patch sitting around half-baked, I'll try to 
have something ready for submission this weekend.

By the way, thanks for the useful feedback on previous versions of the 
patch! I've really enjoyed using the IIO subsystem and am excited to 
contribute upstream.

Thanks,
Andrew

> 
> Jonathan

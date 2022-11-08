Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285EA620744
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiKHDHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiKHDHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:07:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46732FC19
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 19:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6139D612E1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACBFC433D6;
        Tue,  8 Nov 2022 03:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667876836;
        bh=DoQVAWYIhuU/Va/KNg+xTTJC6B/0NXt4BCWT4F1PWQI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nevb3DsrjqI1uRxHQEEw17z3+eEIgaQdTKi2pABtgHcvlVCEeyWefP3+0J3oOLPN1
         Npe7sSODV2lY2mHJXsJar6JkfJA1WY5cyRHamIcC1J3aR1coyMSw7b7CFN8QLpSKO6
         roVirnZahJ5hNU2pSMFmLXTVHm8OPFnWIp0yrNPnULYnHpRQXIsCgBqMRUU/PVqmma
         bnyvuXzaqs0mwEE4RWnbhjq0wydlZztLp29scm/A4bZTSeruaMnHCZpPtQkdy646oO
         NoZy686v2EMUgJ0epGH4fAJGLEY2fOeXnofiK3AFo/BMpvty1DFZRAbfflSL2DjqU8
         APwFKsRqG2CNQ==
Message-ID: <9ce701ec-257a-b923-903f-2931bfb8c3ae@kernel.org>
Date:   Tue, 8 Nov 2022 11:07:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] erofs: put metabuf in error path in fscache mode
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     zhujia.zj@bytedance.com, yinxin.x@bytedance.com,
        linux-kernel@vger.kernel.org
References: <20221104054028.52208-1-jefflexu@linux.alibaba.com>
 <20221104054028.52208-2-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221104054028.52208-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/4 13:40, Jingbo Xu wrote:
> For tail packing layout, put metabuf when error is encountered.
> 
> Fixes: 1ae9470c3e14 ("erofs: clean up .read_folio() and .readahead() in fscache mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

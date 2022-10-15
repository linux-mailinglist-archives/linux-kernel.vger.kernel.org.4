Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E225FF812
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 04:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJOCr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 22:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJOCrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 22:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75107B1D8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 19:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54A4F61CE8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 02:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80363C433D6;
        Sat, 15 Oct 2022 02:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665802042;
        bh=/BEvo3ho6FYtrscyZeC1vth4Xpjqk5rZmS+7kUDD5OI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rPiCtlEZtQiGq1E7XrZhAFA0O1qzqF0/xQsfUhdnrJWJFMRs92ye+mRMP9RqTkADU
         rjanlnZIcpQeHSAfYkfgonyFALyXv2CSbr02cdf9OBOD9FQVSADMug3/hvY0V5UNYQ
         S1cnh84h9L/IetZ2gT0YnFgimWtPgM+tw9CUqu5c7xKjvuNnwTdxWJ0ETQQQLRh7AP
         jOblHNxziYCd9Cng2eDsfll80ma6Z/IAkM4sztnu27TE7umLDQWhvact1FaIQ7IjfH
         ceSdsTGFfwQO0UBnIm1DQ/FNs1YPl/GIPJmZlI4u821v69TgAsZrIdyMY+YyN5qjuG
         F1rgGf9e+cX2A==
Message-ID: <21f00900-92da-f70f-2dc7-bbaab05be529@kernel.org>
Date:   Sat, 15 Oct 2022 10:47:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2] erofs: fix invalid unmapped accesses in
 z_erofs_fill_inode_lazy()
To:     Yue Hu <zbestahu@163.com>, xiang@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
References: <20221005013528.62977-1-zbestahu@163.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221005013528.62977-1-zbestahu@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/5 9:35, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Note that we are still accessing 'h_idata_size' and 'h_fragmentoff'
> after calling erofs_put_metabuf(), that is not correct. Fix it.
> 
> Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> Fixes: b15b2e307c3a ("erofs: support on-disk compressed fragments data")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

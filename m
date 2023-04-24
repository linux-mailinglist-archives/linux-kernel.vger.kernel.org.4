Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8175C6ED1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjDXPrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjDXPr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:47:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C51423C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA5A66265B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32842C433D2;
        Mon, 24 Apr 2023 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682351240;
        bh=4RTntsS8Ltvi/zweHMoGG/466+f9Gl/cJ22m2S/ZjzE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MWidb279bEM5WgbBMBj6MoM4r+XA9hNa4cZhS5rsS0Jchg+5o66aoGHNDrVDImCl+
         qqIt6ssRxmKXjk2Ftx/Bcs1uMUYr8RYZwBtIgDcIW/OqWN8FWdKGmBVYNb1YPBS4Sd
         IxFx2BCUIUWmhgHq2EeVDR/fU69fTjgVp01Yn3i83Tj3P0fz/YVCnV9bnDzm9XeWoe
         qFbFG6MpK+vSn5IAhXQJItFUP4nSV2/x3Qdf1iafNkOe0VYaUMTNUrBWHQ4p0jnkgK
         kG5aX2p1bS5e5nkxOq3ZU9IZ9UHUpITuvAHsEnauSf99sCd4nBh0f9x0x+wdjFDW+z
         DNzh7ZGwnnGEQ==
Message-ID: <32d4cb93-1491-4d1b-7713-61369a93f658@kernel.org>
Date:   Mon, 24 Apr 2023 23:47:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate node blocks for atomic write
 block replacement
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20230424154440.23279-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230424154440.23279-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/24 23:44, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When a node block is missing for atomic write block replacement, we need
> to allocate it in advance of the replacement.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

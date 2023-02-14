Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663AC6964D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjBNNj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjBNNjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:39:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DB225961
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:39:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70A0661614
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235BAC433D2;
        Tue, 14 Feb 2023 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676381985;
        bh=eK4vLSQoNPg7dk64n3Hmsxeg/eQPehh7IZrwJlPMJ/s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z8mz4a0DyOP5T35ZNjJ6zdlb6+EHb/79Kuxw/vDEwOBRpWeCD2Jt6v+lEUIVdtliD
         RPwNqAt4mFszdergB+WMU6mtlF/l8griz8LMunu3OCkr0PYuPkgnkJSOeqVH1H3Uuv
         VhaGEM4tv+7fmc4e0B8kDvAr2erTJ+/WXLm3KvVTHxrXYUBDeNN7RkhYuHtpZ16+Jy
         v6CFX8yA1B+xMJj1Wnr8nvr6xJtYCTjqNuLI8Hj+tKnptqYFRiSYXCORlHm/9kOwDk
         /wm6GEtZtHhrdA+6p8O9Fzpm5STkDBWyd6TrdUjJuCbSclQE8DU//0PC2vLcaGyhxF
         zeXF093F8P56Q==
Message-ID: <14957c9d-ed66-de02-f845-295314d01481@kernel.org>
Date:   Tue, 14 Feb 2023 21:39:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] erofs: remove linux/buffer_head.h dependency
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230114015812.96836-1-hsiangkao@linux.alibaba.com>
 <20230114015812.96836-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230114015812.96836-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/14 9:58, Gao Xiang wrote:
> EROFS actually never uses buffer heads, therefore just get rid of
> BH_xxx definitions and linux/buffer_head.h inclusive.
> 
> Reviewed-by: Yue Hu <huyue2@coolpad.com>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

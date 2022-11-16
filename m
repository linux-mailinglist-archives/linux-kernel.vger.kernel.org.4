Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5123E62B085
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiKPB0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKPB0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:26:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF5F55B5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:26:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26A87B81B7B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B277C433D7;
        Wed, 16 Nov 2022 01:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668562006;
        bh=8gnSm96akCzktmabmash2hbT3a601dNz5cAtgTHwthU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FuKynyaFpGbbG4DOHpx2l/UyYjujbgBFGIxzOcv5cU6Xp9HEyzPpU+pEGClW1PLBJ
         p5ea9WwOXtEXCUlxtykaPgd966aqFglE0Imu+zi3zfAagU4FQKAketgpB8bNNHMnt4
         GNfJBKQRXESJ8rO8sGmbwW5eQ7qdxpmX1sAhlLXgQNmCCUlsYE82OsmbkfecLfJTzy
         kjitsB5u1+ixzkmhaFodGuqfPJP1aE1PYNCnxxvf55oGahv5hC4Pw2i5pQA4/KUZbM
         HaqGUMpllloz69zSvVHPXsu767Gvw3TC4T9MQp1KiW+61N0BFX1HmeGd/gQZoQNxV3
         3JvJUM80orTxA==
Message-ID: <cec4aa23-37b0-18af-5217-e524ad45bbb4@kernel.org>
Date:   Wed, 16 Nov 2022 09:26:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/3] f2fs: fix to alloc_mode changed after remount on a
 small volume device
Content-Language: en-US
To:     Yuwei Guan <ssawgyw@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
 <20221115063537.59023-2-Yuwei.Guan@zeekrlife.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221115063537.59023-2-Yuwei.Guan@zeekrlife.com>
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

On 2022/11/15 14:35, Yuwei Guan wrote:
> The commit 84b89e5d943d8 ("f2fs: add auto tuning for small devices") add
> tuning for small volume device, now support to tune alloce_mode to 'reuse'
> if it's small size. But the alloc_mode will change to 'default' when do
> remount on this small size dievce. This patch fo fix alloc_mode changed
> when do remount for a small volume device.
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

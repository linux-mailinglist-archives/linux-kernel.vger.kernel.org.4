Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7A6445B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiLFOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbiLFObz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:31:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868041F639
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:31:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA3F61771
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 14:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D22DC433D6;
        Tue,  6 Dec 2022 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670337111;
        bh=JeoFrNywnaQIRQPztyv4k9bjuMDfct61Uzw4cnGKLCo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WG6eEwKaV7dWcpLCHsNZjtGR2LkZiZZFadt2VSMp+3SuEazEY8wSoda0Fmim8S0tc
         O2iqTtqC1g2PbdGakqdkIfulajicHAlJa7keuVRhCFxKE0NvUkT4hut88upm352COm
         pZNNbGaMr2oQkngkU9thZeXG2PfjNVDG/ylsnjXP+CRxW99k2Vif60wPSKXwcJ8/3s
         QfsRe3VvkEjdTwJjqDgfmpAjm8PNeZ8n8ut3dq72H/c1X3ATH2qErvT/H1R4Nn9MDl
         Y9ITfbFcOeteffmK0aIBziJNNk8OtSqYYGa5Odkw1efRfIm5Jixoi3x8zbiPh9OGNU
         vU6L40m8GMfDg==
Message-ID: <0fe48416-fbc6-17de-0dcf-5c506315b23a@kernel.org>
Date:   Tue, 6 Dec 2022 22:31:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] erofs: clean up cached I/O strategies
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221206060352.152830-1-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221206060352.152830-1-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/6 14:03, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> After commit 4c7e42552b3a ("erofs: remove useless cache strategy of
> DELAYEDALLOC"), only one cached I/O allocation strategy is supported:
> 
>    When cached I/O is preferred, page allocation is applied without
>    direct reclaim.  If allocation fails, fall back to inplace I/O.
> 
> Let's get rid of z_erofs_cache_alloctype.  No logical changes.
> 
> Reviewed-by: Yue Hu <huyue2@coolpad.com>
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

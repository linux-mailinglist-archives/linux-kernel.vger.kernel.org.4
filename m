Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B649614E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiKAPib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiKAPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD7120A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 08:38:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23AF561644
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AD7C433C1;
        Tue,  1 Nov 2022 15:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667317106;
        bh=eLNcs9IHbuiYQVyORygDQfCWPOxlH6OpvBlG7I13D+Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ARUXTBIILZCmDTJunf4wCNgC12sbCi57dUsh0OextE0Kbq7AUrlpoCYB19J+BrAM+
         VLS5HcuiozLjG9QmI3CqaVknLtnuZqsIwv2UJORDT5+QltRLFLr5OFiyYj94/A/DjO
         2Cdb/XZJv7k7r7hHpXFGHZoqGhdI2aA9doo1WK8eKBAuLohdLTz++OA0oLDMO4hQT2
         WI+rkXyBO/tFIkhenkE3H0HCAKh6IExvd73qSZznTenbOa9strGavGebDnD+mIphMU
         dXDfFPsZSqBIufzl9XivGKqIULRgY1DF3xnCXEjDjfIJlcJYCTXrBo06H501QcW9hE
         O15nmsy4l2FVA==
Message-ID: <35eb365d-7465-95a7-d280-fd39d59f31f5@kernel.org>
Date:   Tue, 1 Nov 2022 23:38:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] f2fs: replace ternary operator with max()
Content-Language: en-US
To:     wangkailong@jari.cn, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <44b06118.3c.18424382765.Coremail.wangkailong@jari.cn>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <44b06118.3c.18424382765.Coremail.wangkailong@jari.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/29 22:49, wangkailong@jari.cn wrote:
> Fix the following coccicheck warning:
> 
> ./fs/f2fs/segment.c:877:24-25: WARNING opportunity for max()
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85E6B26ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjCIOdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjCIOdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:33:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C321ABD9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:33:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D159161870
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45809C433EF;
        Thu,  9 Mar 2023 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678372394;
        bh=w7AQnZqpeLl/SNOfri6RykY1AipM/QRAUfB90P6D5xc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XXZHBnBoDdhlZQXsfxKM881hFTUJ7D8ODeBfZwp6BS3wVxToeHOWrJYHS5XI/GTjG
         uh13EYxvVj+RC2bEI7gcO2U5gmnAzio1QHhdEK7Nuz5DJhJjXYVA4Oj1KjkVERGyfn
         5CtmMIwn23/81fzFpyBP9gI5it5MeaFyUOH9faCcxdvGzYIY3wuJrTlvSvUNtQ5lcH
         h7IMvN3d/Sup1i9DrdVG9PQAJIy5rhnfNKS2kFTdhjwe4VwWwt27/SEH1RIaJIxAtH
         D7ol5HAeHQPmHyEq/tAct7gntWO/rapt5HU7MN6ekX2OnMEtBOxwEKRBihXxgONqpR
         9SOowHDhyI6xA==
Message-ID: <a238dca1-256f-ae2f-4a33-e54861fe4ffb@kernel.org>
Date:   Thu, 9 Mar 2023 22:33:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] erofs: use wrapper i_blocksize() in
 erofs_file_read_iter()
Content-Language: en-US
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org,
        jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
References: <20230306075527.1338-1-zbestahu@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230306075527.1338-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/6 15:55, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> linux/fs.h has a wrapper for this operation.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

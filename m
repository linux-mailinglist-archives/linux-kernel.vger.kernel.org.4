Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EC9637B62
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKXOYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKXOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:24:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BEAE9165
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:24:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 415B6B82833
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB7DC433D6;
        Thu, 24 Nov 2022 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669299880;
        bh=Fda1LOHt/EBtTJeEwnTqbY67nL2+Hwj4JoO/UxYlMT8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ISnot6pDJTsq/07VeONF0GbBPjlWtGfR8YY658kaA5hC+3etSN8wRsHyCzXz8IRJ3
         OndwvJ8qhC99pmUleOJ2shtxf8uQQcpJQKVKdc7VIhn26ZaMgM3s56Tp+yDEZ3N8Vy
         2xAD08mlsM7h3L9ZfKGt0q3flpfaiVOXMGgo0uEIGXjYufsFIgO6lRFBClUjJLJ51H
         FDlc998gDUoPq5eEbWgt+k21oZl/YAFspHGi8AJ5L7W2ByvrcM5NrGtFWIM+3pF+Tr
         iRqqllaLA1RZGNeMgC1H+ZhZReye+sFOpJY1o8mQVYd4lSlE+rBkV6aLZ9PZ5f7WqV
         Zyg2p1VkfnnoA==
Message-ID: <254a85d2-fb86-d56a-56b1-33d89e00e711@kernel.org>
Date:   Thu, 24 Nov 2022 22:24:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] f2fs: introduce discard_urgent_util sysfs node
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221123164402.13849-1-frank.li@vivo.com>
 <20221123164402.13849-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221123164402.13849-2-frank.li@vivo.com>
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

On 2022/11/24 0:44, Yangtao Li wrote:
> Through this node, you can control the background discard
> to run more aggressively or not aggressively when reach the
> utilization rate of the space.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


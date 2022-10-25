Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF4E60C55C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiJYHfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiJYHeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B4514D8E9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 350AE617B0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9BFC433C1;
        Tue, 25 Oct 2022 07:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666683243;
        bh=NcRaNLmBZOsJOGIc24y8WcRzr4vKPzeQM9yCUXgw2n4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UbBtBHL84PpfTDG2QTFSgIKReaZiBNj0KWsHDbn0nYUxeEQcLRDeboq7qyiuDcE6K
         QapIbFjKuNwJwkUfoWO1Az1MBvAPtEWTaN7exsnjNJkdyu/1J9/jOjfMEVGr2JujIp
         ybZdVZFAPnwdnJLQujtaKz5r1jwDgjX67PV1CYbR80d3z2Ez/Du3zHzZlAtZ4hWtEQ
         lzV1Uv+KzyPjBgfJW53cmRiT3nXViKsIKFTlkjl/Zqcyk9Eq26zhqPpfO/1FbJhH6/
         X2ji6qFTJzExLDPgvAHdk/XzEWFc5D5Bm7UpZJKRoflp6JzExdcG2JDfTEukKXhIxe
         YbDLH14/4w7JQ==
Message-ID: <a5744cfc-8c00-02bb-8518-6e86380557c4@kernel.org>
Date:   Tue, 25 Oct 2022 15:33:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/2] f2fs: fix gc mode when gc_urgent_high_remaining is
 1
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221025065025.35017-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221025065025.35017-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/25 14:50, Yangtao Li wrote:
> Under the current logic, when gc_urgent_high_remaining is set to 1,
> the mode will be switched to normal at the beginning, instead of
> running in gc_urgent mode.
> 
> Let's switch the gc mode back to normal when the gc ends.
> 
> Fixes: 265576181b4a ("f2fs: remove gc_urgent_high_limited for cleanup")
> 

Unneeded empty line here, it's trivial though...

> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

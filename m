Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169B16876BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjBBHsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjBBHsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:48:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F4B8494E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 23:48:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B390B6192A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C74C433AF;
        Thu,  2 Feb 2023 07:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675324093;
        bh=3P/W3cNG0R5zGI55o3k9s9UzY5c2wN6ZqugQ++IrJo8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qIhApZG4YvrXpm4bMz6tVploZzs+JHkBK1ur4gwYzcPvukdWJRqs4ykQHN35HFddt
         WETXeRpO3v+rAMWXHpwNRZ1UnrJvGbmt5usmXPIK3kTkHLcuKr+M0CmmZdY3lbc99l
         tfPJcKnow2m1oq9gGFzBChrazk6xdvhU6xJmpR43UPOCX7FL5741NqgME6zj3jGJcl
         Liqp5xIfUdhdZwzifmuJcy4Pvy/GyLvoBt069x83dFItJ5Rsq5Sooxil4rIop3KK+h
         uF8pRr8OXWV+wlfjFC5cnem5NznN33TC8eV5VgSFqJ4LLjrVa1MfThACQiDr7VcLbd
         D2cD1H5jR+B3g==
Message-ID: <1c2befb4-6214-b565-48c3-2e71c5e636d8@kernel.org>
Date:   Thu, 2 Feb 2023 15:48:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/2] f2fs: use iostat_lat_type directly as a parameter
 in the iostat_update_and_unbind_ctx()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
References: <20230201104703.31008-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230201104703.31008-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/1 18:47, Yangtao Li wrote:
> Convert to use iostat_lat_type as parameter instead of raw number.
> BTW, move NUM_PREALLOC_IOSTAT_CTXS to the header file, adjust
> iostat_lat[{0,1,2}] to iostat_lat[{READ_IO,WRITE_SYNC_IO,WRITE_ASYNC_IO}]
> in tracepoint function, and rename iotype to page_type to match the definition.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks

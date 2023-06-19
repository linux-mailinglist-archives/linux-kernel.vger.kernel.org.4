Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C987349B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFSBbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFSBbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:31:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD8BD1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 18:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E7A260F0F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E3CC433C0;
        Mon, 19 Jun 2023 01:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687138301;
        bh=i3jkIUwYMg0GoBLvyBEiJO0i1ENUUhOWr6sshjDMEpM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kUllh/f0NoNMU2ZcAhzXYlzyRRLJO8p75zYc+jWDd41d0jEqA7eD4E1HSsQ1ffe6o
         d/h2XcGNJvwUDS7nwDY9acWTORJyxQl/RQCqSDHDQruSium5aHcgh+Bc9WXUfYXeMJ
         X9R9KE6gaqR8Ig1GIWuFfQypAPspBYx4SmGmFcf5ZEgjsEHe6R2WNi6vryxPUyxV0y
         3ya5BYXVxI+EyxEdJqiJU37otoSReF+rUJvRURUunDdxb9S5r5mCDezMC3qID1024s
         dszuuxr40JYnOGhmr8K/L9g1gQGQ8Wev4xH7FKEFsq3VjrjSQ7qcDCJRmRXARmSb/y
         Il8DlNoTeTxYg==
Message-ID: <0a6619cd-444b-69c4-818b-1b6dd6757c6c@kernel.org>
Date:   Mon, 19 Jun 2023 09:31:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4] f2fs: refactor struct f2fs_attr macro
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230506151604.36890-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230506151604.36890-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/6 23:16, Yangtao Li wrote:
> This patch provides a large number of variants of F2FS_RW_ATTR
> and F2FS_RO_ATTR macros, reducing the number of parameters required
> to initialize the f2fs_attr structure.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304152234.wjaY3IYm-lkp@intel.com/
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

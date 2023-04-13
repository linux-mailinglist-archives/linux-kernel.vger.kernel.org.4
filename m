Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED676E112F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjDMPdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjDMPdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:33:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9501712
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3991C61F5B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B19C433EF;
        Thu, 13 Apr 2023 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681400009;
        bh=5KBMCN/OghfVXdjjt+6NWWf8nfNl7IEIrVkEbI3dp4k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c0FtRgpeDXzH4qTMCTgXG4mf3ccp5c7nPZDj+3ceh7JVAA44RB6wBTRt05/jPC/OR
         cLldXBZznKy2G62lR2diHFHw1MLrdfL5TN3uQBoMd+mdqlPTPi/01DF9WbfGp94Aj4
         3S9WI9vpgFh5I8Nx6J85FjpAgPBHGBpyg/l6jUhQ+8kd8Ah7i7mtUIuA+BuulHPY+N
         PhlCqLLt1eY96Uf1IKir/MNGTouUP0Bh160zSlPaEJW0xqm6lxpg+u50AFm+1XVtsA
         YTmCAYFfcXrIhu9SscO1DG9F0Hov+xNi0AckmdYsYXFHH040V9+1I46ljVd6dzXW8L
         W6bi9F6mnT9Jg==
Message-ID: <88e48f65-a68f-6742-fe25-d05e7113c2fc@kernel.org>
Date:   Thu, 13 Apr 2023 23:33:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] f2fs: introduce F2FS_SBI_RW_ATTR macro
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230412034940.41943-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230412034940.41943-1-frank.li@vivo.com>
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

On 2023/4/12 11:49, Yangtao Li wrote:
> For the readable and writable f2fs_attr with struct_type of F2FS_SBI type,
> let's directly use the F2FS_SBI_RW_ATTR macro.

F2FS_RW_ATTR looks more common to me.

Thanks,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141A16E0F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjDMNza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjDMNz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849A5172D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D7C363ED2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38AFC433EF;
        Thu, 13 Apr 2023 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681394125;
        bh=naa7Lbz+p/8f/Q64NAOFFGM6peXufOjK9iuICoD9zsM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FdTBB15nEVQZb6SkhJLeepu6fVmCMkMKPvG2XOoNAGdFarrPUDoi91u+2RgRE38rk
         LGRsisp9ThuhgJUyGQaZbMC8o77CYIBD2Jp/ZXJDFSJBL94i8dmBLWwo0xGrlVxBnA
         9FsyVZH3kQsqLUi3QpEa/XJqAorfj3ylgYr/CZwb+teQ/Oqs2CAjyAexTzLcRmCXRM
         eLoF55HeMTHqcuG/kAXEtl8PdSJRUNJpyUgEORs6VdKP+xIoUDTnenNjwS1G3P3Rnd
         dmbd0Ir+TsL0HHXgSKY9MwgDHh5QpP4KNsQ74G2fdfGwMlSG/dCsZIyFr++5CKHZmA
         WrpkbEQ8WQbVg==
Message-ID: <2bd9d237-34fb-5e90-b43c-44778e20dbe5@kernel.org>
Date:   Thu, 13 Apr 2023 21:55:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] f2fs: remove batched_trim_sections node description
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230404143832.18234-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230404143832.18234-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/4 22:38, Yangtao Li wrote:
> It's deprecated since commit 377224c47118 ("f2fs: don't split checkpoint
> in fstrim").
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

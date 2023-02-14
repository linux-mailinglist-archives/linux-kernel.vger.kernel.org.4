Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271166964CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjBNNiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjBNNiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:38:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C496CDD1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:38:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E40496162F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E617C433EF;
        Tue, 14 Feb 2023 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676381929;
        bh=tpcX9h0gvlcRiwsTiBG6hmvS2EwaoMV+tj86OmFyOvo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jHX82HOQXlGerkE7W/cGHmJAPORGAbbXJfRkDFzOK+G5DKFGEPJwWKeRdGZScKUVG
         AqQlxqsOsdjisvRogRIP6twe9GeYxigV+LrNvo8S4AL1p6yWJwauST+hvykFaDN6uQ
         kacQ3SwAOZUJCuglnucg4zXCMGUcerMcyl9YN0hu0PXhucJ/17X4yjj480a/QouSqX
         VpluAwaGYyCQBvaX1M/ai1TDRKabFGZFgvXctq+iTIU+UtVbcYuDwmGEU1nxv22dzu
         +xrDlsMqZhmsDjtJpQHy/BmRsLz301dL7HMLKljPFW2twOuO+xctfhsMEHxMEv7IU3
         6D6dnbof9HDjA==
Message-ID: <58d9a261-d8a8-2d1d-a40d-6b88d7e27f92@kernel.org>
Date:   Tue, 14 Feb 2023 21:38:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] erofs: clean up erofs_iget()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/13 14:52, Gao Xiang wrote:
> Move inode hash function into inode.c and simplify erofs_iget().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

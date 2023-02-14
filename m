Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F546696551
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjBNNsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjBNNsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:48:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77E228D1F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:47:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D00E961620
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BECC4339B;
        Tue, 14 Feb 2023 13:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676382352;
        bh=Hm3NTeKzEpgYjkJbBp7+dl97tgXNT9cz6BFe26+Na04=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Aa6b3zQBhr4WszefGzPfFkPO7qmdDyGb39I0AZKJQgKJKq3iYsuMgcoKfC8vsezjz
         7GUlbpmS8sN72n89r+edKLQbvM7uOI46jzEd7ELsIprY71W3pK0WZUHpXg/QQkcOdq
         1suWRJFeP2Rt9VFSSnO58CLQlb7VS2lj4cYmJHHWaONf3mll7mj8viPqNuqKBZ9xKw
         PQSs0hwIr6kilJoeMcDWutSDIjCeUhQlTo60cfS0ICfEvNJWxrrWC3urNnzqzGtFWZ
         RpLo9xAOewodJeUMSbMEGer+GLP++9hGQgjvx7j8Rm38Lbm9nxZxONUvyTC7e6SOee
         qh1F37BnAHWXw==
Message-ID: <d5e32e4c-a4bb-e2c1-4c6e-eeb41947dbcf@kernel.org>
Date:   Tue, 14 Feb 2023 21:45:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/6] erofs: get rid of erofs_inode_datablocks()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
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

On 2023/2/4 17:30, Gao Xiang wrote:
> erofs_inode_datablocks() has the only one caller, let's just get
> rid of it entirely.  No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


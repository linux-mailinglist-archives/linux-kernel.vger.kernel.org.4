Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A01696738
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjBNOoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjBNOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:44:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5692119
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:44:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E22E8616E0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A5CC433D2;
        Tue, 14 Feb 2023 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676385859;
        bh=Y90zqwSusCAM/u2EJRMFr9XMtivTYaq77iwHqvdmeyE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xpb0vnc/glTzNo5OAMcx08nTlOd/8LxUQgxwpRME8RJvkSCz3ia7jfiK326X9g6xh
         h31GucEE88V2T5J+OXDZC9YScD7j8RWIQqmv+fge+me44cFo3mLTlurWU7Pq7l4xUB
         W5Ex7XwnY5JPP3TPgAJqoVTDWnh7N7tebXZR9sCmSas6JbnOJZgo7z1wFwvNfHnvyG
         zNWvW2pHVNVb63BDuuxUoBlM0JRXi8+L/sLGMrMBRn7p1knCdqgW8wbK55/XSXTno1
         65uNAuW63kdg3aFVWYpNpGqb6U38SyzNQ5w6nXIacxUnihNspQs3tckmgvpe+1Gvj/
         bDdvkPMBYTqpw==
Message-ID: <e8f316c0-3903-4835-707a-86e9a01d24ae@kernel.org>
Date:   Tue, 14 Feb 2023 22:44:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/6] erofs: remove tagged pointer helpers
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
 <20230204093040.97967-3-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230204093040.97967-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/4 17:30, Gao Xiang wrote:
> Just open-code the remaining one to simplify the code.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


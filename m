Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD9069673F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjBNOpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjBNOpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:45:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DBE9025
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:45:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FFBDB81DB2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A27C4339B;
        Tue, 14 Feb 2023 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676385932;
        bh=bpGRp9PZUKCb5ApFTO2oPnsxvMoBE9S82dy25TRiNeE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uBKQ+PIQe18kp7QwFW4BWzZGwMik8a0erkmTpJEEG9mQ3uj/CvpdKGRlk09vwxfmH
         zsoJMhpO0JVPvuNK65eH7jo7XXlSh5he9NlDqyu3Y+zwtAxiAoKmG0wiEZBS7zmasE
         +APJwNBVH1AeD4FmMVM1//RhOum/D9WovjVhi3a1WP9YyVNotsIfIDZ3jxGCTUKpJp
         wWRUfhp0bjNo05UPf40/8BOmvJy7P3BUqXIHjRE8BtjEBWdR8bLtGCHFIXg5pgwggr
         HcYPTVuxvGWmVCxPED+0+RgW17AOv//wJ1cnsCrB/frvggln74tYJKaFxnKG+yHvNk
         J9v1RunZ3Tsxw==
Message-ID: <7d56cd84-22c6-80df-d25d-95cb37f7fdd3@kernel.org>
Date:   Tue, 14 Feb 2023 22:45:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/6] erofs: get rid of z_erofs_do_map_blocks() forward
 declaration
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
 <20230204093040.97967-5-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230204093040.97967-5-hsiangkao@linux.alibaba.com>
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
> The code can be neater without forward declarations.  Let's
> get rid of z_erofs_do_map_blocks() forward declaration.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


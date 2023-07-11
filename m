Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AAF74F366
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjGKP2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjGKP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3448B10FD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B23E86155E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75584C433C9;
        Tue, 11 Jul 2023 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689089289;
        bh=245DlscCQ+6MIO/PrS2VsppGM4QHcezpBj0+leo6GaQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AFUTQ/vfJT0QBPWWlpBs0UwtalY9+e+2JXnefqaz2aKS0rteQ1jJc7I1JNVHvvr27
         DfX30pnysioQlfqfAVprFNFcym7h79qLYCLFqPk7SHNQPR13DP8sZr6I7FN7jt0cF1
         2BlOU+oDoDbws9fQy7rwENnnWjJKDZjVmAZo1MzQxloPoIo17d8ZebVThUMhRd4ImM
         tuBFCixobirvrBNejOpBJE97gWMhUvv6VfK7roDLxBglqGxQuhBvq6Fb+Uj/WHk4Mr
         yRefCk6JCgI9anDUngn0xieDjJjzVu/JYTLH50qUi7pJCDPvwc4TauOMnQiZ9gwdBI
         cZ17HYGtJMTGQ==
Message-ID: <8e196b07-6cb5-0bc7-bcb1-7239144f7975@kernel.org>
Date:   Tue, 11 Jul 2023 23:28:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] erofs: simplify z_erofs_transform_plain()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
 <20230627161240.331-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230627161240.331-2-hsiangkao@linux.alibaba.com>
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

On 2023/6/28 0:12, Gao Xiang wrote:
> Use memcpy_to_page() instead of open-coding them.
> 
> In addition, add a missing flush_dcache_page() even though almost all
> modern architectures clear `PG_dcache_clean` flag for new file cache
> pages so that it doesn't change anything in practice.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

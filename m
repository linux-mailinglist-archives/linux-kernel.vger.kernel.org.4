Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4216973857D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjFUNlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjFUNlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:41:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434CEE6E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3CA26150F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D53C433C0;
        Wed, 21 Jun 2023 13:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687354873;
        bh=0dX2S+X5v7h2CEtaF++zubk0bfXZPTqmNrEkBPz9kOw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ur3wx91LpnznFdO9eE4HfIIobhYmThDA8LSHPKEqfUVWqpah1Itr9c5aFyksRX+vH
         PlyteH02oTp+v0qIfuIGT+C2F0SG543rp7IAZw80J9UNj0aahmklvcATRVU/9GF/W1
         bvrzhWSppY8Gj3USxjQeQgPP5c4Pu3OFfobsYe5nemHBpIiqSU5sHD9B0IOCwchWTq
         gHkhTewSAT9YgwZD4rA8FdKqPCVPeCtLcGd4nfN39xLe3+WVnuJn5iWuqn/jGGZ+H0
         yO87wUgGJH+i+9d+zssq6c4SFryNaRqWT1FnNMTn5LRVZjxrwRp71hyVKxFq/M3GzV
         vLErrWqZeHtpQ==
Message-ID: <421c602b-9838-a9b4-1b7d-59d169825c52@kernel.org>
Date:   Wed, 21 Jun 2023 21:41:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [f2fs-dev][PATCH 2/2] f2fs: truncate pages if move file range
 success
Content-Language: en-US
To:     Yunlei He <heyunlei@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230621094359.3827832-1-heyunlei@oppo.com>
 <20230621094359.3827832-2-heyunlei@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230621094359.3827832-2-heyunlei@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/21 17:43, Yunlei He wrote:
> If move file range success, it should remove old data from
> src and dst page cache.
> 
> Signed-off-by: Yunlei He <heyunlei@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

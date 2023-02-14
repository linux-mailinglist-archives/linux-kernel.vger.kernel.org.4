Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4531769654E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjBNNrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjBNNqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:46:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D4D29402
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:46:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B792361645
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D901DC433D2;
        Tue, 14 Feb 2023 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676382287;
        bh=qCm9/g/4vkp0MxxyQCAuRl69DqJR1GLXomb5clqs5rk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mIcLLf4nnTv5Oe6RVsc8Mu9EOzLaaQ5AEzVodaR4J3Raj2EGphkpl+sfEh8geYgcJ
         9u9Q3DZJ+lXMVXeXj7pBJ5jPsUfQQaDz02U/bkFsh5DI626kIv31D/jVEeqbmdE0SB
         hkYp9/BSpq5R0aVPBTPs4R5HX4mkXrqcczvESUQJwxtc+0kr0Xs0FV6Ry9yjMuWY/C
         Nrxj4fyMFJ/Mf/Rhc4+7ucCNFQI6D7yqTrmhn0xEr0DtPPX2BdxHK11bNSQmUBnx0e
         ml4PyRIHXZxNja+rOlcQr6vGKg2/LFqKDX30QD9/S4eoW7RiMyvYZ43ws8JpSj2rN3
         XInM/EKHUTVvA==
Message-ID: <575622cd-6b43-5155-b406-75a2ce634950@kernel.org>
Date:   Tue, 14 Feb 2023 21:44:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] erofs: simplify iloc()
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
        Yue Hu <huyue2@coolpad.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20230114125746.399253-2-xiang@kernel.org>
 <20230114150823.432069-1-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230114150823.432069-1-xiang@kernel.org>
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

On 2023/1/14 23:08, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Actually we could pass in inodes directly to clean up all callers.
> Also rename iloc() as erofs_iloc().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

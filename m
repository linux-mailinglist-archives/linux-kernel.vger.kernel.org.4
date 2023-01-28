Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2212267F551
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 07:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjA1Gw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 01:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjA1Gwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 01:52:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DBC902E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:52:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41464B81218
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 06:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406D1C433D2;
        Sat, 28 Jan 2023 06:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674888769;
        bh=moCmHtP6WNEhW3voaGVZN+oBQpsMfXGYlro+vQJN4FU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VegJ0q314axePk3BRR0facAsmCUuptbrASXuZL/NUmfkRjTxzOqA2hTNX+MNkI5rm
         tZdVBXUYBo8ZpReTiPcV5SQYDQQXZhqEh28zh+fDuGbuVu5JYZYxoHjlpe58spZBfC
         Qhb84+Ov3I3LXzCMQsxdTxJGVbMc+qmA607QabgTigxiv6s5Ei6f44jtIY4b0+1DvM
         EEx3JcnhTFunAmE2m7mo1ahnVFc7u2cVUNATSASnySHPBrTHry1XTWSqYBlumBE/XG
         0PgStTI3DzIIBsAniUYTsjV2N4wOGYgrkR5JaO0yYabs7rCMrv14eN5Crrf5mTiWtb
         LtF1eecbVM18Q==
Message-ID: <7a1dda12-7c86-d5fb-4875-19b28bb786e4@kernel.org>
Date:   Sat, 28 Jan 2023 14:52:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] f2fs: clarify compress level bit offset
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230112133443.16713-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230112133443.16713-1-frank.li@vivo.com>
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

On 2023/1/12 21:34, Yangtao Li wrote:
> commit 3fde13f817e2 ("f2fs: compress: support compress level") introduce
> compress level, which macro(COMPRESS_LEVEL_OFFSET) is 8, But use wrong
> comment about compress level.
> 
> Let's fix it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

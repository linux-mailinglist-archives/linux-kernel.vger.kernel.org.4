Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9683625813
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiKKKVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiKKKV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:21:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7128A6455
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:20:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26B6FB824A6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F24C433D7;
        Fri, 11 Nov 2022 10:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668162010;
        bh=H24VoR2zC1k3+kqFjlp5MPLEwbVf7+X5dDwcpSo7+EI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KsszgdB7pc2dR9r72LEkZt5Qv6cK7FFB6YI9/EJ6BnSRUQHrMOXVJq7HCbjCLyo15
         eIwo0LdwBJVDtEwvKWZ5Gwf4xhWhy8WGWEcLzWR+PX8j9ZsLu/ABGWmlgR7xlo3roE
         ZfSKx3/pS9VozjGmu9Wk7VmcTl8Cr9iHLr+EAsyQ7qChs1vDHUIh/PxeYP82EXO97u
         4aUKTyHJjqKXasL7cks28hpA0oByCGypBjGVqNsO2IlNQRbKKzXXHDRgYGgN7AHx8d
         hfJmfqdCsteN7JRieA1Oa/9ZOGvley+vn+/KC/0OFScuPK/qPVZ//jZ5mbWSf+WeQC
         dvgF9oAwr7YFA==
Message-ID: <a80962aa-412c-6dde-1329-0b2fb5648607@kernel.org>
Date:   Fri, 11 Nov 2022 18:20:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/2] f2fs: fix to enable compress for newly created
 file if extension matches
Content-Language: en-US
To:     Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221111100830.953733-1-shengyong@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221111100830.953733-1-shengyong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/11 18:08, Sheng Yong wrote:
> If compress_extension is set, and a newly created file matches the
> extension, the file could be marked as compression file. However,
> if inline_data is also enabled, there is no chance to check its
> extension since f2fs_should_compress() always returns false.
> 
> This patch moves set_compress_inode(), which do extension check, in
> f2fs_should_compress() to check extensions before setting inline
> data flag.
> 
> Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

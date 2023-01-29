Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A977067FDFD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 11:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjA2KDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 05:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjA2KDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 05:03:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D371BADC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:03:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62D7FB80BEC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 10:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4E1C433EF;
        Sun, 29 Jan 2023 10:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674986583;
        bh=jn67msPbXiY3pHId0BHVujsHgX2fX4jnHsMpRGFy3eQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X4OKzB7T/ks4biSOmj5ARPM5rpE2xefHH/hbt0G3hHn6NBZIUysNhyQ87UjK233Am
         /9whhZ5sW+X413a74kRnyyanScUCCIhUE/fVCVrLqYknP38O2Q21Mhb+RCdoqP/QRB
         WWLXEK960lA8ZgCWZHY981vNXcq2XhOXUf+Qrvfadk53M81s4sg7WGjsfrDeA9pXvi
         mRq+uhamQNk0iW+aJJyw6XjcdcDm0TuYXvwLsauya6Qn05V3Nyh8h6XpFhg0TIAmcK
         m0ULBgemTPTRc6/vEapuSZusAcYpMbtouImaA2s8Xmb159a/r8m1sbrCUrnDh0gS9p
         sqKolJJyxDQiA==
Message-ID: <98140850-1582-6be7-0bc5-e8f8fa892b74@kernel.org>
Date:   Sun, 29 Jan 2023 18:02:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: allow set compression option of files without
 blocks
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230123094601.32940-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230123094601.32940-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/23 17:46, Yangtao Li wrote:
> Files created by truncate have a size but no blocks, so
> they can be allowed to set compression option.
> 
> Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

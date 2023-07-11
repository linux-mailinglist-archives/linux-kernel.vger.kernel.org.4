Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11974E98A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjGKIzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjGKIzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:55:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE26E6B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:55:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CB16613CA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498A3C433C7;
        Tue, 11 Jul 2023 08:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689065708;
        bh=XvP89t3HHPBECt9VjL/sHSXNgZhO/iLWIawMuLuiRYQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Aa6IKtgfgiAOOnAqkzTnwcb34RBZLQMO4yt5mdNXg7gLjcb7U5xgthyRyrjzbavNu
         CeBVIQbAvthbUn7xv+gfeeubMdkNcfUw+SJY0wVQGacfkVOoYJ7E9Ei9coiEvQIoSj
         gEXuanncPmytzTmcR2PxrZRy4C2XtsAaPLKMgzwNZhNzh/yCZSHauFcMckgrGa0LKj
         clD/QPAD9Kl6wRieyvLPmXqzjyH7xAFEYpdVVLVbtCyXEqDA2qZ1eGDio4k5yHO2Ej
         0NyZk5luszfce9XxgzaDnzQstZN4gvQ+93b3cI4DfGm1t/yrTKi5Vuzw3sIlHoqfGb
         VTAXDVBw98kCw==
Message-ID: <02f16df4-e98b-9156-f0b1-52e86e5a8751@kernel.org>
Date:   Tue, 11 Jul 2023 16:55:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] f2fs: fix spelling in ABI documentation
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Yangtao Li <frank.li@vivo.com>,
        Konstantin Vyshetsky <vkon@google.com>
References: <20230710052324.2857-1-rdunlap@infradead.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230710052324.2857-1-rdunlap@infradead.org>
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

On 2023/7/10 13:23, Randy Dunlap wrote:
> Correct spelling problems as identified by codespell.
> 
> Fixes: 9e615dbba41e ("f2fs: add missing description for ipu_policy node")
> Fixes: b2e4a2b300e5 ("f2fs: expose discard related parameters in sysfs")
> Fixes: 846ae671ad36 ("f2fs: expose extension_list sysfs entry")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: Yangtao Li <frank.li@vivo.com>
> Cc: Konstantin Vyshetsky <vkon@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

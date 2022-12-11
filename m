Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CE86491C9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLKCPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLKCPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:15:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2E512ACA
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 18:15:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1273660CF8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F25DC433EF;
        Sun, 11 Dec 2022 02:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670724903;
        bh=ysAWWkD442+3tVYIkKxhWHOsZpRBubaUkwLhnkAAAYc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IIlqhXNusQqvl22+XFC0s3Np6aKYzFBRoGuHE5NwURogeUzQ5veuM4fu1ipRUGNn5
         RLPyEqaWuqO3+aGqyxTLpLkcls43TEkL+Efnet+K0isXC/O/ZoRspy9zatJv5ZV9zs
         fXrzh60O4IlF/NOMyFWhMopJyFSc5fXwt+sh+KRCPKoZmp8ZNz0NiUdkGOMt8eNdtZ
         I0eEyMnGEKqoaeev0lGYyr9cqz7ts2TGUUiXCvWjvoDnqgnWKXY6yFvdVIjQE5TA5n
         hEBp0owxKemEI99ZFjhppwx0Auopxo1lSEMsL76VRP2LAl4qbQh6fMX1rpvlfyKhW6
         2vDy7vvGavaIA==
Message-ID: <05a1dff7-ae67-9804-0556-ded5341d200b@kernel.org>
Date:   Sun, 11 Dec 2022 10:15:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] f2fs: remove F2FS_SET_FEATURE() and F2FS_CLEAR_FEATURE()
 macro
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221124033708.10580-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221124033708.10580-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/24 11:37, Yangtao Li wrote:
> F2FS_SET_FEATURE() and F2FS_CLEAR_FEATURE() have never
> been used since they were introduced by this commit
> 76f105a2dbcd("f2fs: add feature facility in superblock").
> 
> So let's remove them. BTW, convert f2fs_sb_has_##name to return bool.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E3A637C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiKXPLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiKXPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:11:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209AF168B34
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:11:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF9D6621AD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 15:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E910CC433D6;
        Thu, 24 Nov 2022 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669302679;
        bh=WqEm0nMyQPjC7Ih6PxVMZn9+EOVGiLfH4GAfcTTRIr0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ES21AQCHdqI+F4UZC8dgHpk8oYKgfLmvwQVfvyFtykUDTcByw9W2r7B46vhrBLA+5
         LUhxy+tXQXQL+8CHc8uDCWurrMZRJ4YRc4xSfK8b+FBWyHdQyn8/Tq9UPXS0hTkXhT
         a2GNyvH3rp4N17sXasIZ9xtxt2sP+iGUxg0N01qsXve53UEhippMRTMp8KH6F1gxJF
         xGgciE8s7m3RWfmjFNmEIBEuRwvJRQwsDGc5giKAMsVnmilKEuTKY/uPwC5gpxyzpZ
         3vU97c7j+n+H09wo5nrlBynX8VRZ7BxIQzS5bdmK52E+rw6cqs1pFyWn1IWRhopyGq
         4rm2WgHelmVFg==
Message-ID: <9e3d185b-6453-f5d5-e1f4-bcf176c2b93c@kernel.org>
Date:   Thu, 24 Nov 2022 23:11:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: set zstd compress level correctly
Content-Language: en-US
To:     Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc:     terrelln@fb.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221117151054.2232946-1-shengyong@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221117151054.2232946-1-shengyong@oppo.com>
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

On 2022/11/17 23:10, Sheng Yong wrote:
> Fixes: cf30f6a5f0c6 ("lib: zstd: Add kernel-specific API")
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


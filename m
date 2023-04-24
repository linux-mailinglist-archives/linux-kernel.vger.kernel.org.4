Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDC16ED1AF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjDXPrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjDXPrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:47:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B4786AD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B7AF62080
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63B9C433EF;
        Mon, 24 Apr 2023 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682351227;
        bh=LC4skObKqPI+7BhFR03IM0NOmyFyRnFGlYN8RXopcKI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e6uGRl4nBYkGrXa7TEWDsXPoE4r/LgOUzIJvAhyvBH1uHJAGQy2XZ71irQiCmvfW0
         uzrABUnvNEgTkD/PwQvog7FqSIYwvlnXRHgNzPOeiZ6tT68fhu9S0z36KkS11WHPAk
         f4MgcLJ2ku0nmoCyEVFKwmuaYbSOZRVNiwZLMVABWKxx+xgIHq2oZB2n0lTMRXIXlf
         LFZLccItwTst56B6IiKEmmWWoYVWDt7Cmf+/xltk6J+qxmHFjLTH8z32PHBFLDx93M
         Vry33lynzuzLT2SVe/4urTQt2g2QeK2bBkSsTQdw1CNEMAeRub2pHsA6NwWMYYN0ve
         2MBZeaLaQw9/Q==
Message-ID: <4f72f8f4-7f00-aaad-7d5c-c2ce0b80c500@kernel.org>
Date:   Mon, 24 Apr 2023 23:47:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: use cow inode data when updating atomic
 write
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20230424154348.22885-1-daeho43@gmail.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230424154348.22885-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/24 23:43, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Need to use cow inode data content instead of the one in the original
> inode, when we try to write the already updated atomic write files.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

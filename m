Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC83C73DB13
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjFZJRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjFZJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:17:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A06359C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:15:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A4A60D58
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5D0C433C8;
        Mon, 26 Jun 2023 09:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687770908;
        bh=6FqM2iaonj+B+Cdl2KgW7ZGQZdUAPQHb9v+hfZzDZzU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sorggw8zXWu4XZ/+rgklCS2z+ZWyxJm1YLZcmz6zA9onA5/22mdM4UtLrpQ1jyNJC
         FRiSh0K4Xs4DmzkkOY20XtwtDsClPWxAa6K7zmcArokUETttaJfq29Rpvi3V+RHYMx
         tJHBM3kx8kN5ipSImvErFCS5wizxaa1pjeNfYtHTEOhEdETotPOyxDpp8tfRx2JIDo
         Yy1tCcr4EqfiPsBY430bKTyL1fRInHu0X82foIQsmQA4KjTsws2cV4BBtpuKI586qK
         7bsBbwmIb032BwEKHMJp4chhwXBnUn8QfE6JW63V4mn3y37rvBytx8OYbGqCqRIg6k
         Mr/QeFr7fptZA==
Message-ID: <b8f06eef-5249-d08f-b4f1-800ca14d770b@kernel.org>
Date:   Mon, 26 Jun 2023 17:15:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [f2fs-dev][PATCH 1/2 v2] f2fs: update mtime and ctime in move
 file range method
To:     Yunlei He <heyunlei@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230625160627.4112651-1-heyunlei@oppo.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230625160627.4112651-1-heyunlei@oppo.com>
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

On 2023/6/26 0:06, Yunlei He wrote:
> Mtime and ctime stay old value without update after move
> file range ioctl. This patch add time update.
> 
> Signed-off-by: Yunlei He <heyunlei@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A455F6964DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjBNNlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjBNNlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:41:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8379D25958
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:40:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15BDD6162F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F354BC433D2;
        Tue, 14 Feb 2023 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676382058;
        bh=ILRkbbW9Y6xGFEnpSQ1GK+iTKL7xgpCwB42KdPXl/u8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oUx8kw2gB0gyJiSLuiU4aYLG2rhOcZWkE/PD2cz0DA+f6guAoPfeOWC270Kroc6Z4
         Rk3eVuxy6Mr4G13efxk8hQI7e0BDJt1l9OUxbuh3q1IpMu8bddhSeBiqhqHYeM+Re9
         YjG4aIA5nAEEHw9iSPI3ieKu3HZIdkfZdVc+TtjuDbpAZolPKGIFyvURIln2FaVOUp
         f3vLbmeSNwpoXTsHBBPaLqbko/h0F94IOQgg3CxLfw9jpC+VZx5popD1/zF/zyYD/6
         4MJDqxAuIHFs5+1SHNBy3Zat1DKIu+kpFmeL15imVLiwARjzR4Oas66PA3cu6XFjXP
         9BwnQX8mAnvfA==
Message-ID: <637ce3ad-296d-3b2d-548c-4767e1084d1b@kernel.org>
Date:   Tue, 14 Feb 2023 21:40:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] erofs: get rid of debug_one_dentry()
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
        Yue Hu <huyue2@coolpad.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20230114125746.399253-1-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230114125746.399253-1-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/14 20:57, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Since erofsdump is available, no need to keep this debugging
> functionality at all.
> 
> Also drop a useless comment since it's the VFS behavior.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


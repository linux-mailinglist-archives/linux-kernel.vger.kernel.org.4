Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4956E392C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjDPOWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjDPOV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:21:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD9A1FE9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E767161B5A
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A554C433EF;
        Sun, 16 Apr 2023 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681654917;
        bh=R1pdKLuU+X/rHUpxrpNsE3N6gicOOGU3RiUXbEx9TT4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HOR9SwcRD2ME/zDRATIkccIZm6mQsenjaQmGh8rRj8kOUrKUzzdedVIbSRl6hmXyW
         /XcgCZuLV54nXl/3H8nNxl2Geg2Bp2HMtCLo78+agB2HgpOvH8vI3+7P1uu/lsxQ/A
         Mc6VP2AEmsMJJB5HeofncZCQU+/6y4nCypDpnur/GmmZzLzESSKrTKdknK4pWr6sLO
         0E6W68sD8Twx905CEL+ccda86kmheD7tUx0dQQgemy9MJZTPgac5H4e0mdyJ8FStPv
         733T/15YTGPLZsr3ekIt4arPciv6v9Of1e/Z3ApDpzcRQusR89KK1qVVrwKoPGqkRG
         pawWzf1K2th1w==
Message-ID: <24ae04e0-5d26-e005-aec5-0266ad2462bf@kernel.org>
Date:   Sun, 16 Apr 2023 22:21:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/8] erofs: rename init_inode_xattrs with erofs_ prefix
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
 <20230330082910.125374-3-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230330082910.125374-3-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/30 16:29, Jingbo Xu wrote:
> Rename init_inode_xattrs() to erofs_init_inode_xattrs() without logic
> change.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,


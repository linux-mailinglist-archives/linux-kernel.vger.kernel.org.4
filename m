Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C625F7C6D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJGRqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiJGRqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:46:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F742102522
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD75161509
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 17:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892F4C433C1;
        Fri,  7 Oct 2022 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665164797;
        bh=GYvJFCOsj2U1zfDFdDoeHoZGcUx99SoKzBKO4FXvIwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LP8J88p4uPSjSloYJKiszC6Q9OQ9Qv85yEaKADNULmXu1KJhprUXxKEPZfhohJHUN
         NbonQo6MO2W0cat/n62wOxq67CtB9e2wezVpiAzjQTPQ1NHk6AKzqLj02wIju1caqQ
         Ltc7WJ2aIcgnVOXZOS/dlbrhex4JkeuYeANtnYcBO50+d6YMyN4VQle7TpXQ9bDZlx
         0OpfyK6QhN+rmGLKmD86KNZCngIRcCX7AfyhYkjlVOaMfKP+XCE4eptkP5E52pTEJb
         Uau0O+zMJ2pfStM4QJhZVXl7pqFgr3IOYqLMnctQqW4JZTU+OElrseJYviNJHVYSqA
         78xfkEPOWNCBQ==
Date:   Sat, 8 Oct 2022 01:46:32 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Yue Hu <zbestahu@163.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
Subject: Re: [PATCH v2] erofs: fix invalid unmapped accesses in
 z_erofs_fill_inode_lazy()
Message-ID: <Y0Bl+G1uXaH2Au5N@debian>
Mail-Followup-To: Yue Hu <zbestahu@163.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
References: <20221005013528.62977-1-zbestahu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221005013528.62977-1-zbestahu@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 09:35:28AM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Note that we are still accessing 'h_idata_size' and 'h_fragmentoff'
> after calling erofs_put_metabuf(), that is not correct. Fix it.
> 
> Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> Fixes: b15b2e307c3a ("erofs: support on-disk compressed fragments data")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

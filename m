Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754276AD714
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCGGCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCGGCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:02:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE8A4DE30
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:02:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2B18B81330
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468A8C433EF;
        Tue,  7 Mar 2023 06:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678168956;
        bh=Ag+8oqLe4uB1DL7ahwFdt2BrLQT4vYH2/nnPW4BwT04=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R2GWR/DFs/3Tm0DrIjWQYM9I8SIMD9LEU1vIwCkS1Q/XYFlKy0jgnwhEZnFm2jwEI
         /kkAqkGZoI5xC4lke1l0r2UxmikZdi1516+Y8Qn56W7v2/TW4Bdv23BuJA+Na1mRJv
         z1BfVLgM2jK55+GeN7Hz5oqQ7zIIroMRyxrMeTqUqrKz/fn3D1zDBPS/FbORGOTs7t
         rNoQeGbXQxShj6qnpO4P2YT7yo1vrFq4XidkVTUTz9orw0m+hTI/gR8l6xx3+Wzmhb
         m/PeUvB3TaKQmciUmF4Yw8DaJ2BQAZRtHfkZ4CrVzuAoZOsHhEZkHlst3rHFO7RYyD
         Cfk5QaRu4ltOQ==
Message-ID: <161435ee-aafe-250a-bd29-ba0cda186586@kernel.org>
Date:   Tue, 7 Mar 2023 14:02:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH -next] f2fs: make f2fs_sync_inode_meta() static
Content-Language: en-US
To:     Li Zetao <lizetao1@huawei.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230223012513.1781735-1-lizetao1@huawei.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230223012513.1781735-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/23 9:25, Li Zetao wrote:
> After commit 26b5a079197c ("f2fs: cleanup dirty pages if recover failed"),
> f2fs_sync_inode_meta() is only used in checkpoint.c, so
> f2fs_sync_inode_meta() should only be visible inside. Delete the
> declaration in the header file and change f2fs_sync_inode_meta()
> to static.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC37705C79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjEQBde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjEQBdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:33:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A13A9A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D708A6135A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2385C433EF;
        Wed, 17 May 2023 01:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684287209;
        bh=PPVDkY+EvdxwSIQDM237KwILCUREYeT/1zTBXWjoW+k=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=dDvNUra3Ht/hxIlLFmW264o3r1hUlDeBI9dgvwjaYhdUZtrkDMXiDRhUtguALLVyf
         slUWT96k+kGwiAg5XU/6PJvyLafNLF/pGNEpup1xA85Mz36TBiVhY3wMfGJkyQy7Ax
         a5e1zR57Vs4yhbqHG9ezIflz1vtQ13UYtaYy4H0meuvTZ+B3ystekeIgVhGu/1JfYJ
         v87I1h6jwjCg82Dg4KkfObmtsjI4btdGstS9t4KGcwfWimtUQTQfrY7qP3dsh9ljt7
         A9FzPcG1FtvTt20TE+3KRgsZEz86my+e5Qv66RElBkVaKIzFH+2Au9WzB/UaOKofC8
         bVeCSrrolLD4g==
Message-ID: <57c32112-6457-f3f5-ef43-226a3ae2f75a@kernel.org>
Date:   Wed, 17 May 2023 09:33:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix the wrong condition to determine
 atomic context
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230505191841.3185179-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230505191841.3185179-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/6 3:18, Jaegeuk Kim wrote:
> Should use !in_task for irq context.
> 
> Fixes: 1aa161e43106 ("f2fs: fix scheduling while atomic in decompression path")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

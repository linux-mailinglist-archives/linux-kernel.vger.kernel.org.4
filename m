Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D9F73678D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjFTJUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjFTJUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:20:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1B69D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01B5F60E9D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B91C433C0;
        Tue, 20 Jun 2023 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687252806;
        bh=XVX4CCnLdVg7zSRDRhJD0ERZfLbPES+c03e6Dc9ccew=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ABp2kW72kpi04XgYlwADXbnIlzXILtkjyW1gC0kB38gfhMgpnNy1rexazJVndEz+o
         GpAh8gTDR3DF7UL+4Nz4HFIbe+uwr24PZEeZslUc4rdsJzEkkzecxrnwACRHu25qHy
         QfvofI9kATF2z/+xrhdV1FPK954ucw6fNLlKWwnYRUnEZWKrJIYpudgDLOf+XUOnLd
         kyvdzoM0iNuSRswU9T8+vacyupbKhoPRd9A9JL2bNo/N5GV+5H+Cc5eTejSPQbeg32
         RATmh9jueNs64Mscq2SW6kxTaKP4WQZbpVZWJVtdSWA9IovNQkGMQxJBnIrw1DDFYg
         HVG9kZYUAwW/A==
Message-ID: <a6b7bd99-cd2c-69ef-a021-29a4baf7569d@kernel.org>
Date:   Tue, 20 Jun 2023 17:20:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [f2fs-dev][PATCH] f2fs: remove unneeded page uptodate check/set
Content-Language: en-US
To:     Yunlei He <heyunlei@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230619151353.2168306-1-heyunlei@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230619151353.2168306-1-heyunlei@oppo.com>
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

On 2023/6/19 23:13, Yunlei He wrote:
> This patch remove unneeded page uptodate check/set in
> f2fs_vm_page_mkwrite, which already done in set_page_dirty.
> 
> Signed-off-by: Yunlei He <heyunlei@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

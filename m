Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F6A7317A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344372AbjFOLn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344356AbjFOLnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:43:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17F4498;
        Thu, 15 Jun 2023 04:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDE4560F23;
        Thu, 15 Jun 2023 11:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A87C433C8;
        Thu, 15 Jun 2023 11:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829201;
        bh=pyu4I/v1KzEtwaZxUoDpwULyt62LfG5n4s4H0cxODJM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nVyTTd7eaPRxYVWwnRycGUJGtoHFyfeudPP4aaCamDKe4lN5E2jlGSK3TqsyznXv0
         XBKEaRlnyUaGxRVrnzDmkRpD0ASfx2O4LOjF98mme1aZn2MVKn/aRSU8dh47CZsS3D
         stoZPcuysRnjID8x6UY8OckRtfZoroZtcH0tD9iw3NSigfDN5aQItoGxJV8PNiwWVH
         ru2AJy55+XNfVEjXrINOMeY9hyznOMHvny4Hq+ulueJpRKfelcPUxAQ41VX440Qe0P
         xVZfG3qGwHaD0RFjhDo6OLyIbvwlW1MN4MxHi3KMz2vh2ajzLXH1kBKDW58UjPqdIO
         d+xD0NYqcr4qw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Add missing check for ioremap
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230608022858.27405-1-jiasheng@iscas.ac.cn>
References: <20230608022858.27405-1-jiasheng@iscas.ac.cn>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     akolli@codeaurora.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168682919799.30767.14368815744969338217.kvalo@kernel.org>
Date:   Thu, 15 Jun 2023 11:39:59 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:

> Add check for ioremap() and return the error if it fails in order to
> guarantee the success of ioremap(), same as in
> ath11k_qmi_load_file_target_mem().
> 
> Fixes: 6ac04bdc5edb ("ath11k: Use reserved host DDR addresses from DT for PCI devices")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

16e0077e14a7 wifi: ath11k: Add missing check for ioremap

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230608022858.27405-1-jiasheng@iscas.ac.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


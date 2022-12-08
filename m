Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD3C647263
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLHPCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLHPCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:02:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056811FCC5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:02:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB4A61D99
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BE0C433D6;
        Thu,  8 Dec 2022 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670511769;
        bh=QIp3dYP3MbL2i6Why3T1zkhj7QeR0vGowO05CjyufKo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=OdvAgczR1tGqCrXNG4gWvpoZmo+yUYYoPdDceA1PB/nGJ0FMnTvOdtRXsd3+lEedC
         Gh0gviHTX/izxuc8OAjC0RZmRoNJXkGWt1Hcpq7UBhTPl2ewfn0eoM0Ycs8ejJgsRu
         wF3ZtF0U0zMkBIAvvyCQopTK4V3WcA+zVD8zOZXoJkhL3hcpuPyZr//Vojh8yZUu5v
         KYyBwbIXkxyf6b7n6XfqB0VQOwB8wZK1b1MVKj1iJeO+9z5kaxl4tYzd3ZlPA2JGzM
         ETpHp8rgSPylzvd0TdCoGCY9lNVKcd4VvSfy/p9VJbuC0uHjoluXaKajgEM0HxJ6KX
         LSJewnjyU1kHQ==
Message-ID: <b96845da-0fc8-a9a9-42e4-76940dd7e713@kernel.org>
Date:   Thu, 8 Dec 2022 23:02:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [f2fs-dev] [PATCH 4/6 v2] f2fs: refactor extent_cache to support
 for read and more
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221205185433.3479699-1-jaegeuk@kernel.org>
 <20221205185433.3479699-4-jaegeuk@kernel.org> <Y4+SiufEJLNqrmSi@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y4+SiufEJLNqrmSi@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/7 3:05, Jaegeuk Kim wrote:
> This patch prepares extent_cache to get more use-cases.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

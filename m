Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85135EEE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiI2G62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiI2G6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:58:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8049712FF16
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 761B5CE13CD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA7EC433D6;
        Thu, 29 Sep 2022 06:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664434696;
        bh=48Yc5HgQmEVMfhl/617yDA7Og2HjBTpYuAiPgq/9KqU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U8AcfEsTChMEnTKrDEy2bTMj3LFvM9IGogneaYpz5w3drMArm/k9aUcBZ1cAixD8s
         IjW+Rd5UJfjIuB9k5gtUJuzy4tR8hoUAgfw7HJZtdpReBRyBZ45GNH3Rrl8gIYllfk
         YixmJbUMW1rKMTtO2gXtlJaV4x9sSlH6To+IVcqytZVOAdsxlbvQtQM3dO48mK3XDd
         GrW/S/XizkwWGdyPPVu/pduFOofRVYFXgKeJEGIgesLABscADWXCiwMmzdSKHszW0v
         +DF2QGE1GLuGyXhTNt2O6xyuWNgxNNVNQFRDLdKb+2ZW2ffuljZqA8FRUlXyHkmicz
         6TGOdFz+hAMzg==
Message-ID: <e15cbc44-e227-39a9-38e3-9144f458a17c@kernel.org>
Date:   Thu, 29 Sep 2022 14:58:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: correct i_size change for atomic
 writes
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20220919160644.2219088-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220919160644.2219088-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/20 0:06, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We need to make sure i_size doesn't change until atomic write commit is
> successful and restore it when commit is failed.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

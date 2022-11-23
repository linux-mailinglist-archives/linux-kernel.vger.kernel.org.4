Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6096363A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbiKWPaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiKWP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:29:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22891C2A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:28:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30C55B8210A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CE4C433D6;
        Wed, 23 Nov 2022 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669217297;
        bh=dpZG+L8p/ipN5nfLHFuF2VofgalY8nR7bKSYH4b2B6s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fSTHigItWtyddoNS7JhsQ7v0u++z98i24gAbrjmW2LjY6iYd6f/9JzG9PbvvpHstW
         waO116gW1j1Cybdq1WDAPU2wQCJkAdlyPIANUAa6x91RIgfijvzr3Cit32E8E+OXRW
         owmmnFWo8dVAQ3ibZmlNKttGHn7qtICl8WRAv/bzPOV6Ij1q4L3LmgI76qn3Eiue1A
         iB63qBCA8ovz6KQb//+7JFJMMPyMld2eybDLgMwsvZdMAyKqDvLh8h+YsdALvlfMKg
         vRcyyqy1yE17FoJqYqMErC7qz7SWwxQqsqJAcdPKTq42EdGQjGNzF1AbNpkR7rclio
         2rNh/lEiI0a1g==
Message-ID: <088642e5-b0ec-b7fb-81e0-7f64779182b6@kernel.org>
Date:   Wed, 23 Nov 2022 23:28:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: make __queue_discard_cmd() return void
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221116171045.13407-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221116171045.13407-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/17 1:10, Yangtao Li wrote:
> Since __queue_discard_cmd() never returns an error,
> let's make it return void.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ED76491B6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLKCAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLKB77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 20:59:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722D01275B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 17:59:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3F93B80959
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 01:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D781AC433D2;
        Sun, 11 Dec 2022 01:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670723995;
        bh=+ZFoNDlGEVI3bA7hHuuuTNYqlTyIKalrOF9IEBCd0Uo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fawb4oMBxb8kDmxe/jO7AT9Xy2rg1DjoRCOUY6hOFKA5scpqL6nA7rgc/FATPOUYz
         mv4947Rw5sZmfSeguKnp10XL6LnOBlbS9yLUwojpDDiwUWUC5vG8U3olGvB+D9yyma
         1Q+IvG5o+UlYv8r0noOD1XRBWOK4aCrSVHPk2VYvcfkmA7qs8e+pSNo7iLAZvqXs1T
         sCoqR2jrkxDLScVMYVL68WSCLCujts/p2Yug2NF+uEw6e2/sqln4fSLugGpczCZkLB
         ncAdkUWbAqjyRpR33ClDJM8DWyofHK7PGl2gehaTubH3nn1InWdBWqpVEzTTYBfUVD
         a8dWGwMppAugA==
Message-ID: <966e1554-9942-97b9-6ea1-5f970119c6a4@kernel.org>
Date:   Sun, 11 Dec 2022 09:59:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [f2fs-dev] [PATCH 1/6 v2] f2fs: specify extent cache for read
 explicitly
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221205185433.3479699-1-jaegeuk@kernel.org>
 <8ffb43dd-3887-aa56-6f0a-1fb6ff0e191e@kernel.org>
 <Y5OPF//DawJbwYgj@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y5OPF//DawJbwYgj@google.com>
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

On 2022/12/10 3:40, Jaegeuk Kim wrote:
> Let's descrbie it's read extent cache.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

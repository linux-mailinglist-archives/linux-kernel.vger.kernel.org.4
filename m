Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547E66EDD4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjDYH4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjDYH4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9767B9F;
        Tue, 25 Apr 2023 00:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 308886221E;
        Tue, 25 Apr 2023 07:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C5DC433D2;
        Tue, 25 Apr 2023 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682409400;
        bh=BM7hP+iKBMmWkZ0c7t/artoc23OdPSOwarwKxc1EtTo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d/nRgnY26nc62jMRwDX77juVUu7dUm2OCmVCtEQtZBls+GvqqO144CWXmWJs1slr8
         ey/58Z0L/zETswmWEnuMPPSiC1SJokV9hZ168RJMadUQJBjLJixuJDy6M3yaUH1yc9
         61xYY/FvPCdRmtTmbFkCRRMTw59cEhbzRSPlplLPnj0pajDZtGzjnHD8PFZKDazI8O
         YdC/T57VLecbwACuKHiDuC5Sw/TjcomeYhSMvEq0Jyx1PPJ7+F9aKL4qnuNTsmksob
         AvpbaKmJP5nHRUViYA8XGvRBdp+xomSWX/NFdvqh9jS3kaPIAzXQ1747KUATmm/4Ii
         1LtukCpWU2AIw==
Message-ID: <bcfb7115-c78c-b235-5709-294647ea3e2e@kernel.org>
Date:   Tue, 25 Apr 2023 09:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] rtla: Add .gitignore file
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>
Cc:     rongtao@cestc.cn, Steven Rostedt <rostedt@goodmis.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:Real-time Linux Analysis (RTLA) tools" 
        <linux-trace-devel@vger.kernel.org>
References: <tencent_3C22A3418CD06196C2E5A84AE3EBC2281206@qq.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <tencent_3C22A3418CD06196C2E5A84AE3EBC2281206@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 12:46, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Add .gitignore file to ignore the rtla binary.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

> ---
> v2: Improve the log and subsystem.
> v1: https://lore.kernel.org/lkml/tencent_8042C05909979D2A1AAFA8A3028854065808@qq.com/

Thanks!
-- Daniel

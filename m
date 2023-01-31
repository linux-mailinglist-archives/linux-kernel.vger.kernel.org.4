Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81604682FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjAaO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjAaO6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:58:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383641BACD;
        Tue, 31 Jan 2023 06:58:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9298B81D3D;
        Tue, 31 Jan 2023 14:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65823C4339B;
        Tue, 31 Jan 2023 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675177118;
        bh=AUXvmQ08Qq/TFGePV5E04fRc2l+nOAmf/XpIUb4AnRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=abRa4JP6HJ/1OaTFiQzeLhnwjRm0GTu8VQeMGh4JyWnfWg2IwuAkwA5Jg4IN6Dh+m
         BcfMidmRw6HaIP2xAwe9suTIOPfOy2YMlwqB4+ejWNw6Gw7LAU/06aT62LiOZXY5bA
         M285TQLrUhth95G8wzrLfUsP6mD97rTh6y/kGQvpY5ZYpyhlk0vGdFNmzWBT5EMVyr
         pIsnWvKbq3XvSpbu10D7MdvvgNDwMt86+2hgRrafoctN0qKhvBUz8LHuxSEzqbtQQY
         OBlcWnSPAEoCpIi6R6rdOz9FOQMhtmLjP/BH4HtnUSN8LNOU/2t1cUmTeZ4tNTN/Lp
         I4Z0FziW+MANg==
Date:   Tue, 31 Jan 2023 15:58:34 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] Docs/scheduler/index: Add missing SPDX License
 Identifier
Message-ID: <20230131155834.238886ef@coco.lan>
In-Reply-To: <20230122213650.187710-8-sj@kernel.org>
References: <20230122213650.187710-1-sj@kernel.org>
        <20230122213650.187710-8-sj@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 22 Jan 2023 21:36:49 +0000
SeongJae Park <sj@kernel.org> escreveu:

> Add missing SPDX License Identifier for scheduler documentation index
> file.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
>  Documentation/scheduler/index.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
> index 1aac972a652f..ae0229f5a9cf 100644
> --- a/Documentation/scheduler/index.rst
> +++ b/Documentation/scheduler/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  =========
>  Scheduler
>  =========



Thanks,
Mauro

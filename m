Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB456A2B7E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 20:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBYT0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 14:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYT0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 14:26:13 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDAA158BD
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 11:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GqqRkGpOeKktvU4ro7FjB0loLnUNsJxVg32vnklDVLA=;
  b=RuG7YtTlsyPIgyU6JGOrUEFYiR4o45o0pWEZ7MosXfc47SDzUtCzhtkP
   XpKCIys4aHPqyNG/lbmmoicFymNezVh7jbGoTDuJfikrtwKF6Nk/vIebH
   J6R5JJ0/DlB/yWo5q4QAtLUtY1fjr9iqok3yLOPANc/QCJKt4fHV455CM
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.97,328,1669071600"; 
   d="scan'208";a="94345849"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 20:26:11 +0100
Date:   Sat, 25 Feb 2023 20:26:11 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Jarkko Sakkinen <jarkko@kernel.org>
cc:     Nicolas Palix <nicolas.palix@imag.fr>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts: coccicheck: Use /usr/bin/env
In-Reply-To: <20230126215612.86436-1-jarkko@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2302252025490.3036@hadrien>
References: <20230126215612.86436-1-jarkko@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Jan 2023, Jarkko Sakkinen wrote:

> If bash is not located under /bin, coccicheck fails to run.  In the real
> world, this happens for instance when NixOS is used in the host.  Instead,
> use /usr/bin/env to locate the executable binary for bash.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Applied, thanks.

julia

> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 2956fce8fa4f..b4d0d6eb3e73 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  # SPDX-License-Identifier: GPL-2.0
>  # Linux kernel coccicheck
>  #
> --
> 2.38.1
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4BB65E0A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjADW4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjADW4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:56:09 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629AF1C40D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:55:56 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id e22-20020a4a5516000000b004a3d3028bafso6743604oob.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSa3y2kVtXyGfcBV6KdEhTjbXDEsZrA1QZe8gseBjok=;
        b=pdyU5nNwLPBCT14Il41JLXWCOGGjzhZ4+/GNaRyCvoxhZxkZmU4IXOpTTppmn/l7+m
         H6wQXscp6yQEha0x4Im1vXl/LkEmw3hm1SugtqM17JUzmrfKImfohf5zBk5FUs58OB3q
         exz/fJi8zcAHdS4uiEK9t4dx3lQsHNPSchD5KnhuGwT/o7CCDMvrU/hMcYVzbTaS35nE
         9+dQRxUAXzGlXEbQGM+omi47Y/9m9f5Y7us2U2xh00UMTdwQQVPAn41osB1UB2HeDRA1
         6+aDcvEkCLucxEV9EDI93yOaPLK6QEHwPvxkajgsNNX+W3EhSHKPA72kjjhwDQZooPhY
         j1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSa3y2kVtXyGfcBV6KdEhTjbXDEsZrA1QZe8gseBjok=;
        b=dsC044SPZKwnN1GaY/H2/pTcd6w6UgU/kU2wywZ3ee6KV+UlEDyczHQbnG0901kpQJ
         K238hkoPOIhIU9jNNc4dYQSsW+h/K6YS9URgmWoSvm0Ou1+cq/YcgB9BOnH/3hUOOB9S
         cyQkke7WVSSHqrsu4iD8ACESvQH2SH455kH+Xw2kgVDMUoE318FU5I6XHXNxoJxpbumZ
         c8kXDa9cQn+v7o176mOtWjVrNLcK4Rs8GgcELL0p/bzd0lV3h1ZNQzwAigJO0aAe8x25
         JN+dvO15qY1NycGqyLk8p074vmbYmo1UnFOs9flETLEQid5VCdHsovFM2zlUqq1JYKrE
         tMeQ==
X-Gm-Message-State: AFqh2krJbt6jt+ujDBOrc65MiNdHFV1g0qHQk90UQQYLVf9f9fpqyfkZ
        hKsaLt/2vdvbguqNFU+DFLvU0RozCvzfNCPz
X-Google-Smtp-Source: AMrXdXunaxUnZdko3CQ/sTo/WkLccuHLO8jxYV96IN/3Yhs/EMlXwL0hEXVd2h6ymN2kv2e8H7xYPw==
X-Received: by 2002:a05:6a21:339b:b0:b0:29db:fb73 with SMTP id yy27-20020a056a21339b00b000b029dbfb73mr68503088pzb.12.1672872453217;
        Wed, 04 Jan 2023 14:47:33 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:1328:ca09:d4c2:fcbc])
        by smtp.gmail.com with ESMTPSA id e11-20020aa798cb000000b005825460056asm7433625pfm.70.2023.01.04.14.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:47:32 -0800 (PST)
Date:   Wed, 4 Jan 2023 15:47:30 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     andersson@kernel.org, matthias.bgg@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org
Subject: Re: [PATCH 0/2] MediaTek SCP IPI cleanups
Message-ID: <20230104224730.GC2112402@p14s>
References: <20230104115341.320951-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104115341.320951-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 12:53:39PM +0100, AngeloGioacchino Del Regno wrote:
> Cleanups bringing no functional changes.
> Tested on MT8173 Elm, MT8192 Asurada, MT8195 Tomato.
> 
> This series applies only on top of [1].
> 
> [1]: https://lore.kernel.org/lkml/20230104083110.736377-1-wenst@chromium.org/
> 
> AngeloGioacchino Del Regno (2):
>   remoteproc/mtk_scp: Use readl_poll_timeout_atomic() for polling
>   remoteproc/mtk_scp: Remove timeout variable from scp_ipi_send()
>

I have applied both patches.

Thanks,
Mathieu

>  drivers/remoteproc/mtk_scp_ipi.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> -- 
> 2.39.0
> 

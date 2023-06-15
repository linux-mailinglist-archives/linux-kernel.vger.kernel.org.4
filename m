Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F07731ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbjFOOGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344716AbjFOOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:06:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D3F1FE8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C1EA62D90
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5466C433C0;
        Thu, 15 Jun 2023 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686837962;
        bh=2M6qrF4ORzCFN2c/lRhl6bHd4E8kwP4xtKpvVV/KLPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZ2j3/pqpnU3o0tWYY25t99Y4mtVRiNp4oN92bIm4SGfe5/v0MZI4RdQ1BuSrNUyI
         LKqNNYvYRHa7W62924yI+Oam42zxLrno6NgnmKv0xBem/Q2Z7XfSQHNh5GggpRLoVq
         euBJj5ihapWfib7GEbcoSVn7VELv/pYcEhsoz79HLG1baXAG7sI4tkas7UTSameS0K
         V4qRtM1xMt7234aPLA09cm3wLgpx/S6Z1c52XWvtsd7+r2orcPSpJa5u1Wq1Tu6UdC
         4xZUpScsLiwj0zxdz8/tuR26Y4Mcan6RHALDjjbprZqXGkz5zDtPVzihNxBc+AAIxG
         D122hUsy/SxuA==
Date:   Thu, 15 Jun 2023 15:05:57 +0100
From:   Lee Jones <lee@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/2] mfd: stmfx: Nullify stmfx->vdd in case of
 error
Message-ID: <20230615140557.GG3635807@google.com>
References: <20230609092804.793100-1-amelie.delaunay@foss.st.com>
 <20230609092804.793100-2-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609092804.793100-2-amelie.delaunay@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023, Amelie Delaunay wrote:

> Nullify stmfx->vdd in case devm_regulator_get_optional() returns an error.
> And simplify code by returning an error only if return code is not -ENODEV,
> which means there is no vdd regulator and it is not an issue.
> 
> Fixes: d75846ed08e6 ("mfd: stmfx: Fix dev_err_probe() call in stmfx_chip_init()")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  drivers/mfd/stmfx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]

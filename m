Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA5B72CBA8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbjFLQgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjFLQf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:35:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4E195
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:35:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5275362B86
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64224C433EF;
        Mon, 12 Jun 2023 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686587756;
        bh=YXskNKDnS8PL+igoKTVbf5ZOxuOr8fTyflj3bBxSWR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQpEez1t1UEb4cVAE2ds4firPYWwr4CQw/co9tJ4emRm1C5x5D71gcGJsWifMpQZJ
         1NeNIdFpH+lO7x5bO0bzjrXws/Luor3VVzie3GEozEIdrGNLE22vxa5ODVbtqFxK5W
         hK/s6uXVw7RgTtEu4akO6GP+C4UohoepTuql+a4M=
Date:   Mon, 12 Jun 2023 18:35:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "jim.tsai" <Wei-chin.Tsai@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, mel.lee@mediatek.com,
        ivan.tseng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 1/1] process: export symbols for fork/exit tracing
 functions
Message-ID: <2023061238-hatching-easily-5564@gregkh>
References: <20230612151545.17810-1-Wei-chin.Tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612151545.17810-1-Wei-chin.Tsai@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:15:41PM +0800, jim.tsai wrote:
> --- /dev/null
> +++ b/drivers/misc/mediatek_mbraink/mbraink_data.c
> @@ -0,0 +1,417 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 MediaTek Inc.

It's 2023 :)


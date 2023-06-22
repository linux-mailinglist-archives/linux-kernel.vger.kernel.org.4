Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCDD739E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjFVKRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjFVKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:17:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE942107
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63AD861789
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45E1C433C8;
        Thu, 22 Jun 2023 10:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687429037;
        bh=McJw4yj+3Kf9jn1ZwGX0a9V4cQzBuo9RO+rqfuWeUZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J2ZDseyurBPtJqc0nQ1uYwN70v9wASKytD4EvYBP+SUkfk9OUd/hkgTQ6MWDUu3Ti
         BFErVIXG2tQy2IGa23ZPj3sPXX9dhs9XsX/yYjDCFsM+cHEawoODeMWkfwDXtWd46Y
         TxLx1aZj1uiW+qW/hpjjbZqp2C3LNmIVNFr6npM3N/TftslXT/sKe3I5hyGFwCnBD6
         aXogCvhF+VsA4XSIbvMTWyr5a7XuGxsBVo6XvfN5E+ieck1B4oWnQaKqDvequLozH6
         E7r6HNAeJPc9E46B+4nbW0LoJtAVXmfpUTDFWAOg0iktmy1bx2JkK8+PpTv1la4/7u
         +ezH1yRfqO0eQ==
From:   rfoss@kernel.org
To:     linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Cc:     Robert Foss <rfoss@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@gmail.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Philippe CORNU <philippe.cornu@st.com>
Subject: Re: [PATCH v2] drm: bridge: dw-mipi-dsi: Fix enable/disable of DSI controller
Date:   Thu, 22 Jun 2023 12:17:10 +0200
Message-Id: <168742902332.865433.11382317679096265094.b4-ty@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230617224915.1923630-1-megi@xff.cz>
References: <20230617224915.1923630-1-megi@xff.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Foss <rfoss@kernel.org>

On Sun, 18 Jun 2023 00:48:25 +0200, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> Before this patch, booting to Linux VT and doing a simple:
> 
>   echo 2 > /sys/class/graphics/fb0/blank
>   echo 0 > /sys/class/graphics/fb0/blank
> 
> [...]

Applied, thanks!

[1/1] drm: bridge: dw-mipi-dsi: Fix enable/disable of DSI controller
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=05aa61334592



Rob


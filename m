Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CBD74D24C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjGJJwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGJJvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:51:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D07B183;
        Mon, 10 Jul 2023 02:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB6760F35;
        Mon, 10 Jul 2023 09:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEB5C433C8;
        Mon, 10 Jul 2023 09:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688982489;
        bh=PnEAbXpDkS/2DQfknA13T3c/Xhi5kSmvuGgopFlpfSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMyjk8BPbQPAZeekXCM9QGCSkOmYufC5Kz4eRl+JqNXld+HVoT3vIQmV6gQegS3xc
         Xf90C5kC8Z9/BPfe67aoRDY5IJSC4rMMsDrrpZH0+sRIo4TzLNu/km+NAXS/BNYy8d
         ah6ZlZqnmK8rnmjM/IRNEN0MFD1123nEhzbDEFmJT6fBRM7Mgx4DfD+x1/t1+Dw6Nn
         8SjYXvpvMGtGT8n5+59votu043HaMFg/0P3ibfuq8IW+gTpsUDWu7ruvzunGs882Dt
         X7yY29/50WXR9C31E3zE8/sQFtZCq6tpcip9paUnZSF2WrZT3Gp5mmDu48HnO4w2pY
         nf5qH2vuO95yg==
From:   Robert Foss <rfoss@kernel.org>
To:     Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Robert Foss <rfoss@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3] drm/bridge: tc358767: Use devm_clk_get_enabled() helper
Date:   Mon, 10 Jul 2023 11:48:01 +0200
Message-ID: <168898247567.1224956.8670900854330995667.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <208a15ce4e01973daf039ad7bc0f9241f650b3af.1672415956.git.christophe.jaillet@wanadoo.fr>
References: <208a15ce4e01973daf039ad7bc0f9241f650b3af.1672415956.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 08:05:35 +0200, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: tc358767: Use devm_clk_get_enabled() helper
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=70d3c92d852f



Rob


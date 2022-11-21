Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4665E632906
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKUQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiKUQJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:09:17 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB51C6043
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:09:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5so8810851wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndp9pCENyU3E4kYpzWJmUyLiPz4xKgo+kLDz3SBfds0=;
        b=RuHGAabA4hXPn3XQZEVESTm6Zxg8aPGVZevPgWPfcBQWmIc0bR+GmdVIRs6EqWggsb
         vTBlf6Jg+gTq3hXIwtn5VlJ4d5fjMAQTncxa02bh+1PgjTFgkCQ4bZmC0IGprWjBGrmD
         e6B8V1tRdc73kMfiv46H88IpUaJowwsGOIL6hOw2hvJUQH9ZoQf9DLfq3OKAF5ip1xF2
         /D9vXSD2k8IZy33VLFpwLC3GulH6DwT48m4xC5ifzDvejPWdSvyx2Uluxr1POSsN3KVW
         T0ik0MTRHhigZP9kuw3rzH2wnlFl2KYG45tLLxFxIXxkOTF1F9EY8KhWJmIscwz5L0yu
         GmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndp9pCENyU3E4kYpzWJmUyLiPz4xKgo+kLDz3SBfds0=;
        b=TmtlBzPCox5s1i9YOu32ghfenardrA8kJjokMQ3T6VwIOFEzORnMUE7wiJRl7knnSq
         HaBUy1Uva2TLkEMdLD3B9huk2tT7U7yDfofz5Am0gIfttS6Rl3qYaKjLAzJsrbM27AsE
         TK0s8ZLQss60MWw+eFPmIBQdTxSX1yRY9aXMOTo+JBAGUibOOEtE3299BbCShPtbdNW9
         839zq4sLUc+WXv0Y6RPWTFvR/9Y+1zei0/BK4dyfRmDDPz5xvzU6m3noQv4Fof12gTgG
         JeAysGGDhWAdht1wPNpeb4Yqlm3YNleylu/J6v5XGAMegibXOCy8SRIXhLbsWV1lcaJ0
         0tMA==
X-Gm-Message-State: ANoB5pkMkm00nJTr6SMqMnIIv/Q9x2xd+CEcSS0MVt0GujNc3fT4q3eh
        sdG1PaaDa6rhLvLA/rRFs+HufQ==
X-Google-Smtp-Source: AA0mqf5XhJAinBijJRnm3g7NsHsk+2UOjaTXO9W0Sj4/cUjCh+dc3ZFbNaI4+bdvwhSR2ws7hvn5wA==
X-Received: by 2002:a05:600c:3514:b0:3cf:e0ef:1f6c with SMTP id h20-20020a05600c351400b003cfe0ef1f6cmr6411633wmq.75.1669046954280;
        Mon, 21 Nov 2022 08:09:14 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m16-20020adffe50000000b00241bee11825sm10474963wrs.103.2022.11.21.08.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 08:09:13 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:09:11 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     shengjiu.wang@gmail.com, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de
Subject: Re: [PATCH v5 0/2] clk: imx8mp: Add audio shared gate
Message-ID: <Y3uip2mPNkx+KLWG@linaro.org>
References: <1667811007-19222-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667811007-19222-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-07 16:50:05, Shengjiu Wang wrote:
> changes in v5:
> - define IMX8MP_CLK_AUDIO_AHB_ROOT as IMX8MP_CLK_AUDIO_ROOT
> 

Applied both. Thanks!

> changes in v4:
> - don't remove IMX8MP_CLK_AUDIO_ROOT, to avoid any break
> 
> changes in v3:
> - remove IMX8MP_CLK_AUDIO_ROOT
> 
> changes in v2:
> - split dt-binding to separate patch
> 
> Abel Vesa (2):
>   dt-bindings: clock: imx8mp: Add ids for the audio shared gate
>   clk: imx8mp: Add audio shared gate
> 
>  drivers/clk/imx/clk-imx8mp.c             | 12 +++++++++++-
>  include/dt-bindings/clock/imx8mp-clock.h | 11 ++++++++++-
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1
> 

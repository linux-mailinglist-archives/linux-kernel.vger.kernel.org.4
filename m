Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F82768008D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjA2RtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 12:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjA2Rs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:48:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F206A1ABC0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:48:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l35-20020a05600c1d2300b003dc4634a466so2579894wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sr4fFy3dWRxDTNDNO8Ar7sH6BDFvsFVUwILCU9VcaZM=;
        b=Z0b567v2zrQsZmZpB1usLpNIA7m9hlpZar2O/dXmouTBfEfnbZMHzkbfLlHsQk2Uhy
         HnC3c5w79TJ9pQiKxIOexVvLBtukUNUBGqP12H3L3iqKO2lvIpU3/xIwrpD/f3F28wGV
         u3aU228GVcc56ajSOULx6MnM4lOYEcYYxnlO7IjXliLJUC4feyTtR909XF6cRnsbnnY0
         iGoIO1WoIJLsamXRacRiGmO61tFOx6BtVH+acMpzfMv8r+7vUnK3dWdnf+B6367cuoNe
         RusKb/pLiaxfFIsTaOMu4XGBpYtqUx976toY8VzCVj7MS2LylpbaozwdcRr0lcZHZAE9
         wNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sr4fFy3dWRxDTNDNO8Ar7sH6BDFvsFVUwILCU9VcaZM=;
        b=zB+wjrBHhJYk+K7A0jVy+9elcftZZAbV7/FeP0qXBCROCS3byFRAT2CajQ2JeWWVA3
         gPn0EQtIkFNwmpiDJWAoColMDNErWqlJv8T1rZM1Fr8FMpbviH2eLLdzUy1njhHs0v0Y
         hGN+7ewHs5s0PikSHwFs/e8RfUN1U8TN5JoyY8OcBAU5XAaMCWNZgUQqCxW712coorzd
         igfyurq/v/YA7B25k4aGBZN5859PR0rVIrCMkDM6eO9eegF5hsBvUyvcFiTys3hz61Sg
         Zr9PFIiCiGCA88Ip2dVCc4HpRtx/gxA8rqtIao5klfOff75ukyvEgsN9GfsiWvkMSYfi
         BOkg==
X-Gm-Message-State: AO0yUKUfGSqhF0TbzHvhKQFStZSUXNgHsN5SOTkYlzgJUhp6rHqPQDxQ
        O8XSPtI3Od3Re+SkeFmgOXck2g==
X-Google-Smtp-Source: AK7set8V03LwoICGduJRa2Bl27HyEiBCOlv3oVi6LLGhhTDf2BOMD2OtF6I5stna37Mo3ZDdkOdQTQ==
X-Received: by 2002:a05:600c:54e6:b0:3dc:489e:1867 with SMTP id jb6-20020a05600c54e600b003dc489e1867mr5540037wmb.36.1675014534575;
        Sun, 29 Jan 2023 09:48:54 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b003db09692364sm15200937wmn.11.2023.01.29.09.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 09:48:53 -0800 (PST)
Date:   Sun, 29 Jan 2023 19:48:52 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/4] clk: imx: imx_register_uart_clocks update
Message-ID: <Y9axhPF3h/kZEsGg@linaro.org>
References: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-04 19:00:28, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This patchset is to cleanup the imx_register_uart_clocks usage, and
> use this API for i.MX93 clk driver.
> 
> Peng Fan (4):
>   clk: imx: avoid memory leak
>   clk: imx: get stdout clk count from device tree
>   clk: imx: remove clk_count of imx_register_uart_clocks
>   clk: imx: imx93: invoke imx_register_uart_clocks

Applied all.

Thanks.

> 
>  drivers/clk/imx/clk-imx25.c   |  2 +-
>  drivers/clk/imx/clk-imx27.c   |  2 +-
>  drivers/clk/imx/clk-imx35.c   |  2 +-
>  drivers/clk/imx/clk-imx5.c    |  6 +++---
>  drivers/clk/imx/clk-imx6q.c   |  2 +-
>  drivers/clk/imx/clk-imx6sl.c  |  2 +-
>  drivers/clk/imx/clk-imx6sll.c |  2 +-
>  drivers/clk/imx/clk-imx6sx.c  |  2 +-
>  drivers/clk/imx/clk-imx7d.c   |  2 +-
>  drivers/clk/imx/clk-imx7ulp.c |  4 ++--
>  drivers/clk/imx/clk-imx8mm.c  |  2 +-
>  drivers/clk/imx/clk-imx8mn.c  |  2 +-
>  drivers/clk/imx/clk-imx8mp.c  |  2 +-
>  drivers/clk/imx/clk-imx8mq.c  |  2 +-
>  drivers/clk/imx/clk-imx8ulp.c |  2 +-
>  drivers/clk/imx/clk-imx93.c   |  2 ++
>  drivers/clk/imx/clk.c         | 17 ++++++++++++-----
>  drivers/clk/imx/clk.h         |  4 ++--
>  18 files changed, 34 insertions(+), 25 deletions(-)
> 
> -- 
> 2.37.1
> 

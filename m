Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D1662394
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjAIK74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjAIK7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:59:52 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFF411A1D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:59:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vm8so19072538ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugvkkpr34KZztkA1BUw7O7fahTVQ3eLoi7m6q/6osxw=;
        b=ALDAYfAlPa//bISeUyB1yM5OP4iJQb+ycMLjUNqcfzqMiVY7Wp/eqVrBNcAi3uI7Av
         Llw27EG84cUbymynqWy/FmqkpEwDDqxonsLTCL9Pn/7+RGbJKz7G4aH6V8MYD5FTEK4A
         +HMAJhzu507qSVFLkTAGDPRYVVeQh5mpUUaJbbVi6lriFjjWfUVOt4tN3Nry4CXugcAh
         PHG3lm3P8D2WijIy6bWNTt2GYyoxlOaB+yiTyfH7CcGdkHD/kV4PJM6guwQHlJNbTxQ8
         mqsEnuVh6qPI/7ceX7Zi2e5409gKA3AsyQw5RP+3EjnWInKDfEvf5y2JSmIY+cTdnepm
         K8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ugvkkpr34KZztkA1BUw7O7fahTVQ3eLoi7m6q/6osxw=;
        b=TL8HjXeTXn/mBGZ/aq6KlE+eCOvQx/U0UbGVqY7w/tvER6NxSJCIS98Td29IetY4mj
         IvgiHTQu+aOshjFimsTX5PtV5+flpqn/WqrAjMs2HotkTt53H0KmSrIN8EUIRhrf6aGH
         57aPPEqHYFTd5rW3hI0hOobvK5DaIf/0CDV5sg8a973EnAE7ZT3+Qqtvg/Nac/xkZ4YK
         2B9p+JeBxqxkV6sh4IL/UgutwJXshfClky9TFiDAMqSvHX3PRkO+G+FP931Us3dzVRV+
         0Jp7yFtfD1Zit06k13+BdxXJIZplA5d8pnGTbIGn5EaQmxYNuHuHDY3ou+xYIhsHwdDN
         kXtw==
X-Gm-Message-State: AFqh2kos0d0AWSYzXox30QqQpgjjm+qHm+6xwQ81vUjunLxhYWVDD+kX
        WX9xzC0O4wrSPO+uiUdItxgJlQ==
X-Google-Smtp-Source: AMrXdXsaR5j0ar/tVohorOXlCaAQ5mo2Gb6UbLwalHP3erNC9TNFKW6MRPDNIaBSC7RGBPmezGe89A==
X-Received: by 2002:a17:906:3084:b0:7c1:5ee1:4c57 with SMTP id 4-20020a170906308400b007c15ee14c57mr52785196ejv.8.1673261989800;
        Mon, 09 Jan 2023 02:59:49 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id vf24-20020a170907239800b008143bfe8429sm3640274ejb.73.2023.01.09.02.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:59:49 -0800 (PST)
Date:   Mon, 9 Jan 2023 12:59:47 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/4] clk: imx: imx_register_uart_clocks update
Message-ID: <Y7vzo+25Ne0F0gBh@linaro.org>
References: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Whole series LGTM.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> 
> Peng Fan (4):
>   clk: imx: avoid memory leak
>   clk: imx: get stdout clk count from device tree
>   clk: imx: remove clk_count of imx_register_uart_clocks
>   clk: imx: imx93: invoke imx_register_uart_clocks
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8767FA3B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 19:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjA1Si4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 13:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjA1Six (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 13:38:53 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FA023114
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 10:38:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so7474206wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 10:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ktt+Jj0sDLgKEcmopucgL2DJuOv6S3oPl1SrPAyA73Y=;
        b=m5PIyjyc1FSkioDuZ91i2Bs6GgW2+ryq7LYDtsorZZh79bpVI0tdHM66YPuwB0kXJB
         nt6SYzOUznse7izWefZwK3/ky8ewaBakVvWIgynwr8CkqbOAERIRUnlxQjSSB5f2/64I
         WTbQ1uaW4+AohBz2cqDjZWvcc8zKvmHFpY5mKob8hAVSd5mQXGlKYHXlAxAtJN/DFNg9
         0GlPDYc2M38baxqv5Par7IZEfRzpHLs0EESjC624G0tGjXrCulRYGjORT70YfXUnGkiQ
         id8Fz8ZDgQwW8j9x/9cxu0Tp8r09cV8+SGR0Jp4UHRCau1YoKj0Z6Jj7fe5Z3k0/5tdf
         2X6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktt+Jj0sDLgKEcmopucgL2DJuOv6S3oPl1SrPAyA73Y=;
        b=fT1rS2XdH0JB1fpIjdm4q2LBHMS7mV8dew9cbvV54JGn4XCFJPnzwdqjbDaVRFwR4J
         mdXSvGlQqQry3Qt4AwN37l6xSw5cf4QqdQ0hoXw1T6DX+bplC2uSUaNmHvpGdE62yYnz
         YFtUwvGD/doDfDwNLIzMk3r77TXr0i6k74qirkzOYugUxG6QvIewAB8mzq7/jpJEUU3/
         SUsJCm9ogG2flK3tUzQH59I8+CVkCEuEVF9FXfHWLLw/9dnXGShBSkSsoZm9D22pRpwe
         86VLzj1vH1LFdSbTmd4BefdsQk6ZkHbVoO9qKd8sP9T1EGSWrK5S3LxgtvBAyzu8zKZ9
         Gb0w==
X-Gm-Message-State: AO0yUKUQ4FRFaaXPmnzIi8vBnkQY3kSGc8lCQVXQAlIeQlcivBYYio01
        0YYfsElDE+9oD1hhWlQKvuH/jQ==
X-Google-Smtp-Source: AK7set9mBphpUni7E7SMBDZ+fF5wJ5ZXafz26/EFCku5akdPkAcVR1iR9uGa/AmHRT5ML5bBRIpr1A==
X-Received: by 2002:a05:600c:4451:b0:3dc:191a:3b13 with SMTP id v17-20020a05600c445100b003dc191a3b13mr15798892wmn.8.1674931130149;
        Sat, 28 Jan 2023 10:38:50 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t19-20020a1c7713000000b003dc48a2f997sm2476821wmi.17.2023.01.28.10.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 10:38:49 -0800 (PST)
Date:   Sat, 28 Jan 2023 20:38:48 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Peng Fan <peng.fan@nxp.com>
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        abelvesa@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        18701859600@163.com, bsp-development.geo@leica-geosystems.com,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V5 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Message-ID: <Y9VruNgUuA5h3d70@linaro.org>
References: <20230111101030.686885-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20230111101030.686885-2-Qing-wu.Li@leica-geosystems.com.cn>
 <Y8VfEfnWwt8+QB1W@linaro.org>
 <a1285cb87151130de782fc1941b13f34.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1285cb87151130de782fc1941b13f34.sboyd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-18 11:00:36, Stephen Boyd wrote:
> Quoting Abel Vesa (2023-01-16 06:28:33)
> > On 23-01-11 11:10:30, LI Qingwu wrote:
> > > Defined IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV in imx8mp-clock.h
> > > but never assigned. It will cause the system to hang if using them.
> > > Alias IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV to IMX8MP_CLK_M7_CORE
> > > for backward compatibility.
> > > 
> > > Fixes: 8c83a8ff4dd9 (clk: imx8mp: use imx8m_clk_hw_composite_core to simplify code)
> > > Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> > > Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> > > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > 
> > Stephen, can you please pick this up yourself?
> > 
> 
> Is it needed for clk-fixes? When did the system start hanging?

Li, Peng, can you provide some details here?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A559632ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiKUVam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiKUVai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:30:38 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BAECEB89
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:30:35 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so65075wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiQJdCH+8sYhTRQ1EnF60bNt6EZIXVO1VSAMNseQ+hQ=;
        b=FvmiA7LCcIaDkdXjsqbwDDWqxXF5Hd76EBvzDkReispOVeUQ9cgbcNZvA/q/+eAkaG
         HrlG7cDn4Q9pPIdfbHc++C0fybp3nziqOTSuXKtlukl4sVQ/wDzu72WfXhzxDCsCyyMu
         rlYsEn+FeClH7J2hFyIKLBTHOIUA8PdU1GFgNGW7Uy44UrHa5QYnGG2xohCB/hN9rYcw
         AynHvNispHJPU+9OEYSIGT2qPgqtd1+i0jM95o4fV1zGbzHeCJrJf838PpZ06aq/NCJ7
         uZvHRGObsVhwlin+qt/mhLzlRM93V+XdzX9T7BMs6DomkR5Wfe2gwd61gVMJZbppijR8
         9Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiQJdCH+8sYhTRQ1EnF60bNt6EZIXVO1VSAMNseQ+hQ=;
        b=w/8MkI4mTUfbq9YbK6xt4B3KcROrd5OjuLNbslnLSPrkiNYIp5ig9mulXx16OiSluO
         MYRA+aDlDcycMY3ogiqGtvO9iAfLMX1lS/1tMJXSNBacr5sbfa+/XYxq4WKf7ndtEKmW
         Lm1WuvoGLbgOTAaFYxJjPADmuxkXHebXDY3RjT7YjplhmtGo43scoMgcNnR915SuZNHJ
         Wpf+32lCqJStkqwSoIKLC0PWaSLrp7vemm+zwAM1TtONGMUty4Dfb73mrsdg2gROi98U
         Fzrh4gdaGCKyLLIElHDO+dSGToOB/boKsoKMhnn5hKtd5YFDYzt3E19yOX1soEi5jC5o
         4uEw==
X-Gm-Message-State: ANoB5pkB49E8qwSL3l2M1JMrajVhD61pI5RmfEF/olr4jtrFzDfvNLDr
        sREyDNk/Veb+sDiLDPWAKsAAUg==
X-Google-Smtp-Source: AA0mqf6YbQjgJZFJYx4H9UDd2t6AizUuCaMNUc1hrdIXCyVdCjz3mfJODPsXDAwrbHwthDWoUVWnhQ==
X-Received: by 2002:a7b:cb98:0:b0:3cf:9a12:e645 with SMTP id m24-20020a7bcb98000000b003cf9a12e645mr7163985wmi.59.1669066233542;
        Mon, 21 Nov 2022 13:30:33 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v3-20020a1cf703000000b003cf774c31a0sm17947459wmh.16.2022.11.21.13.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 13:30:33 -0800 (PST)
Date:   Mon, 21 Nov 2022 23:30:31 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bough Chen <haibo.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: imxrt1050: fix IMXRT1050_CLK_LCDIF_APB
 offsets
Message-ID: <Y3vt94iDv6MHOPDB@linaro.org>
References: <Y3vRjItCVhvCRLv4@linaro.org>
 <7C149D5F-FE43-466E-A02F-2AAF5B31B844@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7C149D5F-FE43-466E-A02F-2AAF5B31B844@benettiengineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-21 21:30:06, Giulio Benetti wrote:
>  ....

Please, no HTML formatting. Plain text email only.

So I guess I'll just apply this version then.

Thanks,
Abel

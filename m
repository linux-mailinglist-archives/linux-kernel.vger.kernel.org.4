Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE06DC009
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 15:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDINew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 09:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDINeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 09:34:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C467230E1
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 06:34:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sb12so6806832ejc.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681047286; x=1683639286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzxzqpZbAjDJdbncApIxT8iAAAWuupx0hnMwQzqrpmE=;
        b=AI4mv/ZxGEBJ7d8tmjsSLh9ulGuHg/zrvn3wctYSoWCCDkJL+kEObIgQQEmdACi2wr
         3b/yPgEXV656X4iA4mOQekqSsCMkLgbLaftQpVgkEAu/60+a7J3z2FOPb//K5UwLVuDR
         FbF4YTl10qI/XNKNqourgpUjv8XZ1pRmH/nNK9KEWBl20sBSiuNgajn5V7AmOtzDFe35
         eZvGwX2qHpWfMikQx7fhOK1hyrc9Av4qrFPVoOiNodJPvEM3AVtTNt+G2wybyEoKJNsv
         9LPZplfbIKctepxcCoD0xoBSIt1sqSRHuUkrv40N8mfZ+0QBLZjyJ8RWS8fu9j1hrBvI
         TpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681047286; x=1683639286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzxzqpZbAjDJdbncApIxT8iAAAWuupx0hnMwQzqrpmE=;
        b=E6gUHi88+//XYELSn95zvTMmHuiQPVWFbTX8+ZvLM1RyssvHpKykwMWS7NNjchfVI9
         CH0sjQk+snSyvOVDmWwGbk8EW9FLryxRurr1rDSaVKL7XJcevA4dTuRCkdTdxq1OOoz2
         0H0i9nCoilecfo4nuQYxj7QwZ4O3nZDcrS+U8AZU2ZufhqmEd/wek0CxoLt30LHzOt/y
         2iiiO3jzZW3TEqWBXzgiZQWhU77i5Z6klHBWTHA768LytqjM6/Wru4p+pErlkfkkSaej
         j1b6U53awd7HgdZrq8BaB9/ByeFXGAAWPl7qrW7ztvRl9xUNzbc5jS0PDktVECW6zCG0
         YYBQ==
X-Gm-Message-State: AAQBX9cuMAFTC70aaCNNkTqBVqdUZyJQ2fckRdc3VLnGKvpPiicb+ttS
        xYbBAM4APVt21yu92ACNzTv3F4ScHNoJqhWfiN4=
X-Google-Smtp-Source: AKy350ZwDQ745/TT9pPEPK8LGlYJXMbk7SZ9DMZP00fxS3KOHZ6DlJLwxkcN9zi9PHWXICkhswNCBg==
X-Received: by 2002:a17:906:24d7:b0:941:1cf6:dbea with SMTP id f23-20020a17090624d700b009411cf6dbeamr6405243ejb.55.1681047286260;
        Sun, 09 Apr 2023 06:34:46 -0700 (PDT)
Received: from linaro.org ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id k6-20020a50cb86000000b00501d73cfc86sm3811756edi.9.2023.04.09.06.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 06:34:45 -0700 (PDT)
Date:   Sun, 9 Apr 2023 16:34:44 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 2/4] dt-bindings: clock: imx8mp: Add LDB clock entry
Message-ID: <ZDK+9LNc8m/F/GuY@linaro.org>
References: <20230403094633.3366446-1-peng.fan@oss.nxp.com>
 <20230403094633.3366446-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403094633.3366446-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-03 17:46:31, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add LDB clock entry for i.MX8MP
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> 
> V3:
>  update subject prefixes
> 
>  include/dt-bindings/clock/imx8mp-clock.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
> index ede1f65a3147..3f28ce685f41 100644
> --- a/include/dt-bindings/clock/imx8mp-clock.h
> +++ b/include/dt-bindings/clock/imx8mp-clock.h
> @@ -334,8 +334,8 @@
>  #define IMX8MP_CLK_SAI6_ROOT			326
>  #define IMX8MP_CLK_SAI7_ROOT			327
>  #define IMX8MP_CLK_PDM_ROOT			328
> -
> -#define IMX8MP_CLK_END				329
> +#define IMX8MP_CLK_MEDIA_LDB_ROOT		329
> +#define IMX8MP_CLK_END				330
>  
>  #define IMX8MP_CLK_AUDIOMIX_SAI1_IPG		0
>  #define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1		1
> -- 
> 2.37.1
> 

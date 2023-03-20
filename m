Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5026C2602
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCTXrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjCTXrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:47:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA1F15C98
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:46:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x17so17039453lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679355920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yNR8X23A98sblDxbw5Poz4eMrkTW4BedLygWYr/QqY=;
        b=zhreF+PljbDmKvP/Iu8G+igR5OmJ+q+rU5tYXa5BiCuhvU2aEL0hqMDkE1X3CBtvYq
         rlQPLKAkZkvoOyAUg86pz6otZJz5A+fLwDHzGsPp0EN1g2hTEr0CxiZsbIBPIXLFqYkx
         p5t4JPKg2aLkVadeG6d5hFz+pAxd8i2q1/LXw0qlUc9oEwZwdETPzo4JL5CNSZy4exeh
         BfO6Dwx8A1EhpO1q5OrU+lJK1EMc4iCXNaJbfQKqMxzE89PBrzPpgzrsP01BQoSrmwhX
         ANIU33RxUUEZa1DLvHUgf0Z4WQzagFOZzgzzicvpUYefiWMpiTzbnCwwQGs8mXHzYfyJ
         JGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yNR8X23A98sblDxbw5Poz4eMrkTW4BedLygWYr/QqY=;
        b=WYT9aKZo5WNhy49k8rd7eDX/oN7RNeGAww1XK6W6EDiR6Uc0UQX8YT08wamLDpG+vV
         6SurK8GXZbFhLaVmQLXiIcX9WqsfvN4nDHhlU9HkoYiykeIkV7Bn4D8h4Qv9sHyb9x24
         Cj32zWu8HHKB9klELqYLtxF9WGrKKKFbdtdd3pyLTPKwlcTQrKb8nj/xNF9FvUIGQzrF
         6aVPgFq9c8Lls/P7nkHxhAMZsGEE5bMeKLKx3NhEL8IeC6t9UD8v1nYIgUHLYNbzpP+4
         UWcjOXZK8RYlwyOv3DVcY8R8TKO74geRoZoa/Yx15+GsrqHabZUabQa2WpKWjRoRgq6C
         8row==
X-Gm-Message-State: AO0yUKWKERNaZ2fbd+uH5RL7RFcLjF50ONYSDU0SoeqX2SftJxeMcMuO
        QAw2um72VrwYYCCyRka7X3gczw==
X-Google-Smtp-Source: AK7set8MGVhASxzEwrHlVBfW2UlJo/rZ2P+TFZs8vUWIrx9O7hrMJAGVckUytY/qAEStsErgqHNslw==
X-Received: by 2002:ac2:4310:0:b0:4dd:af76:d3c with SMTP id l16-20020ac24310000000b004ddaf760d3cmr170842lfh.48.1679355920301;
        Mon, 20 Mar 2023 16:45:20 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s9-20020a2e98c9000000b00293534d9757sm1982264ljj.81.2023.03.20.16.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 16:45:19 -0700 (PDT)
Message-ID: <2e352a73-181e-7539-7932-f753b29ee967@linaro.org>
Date:   Tue, 21 Mar 2023 01:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] dt-bindings: display: Drop unneeded quotes
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20230320233823.2919475-1-robh@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230320233823.2919475-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 01:38, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>   - Also drop quotes on URLs
> ---
>   .../bindings/auxdisplay/holtek,ht16k33.yaml   |  2 +-
>   .../display/amlogic,meson-dw-hdmi.yaml        |  4 ++--
>   .../bindings/display/amlogic,meson-vpu.yaml   |  4 ++--
>   .../display/bridge/analogix,anx7625.yaml      |  4 ++--
>   .../display/bridge/cdns,mhdp8546.yaml         |  4 ++--
>   .../bindings/display/bridge/nxp,ptn3460.yaml  |  2 +-
>   .../display/bridge/toshiba,tc358767.yaml      |  2 +-
>   .../bindings/display/dp-aux-bus.yaml          |  2 +-
>   .../bindings/display/imx/nxp,imx8mq-dcss.yaml |  4 ++--
>   .../display/mediatek/mediatek,hdmi.yaml       |  2 +-
>   .../display/msm/dsi-controller-main.yaml      |  8 +++----
>   .../bindings/display/msm/dsi-phy-10nm.yaml    |  2 +-
>   .../devicetree/bindings/display/msm/gmu.yaml  |  4 ++--
>   .../devicetree/bindings/display/msm/gpu.yaml  |  4 ++--
>   .../devicetree/bindings/display/msm/mdp4.yaml |  4 ++--

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #display/msm

>   .../display/panel/ronbo,rb070d30.yaml         |  2 +-
>   .../bindings/display/renesas,du.yaml          |  4 ++--
>   .../display/tegra/nvidia,tegra114-mipi.yaml   |  2 +-
>   .../display/tegra/nvidia,tegra124-sor.yaml    | 12 +++++-----
>   .../display/tegra/nvidia,tegra186-dc.yaml     |  4 ++--
>   .../tegra/nvidia,tegra186-dsi-padctl.yaml     |  2 +-
>   .../display/tegra/nvidia,tegra20-dsi.yaml     | 12 +++++-----
>   .../display/tegra/nvidia,tegra20-hdmi.yaml    |  6 ++---
>   .../bindings/display/ti/ti,am65x-dss.yaml     |  6 ++---
>   .../bindings/display/ti/ti,j721e-dss.yaml     |  4 ++--
>   .../bindings/display/ti/ti,k2g-dss.yaml       |  4 ++--
>   .../display/xylon,logicvc-display.yaml        | 22 +++++++++----------
>   27 files changed, 66 insertions(+), 66 deletions(-)


-- 
With best wishes
Dmitry


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253336C00DB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjCSLhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCSLhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:37:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BBC2364D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:37:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y4so36696260edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679225838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3GQ0kuX+CANTyKsciGzMU4Vb8Jeilt6T7QwH/C5HtcI=;
        b=D00+NhyYkKydBEbINUkLHKWGHGCpBkp/v2jQXmxjRv/PR6O1KzPoAfGXvqXlBDooLw
         MDFhqQJBmoM8e0aMQlOPM1snaeCnDase6u1YX06J1yJn3jOcq8kY8pSv+Z2tHI0Bn8jG
         PSI+eRufB8QEQUlU2Gki2Ya73RQoA/20yzg9Y+Ja5tNE+hG5GZR+HoF45JfcXg9JoB/k
         j+ltjUtUS2dErsGsR3X6YwIbE2VvJibb1xva5SsX7lU6AfNraU+Q58J6z5Br7IEJDilp
         eLRbTXyYU5E/EXS566kszMZH8tnrZ/mtdK2Ys1e7HjnnwoGz/phODt2Ql//XUs2joiqt
         W7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679225838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GQ0kuX+CANTyKsciGzMU4Vb8Jeilt6T7QwH/C5HtcI=;
        b=WEvtnJsedugakbnp0vYYNqHjs6xAyV75jTyfDWpMwlxHPyAANjIGgAsnLSMVHg35U5
         871wBaLAuDc+2jAU5Bx8jdZRz7dKqmKwSeAJTSVyYq+UF31F1s49sLSmYoAGh3BpU+qo
         f8imWb0i459iUljCMLxBjailaXVZzASFgXthoYFGboJmimLefphANOFxG4rFP0DCxexO
         4QoYvp0rKt64H5JSXGp0YXlQU1BsRaXnpomrDmBxqfT3it06uoZcgiGzi+VbdfLoSUFY
         MvrG6PNiL2oq+ewMRdk7VFwtf62db8MeZnDTlh1/HJskb5ILHPhPs3vLJ2xYXqx2k2ON
         Z91w==
X-Gm-Message-State: AO0yUKUisoF0LWSxz4k4ws5uaq9RiSkC4idAPcyjfg7bpSSFneZN5L9x
        BUYKiMZcJQeHd4l4kC6OHOUyaw==
X-Google-Smtp-Source: AK7set+v8lgMBbotLK7i5EuslBypcEkfi/Fu+fPXJdbgw87inJZ/klcBJwVzuNGiRec4HuUe5I8AaA==
X-Received: by 2002:a17:907:2bd2:b0:92f:bef6:7843 with SMTP id gv18-20020a1709072bd200b0092fbef67843mr5238447ejc.22.1679225838160;
        Sun, 19 Mar 2023 04:37:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm3178595ejk.114.2023.03.19.04.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 04:37:17 -0700 (PDT)
Message-ID: <de919fd2-898b-f8a2-cc13-c66995e787c3@linaro.org>
Date:   Sun, 19 Mar 2023 12:37:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: nvmem: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org
References: <20230317233640.3968821-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317233640.3968821-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2023 00:36, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


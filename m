Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6B56D4EE9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjDCR0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjDCR0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:26:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E5F113;
        Mon,  3 Apr 2023 10:26:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eh3so120265495edb.11;
        Mon, 03 Apr 2023 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680542798; x=1683134798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+hD9dA0ZbFxuYniLgq410rnyqNfqnu1PjrS/o7Wfzo=;
        b=butJWZEuLrgW6EYVdXQX7er0f2ttpqKwL1T+MagEvKSjYh1ZWri67cTm2AimwJ0oeT
         0yAEcubHelx0+crMbFwYZEwev/9QgTzweiRuTsOnsFmJlQF7l0s8NtvKYdEgC7YASkBi
         wJDNANefgtUl/pYwm5EuCsuEdRMWLlNrYRanIGPkhB+hzk41OlX+qhC+/PYOVd8IU120
         +x8hdO2z9wX9faXLzBpCf0om18/IMGWUMsVONzVPs//VQjyqUm2/2f4hjfEqwcv8/N2s
         kc/4XU4k7ldj05CY+zPwi6DkQE4muIHxqLyLgF/UeN1E3iwAPh4FSEGos0H4d2fl4Srt
         c1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680542798; x=1683134798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+hD9dA0ZbFxuYniLgq410rnyqNfqnu1PjrS/o7Wfzo=;
        b=Wqh7HyyKNE5VsZfB1P/wqHNT90CoQJFCr9JYxHNQXvxrVLGz0dbY8t2RfO6+LnLGx9
         hWR4g19471ozzAri9t0Ob0nXvAiigFuEPGvDaA4KPIL1XXotMJiqFcavOc3oFg4kBP9R
         dm+upZyx27yEY4ePCFO9mZwX5grVqnU7WsUlkzSDwhxkGdKFoX2bQtDizu8X8+nmtlnB
         1SJYJUTgdYCWLfucwEqvGxXfow0erb6LaprgQdo652J/VZ/5u3xBUOc8RJ5QHfj/0biR
         JSe2liNtc/6XHJ4oo8dG0tubBxYt1wr2dGzjyWaGl3UCC9D7iYZmrhEqOX/MUQunHlET
         H+Gg==
X-Gm-Message-State: AAQBX9dcIsJBjrvG5b77XA9gHQuWTbxh2f9RUkDqT+QM4gHrXd5w6FYr
        tNOxp5MDv1xKDwE8q1PWQwc=
X-Google-Smtp-Source: AKy350Ytu2/uzMZQ1usmBm61eO1m+4WPscUOFQRGsCNu1cdSg0v/ydxcUnWenLETPMfW9cawQZYtSg==
X-Received: by 2002:a17:906:3148:b0:930:fa8e:9597 with SMTP id e8-20020a170906314800b00930fa8e9597mr36258140eje.42.1680542797873;
        Mon, 03 Apr 2023 10:26:37 -0700 (PDT)
Received: from [192.168.1.45] (hst-221-41.medicom.bg. [84.238.221.41])
        by smtp.gmail.com with ESMTPSA id bu7-20020a170906a14700b0093348be32cfsm4874651ejb.90.2023.04.03.10.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 10:26:37 -0700 (PDT)
Message-ID: <36febd82-85b2-aa4d-c7e0-6343b119e0cc@gmail.com>
Date:   Mon, 3 Apr 2023 20:26:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: dt-bindings: Drop unneeded quotes
To:     Sakari Ailus <sakari.ailus@iki.fi>, Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Joe Tessler <jrt@google.com>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Benoit Parrot <bparrot@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230320233944.2920964-1-robh@kernel.org>
 <ZCaoVwRuxVOTZdI4@valkosipuli.retiisi.eu>
Content-Language: en-US, bg-BG
From:   Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
In-Reply-To: <ZCaoVwRuxVOTZdI4@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hei Sakari,

On 31.03.23 г. 12:31 ч., Sakari Ailus wrote:
> Hi Rob,
> 
> On Mon, Mar 20, 2023 at 06:39:42PM -0500, Rob Herring wrote:
>> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
>> checking for this can be enabled in yamllint.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
> 
> This patch contains changes to Qualcomm bindings that have been already
> made by other patches by Krzysztof. I think these took some time to get
> merged to the media tree.
> 
> I've dropped those, the result is here:
> 
> <URL:https://git.linuxtv.org/sailus/media_tree.git/commit/?id=d75cae0884e80bba486f85e82b33a1dae3c9c976>
> 

Do you think it will fix this pull request failure?

https://lore.kernel.org/all/20230329214310.2503484-1-jenkins@linuxtv.org/

-- 
regards,
Stan

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C296573E189
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjFZOEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjFZOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:04:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1435E10EF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:04:34 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69f71a7easo17666841fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687788272; x=1690380272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wyIEHWHQ/LcvFyprRxFC+Na0w05IbCRKTBTbUS5cgdA=;
        b=WrUvnmCzy00urIpPmpCzBuKn8wT0tNNC0Wvh8x2Hzr/jbBkLeZGDoUteOMHOBFsEEY
         WoPRB0G/A6/yyXEiFRPlmcWraG49HRyjcV8/EBzHdiTYK56VLk7u1kEfLdxvH8qDXJSh
         I8dbmVCYnd94fxo/J65iv6vyR2bH/EYT8qSC0DRPY4D5jLf6QLfkW59Cb7by6aaSuZxm
         NhzdyHUz0tKyGRIwNit5zGQG6ZpIiQJ8jyTCnRzP1tFP5MVQzSoegV74zffZPfyQ24y1
         nP5pt7iHRUmuMqk2td+hy+rZLyhFJ08iiX5HZ7WorozJbCVkmk0hcbbBY9t4rfbnYsVD
         Fxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687788272; x=1690380272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyIEHWHQ/LcvFyprRxFC+Na0w05IbCRKTBTbUS5cgdA=;
        b=ce2725ezaVTV38jv7A1gvqyTUth7OrSbTIl28suFErlTyPkkDkTGKxOMa3zJtI7Dtn
         uHo1u2Yrs3EtXouDFuLZ8sn1MwtHJFvqWU8xXjZxkR1BPY313sV1Ul32yzwGC2Wm6TPW
         cd9GJUl5DJBmPag8nKpZjRQD7zKj2biZjt9xsb3N8oTcwZM9m7gHGhQDlhSqkfY2SeGr
         9E/FdEi042OAsy99GYZGDIaNTr4mEtcBmTgqFmQhcWUzcdbss7XWZlpEdz9/QyPnW6+v
         UyAZQ0Knii5H2wu4sQ9XqO54jMSMFqs1+yaCVLsIuRUOFMewdBGV8yaXFfTYMQqP1X+l
         9XbQ==
X-Gm-Message-State: AC+VfDzK5Z8TH4zsKRZXvy5hYuKaRebpl1V6yijEOaei02/ExvLyV14e
        Bt8HDStoYyAGZ10f+0MgvOFlmQ==
X-Google-Smtp-Source: ACHHUZ4cCys5jLmsTbxwl6vC2/4BuewVlsgk63nHZjzLyOKbLNIGAd+7i6deIkRRAZW5T+VP+CDn+Q==
X-Received: by 2002:a2e:8855:0:b0:2b5:fef9:6ad6 with SMTP id z21-20020a2e8855000000b002b5fef96ad6mr3241115ljj.25.1687788272229;
        Mon, 26 Jun 2023 07:04:32 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a10-20020a2e88ca000000b002b6a4f35a0csm297726ljk.35.2023.06.26.07.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 07:04:30 -0700 (PDT)
Message-ID: <631728c5-9e4f-fa5d-e954-d4ba35f6fd19@linaro.org>
Date:   Mon, 26 Jun 2023 17:04:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/15] dt-bindings: display/msm: sc7180-dpu: Describe
 SM6125
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-6-1d5a638cebf2@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230624-sm6125-dpu-v1-6-1d5a638cebf2@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2023 03:41, Marijn Suijten wrote:
> SM6125 is identical to SM6375 except that while downstream also defines
> a throttle clock, its presence results in timeouts whereas SM6375
> requires it to not observe any timeouts.

I see that the vendor DTS still references this clock.

Abhinav, Tanya, do possibly know what can be wrong here?

> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> index 630b11480496..6d2ba9a1cca1 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> @@ -15,6 +15,7 @@ properties:
>     compatible:
>       enum:
>         - qcom,sc7180-dpu
> +      - qcom,sm6125-dpu
>         - qcom,sm6350-dpu
>         - qcom,sm6375-dpu
>   
> 

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58F465B4A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbjABQGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjABQGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:06:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1428824D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:06:21 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f34so42067606lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+EMDzXKErZf+vN6mQ6zrYx42SBQGjtY/gt+5BMs6Xo=;
        b=NByzatRvqGeMsX9gRB0PWiiFGd2j4qzqNkin5/k5I6Uqpzb5up4rRBkrmCAp9y9ApF
         VgCfP4MF+im8kHjYmARUbu7QWAa3IlDHzfSOggE2q6EmWyOlJ4jWvuXx5SyATdBCMHsW
         6TSo6iKP3fygGJ4u9KZbzbkXiHENbgS6i0g/TSF5KM8ccf6Zw+EbUxF9QbTAeCVtQtl1
         Cs8C+suxQ61kf3f+KBbgUb2AEJEAZUPOBBgEGpGnsKBPETnnoAJFoEBoCeZaEuHA/xl1
         4zmqp/W1ip3YVdhfKj/veOaVV4/3GzP95s1jRND2p0vsiBn5qjqHRqmBAoHYXvdEJ0tj
         yDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+EMDzXKErZf+vN6mQ6zrYx42SBQGjtY/gt+5BMs6Xo=;
        b=nxOQjKNMaY8y1fQVEpYDDdRRvBczIdrFzC41oOZRkGL6DpzUFj0omrgWrbeaomKjtA
         Lr8MngUJvp4ws321ZzIsTF66H0tU8Lh0hV1m3SUYbLSzPyolUzop3SB0mEQKlFpdhGlq
         vvCRFrsZqZMRBgjc77tBXNk4ix8U4A6WVJ5yYJ8H3FFiFuTxNhNVHtn0xJzIAtlDSJaC
         q2CP8NIdcRr7umvX2qONyifisH5kztMVjpFY0dTqjb2J/RCWyu+IfgFGTIUEeVRRZo4A
         Zw+F9qAceibtz73CQTTFvSrftuOA7Y9htmIQbNRolWfK26RChts5gOCZDlKw6ic91LQF
         IboQ==
X-Gm-Message-State: AFqh2kr1YDTQMx44+vWJy1bbs4JOthiGJy7T8Gm9GJ4gH9gcpuziMpUj
        LbfXf6gREm1/6/EeSZfKV09hOQ==
X-Google-Smtp-Source: AMrXdXsI7m71wDiaaYCddxW/n9A0hM58yHs5YFdq547y5RSna47BOWVWEbwrzQagmNWSI52hIzY0sQ==
X-Received: by 2002:a05:6512:2c8a:b0:4b6:fdc3:a65f with SMTP id dw10-20020a0565122c8a00b004b6fdc3a65fmr15349997lfb.11.1672675579318;
        Mon, 02 Jan 2023 08:06:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b17-20020ac25e91000000b004cb061887b5sm3342325lfq.126.2023.01.02.08.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:06:18 -0800 (PST)
Message-ID: <7b769e39-aa80-1de0-78e7-c0224e3513f5@linaro.org>
Date:   Mon, 2 Jan 2023 17:06:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/4] dt-bindings: clock: qcom,sc7280-lpasscc: Add
 resets for audioreach
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
References: <1672407799-13768-1-git-send-email-quic_srivasam@quicinc.com>
 <1672407799-13768-3-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1672407799-13768-3-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2022 14:43, Srinivasa Rao Mandadapu wrote:
> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
> for audioreach based SC7280 platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  .../devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml         | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
> index 9c72b8e..40fc6ab 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
> @@ -31,13 +31,18 @@ properties:
>    '#clock-cells':
>      const: 1
>  
> +  '#reset-cells':
> +    const: 1
> +
>    reg:
>      items:
>        - description: LPASS top-cc register
> +      - description: LPASS reset-cgcr register

It's now even a bigger mess. First ABI break, then bring it back to
previous stage - so two IO addresses - but with different values! There
is no way this works with other systems or DTS users.

>  
>    reg-names:
>      items:
>        - const: top_cc
> +      - const: reset_cgcr


The 'reg-names' is only a helper, order and contents of 'reg' is fixed.

Best regards,
Krzysztof


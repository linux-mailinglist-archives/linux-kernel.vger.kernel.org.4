Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65C76E966B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDTN5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjDTN5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:57:17 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA62680
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:57:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h2so2817624ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681999034; x=1684591034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TP4lhXyKE5KTAkDMfdfy/BJbT2e3OFVGbEmy4BDp5gk=;
        b=rC9/9IWUTmoWs2lMq4duP5f2Q5wO1ZSMqOxyQXiWG7Odjz8ix31G2JT83QqwLLjbXK
         8atUiWASwss3zkgbMYud0bUjTN6ic89Gn0oM6AsaPra73UmyDa878XmQkO9/kZt8p7ZO
         7FPsoO8u3JdgF+ibY5MToJGd/Xw6ovJOow8Ayxco4sdpGsg1iwqKCFJLnwL8Ntc6XyWj
         //hFspMHTwZWQUloofdjCBtyYad4x0XFlxS5xRAZb9m9513VBYMLbdBd8KW0cIL1oDCN
         GOkOPQzm9FobHEfRfe3C3XxuwK2yvjLbsCwsl9SouLhEuZZtlZ3JZCuCz28SM7OPESdb
         2Y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681999034; x=1684591034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TP4lhXyKE5KTAkDMfdfy/BJbT2e3OFVGbEmy4BDp5gk=;
        b=D9r3ltHAkWo4sovNvXhtysBCrndTubJNAA3rPYyUm7KA3AcX35E0HRwGMB3fEYeDXm
         lxTfEwvlNjqpC1CiJrDmZQiNixGvdipmKeHYPyi/diMUf1weLYiAsNcaDpfles4jA2Rm
         HXZDbAQk2H2qr1lomE9NcC44vv3E30zRfh3sMjKKcMzaSvwJNbJ1IgJVZ7yUphZdTYl0
         iKT3Qz2OnIhvY3sRs5mvzMqwF544TLjNcq0LV/aUBK91dpJNkypgKF3CZvdVhnsFlM/T
         0j7BbfB3rI9UJoZmA4T+JWqWj/FYlpCz04/RQYsl8WiqlEIviCxsol09UxjN/NFoNBp2
         gk9Q==
X-Gm-Message-State: AAQBX9exxVmSnsTpYNP9BQWnepB4Wln5nE609/xZ2ivkylTgh8zefc+B
        Z6rkNDcrgaRmbJX8gp3NlOBY5g==
X-Google-Smtp-Source: AKy350bbrInQ8vcLAPDSHDfaUIBSaDalxHrdj5/uZoDKMnjxN0/nbHGpvT3D1EyWxc5tincgNn5nyg==
X-Received: by 2002:a2e:9d83:0:b0:2a8:bd47:caf7 with SMTP id c3-20020a2e9d83000000b002a8bd47caf7mr448315ljj.7.1681999034024;
        Thu, 20 Apr 2023 06:57:14 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x23-20020a2e7c17000000b002a5f554d263sm250062ljc.46.2023.04.20.06.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 06:57:13 -0700 (PDT)
Message-ID: <6d109e03-0a1a-fa3c-b1d4-7b64367fcc41@linaro.org>
Date:   Thu, 20 Apr 2023 16:57:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: display/msm: dsi-controller-main: Document
 qcom,master-dsi and qcom,sync-dual-dsi
Content-Language: en-GB
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230411143149.16742-1-lujianhua000@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411143149.16742-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 17:31, Jianhua Lu wrote:
> This fixes warning:
>    sm8250-xiaomi-elish-csot.dtb: dsi@ae94000: Unevaluated properties are not allowed ('qcom,master-dsi', 'qcom,sync-dual-dsi' were unexpected)
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>   .../bindings/display/msm/dsi-controller-main.yaml    | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


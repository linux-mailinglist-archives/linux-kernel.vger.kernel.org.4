Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2DF6C0153
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCSMFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCSME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:04:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC0E21A10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:04:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z21so36811308edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679227459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOFwXh6vZtC92bZGzjuIGNdPIVs7BRd69S29zualIkE=;
        b=uQR2XjGwTRSf/EIB5hGDYjQ35bm6+7HhgxNyyqkP7XjNB1b7/6oNrL2JXG5Z6uwNQf
         JJg+lgcEeM7gssCYgRebL6JhM8jOqa2PG4xGEsmI9JKaVk9QoJcdUr0CwKkU14wuazqO
         3ljFSsd6x0Sd/fL1iF+UMP9f4WneJdcJ/bDsJhWMMF/4dgkeIQgK6bMt4f4K2wxHAL7c
         htx1U3jtumILAa3qumfjgj9idqJrgrGzDhfs+yuNATEkUHkrUCCjJ1TARLO2KQ15aB++
         ZwV77V47EMVNQjcwhm1o5mTRTLpS8dmTR+FAcLLkncUJ9dw+Qp+DupT4MOgpLe/XTDGA
         nsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679227459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOFwXh6vZtC92bZGzjuIGNdPIVs7BRd69S29zualIkE=;
        b=YAJEt7pPi5DGR+h/d3uZgmIunqHT4fYpkybajI3SQ6drwAuktj7UO6HyL8ousOBS9j
         F6rkG/vAgEyP1Y2/FRbq3Q7p7UxiC4NGEAM6fVFHPY0e6dMan5v7ooOakKG04UmKO4t9
         iMbhNWZh9BBFOCnlF0AZht/ddZEoJDn4pQ6IMPZ9CXQQji7V+jbZOq2Naz6AH53CmNPu
         1aFEWA2A6TzLPnAaEQzgwP/Jwms6MjYFH/m1Y8X45cxADNuiSpyJVS7JQbJ5M0qQRuU/
         OWjeH48EAfZfzN911uYbngl43vSinHKmelm99y8tOGlWtivV29uiF1wX22Kzg8X+exUe
         on/w==
X-Gm-Message-State: AO0yUKVOF6l+SgxinYuR0Dygnu0QNtFQB7I8USg5+lMkHVlzKZjEaFU7
        65apuaxml/FI+5HLWReCHc+y6Q==
X-Google-Smtp-Source: AK7set9R/qYFVz69W0HqGLExknysHlO0roi/6WDV5hwj4pN19t6DqymA6BFC7JqA67tkpA97BsxpKw==
X-Received: by 2002:a05:6402:50d:b0:501:c0e9:4df6 with SMTP id m13-20020a056402050d00b00501c0e94df6mr872973edv.40.1679227459328;
        Sun, 19 Mar 2023 05:04:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090681c900b008cf377e8795sm3176188ejx.199.2023.03.19.05.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:04:19 -0700 (PDT)
Message-ID: <9825ee6d-58b1-4e5f-16ea-2cb00822f147@linaro.org>
Date:   Sun, 19 Mar 2023 13:04:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 8/9] dt-bindings: display/msm: dsi-controller-main: Add
 SM6115
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230307-topic-dsi_qcm-v6-0-70e13b1214fa@linaro.org>
 <20230307-topic-dsi_qcm-v6-8-70e13b1214fa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v6-8-70e13b1214fa@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 18/03/2023 14:42, Konrad Dybcio wrote:
> Add a compatible for the DSI on SM6115.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


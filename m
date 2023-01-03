Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7065BCC1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbjACJFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbjACJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:05:11 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58F3E022
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:05:01 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q2so31191270ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+Erek443SNLGLXt2YItthxdhxEysdsz0l7unNJI80A=;
        b=GtvyzmlJbXtddi2nzqGDEaYXoqJ4oEOSxEUdfcmuHeeefN7uPD3aYc/bKZfzaXssVQ
         aElYV2JgC5kU/xNqzTqMtCTnnGs8r2KN785ZeYXepk1PDo8geuhkoTIyocwc+hQESTpT
         O+A+H2BIxPps1at46UmaW1VR2I94Gw0JHgyqoKP3yVV6/gvk+iiAa5hya0Gn2RGRgQAq
         u3YN3Yty8CdRfKbxunake2JXMqC9vawQpf7YYOCxGNn/s10Q9N9Sy188A0I6kqX8nVAg
         5ohfJ/XTU1mcvGt3xS5FeFTpPgubNEoVrZsrkX3zPVWWB8KuJJeHgg2FP9gCZx7LLAz7
         NMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+Erek443SNLGLXt2YItthxdhxEysdsz0l7unNJI80A=;
        b=xnipedibsKYfryoc1CD/GsK/6x+Rx5skEti7grvw/OehX794igYBSAO9Fcg35XpIbq
         4j2Hhj9aM+J8mkqv8J4hYTqWmbN1RqptEVxNR+MC/iPLjNNATAvv3lsSRbUjzpL//mhF
         LmbmmMZXPnk45p26f2gqSC9QuLbxASNvPyxppYtrO7PNdIYRhMxM+mMFPBLvz+fEVU+e
         moeOt6a2qIaVmQm0kLxIfrUNhZxJn6Vo0MmToaTgHgxQzLhAIazR8PPke7tAY88J2GIm
         JOjCVZ1S3ApKF2aiEqXfna5a/RslorWkD/WfC3gxYAK2oi09LpjsGRSjURuCoPRnEslY
         Q9sg==
X-Gm-Message-State: AFqh2kpne7Ku1lWx4s0wXU40FKsq6C9d2QGrBV3KYhBKfsijfjlYXAXh
        LTBfty/O9473wxXbbBFiX5WhWQ==
X-Google-Smtp-Source: AMrXdXtOPN7rICaM2s/brO1fEbcqmDhb86o/SXWbh1vj4PciIi9r2ePPPQiVCeku/+dyqoaBC0N1LQ==
X-Received: by 2002:a2e:980c:0:b0:27f:eb53:4834 with SMTP id a12-20020a2e980c000000b0027feb534834mr2242535ljj.26.1672736700165;
        Tue, 03 Jan 2023 01:05:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r12-20020a2eb88c000000b0027fb77e63bfsm2833578ljp.17.2023.01.03.01.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:04:59 -0800 (PST)
Message-ID: <36c330c0-8e6a-3360-5379-5453ce248c34@linaro.org>
Date:   Tue, 3 Jan 2023 10:04:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/7] dt-bindings: soc: qcom: smd-rpm: Exclude MSM8936
 from glink-channels
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-4-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103010904.3201835-4-bryan.odonoghue@linaro.org>
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

On 03/01/2023 02:09, Bryan O'Donoghue wrote:
> MSM8936/MSM8939 should like MSM8916 not require glink-channels.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


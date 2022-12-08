Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D1A646D45
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLHKmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiLHKlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:41:31 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E465862CD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:36:46 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z4so1091636ljq.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sLgD4mcq6NGXe2Z5yow35JLIwbCl1WcOMrelcw30Bb8=;
        b=CF9YKsqP/11cHBIXUz03ZsFPnhJHFngU9qimSaYyprnmJ2noIS6FX9wJH0cbjhMRrN
         HdPfraeLtfMtqtvS3ditepeMr+P5fXMBYirqPnYfW3/KW9fFckIiF1Y5oJpNohSYQaoa
         l/shLXcbQjHmCqSYrVtEE2vNQQ2P3KwFc/a1+qInmmyaSlkKbs7GHI/fZ36X/N5XPPlo
         F0kGh4lEUVJOtR7StaX6gj2wC+ueMCAHDCVs2LeQI5ibwH8EmkiQYIMLWBOG9q2n8jFV
         OfbQaPImsaoAL5Idoo3r70g81fg4BFghoTB/O6mIrc1A/aKsWlKFJN2k0t+5c3uYY/4J
         tz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLgD4mcq6NGXe2Z5yow35JLIwbCl1WcOMrelcw30Bb8=;
        b=49TwfQCNVGlbMuTWgQBhLUzBPk7Gr/WLrh3ErwUj9Cswl2J2Q/c6u2vKGBtD9XrJm6
         Ds1YRFXdpUOWtrtR2cdm12XIc0jSjuHSaxNXtskdjPx5SrOER7b0LKNJsVraX/QFXe3G
         P3en8TXpJwKTttfeikApaN2TU5szZffIJw8ZaKgCK6rL2uo05wkhXDu9vnc8UB6Ld3tP
         XDXpHIh2I3k0FIvzhfaeL29vErktwMDcaw8USUXJ1+gBpcmi82Gl2LIP4jZnzNxj4uQx
         9urYQNLkrg2D0r0R+x1T7uIbAU9Cs9JMkPOlGvXYaEiah+Yl08PmhxpExMWwvNnR2Nk/
         y3nQ==
X-Gm-Message-State: ANoB5pmFVBNswWq5cK/0SXRcWYLW1eyQ+s4m+Tq/vGqkLcI29ILkvVy6
        5SvSG1dWQ2s+KRc9b22Sn6kxmg==
X-Google-Smtp-Source: AA0mqf5ENdBwq+Xg+vLczBJHlsxjumL9lHK33PbP4IM/NElioaVr1fIvYaupW5RTfAbgj0rzifRzBA==
X-Received: by 2002:a2e:c52:0:b0:277:9bf:9411 with SMTP id o18-20020a2e0c52000000b0027709bf9411mr22163424ljd.504.1670495804952;
        Thu, 08 Dec 2022 02:36:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004b5785b1d9csm1450294lfn.302.2022.12.08.02.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:36:44 -0800 (PST)
Message-ID: <25cd4c9b-13dc-1e12-92ea-3610eb9af7a7@linaro.org>
Date:   Thu, 8 Dec 2022 11:36:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/5] dt-bindings: remoteproc: qcom: adsp: move
 memory-region and firmware-name out of pas-common
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-0-62162a1df718@linaro.org>
 <20221114-narmstrong-sm8550-upstream-remoteproc-v3-1-62162a1df718@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-1-62162a1df718@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 20:23, Neil Armstrong wrote:
> Move memory-region and firmware-name definitions out of qcom,pas-common.yaml
> since they will be redefined differently for SM8550 PAS bindings documentation.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


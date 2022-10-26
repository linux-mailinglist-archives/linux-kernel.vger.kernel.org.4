Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DB960E5B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiJZQqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiJZQqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:46:12 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D470FD77E3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:46:08 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r19so10354995qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMheSMSekbziACF9KD/QIawPn1J9B/ZRlR72lMIdU3o=;
        b=Fxlg1CvaJwqqgmRMrgdlnSe1Elacu30GnJi1VcTxfXDIGaS9b7dk6BDN8vwq/UCCQL
         vhbwa+ZvUOwQnKv6iwSmKKcvy+Sgk4IusDuZJiAFvGGiyp2odTmYwOqGEhraw+yW6ffr
         ynDkkJYjYZrMZPKg0OmX7HIVlRIaCguv/cY/LCmqvwjuI+8wtYc+OpLmRTGtXMTU8T1V
         JxiWInr8FSVRoz234r1W/GT1s2jPfN+EKoBnSOiRMpD1/6bx+cRv9YFeEO7KGF5Nny4d
         ZeFybqrRzgu4/0Cu+bEWI74AyfohMy5m/SJM5m1VMeiN3+ssP5ZPSruun+vWfkafNTkn
         6SPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMheSMSekbziACF9KD/QIawPn1J9B/ZRlR72lMIdU3o=;
        b=CN9RrtZe8vJR/6nr1rFByNDh1n8OJ34/KLb7JBXQTnxS9Omvp/8Mc8tkmvk+rFj1po
         oazgQowYAnY3jLHck4F2KzfHCVwl6xsA6Z0X3btUUYU8ldt+1NwEDerOQBY9F90mBp5C
         XXJUjI/xQg5dDZrGFLzj9fpg26A0luj2wsGf9NZmQbhMALfXll3MDAfJRy+9dOmlxrwl
         C+SLZPWpsYk4+IeyxhyyMBxrGoJ8Y96XPjLGB+Q3Egd0I1KEPy1Oo9Wmq+haditW4+6R
         XYy7uoZjerox85oPsDA7alrsYImZKAn/z0adsquQtWtZTwdyrkZzQkUG5ipN/gmsVG2o
         2t0g==
X-Gm-Message-State: ACrzQf2ZkqFXZfGqE9eZhwervcAQ5TJ6VDiIy+Uyepu05ZT9X9S/XeUe
        RdVi7StSzNtjOxgIrY/h95ZR0Q==
X-Google-Smtp-Source: AMsMyM5Cwyc5F4+bGg7LrcAxX29LSjL4SMZBz/L+9GWcZ2aqfepUK2sSXlSGUYUEzi5Q8JFWDE1EHg==
X-Received: by 2002:ac8:5712:0:b0:39c:cd48:25e4 with SMTP id 18-20020ac85712000000b0039ccd4825e4mr38044105qtw.581.1666802768083;
        Wed, 26 Oct 2022 09:46:08 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id m8-20020a05620a290800b006ce40fbb8f6sm4285888qkp.21.2022.10.26.09.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 09:46:07 -0700 (PDT)
Message-ID: <89071dbf-9a3e-a199-5599-571ee8dffcc1@linaro.org>
Date:   Wed, 26 Oct 2022 12:46:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] dt-bindings: arm: qcom: document Google Cheza
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20220918095430.18068-1-krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220918095430.18068-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2022 05:54, Krzysztof Kozlowski wrote:
> Document Google Cheza board compatibles recently added.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

This one waits for a month. It has Rob's ack so I am not sure why.

Best regards,
Krzysztof


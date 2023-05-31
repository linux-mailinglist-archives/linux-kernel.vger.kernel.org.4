Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6BF7179DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbjEaIUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjEaIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:20:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AF1132
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:19:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-970028cfb6cso1018574666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685521198; x=1688113198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBN0g76VOltgE12hoKSlbM5cE+C/tz361Ho2oM4xT1k=;
        b=g9+iytOncWpiwVCrSueeXORbVvIrgeLqC8W7bopZKhgoee2JInalZXsrsHXVt+2qHh
         Vxbp8WsObkslM4GXm0Nb5mrIfEozlHAP2Ur86lZJdbhXmk+LNX2NIi//Gm0VIXjkJO9r
         Kb00847l7+wPfJdaA9pDSZMWHq55giNMY00OuBOtslF1AE8npCl8BlA6gPuHAEh8mw4i
         fCiTDxOH2/EdbUsLDMYwacWuow2yjMkGh8ppIt2bevUKwAgqodvB+AQf4qrYsZ4prPPY
         WVSrnhidxa77hGNF7lye1jDEK/YIRIJzv0cvdbISHUPzT74ysDPvuoQb5fkwYJ+T9eyh
         ifhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685521198; x=1688113198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBN0g76VOltgE12hoKSlbM5cE+C/tz361Ho2oM4xT1k=;
        b=TqY+JSBPBlkQhHdhMBaQFu1aBw/D+h0zpxukjWkUJGNJWjGs6cF3vyeD1LNcRLAPWc
         6LYe78o5RY/tkUdKdD5LlgMo6mHrLuPQmue168Dr3Gecre//HTQC+wHvH/5hASX6cjhz
         pXW0Qf4JZEA+3ibGa+ETc6t5E/KNahse5nSEZv16gugd5+IpL0sbBSk3N2WMcjVhiWgj
         ERy/NX46srnGsu4A0yXZmg7FiGciWofqy+0WNf6T7mvMZAGIcS79z69+Sll5y2WeTkPz
         lS9nWLg3j1dusF9lxSWRu+YNUGKpbVrXtLii/lh/xXir+kMWfsKOBRHqcFvOu7DsjwUr
         7sFA==
X-Gm-Message-State: AC+VfDxoImeItEJZEM9OmbSK8VsTY45ohIWzeKq6tf5SKrwTsa49uk4e
        wqJ/Qg+zYr8phM7zAxDxxOh7lohCP8eUWR7Xcm06lw==
X-Google-Smtp-Source: ACHHUZ7oOwas3dKHOemqzT//fxqA0reaOD85uBKVDYOiPQqAZk9DZDZD+L+H8C1T2VuPa75ij0fBNg==
X-Received: by 2002:a17:907:9413:b0:973:bcf6:1d4 with SMTP id dk19-20020a170907941300b00973bcf601d4mr4566154ejc.76.1685521198147;
        Wed, 31 May 2023 01:19:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id la11-20020a170906ad8b00b00965f5d778e3sm8591093ejb.120.2023.05.31.01.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:19:57 -0700 (PDT)
Message-ID: <785fb453-7000-39c7-b4c3-709b76d7f5e4@linaro.org>
Date:   Wed, 31 May 2023 10:19:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 02/15] dt-bindings: usb: qcom,dwc3: Add SC8180x binding
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-3-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530162454.51708-3-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 18:24, Vinod Koul wrote:
> Document the USB dwc3 controller for SC8180x SoC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


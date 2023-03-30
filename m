Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E866CFDF6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjC3IQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjC3IQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:16:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB3176A6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:16:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k37so23537505lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680164183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KaDyW6z6XuYhRtr0QA2BxgBT9mFk6zOPgn6BDQB/clc=;
        b=tceJLeFJ1+iCkdm97eVxZvU9flLgSis4gO3XGnszaE4I82F7leGqF306RA7Pu3W4pL
         +BmVBDBfMpSUvfoPlbQv+F+WsJJrJnXnrzPa+dQ30P0KsvfGFClkHH71INxqIDStBRJa
         Se6qWPZxa0tvkqYR6VVXHUGHv8YkqXD0NIjXcuXA6pLdHlH4AvflPxGiSreK5p9pr300
         CpoRvx1iYHTLk4x83BV6pIR/N7XRwqNncxWsHDktw5zhBReNI2PQdEWJLBjIVxvtHBzE
         7WpGBtuA6q5zeGpErkGy4eHHvLqGACFnDwrHRdMaWebPoTfyB244f+KKxPD1NrFQ01Et
         xdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680164183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaDyW6z6XuYhRtr0QA2BxgBT9mFk6zOPgn6BDQB/clc=;
        b=d/IBRgwOjdQAjzLJGkLPogrCB+GS0KtgniuZdWXA+oSC9xnwRLxsOiYOjBS067qAJG
         gyTEP4v5JJplXDB+FFcKIqAzNk+0fXEx1T4ZyVHzjc568OMvf/bCkDPUrXYAIpSO/WaT
         BzbqRqQmRoI60PRbO5UoAIRoYqYqf3L1rkeY/or5um9MjAA+6G5ZP5cldNb/gLTQ3A7Z
         egIl/mXMutCqr0AMlAAAzT3YmxcQVtdLOiI7JjvXJivnua9AdDs1WlMeZFb3H9QPpIbV
         WT7O33LHdzl4CkpNs+Ji7u29HgeeT1oYjSFlxuihHB6rY0Sz+lLrAqBLhAQWy04Ds1YQ
         fbgA==
X-Gm-Message-State: AAQBX9cRy+F7HpNRacAYtjkhhkQwKhDy9CH1ohVAOCBiIFalGZlR7mtt
        C7oFg3t5ff1Ad2dUyZCnvL2yqJ1Iloflyiy+WME=
X-Google-Smtp-Source: AKy350YHij+FTXrBHe1yofTEvB7NvFe8x3XC5Pl4Mkxm+AfAM30UwgMEBfzreMB46mYkPwd0+PHcKQ==
X-Received: by 2002:a19:ad48:0:b0:4ea:ea00:5d45 with SMTP id s8-20020a19ad48000000b004eaea005d45mr6342262lfd.44.1680164183388;
        Thu, 30 Mar 2023 01:16:23 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p16-20020a05651238d000b004e8508899basm5823667lft.86.2023.03.30.01.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 01:16:23 -0700 (PDT)
Message-ID: <05535da9-474d-eb14-44af-4621020400fb@linaro.org>
Date:   Thu, 30 Mar 2023 10:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/9] dt-bindings: qcom-qce: Add compatibles for SM6115
 and QCM2290
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
References: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
 <20230328092815.292665-5-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328092815.292665-5-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 11:28, Bhupesh Sharma wrote:
> Crypto Engine block on Qualcomm SoCs SM6115 and QCM2290
> do not require clocks strictly, so add compatibles for these
> SoCs, indicating that they are similar to the flavour
> found on SM8150.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


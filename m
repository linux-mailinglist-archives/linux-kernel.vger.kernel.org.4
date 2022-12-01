Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9E463F29A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiLAOUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiLAOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:20:36 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C266AFCE2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:20:34 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id x11so2039738ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 06:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOf24rKX5pm5JfN7qU6OwPCGNKodGVmTgnDkTUii6cg=;
        b=ekuLLc/9M8DbGi7FdJVHGMXEjCewR+jQ46WRjmvb3RDCYcAL5pKyxmd2/yqqJWB3La
         X7lCSvkrciZjMFgHJihS7yKxR53Rnwcy6J231a+1IasHT77sDi7bgbM6eN3575uDNWEG
         wmdsW6HXuyVM1UHMeP1cv++SPdNNusH21oA5g+OSIlhGjI6zSGbQHlqTeUSIUqvy8iUa
         DSYK60gSF9P8/JiJu/PHXf3b07iHHTNkh21vo+HZSjpyVBLHPY9VzpgL6yISIVTlSnpZ
         Jp5Bei9wESGHJXFEOXhDLTFarSNMnsGIJ028tGVPy3DQ0Tcu8d7qIamvQZQzgGUJh3Ez
         l4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOf24rKX5pm5JfN7qU6OwPCGNKodGVmTgnDkTUii6cg=;
        b=NQRjO2sbr//q175SFfjJE0EmxjZTRXYXQI4pow0csT7mxZayEOod+teZVC+sqb9hc4
         2FHfxWXc4hqMGCFjNE6D20nwRBfxt+CxPKbxUezRAG8VJ4jBFjSZt1jajCVu9qmEGTcu
         olprUgTzYklnU45vU7z4GHaDhCHXyuKpgPqdjFcsctSKQkhLLnz05vOdHF4FZkfbFMv8
         QgQPhFlT/NlEpGkXWPFpUA2E9cFOGvAmP+vYCw+LXceFEdKA7R0wHXu/Ujk+ZicdaEdi
         Db5+6N464WP99FXONfXUD9osaXS1MER4m4/BZlNm3xypVmxGqxrkuCbbFcx6DZEFlHUR
         pDBQ==
X-Gm-Message-State: ANoB5pl15CwGQmztOP6+619dRG0CXX3qy0GtUpamCgG4MgxkWVMDRb2F
        4iGSDLHWot77nyJPsF4cXPdcgQ==
X-Google-Smtp-Source: AA0mqf5ZicTd0xWoqUXIzzYsDF0yWphnboAeKCYvgkUAROoxbdOwhUbneK96nyH9E/04oMPY6DMw4g==
X-Received: by 2002:a2e:9193:0:b0:279:433c:989 with SMTP id f19-20020a2e9193000000b00279433c0989mr19522199ljg.111.1669904432928;
        Thu, 01 Dec 2022 06:20:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n5-20020a05651203e500b004a2386b8cf4sm659130lfq.258.2022.12.01.06.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:20:31 -0800 (PST)
Message-ID: <aa980b98-630a-352e-4d1c-fd84c8b3f95f@linaro.org>
Date:   Thu, 1 Dec 2022 15:20:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom,ids: Add SoC IDs for SM8150
 and SA8155
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        a39.skl@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221201141619.2462705-1-bhupesh.sharma@linaro.org>
 <20221201141619.2462705-2-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221201141619.2462705-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 15:16, Bhupesh Sharma wrote:
> Add SoC IDs for Qualcomm SM8150 and SA8155 SoCs.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>

All these entries come from MAINTAINERS file. No need to store them in
the git history.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


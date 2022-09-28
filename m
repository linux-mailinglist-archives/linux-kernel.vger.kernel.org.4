Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA55EE3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiI1R6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiI1R6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:58:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF703FAC74
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:58:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o2so21482371lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yN4um1smP2F+TG5gs5QZ/TQl7Asm8vT5j1tAoh5EdtE=;
        b=QAYAKuTYdWnjUNkoD3f97AFFeK+Zt5jtzGznQ25QEkUbrKqHJPPwKwzVGQE8vIX28e
         mcK0vxPVfutBcX5nzO9DEON2QN0j7w3uohHrywzBH5Bw3Rze4WrO4IrwaKxJRAzMTAaI
         m+lc8dTm0Symkc5YDGoSSXRfy8xJiTV5sqaVZjI4XTudeoXlfA8NSiNJAFhekrVafJ78
         O0PR8ZJ0bcUnPAHVrRWQi9JfEIi1VrDmR81YKWjUUjOBLAKm5IgU3D9rLLWTcpTkiz9a
         d+F5vMkaRrY3NaDz0k5rrzqt5t96DRBKGNPcwZvBSmQJJS7yFZ4IVH2Xtbl2QG2dAswa
         0/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yN4um1smP2F+TG5gs5QZ/TQl7Asm8vT5j1tAoh5EdtE=;
        b=XyZWpEt1etEv4wkXyi2BYM6GzNlaJ5FGljaqZlYAsPLn4/2HJM2A9zy3AD1adrhNFt
         dOtgbCHAMU+e3ImRZx6KFGow1XUNCV3hzZpdOtapg4muNcnSrHg2g6OYRtYOOcrWgWWo
         gSf/ZxvWFJXC1gwlPFHkGhGDJf9lvmJijI+4NoohATGR2nhOknmhHPsvHYsRj+gnqVZ8
         FFvhDxh/647hjDMaz25SndI5HNVj1Vs7m0VGCjX13WSfInttwdUb7G8wlcB3sKKU2DKR
         IPoFC3hpDKN3LHa+bSEAyGNn6RJwWD0dT4etNy46/sXkC0I1Lx3FwPluvEBRdl2jDJTJ
         KVYQ==
X-Gm-Message-State: ACrzQf0Piz8UVIysmJUnR2mOHSbPhxhLLGiQoPZY+R9N7/rEj2kSZWHU
        n+HB5+UMp9ksGXV06qDgFp8hvw==
X-Google-Smtp-Source: AMsMyM7Y1Bcl1q983mWPcLp0VWzsDMz3qyObuMrAc7qUT2H1IgABRMOmHy5o8M0QFdVyFh+1CSzC/A==
X-Received: by 2002:a19:7411:0:b0:49f:517c:9889 with SMTP id v17-20020a197411000000b0049f517c9889mr13081756lfe.283.1664387884223;
        Wed, 28 Sep 2022 10:58:04 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p18-20020a2eb992000000b0026c3fbac3d0sm502698ljp.127.2022.09.28.10.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:58:03 -0700 (PDT)
Message-ID: <c2305614-b15f-f17d-878c-6c2a0bbb2409@linaro.org>
Date:   Wed, 28 Sep 2022 19:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 4/7] arm: dts: qcom: mdm9615: remove invalid
 spi-max-frequency gsbi3_spi node
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v1-4-b6e63a7df1e8@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v1-4-b6e63a7df1e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 11:14, Neil Armstrong wrote:
> The spi-max-frequency property has nothing to do in the controller's node,
> remove it and fix the 'spi-max-frequency' was unexpected dtbs check error.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DBB6E60FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjDRMR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjDRMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:17:56 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383F01BCA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:17:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2a7ac8a2c8bso20029131fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681820273; x=1684412273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pm8kfo3XeSVwAetxgwT0FTokY6mXbT03bQ/HeaTO5sg=;
        b=BWqcSSa5M/DWIFNbg4ZO7UwMLj5VWEnGqqVHDgNleYwqCR1muKHmvjPz+dsv3fnn2p
         HgM7l3NZx/91bqWIEawAklbJXL2QVGOnYXVVVFVhqXENv1C0TdDuYJSAolh5BBlEZ0Z0
         /GMQTPZBJeD/7MkmZ333jRL+8Pci+PndkxJOw+SeDkZ7a3z6e9r4PbJgkF3D8BeYXLSw
         Jpl3cULrPqEgROuaQAndgzk7bPtuUEGIBViUYdwlLIEI8+z+IAfMETKw4lLh6wvUgswp
         D/QF24yUGT/4W28VMJMsOWCdfyShdXqgFMJ976ajfy0d2E7i7f3bASBD5qAKQ9yuNskX
         +v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681820273; x=1684412273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pm8kfo3XeSVwAetxgwT0FTokY6mXbT03bQ/HeaTO5sg=;
        b=mGrK3iMwXoOdoqhgb8FsJPIPetmdH8u+9OvPWe16sEHJt1y0uocfU2uddrkTlgy+lk
         +YPlBfFQI2QnJI6Xoq4ITZcw27BYewNzcKofJn5FUPQfPdbdGrh5DESdW1up/3fkv5TW
         elVuz6tUslpYZZ8MCKyK3W+o+cScREiiNxfPzzDhxQCSZUOEB/F3oRCbLETDjnkROX/t
         vXzx+3WTSPsdOztuLUCmqdjnAm8MRoFRgyAFRLY1MFaH4vKW2vfNtpJobW2P1Q7Xz8c+
         VLomdyrb5eMULQ18a9fVF9ZlK9MzWTNQykGAn9ag3oQQtHVofHAxrcIwyq0aJa2kMtAa
         vppQ==
X-Gm-Message-State: AAQBX9cOZX8UmNuSrKbSoPMGkm31lc3vTti8VPlR2Ap0N8SzbGxPE6kt
        hNgcO2W+M/ynvtE8Aho5x/0sdA==
X-Google-Smtp-Source: AKy350Zpv11CFVrXOJiJ6pDXhJb1NwLe8eKm9EyvXhDLS9nC5cGtz9y89V2oYVJtwOv8s5AcCLi44Q==
X-Received: by 2002:ac2:4a89:0:b0:4ed:c089:6e5a with SMTP id l9-20020ac24a89000000b004edc0896e5amr2759303lfp.23.1681820273493;
        Tue, 18 Apr 2023 05:17:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id m2-20020a195202000000b004edd4566114sm109236lfb.24.2023.04.18.05.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 05:17:53 -0700 (PDT)
Message-ID: <8c102e7c-3ec7-5ffb-9d99-cfdc183acf19@linaro.org>
Date:   Tue, 18 Apr 2023 14:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 05/17] drm/msm/dpu: Remove duplicate register defines
 from INTF
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-5-ef76c877eb97@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-5-ef76c877eb97@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.04.2023 22:21, Marijn Suijten wrote:
> The INTF_FRAME_LINE_COUNT_EN, INTF_FRAME_COUNT and INTF_LINE_COUNT
> registers are already defined higher up, in the right place when sorted
> numerically.
> 
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 84ee2efa9c66..b9dddf576c02 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -56,11 +56,6 @@
>  #define   INTF_TPG_RGB_MAPPING          0x11C
>  #define   INTF_PROG_FETCH_START         0x170
>  #define   INTF_PROG_ROT_START           0x174
> -
> -#define   INTF_FRAME_LINE_COUNT_EN      0x0A8
> -#define   INTF_FRAME_COUNT              0x0AC
> -#define   INTF_LINE_COUNT               0x0B0
> -
>  #define   INTF_MUX                      0x25C
>  #define   INTF_STATUS                   0x26C
>  
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3626061F0B1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiKGKcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiKGKb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:31:57 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E459D15FE1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:31:56 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r12so16149842lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2KjXpbYDjWuB8Bvq0F/itLLQSxvTUuilJ2G47EDrJs=;
        b=WpdmloYf4T0MEnJl8mxhlPJ3EHcwSi97TejgPtT7wNeH+S6hDeHskkvswovRO2sWXY
         b0Liy9qHgNntrCrjjeFyLeB4KWRIQw0LNnNColDQswCl2U2jeQ9plarIyOT6JIWxcc7j
         tt8pB1PSq6m3L0WLfz3ik1rGkf4DQ3VkwggkFqZ9XBIVutOno5ON7T5KJ3vSulht1aqH
         jGC3sguMP0E+2XDNF1anbB/RJYkGLJiCO3fvhNduhbKQ1PeNOnWDbrPsnSRfrNbABal5
         NWDM+nGSFhcd2PoWBVUEZhA7H3V+W/9slfR/gVHp9iFuf6/8H82ZRf6b6AxOecaB7Jkl
         omFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2KjXpbYDjWuB8Bvq0F/itLLQSxvTUuilJ2G47EDrJs=;
        b=PFODy9A3pUS0rNtc+xYCZdppuoS0V54HO0+D40Nn5pa9SaAFee5a99j4KB7zL1xvr1
         d8Wtcqn+VhPnD6kskiesr1EQDQniQJuIA66PusTNuZBdxrSgGOoBxSkO4BurG+02Yhdy
         32KlpRm54CswP7CUNyj3BtGzGT4wTzMRPq2eL9N/Ync6P2UCnhWdjNj7+3P5SZ6pCh4/
         S6aZ2Whb3Vl4LXIobGAxUGlf9nKdB6uRscdoljFacnI90ifW1lMCSxWDmfdTRkBtOHBi
         9irLK6xE8cJH0qhKtqeLcGmSvmyCWPXJP70/GvRGJGF1BhSp/NRV2Xbv8aiALM0SqRLq
         g6Jw==
X-Gm-Message-State: ACrzQf3p5dKGDcyVA1aVRFoJc2hw44Ztp6G21x6Ygc2lC/HZj0ap13sk
        GFOWD1EYT8aUgvhDeJboEEXlMg==
X-Google-Smtp-Source: AMsMyM7ZqJN+I5JBYuzDOtZ4QzxGlANcrKIfFK12izToLp9QEfnvQB7539DMUkmL3AGpiuFy7PwPpA==
X-Received: by 2002:a19:7718:0:b0:4b1:3625:4c96 with SMTP id s24-20020a197718000000b004b136254c96mr9598757lfc.439.1667817115320;
        Mon, 07 Nov 2022 02:31:55 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id a7-20020a056512200700b004949f7cbb6esm1179391lfb.79.2022.11.07.02.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 02:31:54 -0800 (PST)
Message-ID: <cae429e1-753b-f7db-ca5a-1f485e0c9f2e@linaro.org>
Date:   Mon, 7 Nov 2022 11:31:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] arm64: dts: qcom: hk01: use GPIO flags for tlmm
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107092930.33325-1-robimarko@gmail.com>
 <20221107092930.33325-3-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107092930.33325-3-robimarko@gmail.com>
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

On 07/11/2022 10:29, Robert Marko wrote:
> Use respective GPIO_ACTIVE_LOW/HIGH flags for tlmm GPIOs instead of
> harcoding the cell value.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


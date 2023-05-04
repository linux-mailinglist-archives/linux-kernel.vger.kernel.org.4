Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B916F6D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjEDNuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjEDNuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:50:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AAC6E95
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:49:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f3331f928cso4122405e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683208193; x=1685800193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2X8b+BROLb0l/VBCzn6Vje7GJpf2io4XYFX9tdubz8=;
        b=xI5mweAXgPJ5ZneC2In+CIz/9gJ/jXfDImYzvinOtc0FVfry41QaS7UB54IebENhET
         PV5Kt6eplwujbVoK7a/bOaKRnpDP2YI3xLa8th9AQm/tAEXpp8DVM4sgHGISUbSPz5LD
         Wk/l53UA2T9u4Q1V3yZnUuEo79jb5px76IRpjtl3/GEII7fvHNcdLYa1LPyuViFTp06a
         nOZHRj0gkopEhk/KIm7qF906YzeMY32h19kcTJs71LCkDUdE6eyzqdHYH8KZ3ZCUn3AG
         md61h5czSGCMp297+PwroWXe/lB/6IwDkNQfNUkKiM67DPl5nqPw/+4nlzjAB3M8Gvya
         sdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683208193; x=1685800193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2X8b+BROLb0l/VBCzn6Vje7GJpf2io4XYFX9tdubz8=;
        b=HUCC/wmjiWL2ApBO2QjT8rZVOuuHYBOqkwssSwLNhtJ7OCvxL9ZYsd8n38bCCmOkY/
         MyB30zQk9PkBt1QSSbc7JvJ7rAC2LZXSRXZqU6yzk6cbHPaBRoOKxxgoOi1aqgKxOBV4
         C9qgSq17TZM4lWBxRJ/fYMvf7Jz5ez7bRsLDk9dXQZPINmOzKCec36FYpLisR19aWHen
         N2k8WhxLYOCigLzk7F33/NXEkLno69/gSpGLPa2FXsBWPcyyHSXog80dkkCj7GoDD3bj
         ptE8UG5VdxPrMOJ3tcHMHo7neIVPkKxuxobLac+/FDMJ4EjVN3b4ohRYDYKPqDTqwbGd
         /ZRA==
X-Gm-Message-State: AC+VfDzliHklWjBHfFNghJ2a7yDRDVcRkxE1wTzHj+Sz3HQNCtpr8viq
        dYDYTU/m7Rk0KhuwuwBsRF0Brg==
X-Google-Smtp-Source: ACHHUZ7aqyaWyrvs1VipqgPBXmyd2QsycmpeRQCTGJiilXe6vVjB8PxxJutHkzce+dAbuj/rmE3ncw==
X-Received: by 2002:a1c:7c19:0:b0:3f1:8c5f:dfc5 with SMTP id x25-20020a1c7c19000000b003f18c5fdfc5mr17534214wmc.39.1683208192899;
        Thu, 04 May 2023 06:49:52 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l9-20020a7bc449000000b003f2390bdd0csm4979526wmi.32.2023.05.04.06.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 06:49:52 -0700 (PDT)
Message-ID: <8df7f24b-9dbe-4491-bcb1-f53021bb482f@linaro.org>
Date:   Thu, 4 May 2023 14:49:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/4] venus: add support for 10 bit decoding
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 11:36, Dikshita Agarwal wrote:
> This series includes the changes to
>    - add V4L2_PIX_FMT_P010 as supported decoder format.
>    - consider dpb color format while calculating buffer
>      size for dpb buffers.
>    - update dpb and opb color format when bit depth
>      changes is detected, also update preferred color
>      format to P010 in this case.
> 
> With this series, divided the previous version [1] into
> multiple patches as suggested in review comments.
> 
> [1] https://patchwork.linuxtv.org/project/linux-media/list/?series=10376
> 
> Dikshita Agarwal (4):
>    venus: add support for V4L2_PIX_FMT_P010 color format
>    venus: update calculation for dpb buffers
>    venus: add handling of bit depth change from firmwar
>    venus: return P010 as preferred format for 10 bit decode
> 
>   drivers/media/platform/qcom/venus/helpers.c        | 24 ++++++++++++++++++++++
>   drivers/media/platform/qcom/venus/hfi_plat_bufs.h  |  3 +++
>   .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   |  8 +++++++-
>   drivers/media/platform/qcom/venus/vdec.c           | 16 +++++++++++++--
>   4 files changed, 48 insertions(+), 3 deletions(-)
> 

For future reference a series like this should:

1. Include a log of what changed between the last series and this
2. Describe which comments you addressed
    I generally try to say
    "Added newline to dts - Konrad"
    "Sent the series as a -v3 - Bryan"
    etc
3. Ideally provide a link to the previous series in
 
https://lore.kernel.org/linux-arm-msm/1682492417-20496-1-git-send-email-quic_dikshita@quicinc.com/
4. Use versioning
    This set should be prefixed with "v2-0000-cover-letter" 
"v2-0001-add-support" etc

"git format-patch mybase..targettip --cover-letter -v2"

---
bod

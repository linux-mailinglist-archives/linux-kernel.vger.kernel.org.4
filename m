Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87C65B881
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjACBHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjACBHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:07:47 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFECD9584
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 17:07:45 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bt23so27023317lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 17:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfDOgOIQ2WWdDnnkvgVxyE3haOx9UkJymTl6bifPRNU=;
        b=N1wWUmESRIAEagpwUV9Nh8oMLkxRz/PdFSMkp6J9hqGwqLrbK+6iXF06shnYeAyd9N
         Pc3jUUrwiK1TloQIy2M4lAjrGf/4DkT1tac4UKVQgI3odQryk5hSfAmBBS5Hd+dzA+6v
         fs2cQBaawJXmVsKrQ6lfypfXH5X5v36DePAdc2ssD8s8CybQoJ33vCeyQz3ZAujnneGB
         mD9CGo4D6G/ENbUYClBmrHx3J2aaXd38HMdNrAUsCzCPuyq/uTw7OR00ZJEX/bium87K
         FhrWNiva8yPwsoi0c4RAyjMjKFRCZzZotTKWr83/KOnAeU4FEzBKevC1xtb22+NbaXBq
         PL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfDOgOIQ2WWdDnnkvgVxyE3haOx9UkJymTl6bifPRNU=;
        b=JpFrhggYNqNiprlU9L+Q0MMoOY+ZbyvwApBQ6b7ZaDCoPGqpibCJYT5P+B6/P8Ocbn
         Ui8BnEosx96AqQv5KSVWaDi4lM90xuvQim+FJSTcyxddFud8iX4UqaKVO2CkwIiaaiDw
         PsnNS4f8ODCgUuTlWeQbalDpTeQ9uwfDG49dQVm4QAfUzQH2bnyzo/hiCZ3OeOziVFiY
         XW3Ze3LiHp4207OkwbThEV83DfwJfj48ZwMYuP8rK/vcs92pyrWC5MMAx3En2iGKQfkV
         ilCEndMuy2C/iUPEO1enE8lAmq5XHivTr8XbZX8vENHn/wZYEsrr7e+Kzk3Xv9Esn/It
         NbHg==
X-Gm-Message-State: AFqh2koTWzpsBwnlX5Yir44NZY1zol+qjWzsssaO88z+/vrNg6k4zEIi
        KzuibJWxYBKWxb2f2k9sPUzjew==
X-Google-Smtp-Source: AMrXdXuEPE8e7KN7mpxtIP4/TMc7MfAetQzgbkavNnx/B1hwKmzK4STp3B6+/fdo67+Kif7wgHvy8g==
X-Received: by 2002:a19:ac41:0:b0:4cb:3471:ab94 with SMTP id r1-20020a19ac41000000b004cb3471ab94mr1670128lfc.31.1672708064111;
        Mon, 02 Jan 2023 17:07:44 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id y2-20020ac24202000000b004bd8534ebbcsm4608438lfh.37.2023.01.02.17.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 17:07:43 -0800 (PST)
Message-ID: <cf079fa7-56cf-2eea-993a-46c60adf5c49@linaro.org>
Date:   Tue, 3 Jan 2023 03:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: qcom: msm8998-yoshino: Use SONY GPIO names
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230102190157.970053-1-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230102190157.970053-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 02/01/2023 21:01, Konrad Dybcio wrote:
> Sony ever so graciously provides GPIO line names in their downstream
> kernel (though sometimes they are not 100% accurate and you can judge
> that by simply looking at them and with what drivers they are used).
> 
> Add these to the Yoshino devices DTs to better document the hardware and
> rename already-defined GPIO nodes to fit the "official" names.
> Note that 4k_ is replaced with four_k_ in one pin, as labels can't start
> with numbers.
> 
> Lilac and Poplar have identical pin assignments.
> 
> Diff between these two and maple:
> 
> TLMM:
> -  "NC",
> +  "TS_VDDIO_EN",
> 
> PMI8998:
> -  "NC"
> +  "USB_SWITCH_SEL"
> 
> -  "NC"
> +  "4K_DISP_DCDC_EN"
> 
> PM8005:
> -  "NC"
> +  "EAR_EN"
> 
> Which is probably due to Maple being designed and released quite a bit
> earlier than the other two and it having a super high tech true-4K
> display.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   .../msm8998-sony-xperia-yoshino-maple.dts     | 179 +++++++++++-
>   .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 260 +++++++++++++++---


The patch doesn't only add GPIO names, but also changes some labels and 
node names. I can not judge whether they are correct changes or not, but 
they definitely should be split out of the GPIO names patch.


>   2 files changed, 406 insertions(+), 33 deletions(-)
> 
-- 
With best wishes
Dmitry


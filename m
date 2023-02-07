Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0E68D418
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjBGK2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjBGK2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:28:31 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A1423660
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:28:29 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hx15so41842984ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ts0acRxUBjbRENNqOH3ml+/mZlOaH3hAaRGG4xxO/dA=;
        b=LUHCt0+T2Hf0ZKwD43H5lkjLO6ulP5eagMt47wgdb69tnWD89AQ/JExXLTGnhvzQ2t
         ue9Jzr2h+XtHybrUklYYZXOZ53YxaIvgACuEvFuXIQZ1GlRIITUK5Sn1+8d/6AyTkz1d
         pW7c2KM1Dvcfx6R443sEW5NP6+7q/1hFp02tRVTTIKWFZSk+0nkGQaaUpiJVuEq2ufxG
         8EvMaE1bvTC0jMA8qSgzFEMgyQH4/1iTMkT7ndg6MDsVs/PY2vjegnUBMXTRk6GeiVvv
         GK8a5m/kYH9ngXdCB5HqR3WvjbGJ9hLfKBhpiOAIxNkbBbqLmmwheUPI+6JePtroVSa3
         B9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts0acRxUBjbRENNqOH3ml+/mZlOaH3hAaRGG4xxO/dA=;
        b=jChxkOkb9xhO0C6ien0qQtziTx9Ejh4jjrlz0APAPNDyd19+InfTleoTZhIknjOrPn
         Ih5pHz2oKR9qXYv4ulv4Gwmn+OVOQBbdPILDFBvIt5qhvOvtfPPCytq77JforqkB6gD3
         W5p6vIIRxVOsdsx/t3f4TAzsMEkILw+YYY53J8NuviXhlwscn1Jr1zOsQlNUCNuezD6C
         v+pThfViH9zC6BJY2zlpbdAtjQu0Kh41Z4Myrbvho6vLi4uh0QPi+Z3jJuqQw7swWxrc
         aeVmRe4xUhLiXKPN7XcYIkhk/wSd4+o8uSkKfrps5hCcTDBW6XBX4kL3GRN5u1Pg+1wG
         5WgQ==
X-Gm-Message-State: AO0yUKW5oOc+8WbmtWFWs8xDKH++4Q2Z80kIBNyvfh6jxAbcDW14Jp7I
        Ncru6A/H53PxOi4zY8Q+dZ2WsA==
X-Google-Smtp-Source: AK7set9/juo6jZwynfeVJKi6dbEl+eEIfDse1Ww3gi5cTUFdnPobV93AbPuSQ2zBPXVlSBoFdRmWtA==
X-Received: by 2002:a17:906:1d44:b0:889:b6ae:75ff with SMTP id o4-20020a1709061d4400b00889b6ae75ffmr2792898ejh.53.1675765708568;
        Tue, 07 Feb 2023 02:28:28 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090668d300b00880d9530761sm6652434ejr.209.2023.02.07.02.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:28:28 -0800 (PST)
Message-ID: <2649a9f2-236b-7108-8f68-7eeaf7f1a0fa@linaro.org>
Date:   Tue, 7 Feb 2023 12:28:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/5] arm64: dts: qcom: ipq6018: align RPM G-Link node with
 bindings
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207090852.28421-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230207090852.28421-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 11:08, Krzysztof Kozlowski wrote:
> Bindings expect (and most of DTS use) the RPM G-Link node name to be
> "rpm-requests".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


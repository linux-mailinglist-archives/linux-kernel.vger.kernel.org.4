Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1167652A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 09:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjAUIrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 03:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjAUIrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 03:47:02 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F3CB762
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:47:01 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id t12so398304lji.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTId012Gt6PWvQonFnbk4YKgwaLEuR7guf1cpuZhcdc=;
        b=AvgoHUPeLfhtPkFAC32ZIxPPeDAQrZNhLRXrU9i+vt0sIJ6oaTdVlE3k0HBG1RhBi1
         yDzh2lvVWzp8wsxQ8BVPd/hQJhGE608a3K068rBapLfV1FrreS4mZcCk69/C1JSB0/Ix
         Hkp2jQPeUr5iV9iE/J+u7gDBZmqJJoHsHjxNRAFHwi1NOlJphpe35XsvZorPk9E5hBD+
         QYtjG19EOAqTkp84BN4naMakh3d0Mjss1n5Eejmk5AWaFQIVqYhdodAdWj0bbjh+Oyyz
         oUDgdc5kbSbDGQLlUEG1rcGRJvHF3DFmkbd5wdUG9S0kEB+Hx3uC9KpDUucRDK+koy0L
         4E3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTId012Gt6PWvQonFnbk4YKgwaLEuR7guf1cpuZhcdc=;
        b=k0mwWdr/D9fpBQj7lfh6V+91StFNDme8i920py8efEQTTfXc/Qzln+mjy2sgcVUKfU
         2O35yzVYBPaZ8u/AGmJPeHsTm/1W0UElEoT9eFrvXxUxjNzhS30z98+urwUC3iv4Mh5U
         cExyvyKVKCRc0LKuMQedR7lOsn478kSDAr5NjhIV6repgmJd6SvI/ayS7k/dGRvBEN81
         Tz9mm+PINcTDdqZ3ThURl035eKNqEJUQYXnrjBXDFCADNmu6hTpJ/smIFoY6jYN5R5wc
         YHq+bJuy/llHC1G/5pAQvEt2n6di7hKXQdsQcCqWSdgmXGHBgPkIRzhXbzW+WmuvozCR
         d0FA==
X-Gm-Message-State: AFqh2kpzrr/DwiREmbDQAyj8fTDn2oXPvKph9HleiJYRKaF+ugHjMNeX
        8XvLT/fvEWqyaNgHYJov3J68DQ==
X-Google-Smtp-Source: AMrXdXur8w/pIdAGPL8mUMuc7WdalL3iKUhClyPKVUXZnlyW+pK+ZV5CNHrDP+Xayp5Gis9ElJ4cxA==
X-Received: by 2002:a2e:a22b:0:b0:28b:7a74:15a4 with SMTP id i11-20020a2ea22b000000b0028b7a7415a4mr5098563ljm.12.1674290819340;
        Sat, 21 Jan 2023 00:46:59 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id be31-20020a05651c171f00b0028bc41df604sm448646ljb.39.2023.01.21.00.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 00:46:58 -0800 (PST)
Message-ID: <60f2da52-a757-87ae-5333-8275f98c986f@linaro.org>
Date:   Sat, 21 Jan 2023 10:46:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/8] arm64: dts: qcom: sm8350: Fix DSI1 interrupt
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>, devicetree@vger.kernel.org
References: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
 <20230120210101.2146852-3-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230120210101.2146852-3-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 23:00, Konrad Dybcio wrote:
> The interrupt was wrong, likely copypasted from DSI0. Fix it.
> 
> Fixes: d4a4410583ed ("arm64: dts: qcom: sm8350: Add display system nodes")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry


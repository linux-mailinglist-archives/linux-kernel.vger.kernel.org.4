Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD406738C5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjASMie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjASMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:37:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5058F7E694
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:34:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h16so1683974wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8rfEMuDyZxUr/lsXYzAmRQq2T1KGzsa28lJ/dp8Na0=;
        b=uVzH5ljAauUiCFlvukItmwkf22rMDfOGSirz90QzPyVNy9A1Nzas9Lyh/1l3ZKigGm
         GNjswLxOXkN+FBh33Od9dmamLU2yf5gapgJrgg7P1DQezLfU9ccHz/scMB/zgSE/tegV
         6rjLDrbdb7HUVuWw9l0uOuJionnr7wMgKfN4XGOIC4DFLp+eLEBeUXB0POsZZMWakV08
         eCzrf8Vqtci0edsFH9/Vi13Xb/vSVSBJtGY4C0n3OUYwq0xZQDG6XctrNKEcJd+r3SAT
         adWb1ZLX8Fbq6ftdt2xQ94VojSKVYw40WY/GYz1l9OuALzdFR0IKc+PdSf++RVQ7pOJ6
         GCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8rfEMuDyZxUr/lsXYzAmRQq2T1KGzsa28lJ/dp8Na0=;
        b=X4MYa0F76KfChmCkNOYnNLwylgNmi3jRdHp1R5mOKez7SN4O+GzyM98Tk2WVq9VJpZ
         tFIXZM+G4ysqZmCOEA554j+/3nvRMTelmxJI1+zmjgXoBcxZegVYhMVV0OzsoyXX8yOG
         LJIMAKHzNFmYTR8X0JE8laktcIDIC0lrT3a2Vyi1nV8rKVFX3cJjRExlkRDHMxUslud9
         XMrvpaGoNjaaB04lT0Je9TD8KmhOaj0wXSNlrx19Z9pTUXceM1/K3mbAVj98Kk45K4VD
         bwmgbpcGKX5SGFmgHuiRBmV+MlnSd5fpf11eust6D4eqON6NfGksMuXQAb84ZJ+O89SM
         n+jQ==
X-Gm-Message-State: AFqh2krI7Jn6nanPSTQBiq7gVag/41BWZoIHdBC41jU+kzZvkNDG8uF/
        rjZFLg+nTJeNUVGEkNwpK/4Geg==
X-Google-Smtp-Source: AMrXdXvzVVbesAd0ZmGM9ysqilbbXkk1wRoX+XB1+gxFbmc3m9tTTSqEwRqVqqLxwV35oAz7m3k7/w==
X-Received: by 2002:a05:6000:1b85:b0:2be:f21:6af6 with SMTP id r5-20020a0560001b8500b002be0f216af6mr9229691wru.23.1674131612583;
        Thu, 19 Jan 2023 04:33:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b00241fde8fe04sm33247124wrr.7.2023.01.19.04.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 04:33:32 -0800 (PST)
Message-ID: <af7824c3-ebdf-5913-1fa8-1c167911d06a@linaro.org>
Date:   Thu, 19 Jan 2023 13:33:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 7/7] dt-bindings: remoteproc: qcom: sc7280-adsp-pil:
 Add missing properties
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org
References: <1674131227-26456-1-git-send-email-quic_srivasam@quicinc.com>
 <1674131227-26456-8-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1674131227-26456-8-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 13:27, Srinivasa Rao Mandadapu wrote:
> Add reg-names and power-domain-names for remoteproc ADSP pheripheral
> loader. Add firmware-name property to distinguish and load different
> firmware binaries of various vendors.
> Change qcom,halt-regs property phandle to tcsr_1 from tcsr_mutex.
> Also add required-opps property and change power domain from LCX to CX,
> which is actual PD to be controlled, for setting appropriate
> performance state.
> This is to make compatible with remoteproc ADSP PIL driver and
> latest device tree changes.
> 
> Fixes: 8490a99586ab ("dt-bindings: remoteproc: qcom: Add SC7280 ADSP support")
> 

Here and in all other patches you sent recently - no blank lines between
the tags.

> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>  .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 30 +++++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


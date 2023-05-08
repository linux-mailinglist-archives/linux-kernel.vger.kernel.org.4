Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02D46FAECA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbjEHLrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbjEHLrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:47:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEFB436A0
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:47:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso4970787e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683546441; x=1686138441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9B6CaPkZBil7QXhW4xgkl76LhhEn9jjhosg130Pnjk=;
        b=okyKiK9bPRvAKcZ8d6twz3XWnUxQOx4c+TlJ1oWtHv4bgtr/ul/3BwO2RLiOEs54VS
         xjyfF+SFT2lIViPThbuwxce3iPgBcuYyyrNJr3+UgXzKXFwKokmabmInbFYsN8j/Ti0/
         5g0g0ZMt5EnTHFLoOTdmV9KqkcCLparR46ewQDE3qdyyaSLOUpFRF3n2uvTPL8WOI5oL
         CRuZ+QYCybccX6aifpxHRRe10fQyXhdwmc3rrDJvvD9H9NiaGtqAlOs7FaMQtnYsYEjd
         OctqJbwk0/P9W8/YbDFdWtAG4toZFBfL49sXu0imcTwiHYI5bTm9WyThk8jseI+aStWl
         h1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546441; x=1686138441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9B6CaPkZBil7QXhW4xgkl76LhhEn9jjhosg130Pnjk=;
        b=IFdLRDVsdUJxJxhwWeA5OVEo+TEULD6pLSA/WaRQ3LLHzoNLKtB9xtIjlfFrWd9diq
         s0E/WPicvgY7zl1N+KPVL7/gp1iEgsvoX86gGWjqhBHvvCy/PAgp543AGPCJjp2Vte3x
         7vxwE6IMoJNmJHA4yx1URj8oOZrDoURWTDim1XXouTunG3F8Zc1jCM5sjU8PLWUmimb5
         io76ullTdOWSyHk1xWx741TDJerLYAWCdm/cOHyRm00dcLXipLNGrftBWxu/wJKuADa+
         pthm5CDmY5pPWVHcmTpTr3unROj/rT34hb2s5sA50RATQ+TIArKZMVMYmRXPRb4OZ2RH
         CrZA==
X-Gm-Message-State: AC+VfDxmifF1mx+Drtey95iYCm4TlALgcGVifI4w82wkkjpNWcDFfKgT
        EvIAImxYaWgoZPMDTyQCRHc9AA==
X-Google-Smtp-Source: ACHHUZ78bOYsN43Z4jsxYSEe0z1+PvFyM4UC8dfrOVUCyRWf1YZAVn9VwTNe5RgPfXFZJoWQiGRj0g==
X-Received: by 2002:ac2:457b:0:b0:4f1:80cf:6194 with SMTP id k27-20020ac2457b000000b004f180cf6194mr1633066lfm.64.1683546441625;
        Mon, 08 May 2023 04:47:21 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id 1-20020ac25681000000b004f24d357794sm482171lfr.281.2023.05.08.04.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 04:47:21 -0700 (PDT)
Message-ID: <74cfd112-5896-6dad-ca52-b22b1b1ec82e@linaro.org>
Date:   Mon, 8 May 2023 14:47:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: ipq9574: add tsens node
Content-Language: en-GB
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1683523370.git.quic_varada@quicinc.com>
 <81653f1ac4bf42e57a7d6c4f1af844846d091224.1683523370.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <81653f1ac4bf42e57a7d6c4f1af844846d091224.1683523370.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 08:32, Varadarajan Narayanan wrote:
> IPQ9574 has a tsens v2.3.1 peripheral which monitors temperatures
> around the various subsystems on the die.
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> [v2]:
> 	Add "qcom,ipq8074-tsens" as fallback compatible
> ---
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


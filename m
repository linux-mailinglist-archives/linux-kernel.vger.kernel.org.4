Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF067053A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjEPQZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEPQZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:25:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5365B9EEA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:24:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510b6a249a8so154194a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684254235; x=1686846235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUikb9CiBvwIkQSA68+r5AMXjqRggL7xlVoG0Lr7Dlw=;
        b=zdHgs1uhk9j9Fvzet/xg1PnShN9nZLOXcBd5FBheGTgp9TlWjxTJU14JCV0NbL5iWB
         kz9xu5cj2TSFOM9HEqmCTtf9wh3TMGXd5cYS0xScf3yu/WHN91uj+EjBGqKfiodtFVP/
         w4BnYXhQ7RPXHJd3c6jPXd5is4H0oycDa09CiHjpkFj8sizx0idRlBgAc5eSIzR6ER7X
         4fr8siO4cffBArmjQxPR2AANjU2RoQGfZXCVdRJH96uF6nmnMaXpM1kCy97Rdp5KPbbB
         ilF9vVtaz07RRBeiWd4mh1Hdh3hVczEWyXuLhSMblBtPWJE/s75/UDTK4hdIJTcSRa8d
         zGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684254235; x=1686846235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUikb9CiBvwIkQSA68+r5AMXjqRggL7xlVoG0Lr7Dlw=;
        b=l46D6j24uZUYFN7YI9Jb4NHrNN0NSkAwv9KwHsJNTjjzD4/VoJwd6Rg++EHNdNwdtS
         Op5CqrGN1GbuxiyXwoBYUk4pGN1PjYpovG4C/Gfc0tlVyVpxloTmGiTeYRyU9JkX3k5L
         H/i9NiP3lFoBn+XZNi5z5qTfcTpOreMa/alXl8zc5z5pRXt5bRehZK4smQRbjPZD/gqw
         pG7bek86YMyeMChdOakxpuPLAHGMmCO8npvwV5+Ou0Lv1+yPvunIij17vh8owNQ9b5DO
         duv7kxBeoOqznPDVf7ZmyOx4sioQpU4aIDek2+9ouGX8pdkHrxi6J8/cPdX788QJ8vlQ
         +hjg==
X-Gm-Message-State: AC+VfDxkbGmAnU3BN8InpPqp8M9bn+C+CUdsqDJuNX70LdkMdCPeT0YK
        dkEi4LM4we7Y09iJUiY5zBsSAQ==
X-Google-Smtp-Source: ACHHUZ4ciV6/qSxcU8jgXk2c5v9kXV6rVKisuEt1ztrBycY+7PN5s1cdFG7yNt69mDvGaQR9JvYSkw==
X-Received: by 2002:a17:907:9617:b0:94a:6de2:ba9 with SMTP id gb23-20020a170907961700b0094a6de20ba9mr40789193ejc.68.1684254235712;
        Tue, 16 May 2023 09:23:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id m26-20020a17090677da00b0096ae4451c65sm5101707ejn.157.2023.05.16.09.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:23:55 -0700 (PDT)
Message-ID: <138ba3a3-0f89-e612-4e29-0e4d2838489b@linaro.org>
Date:   Tue, 16 May 2023 18:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document AL02-C6 board based
 on IPQ9574 family
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com
References: <20230516135013.3547-1-quic_devipriy@quicinc.com>
 <20230516135013.3547-2-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516135013.3547-2-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 15:50, Devi Priya wrote:
> Document AL02-C6 (Reference Design Platform 449) board based on IPQ9574
> family of SoCs.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


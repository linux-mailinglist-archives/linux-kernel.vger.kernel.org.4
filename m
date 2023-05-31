Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8071894A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjEaSVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjEaSVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:21:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B1A1AB
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:20:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso1123582566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685557255; x=1688149255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1T0GTPGXW58WMv7iRFoetMGLQWxPwUhy+uBYYQwBrQ=;
        b=RUljuDGZQ+xc1tqWrfne2m4p6nekeCHFYliuni+8zdX2FUrk/lLA9AhUPTZSzBfnAt
         ehNGzmpYe1Kd5mM516HyvfpCvJzHMlV/vAp7pLJ4lGa1vy0Qj59DWYibYcLDyr/BBKVY
         Vm69064WKNMp0kaEtyyJHBmO/zTEhogaatH5dMvvSdTxpjsAhq2EKgZubpGuV7dZm4VF
         C7WR2PqMa9HEGJdla6EQd0+1Kx08nghkMMd83IVBYX6DTgntApqFJDCIyXhPUO8Per3X
         ZuJ6V42lrfYiSDK2QqJazjaezl/O4iH8QV3QZblcA168YT39Owxbsope9rBQLPqraKyr
         mkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685557255; x=1688149255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1T0GTPGXW58WMv7iRFoetMGLQWxPwUhy+uBYYQwBrQ=;
        b=N5Rl4EiTUp+PE8TTWlbYbXM17LxNcGvSxyZIQhF/TvOekaSKmV6Omrv5F3GLdf9sYQ
         hpC8mTuJBMDVu1/npuAxLUyxhBYKq/xy1wuAXVa6htqdIYkWDTtqDGBoQIO12MrzzFGO
         Uu6rvNA88x+IQcfYHfVeUW3G4cUw+wXLFRVOwxelcxv58eFlKfKrcyzufd/DfdqERnKO
         jGW+E2Tq7eDiFEfL17PG3dmbND4LPW4PMo70+NoQg/P65RwKm+Wm0Kf7cpLfasFplHRd
         qHW1CxTuJNaMFBO4ohRCfmC4eySc9Dcdp0C0TAnTj4GNM4LrjlB+FarzjunWjBLcnE+Y
         RPzA==
X-Gm-Message-State: AC+VfDzO70+8RTlNAXMVPNrdC9p5x6Ngqs8YkrvK6OXVj4L61FE0HfmE
        VW2VOyAc6k3g4rP1IC1/dWZ68g==
X-Google-Smtp-Source: ACHHUZ6j2/tD4LCUjTT2RVx/mXxK7yKQZJ1QwN4PQ3FTEquaIlsa3kjWbZDdeZbOsRdvp9vBW/lKXQ==
X-Received: by 2002:a17:906:6a19:b0:974:1d8b:ca5f with SMTP id qw25-20020a1709066a1900b009741d8bca5fmr5717416ejc.9.1685557255491;
        Wed, 31 May 2023 11:20:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id v15-20020a170906338f00b009663cf5dc3bsm9320865eja.53.2023.05.31.11.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 11:20:55 -0700 (PDT)
Message-ID: <7b08af5b-650c-677f-54ad-e2511b169489@linaro.org>
Date:   Wed, 31 May 2023 20:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] dt-bindings: net: Add QCA2066 Bluetooth
Content-Language: en-US
To:     Tim Jiang <quic_tjiang@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_bgodavar@quicinc.com,
        quic_hemantg@quicinc.com
References: <20230530082922.2208-1-quic_tjiang@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530082922.2208-1-quic_tjiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 10:29, Tim Jiang wrote:
> Add bindings for the QCA2066 chipset.

Do not send bindings separate from their user. This is one patchset
consisting of multiple patches:
1. Bindings,
2. Users of bindings: drivers or DTS


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


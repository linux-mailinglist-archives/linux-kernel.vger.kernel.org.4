Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7074062F4CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbiKRMcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbiKRMbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:31:19 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02BE6378
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:30:20 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g7so7993232lfv.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/T5TC2x2EcP8PwnJhpyehxMZsEf7shKkdFwJGz20mlE=;
        b=bwZ0ilwP9g7vEhzjlxFtHmSMsaOEt09iun5pYTr5EahMTFujYpaFGnfFoF1G4E11WH
         op7wV4ErjdpnumW6ywNHAmkY1RGn8ZN+7F/KDnP3GDi+YLbP8Jb8pFytfXO1TrkXaH+f
         JAh5ISKFv6a5tytguUC2QclPi/cBnE+Ie92otQ2btgXHLxiHh8ROkLz9W+z6HXWvN01V
         NeKoKRckg1rGHcAbVKRh+8KbO0Has3rpRum4HdZEnmPw4HaFPld3mp+Lp66aWJCBkLAB
         5jqteDp5O2gf5qWvj/SHsw3u+3uvpt1LUhU0z4c6H2OI4k91pBXVxG1DNjvfzmuUqXBv
         JmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/T5TC2x2EcP8PwnJhpyehxMZsEf7shKkdFwJGz20mlE=;
        b=ynB5Laf1PI1M9aa46kcac/7RrLMoNwI5r39flCwcUbkCazdzooDi1kWHEj8qbqy9yd
         Tlt0HihprAU9xjEYUdctyDwkLbMZT/9UeKFp7UTLVEupp6hxOjG2x10uyHEDi1fTyzwN
         VNovqWfgLevltwdZ6JDVETydlOtHit5dbSXsy6B+Ac0TcZ7HCX6F5ngCvABn3beGUY7p
         rDcP7Y21mJj3NGkL126x1MLvYjR/4TsQeNO5rwcqQBpjb1/eOM3lXZWF9wPLFd6/A6Pn
         62u5WuNcZan7N+h4qR/FQ6zAnoNjWla86MtjSWxoWwtNEbLZx5JrhArV+luPnQPSR2tl
         L1Vg==
X-Gm-Message-State: ANoB5pkKXEp/sVWjKlbVif8tXhHLqWaf2tlxfizG5soxYgbtVH7RY8Qk
        +0svNMjUWrxeZXbYN7bKMtGj/Q==
X-Google-Smtp-Source: AA0mqf4Dh4IvP7mb+ocP2QMPZx3i5Tp7C3K547xiIXWSsW9WrB19GheCfLjJZueArYPJCiGCcyA3AA==
X-Received: by 2002:a05:6512:790:b0:4b3:b6db:8ca7 with SMTP id x16-20020a056512079000b004b3b6db8ca7mr2398193lfr.590.1668774619005;
        Fri, 18 Nov 2022 04:30:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b16-20020a056512025000b00494a11c5f52sm638163lfo.256.2022.11.18.04.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 04:30:18 -0800 (PST)
Message-ID: <1a53679b-07a6-1180-2ac2-ecfc3382fb52@linaro.org>
Date:   Fri, 18 Nov 2022 13:30:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] interconnect: qcom: sc7180: drop double space
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221027154848.293523-1-krzysztof.kozlowski@linaro.org>
 <20221027154848.293523-2-krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027154848.293523-2-krzysztof.kozlowski@linaro.org>
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

On 27/10/2022 17:48, Krzysztof Kozlowski wrote:
> Drop double white-space.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/interconnect/qcom/sc7180.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Georgi,

Any comments on this and third patch? I did not receive any
applied-confirmations.

Best regards,
Krzysztof


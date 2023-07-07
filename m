Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B535D74B0CD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjGGM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGGM3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:29:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145EB1FEA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:29:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso2790766e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688732958; x=1691324958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3H/cw+NDInjs9SJDWXqRf3DMhHgAg+6vWsSVOtVpZfg=;
        b=REDANDM4w3B+ePj3836UDrxjjHZbaGpUhWUqmjT2GtcbmeqNTTAIdjdKk3IT8nDjX/
         5Mp0kfFVShE3y436qgbhXcHe5WEaYNc65CS7KIgptRd8QQiBk63ppj103TDaysArodiW
         77X8HBTfZAmLZNJ2A2Lz45gBZ9HeZMRGwxDZszT2RfwpdOHZyP65QahpzcTrJBya31kY
         jzpnNAD+V+cCg+nWz2ne5dPragtTz/ISeyKfzWz+qZlABrxHxSxVBvbnzwvyCufdxGTb
         eJDx9bsIZh4r7QtKgMn4Sl0HXL2WhFLW0q8GbAlp5Qsy98JjD6I+oKEwp2PNNHUKjKEO
         jTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688732958; x=1691324958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3H/cw+NDInjs9SJDWXqRf3DMhHgAg+6vWsSVOtVpZfg=;
        b=Cill+6Nlmewg59R8O58hbXVuHSjr9XLHo92IxXWIIJI9qaDY1q8UWUI8tzJVNhE2fW
         c9fOPvweVj9/IYtaefBQQRGIlSJ+k0P9evv4I0Hy8OM68bWqtOx+vdALUkuJmB+BRuIn
         42Ko8VDAxovBIqrsllvgSU5OX6gS1hh/kSO5Gd3VYmmuvBjuVux14x1f1pvUhSeY+FQV
         GCjQo9TYLt7qurljXHc/pW5fd2+S9CjlH3FAjoOvHhEHfkOXSWIcQ0wb6N6mG6rG9Svf
         YRuYN/pDcCSyYxSEtR+sArjb9EoICn+cWx/EyDkAY13wA44yWLEmKdSoEkvipmnbtqSR
         riRA==
X-Gm-Message-State: ABy/qLajWChJ+0yS+hY7n5+p4V5Hs0r8aibbTGV8CqD9sex5j0lUMVFn
        T/MNp0h0ok9bQ6b6zTpmIYrw1A==
X-Google-Smtp-Source: APBJJlFBx0KTotWF/y3AHFvCg4k0qoFwt+zAhreMCg5CF2LKiuYBNnfHTZZaB7irlRCZcN6QQJn0PQ==
X-Received: by 2002:a05:6512:3a82:b0:4f9:cd02:4af1 with SMTP id q2-20020a0565123a8200b004f9cd024af1mr4221783lfu.34.1688732958325;
        Fri, 07 Jul 2023 05:29:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id d11-20020ac2544b000000b004fbb1bc1ae0sm669286lfn.163.2023.07.07.05.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 05:29:18 -0700 (PDT)
Message-ID: <f26fed94-c6c2-cc39-62ec-8aee309456eb@linaro.org>
Date:   Fri, 7 Jul 2023 14:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 0/2] spi-geni-qcom: Add SPI device mode support for
 GENI based QuPv3
To:     Praveen Talari <quic_ptalari@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_vnivarth@quicinc.com, quic_arandive@quicinc.com
References: <20230707051636.5301-1-quic_ptalari@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230707051636.5301-1-quic_ptalari@quicinc.com>
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

On 7.07.2023 07:16, Praveen Talari wrote:
> This series adds spi device mode functionality to geni based Qupv3.
> The common header file contains spi slave related registers and masks.
> 
> Praveen Talari (2):
>   soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
>   spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3
> ---
> v4 -> v5:
> - Addressed review comments in driver
"fix bug" says exactly nothing

Konrad
> 
> v3 -> v4:
> - Used existing property spi-slave
> - Hence dropped dt-binding changes
> 
> v2 -> v3:
> - Modified commit message
> - Addressed comment on dt-binding
> 
> v1 -> v2:
> - Added dt-binding change for spi slave
> - Modified commit message
> - Addressed review comments in driver
> 
>  drivers/spi/spi-geni-qcom.c      | 53 ++++++++++++++++++++++++++++----
>  include/linux/soc/qcom/geni-se.h |  9 ++++++
>  2 files changed, 56 insertions(+), 6 deletions(-)
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665FF6D19B9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjCaIZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCaIYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:24:22 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F661B7C8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:23:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j11so27863256lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680251012;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFM/eoJq62VMd0BThJcIsWt0E57OGZL4qf+KcrA3TXM=;
        b=qjBLAWtwVkcMJKOf/T/zHVv1LHnyI0dYBudnw1wyesrWNPDE/UH+dZ0bG6t4MrjHmm
         rBBbOTK8Fivj12NbFtEWthmJU/vyNbHTvSbwlJR+rM7ufQWTGDagP2WH+qCt8kmePvov
         iiiIN4fyAPCHSIIkTxkdd2OOEWlYEZSzirBzt8JJDkqotaDfQcE/c4KTAb2rAj/vMGs1
         lVAsOZlgc3GgEE3fx6OoAyTQXbVHZSOQM5UrZaMEzlmPY2ZrVz/zbb7qt7TxpxJMniwq
         b9CdtqGL46fkIm5Wdigo2zj+ersnKnkARaSgqFUbz5TMzvxmRp6Bdke6LF6T2BgEI2JE
         G5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680251012;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFM/eoJq62VMd0BThJcIsWt0E57OGZL4qf+KcrA3TXM=;
        b=btlIi1JLooFpz6Dj6yfGPM3WQwSp9sHx+FK4xRzvGxxWdBTYcvMJpeEyuIak2nkyoL
         9g7ZRxRf9jSucZV6kIzKYL3eyCwjcSgea/8H24/ondshO5tl6Ue1n7Ihder1ZUCfNVHm
         BPDNN2AzDcd3/MpBhfzy9ZwIW59QdLZrA2dYUOV4O5L6dVODS6+9SE2iCmG8GJXIv4ch
         LXhnFg8QKEPciiKSnXzbZvCGjrtPlEx0US+6K5+VZwmWxsA8nITydfp7PJapD+ZZ8JXh
         n+1QaYWd31PSl5w84ThbbVyCIbp1sPMY7pIAN9CWx7vR6PLfeEHTMDNb6EQXmupUPjNT
         lEMw==
X-Gm-Message-State: AAQBX9djsbbcFUl2FpvnrGGkHcccZ9262QVNCIH/Vi9OhPKLHbHXHjg0
        xE+ubnGsRpDowboqeHsJxcS2FA==
X-Google-Smtp-Source: AKy350Yx2sdKgu8tI9CRCsLXniSwS6JAiBf3Jf4pjSYqbo9lRR7T1GxMyik5Jl1LaHt+KwpoJ99OCw==
X-Received: by 2002:a19:7003:0:b0:4dd:af76:d3c with SMTP id h3-20020a197003000000b004ddaf760d3cmr8275543lfc.48.1680251011806;
        Fri, 31 Mar 2023 01:23:31 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v11-20020ac2558b000000b004d85316f2d6sm282684lfg.118.2023.03.31.01.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 01:23:31 -0700 (PDT)
Message-ID: <a4d235ea-8476-23ad-6678-1ecbce93ade6@linaro.org>
Date:   Fri, 31 Mar 2023 10:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: xway: drop the deprecated
 compatible strings
Content-Language: en-US
To:     Aleksander Jan Bajkowski <olek2@wp.pl>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230330212225.10214-1-olek2@wp.pl>
 <20230330212225.10214-2-olek2@wp.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330212225.10214-2-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 23:22, Aleksander Jan Bajkowski wrote:
> This code are marked as deprecated since kernel 4.5[1]. Downstream OpenWRT

References to commits do not use [1] bookmarks.

"since commit ....., in v4.5 kernel."


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof


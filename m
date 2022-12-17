Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F287A64F8D0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 11:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiLQK7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 05:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiLQK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 05:59:13 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51A6636A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 02:59:12 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s10so4636417ljg.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 02:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bWBK8NjdOSu2oHxSgXnlLAV0JJ7om2AhC9msq+gIQIM=;
        b=Dlhh+IGTjTctruJwrIaH6drA+PFg6ZZJ92h9c61MVbbPSXUenClCC+DRso8ySoGoQC
         t+b+YXGI2GdDC6+JOPNlFH+BW1RaIHoCsofdfmwKUP4cnbm491J+8FBCl0+1eYQWcMRB
         SybJThQORk17Dey8dWxK577KDG/qgxIGd6uYidPmv+5mPe0wGPlsZcXX7TdKQBgHatFd
         E85WHFb5Tdvf2UrDHlaV3moTNZ6ahNNSUgFLTYlfKEAFNlFYao/oFKBoUqn3KlTdyLsL
         172qDrWM1GMPhHJUgcMxWw/RM4yoIXgSK0N6Kc0vaCRQxXJ8FZ8ZafNTtLm+JiqRj0Ga
         5E2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWBK8NjdOSu2oHxSgXnlLAV0JJ7om2AhC9msq+gIQIM=;
        b=ydaVNWMmzX/PHe9IqfO1AIqyJDnBTnMO0C7NxkzWiIu+BiYLrySJNZ5tJZZv3glSWN
         gg9ZJ9yci9xjDItRLNifIz8iC962vynRj1UcZeiiYGaiERWqYkPVpjVc/vJSnnFDTFSJ
         BGQxbgHy3+nxrerA4n3ADThBEDGZjNHHXjk0b1kKJ9PXVWNLmLIyxe08fKQ2ZOHXOYQK
         zTyXSWBHyX0ZqcQSMEyK2DLvrvQpmGMQLb2wy4euiMWiQr/iui29GdaE1nKyHzgVXCCd
         lWTyDlXd1AIrz8f1QgjCoFckRpJV1TA+5WCSLd8Rpqx6ZHUZxw6y68tv724sAVwhaid4
         Pv0w==
X-Gm-Message-State: ANoB5pmWuma50tyjbi+DxDMTxjm0O/zrLuqQkE5N8sHD690zIdvLQxZB
        bTjSxodI+DvQ2rGdQUH/Ya64ML8/BiktBpQ7
X-Google-Smtp-Source: AA0mqf7Y4mEt/k9+m5ipOow6pNb/D27j4c2KqpRcfhLmsqUub5zJB/St9dC7Jsmzft03u3M2Kyvr+Q==
X-Received: by 2002:a05:651c:b0a:b0:26f:db35:6059 with SMTP id b10-20020a05651c0b0a00b0026fdb356059mr11629668ljr.36.1671274751143;
        Sat, 17 Dec 2022 02:59:11 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i25-20020a2ea379000000b0026e0434eb1esm302535ljn.67.2022.12.17.02.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 02:59:10 -0800 (PST)
Message-ID: <ff8cd48a-c353-3663-4370-f86637e092b2@linaro.org>
Date:   Sat, 17 Dec 2022 11:59:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 3/6] dt-bindings: mfd: syscon: Document GXP register
 compatible
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux@armlinux.org.uk, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221216183532.78933-1-nick.hawkins@hpe.com>
 <20221216183532.78933-4-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221216183532.78933-4-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 19:35, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Document hpe,gxp-sysreg compatible for GXP registers.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---



Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD669A745
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBQIpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBQIpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:45:22 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7963E4BEAA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:45:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id co2so1043403edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ebHEjhhQg6SrbCXlcwPL5qX5DnluT/Ueq/0wDwmR68=;
        b=DcBx0ksgIs/Y1vPtT+jyIe2mwq2R5Uj65SNGWhVnpxL3apephRUFA5dmvWlcG1iAWd
         AYG6KMSQvl2YxKwT570b/G8SUFUnrlq7ZZuwG+swU2QQefmq3LAChUj3E3Aw51ydYEp5
         zxKm2NBilHiHnis5s6l7xsZ3BIJwf8SaYgRcDqnC8ualc3FsyoKs2KyS33qzyE8/VA1G
         /bl3is1dlGWSCwNfUUs7Dc3/sc716DNXG02oYtURYr6Da9fpFiNwYW8wi/NYWIt7n0pW
         xhop3be0Y08IC2s/Apc/3QrKS8DLrfSbCKdV/DbkHkWvcQ4Ph+Fro45iVOp5iuub7D+J
         PKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ebHEjhhQg6SrbCXlcwPL5qX5DnluT/Ueq/0wDwmR68=;
        b=firHqQqAh3btUNxpTCRE4FQnRqCwXzPXSwcxYTsHFFXZooK64YOiKVQaxu67owvES7
         gN7NZaurQOHiimPbgkgcC/4yK0JX6tqTj3xMrga+YDPUI36utHKB+1u+KDLtxxdYVm4B
         FnsEwDtaAf3tpROcigA3hTDXAvc2TWRT6OI9EbqCdOVrcgPXOHNAzTWk3Sp0jVxVuOKo
         ZggGrrXwk4KxdT4LcLBK4wfOxnLYvsD7oAYe/S44I86M6a221wVlT10rhOebLeQ+7B0B
         tFAVBGRPH07wCGn0C1JMXKLONo/vCpPxXKMp1CroD/mkhbKOr9kFmD+kgBwtOoQ8bcAt
         c9Qg==
X-Gm-Message-State: AO0yUKWH5nINAOjjoTOFRvpMUVT6ZxhZl6c/yQ1v2b+LxLWuIgLVqmEe
        3iEK1cGSPyeY2BppYq7h5wkAxQ==
X-Google-Smtp-Source: AK7set8i0o5lqUG8tIq6CIIUZR3TFQhZ+xoWnygHa2WHOM25cp1THXFzaVlWebxs9MpN/Vx4lSkkWg==
X-Received: by 2002:aa7:cc0c:0:b0:4ac:bbb1:e61c with SMTP id q12-20020aa7cc0c000000b004acbbb1e61cmr62829edt.1.1676623519966;
        Fri, 17 Feb 2023 00:45:19 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u12-20020a50c04c000000b004ab4db9be14sm1963166edd.81.2023.02.17.00.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:45:19 -0800 (PST)
Message-ID: <76dcdd11-ab4c-62cd-2570-51058252fb4d@linaro.org>
Date:   Fri, 17 Feb 2023 09:45:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add Richtek RT5739
Content-Language: en-US
To:     cy_huang@richtek.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lgirdwood@gmail.com, u0084500@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1676599618-24819-1-git-send-email-cy_huang@richtek.com>
 <1676599618-24819-2-git-send-email-cy_huang@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1676599618-24819-2-git-send-email-cy_huang@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 03:06, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add the binding document for Richtek RT5739.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v2:
> - Refine dt-binding patch subject
> - Shorten and refine title and description without too much marketing text.
> - Fix the typo from 'connecton' to 'connection' in 'richtek,vsel-active-high'
>   property description
> - Remove maxItems in property 'regulator-allowed-modes'
> - Fix the wrong min/max microvolt in binding example. Must be '300000' and
>   '1300000', respectively.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC86A6C941D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjCZMN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZMN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:13:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0B930E8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:13:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b20so25130215edd.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679832804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfylKtuqAdjWyuMFH3aXceJDXKfQlN7GtkmpCp4vpDQ=;
        b=TI/sZ5klonceETXd4v1IIZbs0JqAKBoPoMF22tmnim2jZPaW0GrLb1snHgedeeYKbL
         WCGwlAHywiRjXoslzc7NdAbuBgltPuBvqSLnWrj45JjnGWpNaotrlRZFFHapAQp+6iXb
         OsjmucWoMjH48o0DdltpXS60j80yKVwOZG2FR1CwxvVr3pMjxRdS7J4ayDOE9yXSPnQK
         1L+lFSV0wKztvtZkwST+uwkMsX5z2lLuQ2nUGuJsgUf0pBKSp0OR9OEkYTgBuYxTK2VC
         kqbPYHOr4RVTGVgakagCYQFLdGAr6LGCK6gq9MQjrz8MTkpclDXqOiVdYGidDjMriSAa
         s2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679832804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfylKtuqAdjWyuMFH3aXceJDXKfQlN7GtkmpCp4vpDQ=;
        b=lV9Tl8IvKXXGfAfTVSJIPG4EfgTjhi8PD59clpvc+s9QtE1UBBYpu/6f8zX+b0r0km
         crk+DCCkKDiF5x8b5GSs+tuladfwcjZYp77S4NgKuKWyPIj00HlOWF/gdqJFlg5wk2+C
         XfW3EkRy7JgkfEmFZj2ztLy8R5XLt3wybhzcz2zVmLtETgglwK/u+elK4LryrodEfGQW
         NEVs0oWZCEgFbjjqMT0nnu95/IMVXtBtLoY/Cv2w1Mjrnl/ISPINIMzlVoEE8urFRH24
         RU6nV+dsXH3M8xBwvyhot1T3SwAXl44oS4YHJTkDpuJKuuX/z7/fYSskId+wtPmDzlJf
         FIKg==
X-Gm-Message-State: AAQBX9fxw+yKGvHvl+vK9t5zEZmrXnuL8bKGmaZXTJ4PYUIrMhYERRfR
        LJsXB8J5/WH+qvxQTgEZoVPjfg==
X-Google-Smtp-Source: AKy350Yvy1Y+JDumuEvGtVH5rvXS3ImzTb1katIGgHGIfY5OqMoBiaG2UM7CLyFikjBrprHV+9iWIg==
X-Received: by 2002:a17:906:3f8e:b0:939:ad91:adf5 with SMTP id b14-20020a1709063f8e00b00939ad91adf5mr9741002ejj.25.1679832803951;
        Sun, 26 Mar 2023 05:13:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b0092b606cb803sm13112964ejp.140.2023.03.26.05.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 05:13:23 -0700 (PDT)
Message-ID: <3eb2133f-7e9b-ea98-87c8-cd24814bf12e@linaro.org>
Date:   Sun, 26 Mar 2023 14:13:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/3] dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3
 glue layer
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
References: <20230323163116.2921999-1-Frank.Li@nxp.com>
 <20230323163116.2921999-2-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323163116.2921999-2-Frank.Li@nxp.com>
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

On 23/03/2023 17:31, Frank Li wrote:
> NXP imx8qm integrates 1 cdns3 IP. This is glue layer device bindings.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
> - Drop all clock-assign
> 
> Change from v2 to v3

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A332C6A94BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjCCKED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjCCKEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:04:00 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7051B125AE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:03:59 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cy23so7952321edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 02:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677837838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFf6sFjM9AwS1vxSlfi/rPHVOurvo1lmtYF9mvz1O5Y=;
        b=zx5m3vZMH3KlO2uf0cs9g4D8V+W1lNnHgyH9QWmWZ1B/JPjh+cbXhobAasNA92Nk65
         p0NCSOP9zamkeROAmoQZmudbJbLLQ/RbuvkHBhPJ9gEQkzUVbB5LKxOEjIaFaJZ3tMdk
         IZr6zIgvy5cmULIrPAlmZn913/7GBK9bAgRzyeQ6XhAp9VTXgM91WPg0glen9rvR5INU
         16r8xXCA1fdmi/CbIYTigygcUm/DxiHN/3pgnMv6NG2tCZQvgb4Py6g8v5TyFRQ8AY//
         xsYTg4n60cvRr25h/IN1pAbf3/6vmAdgosds4Atv1ZG0uVbFBJYqRCC7FsRWt7r355LD
         aL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677837838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFf6sFjM9AwS1vxSlfi/rPHVOurvo1lmtYF9mvz1O5Y=;
        b=yZMIePd4jVaYvDI+fb4Rf09ELdQnYolibWMEUmEAaUIoC8QyflZCyFib6NhhW3lYBd
         3l9qFULtZOfJJmK0Lwe4AmVFOIOVAgKpaXLH0inXR/Jw1AXEnW6MaucGiBMQnZcQy1Zh
         FOIqk8e5MwTH0mjLBGbWmuID/PSkxJhP3MqYagkB/xMw9RmeUBi6rici/7Y05sl4g7Vq
         91g+BE9RdpvUCsp1v77U+FkSGFNlhtu2gcNEhUtU15BMlXP3vqQTN1ieAXXyNYNzOeHd
         8BBrEzn9XZiw6fSlxXxcKe0tCtW8nQn0tc2radnbOSIhmkzkaGic3mSQV1MHEsPwIg8W
         K4dg==
X-Gm-Message-State: AO0yUKV4fCZE4rPAcW5wLtGaFMmR8OWsK5H/Kt1/XhwgpuFhCkrG8k8w
        emzDt2YWDeEPIM0k+tmWHgvlrw==
X-Google-Smtp-Source: AK7set8J9wC7WUMYb8YDMvGJL6hOwAih78aKtpILcC4baQe4y2VMOXI3QuvzDyQNzxhwsnc+NGadPA==
X-Received: by 2002:a17:906:db05:b0:8ec:4334:fe with SMTP id xj5-20020a170906db0500b008ec433400femr1347302ejb.26.1677837837972;
        Fri, 03 Mar 2023 02:03:57 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y27-20020a17090629db00b008f14cc5f2e4sm776929eje.68.2023.03.03.02.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 02:03:57 -0800 (PST)
Message-ID: <da483d76-ddba-513b-999e-494b4af49bec@linaro.org>
Date:   Fri, 3 Mar 2023 11:03:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 9/9] dt-bindings: crypto: fsl-sec4-snvs: add poweroff
 support
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
 <20230301015702.3388458-10-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301015702.3388458-10-peng.fan@oss.nxp.com>
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

On 01/03/2023 02:57, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add snvs poweroff support for fsl-sec4-snvs
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> index 688057ec5c97..f08a7ddece96 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> @@ -124,6 +124,10 @@ properties:
>        - compatible
>        - interrupts
>  
> +  snvs-poweroff:
> +    description: The snvs-poweroff is designed to enable POWEROFF function.

Your description says nothing. Poweroff is designed to enable poweroff.

Best regards,
Krzysztof


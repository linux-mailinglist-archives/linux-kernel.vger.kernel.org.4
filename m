Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76C15BBCE8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIRJqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:46:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFDD23BDD
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:46:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so42319823lfr.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=21aUxLHH4VXgjMlvV9m7Z7/X0EZG+kNnGLJcXXOrK0w=;
        b=ojsFkgiYK/Dv76eEBErG7KtJ8odVR/65kpeulrSdhhYWX8kIEKYdw5PNfb7Dp7Dq2a
         q928bdTuwJXy1iq3uNQJ3TAFOb1fq6dbvQMFHpi4SyJ8bVibWpHoor+IaDi7s6hIQzP7
         q69+wQaFjy7Lo36CyBOINyK6v0nCl1lnh/b5CD7DfrupZA40VycjdoJ656EvloixrPXE
         Er5Js45KbtqSR6zdYWlPOmBr+ajUBQUqe05VQO7/NoC2WKsKoz6juWmP1tS5P8BezEm9
         yYEL6ZFUbEiioffY/CdwB7/B+vY35D4FrZog2CJ8LpXBtgfLVUWlcY0PUVPpiggXQ5zU
         quDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=21aUxLHH4VXgjMlvV9m7Z7/X0EZG+kNnGLJcXXOrK0w=;
        b=1rzVt/qc5zp4EAIRF+6RhNv/tws4p+0mE+g9XjvyV8ZKzBj1RqyNslQIISVJyymjLu
         7z5b2bZsoHbyz6LkQq824ZJnkLrhFnllDNtgVwgfzj63t54khaOJbnjTAVY+jtQrP8Bp
         TU6lZBnpisXNwtMffr/NTYX3Tjd7puVTOB1kKzP1XPOxTuZcrFvCg4JS3YvTXc63o9qo
         +XPT6NRs4PmSWJzJjnEUjxQfWkZJkSiQad8zInlDfCFrdb9LISEb+9bP1qsElRaD6t6O
         L5B5QjrV30QXT+sd6ysK8iQv9ykQNltFIRujbGiFaqJMoOf8X8BWoIPbh/VWVxMBWkOb
         ExEw==
X-Gm-Message-State: ACrzQf2RQLrvMYnSPh3IvBRkh4OUZZNcxnv8F+a8r06rvy6aGCrDmWLp
        NtuqlbRF5YMuo5FEVJGN19p4vA==
X-Google-Smtp-Source: AMsMyM77GnrmytRKpKeUnNWN3mHl280lQHxGajtZZSoJ7Z4ejAWff2bBcL4vI9nA4/cAbc9husyHnA==
X-Received: by 2002:a05:6512:3502:b0:496:272:6258 with SMTP id h2-20020a056512350200b0049602726258mr3985166lfs.429.1663494408681;
        Sun, 18 Sep 2022 02:46:48 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y27-20020a056512045b00b00499019c34a3sm4577639lfk.184.2022.09.18.02.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:46:48 -0700 (PDT)
Message-ID: <66c6349e-c841-e895-2c42-4e341abbe525@linaro.org>
Date:   Sun, 18 Sep 2022 10:46:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 6/7] dt-bindings: spi: spi-zynqmp-qspi: Add support for
 Xilinx Versal QSPI
Content-Language: en-US
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     git@amd.com, michal.simek@amd.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, akumarma@amd.com
References: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
 <20220915120750.1424984-7-amit.kumar-mahapatra@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220915120750.1424984-7-amit.kumar-mahapatra@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 13:07, Amit Kumar Mahapatra wrote:
> Add new compatible to support QSPI controller on Xilinx Versal SoCs.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> ---
>  Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> index ea72c8001256..37108bfdcd81 100644
> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> @@ -14,7 +14,9 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: xlnx,zynqmp-qspi-1.0
> +    enum:
> +      - xlnx,zynqmp-qspi-1.0
> +      - xlnx,versal-qspi-1.0

Alphabetical order please.

Best regards,
Krzysztof

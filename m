Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD570602FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJRPfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJRPfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:35:09 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2403844F9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:35:07 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w3so9854819qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0bIa8wyTi8rbAcSZxWhCurl6ZK0Xte2iA5Q836GnBQ=;
        b=dKkNYSYmqsNvyoNglHA29uVahhFDihXll/UUBpziWBkT9xPuazvfnr71TBYlvqe9w8
         XSAikAIB4RkBfh3PZC9NoohzDSUNmPfj4KJoSMIcscWs88HWvGsG6078gw8PY/r++GFE
         xVGZaU/EtYOlFiDBoU0emIo7nr9/Skx0UUA2vZmegdCUpWOBdeZfFpuDiL0YHWYCD/OP
         t1rC7uijzyiN91/i+Gq4ObhWwjFL/GSyvYyuVU2S3c5aEJJgbLdXaUrWV0oVmbag8fdF
         OXeLLptMDmaw6Ty/AUdYhvLiPFQOXYLzgOCII09MUnXq4qYrUrvGq+GDt5DsUyL3A4CC
         jsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0bIa8wyTi8rbAcSZxWhCurl6ZK0Xte2iA5Q836GnBQ=;
        b=Xaxa0Fy8IfaS9VqeLputDBw+4oWNRQxzbrf5W9ndWvKN0zdasxBYBN22hgSLpYKmDb
         xGuPtEKmxSgvq1/V6LbjFTN8kKIXWW/exY3YcDoeymqSwkh4MDLSg+qwc4saAQPXI+Pk
         gyjXiEyjqWc9tU1iauZ7RKBdDSOjxcPcdHkDhtDi0UBcJRFsUMEs+nkhDLhbavc9cuGi
         vQRgJUJ32UL164Xzzh/xT+vy3mjpGQmIPsNFs9SnEjbC/2lDb0W50U373Unqk/MyTCGH
         sCMFXyjVid3egOEWy+y9i0dnUJLirdou2aHZND9+d0cPuqzzNQzMOVcCAyHIKixmeQIn
         g77Q==
X-Gm-Message-State: ACrzQf2+euYkHTZvBMtCKWoQJvQZhLfsHOPgD6ilqD/3It9fhl9owksG
        qSeesrO/eOpF+LxW56r8nBewyA==
X-Google-Smtp-Source: AMsMyM4FoTodLhR6r4cs+duQkTco0qem4q2FGg/JDNLCynJiZ54JLd68bW+8p2Tqy2nqvzgOS5r2qw==
X-Received: by 2002:ac8:5b56:0:b0:39c:db95:ac4 with SMTP id n22-20020ac85b56000000b0039cdb950ac4mr2538109qtw.299.1666107307125;
        Tue, 18 Oct 2022 08:35:07 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id k2-20020a05620a414200b006bba46e5eeasm2787991qko.37.2022.10.18.08.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 08:35:06 -0700 (PDT)
Message-ID: <684c5659-0691-6534-1602-6c0a53e6e503@linaro.org>
Date:   Tue, 18 Oct 2022 11:35:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC v1 02/12] dt-bindings: PCI: mediatek-gen3: add support for
 mt7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221017104141.7338-1-linux@fw-web.de>
 <20221017104141.7338-3-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221017104141.7338-3-linux@fw-web.de>
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

On 17/10/2022 06:41, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible string for mt7986.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> mt7986a.dtsi misses clock-names which are now required since support of
> MT8192/MT8188/MT8195. This change also introduces a 6th clock which is
> now needed for all pcie-gen3 dts.
> 
> i do not know how to map the clocks to the names...
> 
> mediatek-pcie-gen3.yaml:
> 
>   clock-names:
>     items:
>       - const: pl_250m
>       - const: tl_26m
>       - const: tl_96m
>       - const: tl_32k
>       - const: peri_26m
>       - enum:
>           - top_133m        # for MT8192
>           - peri_mem        # for MT8188/MT8195
> 
> mt7986a.dtsi:
> 
> 	clocks = <&infracfg CLK_INFRA_PCIE_SEL>,
> 		 <&infracfg CLK_INFRA_IPCIE_CK>,
> 		 <&infracfg CLK_INFRA_IPCIE_PIPE_CK>,
> 		 <&infracfg CLK_INFRA_IPCIER_CK>,
> 		 <&infracfg CLK_INFRA_IPCIEB_CK>;

Maybe the clock is not required on mt7986?

Anyway, for the bindings:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


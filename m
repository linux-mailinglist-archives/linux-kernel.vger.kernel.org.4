Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAAB65768F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiL1MjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiL1Mix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:38:53 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93EE10FCA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:38:51 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g13so23437123lfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gVWXE7z6V0jr17DL5tWq//fgcFRcs4qyTA+UKWgDDc=;
        b=HsIlFhBTpBa0Btk0oee65VTeaCe8A9pEqSA49U65BZyWdgEnYXS94jkHdMIgggtg60
         JklnSc9C9yt7j+lDbcEW+/9tr2H2gdn6YV7OASRqTiAG0xxofK83LTyiX/2Qc31qv4So
         tVQG4D9uLibKDhsna70XFXMY4wpiUYczQB+aUTNck15N4sU2/2WfbwR7rbUUojOfeFWe
         RsYqPrC4/0JZu+PFhj3bA/VMkCqRW3vztmaoZyFvdLkVzN2uWN3NIG/2G5JWt4jXwDaP
         /e0cpDjxtk2KXtVoC4znhNiN7xC/9YATLseNrRsbeDy1h81qQm4NffaLQVrJ0v2pM7M0
         7x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gVWXE7z6V0jr17DL5tWq//fgcFRcs4qyTA+UKWgDDc=;
        b=CbygDUGC5yjaHUwooX5BC3kvaiotsi6sJNKktFyY84/3CFoa2u31EUbUzsnkCzMCoZ
         Fa3slqkqGJzOMObAEDq6woLAnT3vubCsZzYYOIP9tZyUAPSpcltHYTDxudFXTNpr10s2
         KcAfnu4S1tT2IU6/oF0f4lmOoJgR2vAQWHa1fLOQQuXepFhPLZ06fMhIq9BGwTdj/XNm
         Xe5dPwVrGpXdC10J6O0/jfp2e/3I7BqscjBFf3+MjV1Gb3/j5DX3mojCYEDCD3/uY/8+
         +XfckdDMQyf3SoapGwE2AI5B6x5Q9w0ciVEYbQ0yacFGLBD9H5xB1M5B6Tyt+zzFSul8
         uHUw==
X-Gm-Message-State: AFqh2kpVGhPJdYA4mQVLNaRvptnvKjkw4j9lECTCslIqN6QeXbeutHFU
        U81t/IoK5SGRJVvYbE0y4cJudQ==
X-Google-Smtp-Source: AMrXdXszEivzFZIcilj7nrufZ29e6vg8o/RIJzRWXm9ibvZczGVg5f2m+W9s5+FcsEXwKu7P5zmVKw==
X-Received: by 2002:a19:ca54:0:b0:4b5:889c:f2cf with SMTP id h20-20020a19ca54000000b004b5889cf2cfmr6914060lfj.20.1672231130142;
        Wed, 28 Dec 2022 04:38:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p16-20020ac24ed0000000b004b4f3c0d9f8sm2636938lfr.283.2022.12.28.04.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 04:38:49 -0800 (PST)
Message-ID: <18a2fd76-c708-0c14-2d5c-b771ab8baee5@linaro.org>
Date:   Wed, 28 Dec 2022 13:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: k3-dsp: update bindings for
 AM62A SoCs
Content-Language: en-US
To:     Hari Nagalla <hnagalla@ti.com>, andersson@kernel.org,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        p.zabel@pengutronix.de, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-anna@ti.com
Cc:     praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com, devarsht@ti.com
References: <20221228123655.15384-1-hnagalla@ti.com>
 <20221228123655.15384-2-hnagalla@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221228123655.15384-2-hnagalla@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 13:36, Hari Nagalla wrote:
> The TI AM62A SoCs have a C7xv DSP and Analytics engine for deep
> learning purposes. The DSP part is similar to the C71x DSP found on
> K3 J7 SoCs, but additional hardware accelerators and IP are added to
> the subsystem for deep learning.
> 
> Compatible info is updated to match AM62A SoCs.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> index cedbc5efdc56..846c9c14169a 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> @@ -34,10 +34,12 @@ properties:
>        - ti,j721e-c66-dsp
>        - ti,j721e-c71-dsp
>        - ti,j721s2-c71-dsp
> +      - ti,am62a-c7xv-dsp

Add it in some order, e.g. alphabetical.

>      description:
>        Use "ti,j721e-c66-dsp" for C66x DSPs on K3 J721E SoCs
>        Use "ti,j721e-c71-dsp" for C71x DSPs on K3 J721E SoCs
>        Use "ti,j721s2-c71-dsp" for C71x DSPs on K3 J721S2 SoCs
> +      Use "ti,am62a-c7xv-dsp" for AM62A Deep learning DSPs on K3 AM62A SoCs
>  
>    resets:
>      description: |
> @@ -111,6 +113,7 @@ else:
>          enum:
>            - ti,j721e-c71-dsp
>            - ti,j721s2-c71-dsp
> +	  - ti,am62a-c7xv-dsp

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Wrong indentation.

Best regards,
Krzysztof


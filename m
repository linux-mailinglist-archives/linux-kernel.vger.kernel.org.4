Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4B5EE407
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiI1SOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiI1SOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:14:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB98E9522
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:14:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j24so15240438lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=BrOXUUfC0kL59Y1UmzHzsftxixuWlRc4zXH9J/eo0gI=;
        b=VSPtJ1HnP3Jbl6tzHhrBtDVbSdlieIY7u6ddlkpRFMKUCCOcw7HGIDaUAmIXWou/3c
         YnOj4LVd3/rs+a5y4HRmun7sL5tyZhXB5UeE7+rJCTMiKzTsvx5kU1h32YSeYx7FyOfO
         G3dxhtCZjn9twCnqQpatdGB/n5chgqUuzQA4FzDx+G/OcrlhKSk9MdjysQr12gl0GGUu
         XiaaAZTFJvoJfG4SC+4RWn0Nd/KQ/1aOU7mKQA7vTcQI6unS3Awx2RPk94o6EIr5EF59
         jkrvj3dzNbA97EavqLlKCl/aAveyHXtX9B5yEgRt6AnqvtPjsqu3QQjbx4mILY3gvIa3
         ZIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BrOXUUfC0kL59Y1UmzHzsftxixuWlRc4zXH9J/eo0gI=;
        b=f5U+2PBHMxYX6rFvEbZKTiaEmh4CqBj0ZIsBtIS1cfpE9ZcNqbLMOVpz3MD+r7xGJk
         djL0k1UI0H8t9lRhhOZvg9NXcNVIpvqhJxVQx6FaYAzRUe3fRHntCzFSzE0RfxAru/DB
         YrWg8wHV5Ek1WIvSv5Bp1VTi+k3uSFKvPGp9B7nJ2dWICO8wvbo29poYo1xqC6ZVLHRS
         iELkGQM1b39ifwwo6HdV7f4ih9uDdsisXL2WbYZincR8wsRiyjkiEf7VWgZB4DsujYqd
         Yf2W/il2GYE7r95z1d6w8nXVvtMeV6DPyUJtwsgXFHVOeAzbX79KhNwhtlXoltvC5qHU
         fTpg==
X-Gm-Message-State: ACrzQf3dQ8d12LoOty5rcD5Z0ncKbdSn9AdVjXqEDag8mYsgxJZrOEod
        +H4xvKvInqmt87fDgv9p5TfJrQ==
X-Google-Smtp-Source: AMsMyM6FIcW8vQl/oHQx5+DSxLH/9IFwShQrmQwd207vM7vZlH9NsAILtgDsuEYjcARwnUiwtRx+XA==
X-Received: by 2002:a2e:998b:0:b0:26c:1767:43c with SMTP id w11-20020a2e998b000000b0026c1767043cmr11584534lji.342.1664388854336;
        Wed, 28 Sep 2022 11:14:14 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b00498f32ae907sm539511lfc.95.2022.09.28.11.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 11:14:13 -0700 (PDT)
Message-ID: <bab96626-3296-70aa-90c6-bb639d3c6ad4@linaro.org>
Date:   Wed, 28 Sep 2022 20:14:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH v5 2/6] dt-bindings: display: ti: am65x-dss: Add new
 port for am625-dss
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20220928175223.15225-1-a-bhatia1@ti.com>
 <20220928175223.15225-3-a-bhatia1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928175223.15225-3-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 19:52, Aradhya Bhatia wrote:
> Add 3rd "port" property for am625-dss.
> This port represents the output from the 2nd OLDI TX (OLDI TX 1) latched
> onto the first video port (VP0) from the DSS controller on AM625 SOC.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  .../bindings/display/ti/ti,am65x-dss.yaml      | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> index 6bbce921479d..99576c6ec108 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> @@ -82,13 +82,18 @@ properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/properties/port
>          description:
> -          The DSS OLDI output port node form video port 1
> +          The DSS OLDI output port node form video port 1 (OLDI TX 0).
>  
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
>          description:
>            The DSS DPI output port node from video port 2
>  
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          The DSS OLDI output port node form video port 1 (OLDI TX 1).
> +
>    ti,am65x-oldi-io-ctrl:
>      $ref: "/schemas/types.yaml#/definitions/phandle"
>      description:
> @@ -104,6 +109,17 @@ properties:
>        Input memory (from main memory to dispc) bandwidth limit in
>        bytes per second
>  
> +if:

Entire if: block is usually put under allOf:, so when the list of
conditions grow, you do not need to change indentation.

With the change:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


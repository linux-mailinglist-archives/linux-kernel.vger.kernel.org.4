Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16D96C9C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjC0HmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjC0Hl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:41:59 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C89272D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:41:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so6323405wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679902891;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nMDnDVndzHNxg8IysowsDNshZJLrhOGXhE/oQgMJt/I=;
        b=EsFgBGI6BZ5ZwDAdbcfRIPDxe8eYQItMtqfFw25GhIa7AY+vGmel0quZRkl9QnaAFu
         pIrgEpxLejlsdV4FguN9YPOUkiNJsKDefJ6eEVTDxdXSpGBdrzHmYONRTTODpaTOxrWO
         9m6SdAhLyUB8NGgMoPEgGd8tUkzYAo0TPSDEi1H6HYuuO6T2aA5GjnlHo3JJsm/jD4DL
         EHIsp+4/OVrHhR2WLmOQ9ZiDHKLxSWdS2HMHzQk/YgyjqxYlP/Ddw5wuEvAERzxW6uNp
         CHxU133Y47dv1W2gn7qo2ODdqF5izciLdy4RNlGyx4XSfHI1nUoyaJXmpaJ7Cxj76/KZ
         RZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902891;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMDnDVndzHNxg8IysowsDNshZJLrhOGXhE/oQgMJt/I=;
        b=lVEUAd/g/EG+kWkE+Awkrwv9F449pmBAGobG+IJ2OAhz9xqOoFLFkT3fX9s1W0KbHn
         iag9/mb5Z9WGJ9Hbv2SL/Ax+g45Wz5kzXhi9+O8Q6oLhjKU2krvwfmOAG7nK8AkumgQF
         xf7mKGMFMhmCMY6jnZZkPKoxpSAj6hzdfvPYPbkuxGU4DjSbqooEEPtQ1rn605BcVUK1
         ZO9UGdNlqlC0YLq3XSz/jzeJNaqfqTsKdcUKNQvfLl5Cm3OGhemyBlmKTcOCtFM/DGqX
         ZzscCJtQH4lxeri3ylBgYEFLtcP0mL0QYFoUYIKLklcZ5qGnxOPqQFkLp+VE7StnLNWF
         tg9w==
X-Gm-Message-State: AO0yUKXoPI+KyhFx16ECLOait76hEwKllcCIBcxJgTFowYPSxvQ/mhIi
        22skWcrkteF7ZwmPaAW5X8QWOQ==
X-Google-Smtp-Source: AK7set+XzclimABLgzyAaFqjRJkjXg0QKtHa5QnWiLQJdngamdnCBLbkp2QJ3aYaDYZYaiWLArXVCQ==
X-Received: by 2002:a05:600c:25a:b0:3ed:358e:c1c2 with SMTP id 26-20020a05600c025a00b003ed358ec1c2mr8493947wmj.18.1679902891504;
        Mon, 27 Mar 2023 00:41:31 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id p20-20020a7bcc94000000b003edd1c44b57sm12680153wma.27.2023.03.27.00.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:41:31 -0700 (PDT)
Message-ID: <702f7101-8e1f-21b3-d958-b9653313efa8@linaro.org>
Date:   Mon, 27 Mar 2023 09:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/4] dt-bindings: display: xinpeng,xpp055c272: document
 port
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326204224.80181-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230326204224.80181-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 26/03/2023 22:42, Krzysztof Kozlowski wrote:
> Panels are supposed to have one port (defined in panel-common.yaml
> binding):
> 
>    px30-evb.dtb: panel@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/display/panel/xinpeng,xpp055c272.yaml        | 8 ++++++++
>   1 file changed, 8 insertions(+)

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

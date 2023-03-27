Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0126C9C85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjC0HnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjC0Hmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:42:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1124B270D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:42:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l12so7595945wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679902947;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B5aU9bHzODaK8qjg9M5VSodvgfMkOAX5VGyvS2DpbQA=;
        b=xHrEr7PIQIf09Cr3ey43d9JBP+62zFFkxZKCzSP2+3BFp29qyif4AxPc6xBSj3P7G0
         nMFI2mfhBB/IACWJjyLxQfP/u2IQOQ5PQ+/kAfw/mX5L68QZ7YjYp3iSSSK0GBJM8VEL
         RnLiM9Xpi8nDMk/FhJDsZ/67f6l/seoLgacYtASi9na0MRPgAr1i3q8gi5NeQOQeailM
         otEOfsrgkUm1UZxhRbqlh05HbCUaN/nxhrUTUp/uXMoj0gwH7mIlJ5yRLbOdXHEdJXSx
         pofV4dhqXapsbaL2/5nOzuqkO4C0uRQvcnuTUmr2KHXVnGbIQn/3s3O7cOM9MAgcEzeB
         Qneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902947;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5aU9bHzODaK8qjg9M5VSodvgfMkOAX5VGyvS2DpbQA=;
        b=cg+u8l4eKSt61YQKAmyuavN7P1sutHd+i6dJYQn/5ygtlHmEZOuCHTE8TvEfXvvs8P
         furXA8v85jKoloOL/lKI0FR5i/tc3SGAwGZthnVd2n++YqUR1km3KWH1Vn2PDJ68qoxN
         +qdOemxb2VyazQHR8og61JZfx9GSKol6aP0WlVwLavyIsNbfCA5sjKc9GX++lF60Gi2S
         v7zHlEZ6Da/WRyDQ6spvmVeOTN24Y8dtkoptK9q8XhOJiwJkBUdqOen2zzOeg/os5okA
         q4TQeyJY8c2ci6tsCec1JZ5VwuA1dG4eGPZB2Y8x6219jDAEiJ5rNM7UAgiEd7pvQ7bl
         vd+A==
X-Gm-Message-State: AAQBX9djk6gf+9iRSLkSaoAAMq9jYLw3CJbyrNhqQhPsb9cO4kRx9JSa
        GUuhkB0h+ji+t0sVscY7Pzaxuw==
X-Google-Smtp-Source: AKy350Y7Xtq3GeNICmc/HAEhJPJTRUMyKgTgsk272dxkFzbBWSYpjLumSnh5q86Hp8LTDdGcQEJ6gw==
X-Received: by 2002:adf:d4cc:0:b0:2d0:2d4:958c with SMTP id w12-20020adfd4cc000000b002d002d4958cmr8430384wrk.60.1679902947527;
        Mon, 27 Mar 2023 00:42:27 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id a3-20020adffb83000000b002c561805a4csm24279636wrr.45.2023.03.27.00.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:42:27 -0700 (PDT)
Message-ID: <43e02cfd-8fba-05c9-43b0-cf9382704ea9@linaro.org>
Date:   Mon, 27 Mar 2023 09:42:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/4] dt-bindings: display: sitronix,st7701: document port
 and rotation
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
 <20230326204224.80181-4-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230326204224.80181-4-krzysztof.kozlowski@linaro.org>
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
> binding) and can have also rotation:
> 
>    rk3326-odroid-go3.dtb: panel@0: 'port', 'rotation' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/display/panel/sitronix,st7701.yaml          | 9 +++++++++
>   1 file changed, 9 insertions(+)

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

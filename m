Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591AE7062F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjEQIdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjEQIdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:33:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C621E272C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:32:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96aa0cab88dso64537266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684312358; x=1686904358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWitSHiMOT4coKgFlzLg7KYluG3UUdq8GESJECXOiJo=;
        b=ZDjysRqZkqvYqOiAxYXP5en70O41y4PMGStzeR2KSskajjek6DPKOkN7rwYJADSunf
         bw/b0dQ8vxN88mNng1C3HRksj4InazOzddCCtYRU3momPUP+sFAnmXAoNU5kY48FiI/g
         dSKrBcu34c3eoumV7Z+tutJhpbMl2AEZfDk3tpSxoWNIjUfXYpAQnsbMxziwrIP3izXb
         6+TDNJ4af3oWy2gXIfh4jJTJuJFdLBL13vN5FDJIaQx6uq0oCa9OJHQHDJROELIAUkKv
         oSTSxmW0v2homiGBJnNHwsfCq2eK/xekmVtzWC8U9llLNAEbkWSYIaqWiBpvNAfb+TEd
         8SMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312358; x=1686904358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWitSHiMOT4coKgFlzLg7KYluG3UUdq8GESJECXOiJo=;
        b=KpkzR2pLW/UjlD4YEGqf/7/76MODJabQn5B9YhOZRqS4c/j89nsQnxlkAdmaP5Z4HY
         rOKkL2ZPPf41fxCMs0Y5EmXsmOLQslUx6ikT9vmj8hEXoDNfcXHKiWDXYE3yhQx9pAXr
         6LQ8HY9WV5hCziRw1ZUvNSEob6/CZJ3ecO4p3uXlCkvTFX1tNvA15K4KtmEvHuihLfxE
         1uK1j5R9w2JxP+VWzIHI4tsNixx5WnNYHZEe3LlwEmdQteOFJd97u92BmZ402yvsv90p
         eBNNu2YOzsGyr7+v+i0Wgu3xztlWoITK/wVqNFm+O0QZdJR/Kq+SZw3gmfz2vQmuumXX
         Tlkw==
X-Gm-Message-State: AC+VfDzJjbQoxoM6LL1Yx8+MSQTh4pwDmade5el81VWPX4S1rx4cs8MK
        NKEPe81tD9tjf0femvXqj2yoyw==
X-Google-Smtp-Source: ACHHUZ5lTHcklO65Tbda/84467VNgoKGANYGw+A+KZDBbn31EhEdfTRKaT6JKayUE+IvTUYh+tFpxg==
X-Received: by 2002:a17:907:1c84:b0:969:f677:11b7 with SMTP id nb4-20020a1709071c8400b00969f67711b7mr31440550ejc.20.1684312358276;
        Wed, 17 May 2023 01:32:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090655c400b009660449b9a3sm11955786ejp.25.2023.05.17.01.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:32:37 -0700 (PDT)
Message-ID: <250e0e95-9f34-5fb7-aa5d-61b227dc9cf1@linaro.org>
Date:   Wed, 17 May 2023 10:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] dt-bindings: display: panel: add
 panel-mipi-dsi-bringup
Content-Language: en-US
To:     Paulo Pavacic <pavacic.p@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        robh+dt@kernel.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAO9szn18KsR0c+U8EEY1=xnmsKMxy6SEArMUic0z=aYJDVwWCQ@mail.gmail.com>
 <023f6cf9-0f08-f27e-d203-5ff78faf110f@linaro.org>
 <CAO9szn1EsbuPSRrOW8CLqhp+QUcL=9NE93FAwsg2n3htd_aJTw@mail.gmail.com>
 <97124cb1-4f45-22d5-418f-568f8a68deec@linaro.org>
 <356bfe96-75e6-1c6d-0049-d664e719a266@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <356bfe96-75e6-1c6d-0049-d664e719a266@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 10:29, Paulo Pavacic wrote:
> Hello,
> 
> If I understood you correctly you'd prefer it to be named 
> fannal,c3004.yaml?

This is what I wrote:
"Judging by compatible, this should be fannal,c3004.yaml"

>  My logic is that if more panels were to be added that 
> means that each one would have yaml files that would look exactly the 
> same with the same user.

It's not a big deal. Although anyway why would other panels have exactly
the same supplies and all other properties?

BTW, you miss there supply.

Best regards,
Krzysztof


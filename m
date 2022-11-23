Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348F66362F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiKWPLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiKWPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:11:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F91349B51;
        Wed, 23 Nov 2022 07:11:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bs21so29852040wrb.4;
        Wed, 23 Nov 2022 07:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+DYRTkLQkt5QsUQFkBhyOTw4ineCXo6DjjJscrJFSgc=;
        b=a6cyw71kovfdAiAgG/Pmn3Is0bFtobdtqmKQZVwHwZei0zj4buzNah86/6bkSx8hZN
         CcaVd5gUchTpWqD2YKnTiQoRcyvmf48JeMS46LSu7Q9BrUL4fczKCaj3MHplZnuYQfEa
         z2J3Z3PZGMWNB9Sgol4pLp6h+7qPsTOhfvCZ9GSE1l9u1+7ZGSRbax6FkyThJTth5Q7o
         b9vbjKpu+RepLZhj09l38CIfBMzC69vK7zfGD73f6RfnUPNiyiz7PJiu73xSVq7UUGS4
         x8W9YjKne9o/WZqFiKiwWGkvJ1pbw2uSbyKO2wQApRTUA60nrnolf1LTh/CBx4x0XOXv
         9bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DYRTkLQkt5QsUQFkBhyOTw4ineCXo6DjjJscrJFSgc=;
        b=ZXzXtQPuzqTZbb2JmFw4FGtZTu1C1uJpz/iVk+eZ+LuI+yM8+tNk47pEuUqB/BV6A3
         xX+HAsNENbclk9yHHdtSFn0NsvACWzFl2fbQOhB/39vhjW9oaDa4d4GLsP3Mwq426E5m
         ii7rF+f9zL5DfIhuIXjybUlhJ65/zBLV3ebRsMdv9jJHta2tLKXE435U+zZ4N61Ntfox
         Rnh0lVBDO0FHBJ1gvorNBy7lMil0tOi8lxUXbzVQ2Z+6d1XN5hJntATjvIJ2kYtYGz9M
         nuaIZB4Rl4a1ZFLLdNOcMG28d0eGEXVXw8/j8wv+X066GWJGpIutcBQupgH9BRyLS29C
         u7gw==
X-Gm-Message-State: ANoB5pkZ46pyYoAOkR1D7p9XpDukCutnwtdYHSueFwFL27EI2MHwPmdL
        nz4xPfSCAWeJk0cMt0umb5lrWDmpIHI=
X-Google-Smtp-Source: AA0mqf6QDXovSwze3tv0ycv0Haj3/XbQr1CmC7ICTzDgFzPaqSinUcDrrNIj+ryOtRqBrdJZ7F3JgQ==
X-Received: by 2002:adf:dfd0:0:b0:22e:32d9:e1b1 with SMTP id q16-20020adfdfd0000000b0022e32d9e1b1mr16994282wrn.631.1669216263997;
        Wed, 23 Nov 2022 07:11:03 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e18-20020adfdbd2000000b0022da3977ec5sm16850807wrj.113.2022.11.23.07.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:11:02 -0800 (PST)
Message-ID: <802ae971-0790-9ad3-821a-7faa36bd9035@gmail.com>
Date:   Wed, 23 Nov 2022 16:11:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/5] dt-bindings: usb: mtu3: add compatible for mt8186
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
References: <20221123135531.23221-1-allen-kh.cheng@mediatek.com>
 <20221123135531.23221-2-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221123135531.23221-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/2022 14:55, Allen-KH Cheng wrote:
> Add a new compatible for mt8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> index 80750b0f458a..7168110e2f9d 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> @@ -24,6 +24,7 @@ properties:
>             - mediatek,mt2712-mtu3
>             - mediatek,mt8173-mtu3
>             - mediatek,mt8183-mtu3
> +          - mediatek,mt8186-mtu3
>             - mediatek,mt8188-mtu3
>             - mediatek,mt8192-mtu3
>             - mediatek,mt8195-mtu3

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F7F6990AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBPKEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBPKEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:04:42 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9663A4DBFF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:04:37 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id eq11so2024258edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uHOyQ5lmh44/x0N5o9EsWAl8D2lj1V8oYJTQzd4/iwg=;
        b=bjZQpJ3lzdwQ8hGv3TiVKeTU35vniZY/thIN9btZzz90XUJOLhcN9Z7phrwR7ME7jb
         XNm/51PJRU2HHchyrEc8hwF7cdzv7z4r+93iuikWUBkyxjgFKu3gxT9bjSmgPNT4Pl6d
         Bv2Ws/i4ScQ9647GxmC2sxRX1idbw5LtIJ9cdtmJnoyNduPYEGa5xPI2josYcuT5Fllh
         lsssLoSR0N8rc0QYXHSOHtTtcmeY6toL74u5lem43ZI+jAa7IJua79bHUW3TVpdCaoxt
         wQDDndTj0CAlUME4H68ScsnMzc8nPyAgBhr3Y1qJS979xJeDTQM/S46vbI9pL4tjg+C4
         q35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHOyQ5lmh44/x0N5o9EsWAl8D2lj1V8oYJTQzd4/iwg=;
        b=fqi9AquRebX3I6riyzHc2wHvSQt7tDlJPTwP/6U9lCdunvdFkCadAm5RoaBfjRc72F
         /z/o1lpMl/VS9ydVUcNFZsBPpofKhswEbj7UR964KR1Emk1VTBolZY7P7hZFzGhokhQG
         7OfuFxxL2f8bwr9sKiyceAEGl0y1LwRXC72l6rV8kjw6Dr15iaJ9QiAJQhLdna4LaR4H
         W3drjgaV91qHcPIdq+myJrh5Orl20lc4o6ab6leI83A9mhq/868jEkQ/bOatxZNoXiRn
         f/UaiN+/VI6RoavpRa2tCLVcc+aWZY/t3Qcze7MAG8A3y5oOs+Y+II95fXrCwtmZQcEB
         DBvg==
X-Gm-Message-State: AO0yUKWoSbosUijJVge5hmJXc7wEbHgDFjc0qSeMU2D71/tiN4eXlnG1
        VicDdTR4H6snBizoFOLl7Fhfig==
X-Google-Smtp-Source: AK7set9uWaBpaH1PbK5+K7zWxGk9xtocPZW9k0aRimgCx3zjxnmc6I9YqaLLs+v34zBVzX/5pzScEg==
X-Received: by 2002:aa7:d28b:0:b0:4a0:e31a:434 with SMTP id w11-20020aa7d28b000000b004a0e31a0434mr5546917edq.27.1676541876140;
        Thu, 16 Feb 2023 02:04:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i5-20020a50c3c5000000b004aad8d2158dsm579668edf.66.2023.02.16.02.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:04:35 -0800 (PST)
Message-ID: <485d74fe-bfb5-c55e-724f-304476624abd@linaro.org>
Date:   Thu, 16 Feb 2023 11:04:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: sama7g5-pdmc: add
 microchip,startup-delay-us binding
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de, perex@perex.cz,
        tiwai@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
 <20230214161435.1088246-3-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214161435.1088246-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 17:14, Claudiu Beznea wrote:
> Add microchip,startup-delay-us binding to let PDMC users to specify
> startup delay.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml   | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
> index c4cf1e5ab84b..9b40268537cb 100644
> --- a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
> +++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
> @@ -67,6 +67,12 @@ properties:
>      maxItems: 4
>      uniqueItems: true
>  
> +  microchip,startup-delay-us:
> +    description: |
> +      Specifies the delay in microseconds that needs to be applied after
> +      enabling the PDMC microphones to avoid unwanted noise due to microphones
> +      not being ready.

Is this some hardware delay? Or OS? If OS, why Linux specific delay is
put into DT?

Best regards,
Krzysztof


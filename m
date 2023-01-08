Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E10B6615FE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjAHO73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAHO70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:59:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9B7B1EB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 06:59:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso316787wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 06:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l4M/UpUULlMB/QRDK84kNKvNm3p0JIVteECSWzec3Ns=;
        b=Mdh4xNLK5EGYOgX2nVxEUx5L1UiPB+khVNYaQfPSmQStL1BSuw5IOXtROunniO6+xe
         KMrYehrz4oX+cRis9/L8u/Nq1Yt8UssFdNEOXzUJS7904FSWWjW2b9eZ59h3X1eFICK0
         CivGtb6v6jrgzEm9IUafFiSY/TAVNVQXFFuQMQhQEpRlWyuaTF728gyxDJX0dt/ybM73
         Bd9ZgMwS01+5RgMiGa8EnB6X3S4eovB0EOxkXdn5FtAYKtF211SDstDZFQuWY6zhh4w6
         DsC4qFJZv0MvRdXUqjfW8/PLGRBYba6rjx7x35eck57r9G24WJtGBTokaHGZ3ajBtCSP
         Lw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4M/UpUULlMB/QRDK84kNKvNm3p0JIVteECSWzec3Ns=;
        b=XAMV58nF/dm9i87CY15rfxSpq3181Hh/0jO4LiGftNyGKH+ymrQ72c5+mc/jLOkmz7
         eGYVg6jGE8H3cfif09x6R0bRKDzeXNi4j8C9K55MYE1v40hCBia91jwr/G5fl7f5nUr7
         k5gCa1cERSFLCiExGHFxmITBhWUMrqBAg4KFmE9TpG5I7g0cKOQcvCA3CwnkqzD0+GLv
         XsQhw96A73gC4d6v0rlQHADXWw5XYlNpQo/2CLrbe8qmtzwy+K0/iEMtgNWpQkgvIc1b
         t1JXezgGwB9i2IGLZONW61DUDf1gGKMG2/PAu8FZaFXdC0plO9CaUVJk0jYWtd5YhZBr
         EoqA==
X-Gm-Message-State: AFqh2kqxi69nOnDFEQFS4Q1BA9MhVBqUAExYJhMX+YkZC41eyI3Cjm9A
        gsgXUt8A96r8NLjtIifCxfdn6g==
X-Google-Smtp-Source: AMrXdXu36HW1suA8i90fum2DC1iUwZ6q029yvEEFPy79hWo1C+3IfHGRRRTwWy5zSQkwe5jiynSHMQ==
X-Received: by 2002:a05:600c:3502:b0:3d9:e75c:756c with SMTP id h2-20020a05600c350200b003d9e75c756cmr3336586wmq.12.1673189963864;
        Sun, 08 Jan 2023 06:59:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003d9780466b0sm9203210wmq.31.2023.01.08.06.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 06:59:23 -0800 (PST)
Message-ID: <7f672ee7-7b78-dad9-ca58-2eb4c2c2dd39@linaro.org>
Date:   Sun, 8 Jan 2023 15:59:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 7/9] dt/bindings: display: bridge: it6505: Add
 mode-switch support
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        chrome-platform@lists.linux.dev,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        Marek Vasut <marex@denx.de>, linux-acpi@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
References: <20230107102231.23682-1-treapking@chromium.org>
 <20230107102231.23682-8-treapking@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230107102231.23682-8-treapking@chromium.org>
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

On 07/01/2023 11:22, Pin-yen Lin wrote:
> ITE IT6505 can be used in systems to switch the DP traffic between
> two downstreams, which can be USB Type-C DisplayPort alternate mode
> lane or regular DisplayPort output ports.
> 
> Update the binding to accommodate this usage by introducing a
> data-lanes and a mode-switch property on endpoints.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> ---
> 
> Changes in v8:
> - Updated bindings for data-lanes property
> - Fixed subject prefix

How? It is still wrong. You have slash there.

> 

(...)

>                  port@1 {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
>                      reg = <1>;
> -                    it6505_out: endpoint {
> +                    it6505_out: endpoint@0 {
> +                        reg = <0>;
>                          remote-endpoint = <&dp_in>;
>                          data-lanes = <0 1>;
>                      };
> @@ -148,3 +173,49 @@ examples:
>              };
>          };
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c3 {

Just i2c


Best regards,
Krzysztof


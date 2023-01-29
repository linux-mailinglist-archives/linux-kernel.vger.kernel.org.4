Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146B267FFB6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjA2O7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjA2O7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:59:50 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA572128C
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:59:26 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h12so8906362wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pkYdbcUfukIthtd0r0b7QQIU7hJvHQCUD0UgIfwX48g=;
        b=Rgf5I6a5W6LV986SXUsrBWelksbM0i4FXT1HC97i/SSzvpCaZbPRbBo9DZv/bTM0eh
         dteXweklQFLuPQWCS4LQDxr0mBXcNgzQ4t8Frm3wZfaJ7qJlrlwj6U/54IY1HWdRXAoT
         938j3DbLNIq72jEZPVDOxIw/xTwiIX522fIFHn5Eff19qpTfJMh6hOfdJKvOuJ7zQZB2
         oKw7FZ2nOO0gIL2xnBsFuYW4xj9ulnYFROKpTxPDGJcJuAeW+fVrPvD0biHPQSpoeZdg
         eIpkqPsunRxZnVl3lAzj9u696I97dhkjFd5FQ0qBHqS5Js2fky1dTo7p0hyhJB+7m8bQ
         Kydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkYdbcUfukIthtd0r0b7QQIU7hJvHQCUD0UgIfwX48g=;
        b=OwrS3JGqrlrvs+vsL095G+jlZiXhCJ7jsz7VCXtW2423KpQDUt2r+yMUp0sHTyA0dP
         QowKFqBNbwIfWFrtHA/n9rXhhLVBApaVBzls4Ivi8nqMfim1MBzj9L9VlDCvRpPM/frd
         nGHBzQZUIfJfZAjli1zVMwFHQ8rnO3snIXEq3kVRRQUyIQwGlaOawl1F2cZQYcMJoAfF
         YXz2CXcouaDzZ0ksSUGWQEmvg08jAs8iwbFXw/W5RVQu8gt7RJ8uZjumV79r29wafkxk
         JJF531VqkrQUBLC7b9Hnw4qk5n69duGgi4ixmTdcCqYWR2hTDkR4sqAM7d6QvXDAfgfg
         V4Ag==
X-Gm-Message-State: AO0yUKX4v9EnnG2BbOl5fR4fWddLbfSyrXyJRe669RG86VZAkDYrp7Rg
        qdtBqyDJUAOP0JVFURnvCZrvAA==
X-Google-Smtp-Source: AK7set9lhBibwCPMEZTCkQwTk/Ur2R6HM3k4cpVtVT2vBoRMKmwSGZlH4f5o5iVDq5EyI0dHIaXfOA==
X-Received: by 2002:a05:6000:1204:b0:2bf:b33b:fb7d with SMTP id e4-20020a056000120400b002bfb33bfb7dmr17152701wrx.61.1675004356655;
        Sun, 29 Jan 2023 06:59:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e21-20020a5d5955000000b002b57bae7174sm9217250wri.5.2023.01.29.06.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 06:59:16 -0800 (PST)
Message-ID: <19b4be07-ac5e-b4b6-acf9-621e567aa8c6@linaro.org>
Date:   Sun, 29 Jan 2023 15:59:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] dt-bindings: display: panel: sitronix,st7701: Add
 another panel
To:     Maya Matuszczyk <maccraft123mc@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230129143141.173413-1-maccraft123mc@gmail.com>
 <20230129143141.173413-2-maccraft123mc@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230129143141.173413-2-maccraft123mc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2023 15:31, Maya Matuszczyk wrote:
> Add compatible for 854x480 Elida KD50T048A panel, found in Odroid Go Super and Odroid Go Ultra

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/sitronix,st7701.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
> index 34d5e20c6cb3..dbc92c4e26ed 100644
> --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
> @@ -29,6 +29,7 @@ properties:
>        - enum:
>            - densitron,dmt028vghmcmi-1a
>            - techstar,ts8550b
> +          - elida,kd50t048a

Alphabetical order, please.


Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C876776CE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjAWIxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjAWIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:53:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DDFA5D7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:53:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso4166304wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVf3AvujnaoCN2yeM/Xk1YpwQO0fOjy9SVB0LBEsLLc=;
        b=bQxrDKysn8Jf+5WIaotfiFymNB92cJIdwwBzt79u/JcE88nzW+nasQgxbyFDMwsjx0
         AUbK7OZnD5nW/AzPAC3tsazhFP0e3SHL0N2lEOSr4ew9LBAUI5ICsKESdtuEklDP1W0n
         /SEvfblneK85I0dnEnLSslp9mB2rF89B7+abjlM+1v5zoDWAZ0+wHaNezjnjfSLGauPU
         WEqnwBlZZwDUsZzBjw1mQTTON8hvB19cWqE/JL/OH8RDT+JUBu/KfC0Hn9C4yPP8eA6l
         OJ2ArZCvw7F46bQpFLYs9hquTCI0fOYkjyL8tbm0MyPw/jEX3owOVl1N9LHUk4TFTPk8
         8PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVf3AvujnaoCN2yeM/Xk1YpwQO0fOjy9SVB0LBEsLLc=;
        b=6Pf6lnzryodzbgcA96wyPunUNZPjleJ8952wjIwidQ/c4cwBhZk6rfS2gFgHTxdRTb
         HJuUbKvUg3FEK6v57/lPfzV3EITkbXjS845md8gXmbIFnuEa8KurfbLa5cV58ixS4wjq
         V7qIY47tOoZQ6XbqHjV4kEQW5BkrRaTPVSo0eN6K1O478iYYPCXedijTehKZoesjEhhE
         s8G3zxWyt7GGtXWASJs2kcO4VlKgKwF8KhD5z8r4KO/K3nCE8/NgEVJWt5UhuQrkhRfI
         bgPpR75l1Zt+sFJapyi+jLDY1HbnmCo0myky1ie1yHAo75AsZN3VQhZoELklOh3KygBq
         X6hw==
X-Gm-Message-State: AFqh2krn/skixvuCxdYKNubzNCD3ge+ni+fGDxELL/ifZepYdKlXxo8l
        hUtnW7kO15TlCC+7PTT3gh3PqA==
X-Google-Smtp-Source: AMrXdXuvYhhXjbTCUdMrmc8i/3yBrY8fe6Vzlfg4CABMqtm9bGnF6nkCh6c242EgEpS7IeKE2atK8w==
X-Received: by 2002:a05:600c:3d14:b0:3da:f793:fff6 with SMTP id bh20-20020a05600c3d1400b003daf793fff6mr23044032wmb.16.1674464015780;
        Mon, 23 Jan 2023 00:53:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t13-20020a1c770d000000b003db0ee277b2sm10091201wmi.5.2023.01.23.00.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:53:35 -0800 (PST)
Message-ID: <bd5dd7b9-7704-ec40-2b42-8e3dfdddb7fd@linaro.org>
Date:   Mon, 23 Jan 2023 09:53:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/2] dt-bindings: lcdif: Add i.MX93 LCDIF support
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
References: <20230123072358.1060670-1-victor.liu@nxp.com>
 <20230123072358.1060670-2-victor.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123072358.1060670-2-victor.liu@nxp.com>
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

On 23/01/2023 08:23, Liu Ying wrote:
> There is one LCDIF embedded in i.MX93 SoC to connect with
> MIPI DSI controller through LCDIF cross line pattern(controlled
> by mediamix blk-ctrl) or connect with LVDS display bridge(LDB)
> directly or connect with a parallel display through parallel
> display format(also controlled by mediamix blk-ctrl).  i.MX93
> LCDIF IP is essentially the same to i.MX8MP LCDIF IP.  Add device
> tree binding for i.MX93 LCDIF.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


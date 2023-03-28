Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE4D6CC2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjC1Orx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjC1Orv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:47:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CFCDBE5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:47:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r11so50768112edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680014836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnwWe//I3aGEnkQFyYOJD42VZ80LiNeGzNHcqcdNWxk=;
        b=xLWW94Fh3SouJo6RYcN6ZAUYDwcU/fFoXXMyCrdwSs108/5TXLZbGQeruybKfGJv8L
         agSnbZbCQY3oQzfIwW+FG3F6mHONakN9PFs7eIyuYXPpyZab8FLY9TIVaz62zi4I5Adt
         rqzaY1TsWbEDMWIyjSM504H2iB9843jEXSxccgvr75l+KW4b4klRU4FNbQDCMkCwQsLI
         3wHmXn25B/ozuos6Yn3fZ6LQ54fl1jNJtqpf8+FL3ae0B0eZTXQ9Qu7pjVZVm23Ajh+j
         9Z/J9fu4ZHGXWveDL6p/2zPgGHWiGsNVuEKczi/Ij1ivOGETHhNhPvzSx5xpHd3Pkrk5
         4Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680014836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnwWe//I3aGEnkQFyYOJD42VZ80LiNeGzNHcqcdNWxk=;
        b=NhgX8RLKvfjWBoflo9/28GOFqvnDafiIgd59/WiLcHN32uA/0/hWOV5v8vMVB56yP5
         Ig9+1+WYnvW5M78HhVgXsHAXXLddwnRgab6zbSecQ/QW4THv9fMezm5dEf/c0cqC+baL
         f+VGtJWijKvAYVQ0AWBMZa19xXZtSCUn0vw0SeHH++yY1dVmZHTIR0kzZUSJjzB+ac2P
         eh5U2S1rDdpo4mp8LPT8j96p8EZU744T7816rP9FwnrBbgmmey7ORe+ZYvhM2nEdgDeo
         LfASebWS+9Mbzz8DBUmNRa+pdF1DGkHPAKgW9cfF+KGSGqqIsnkMD0NqWN8fWhuAjLMP
         5m9A==
X-Gm-Message-State: AAQBX9d8Jd6db7KQmMcoDEbUNj+TZWzLV3dB22I5Lts6Vu6pQnCbsrtr
        0IzlAAHevoy5QKCy4VK/UNdcag==
X-Google-Smtp-Source: AKy350YHGGpXTOTahvkLd4WAr/S8rNxbHzVhX/AXHE6j4s6BwHIa4pHDj+2AvIMlrvwVolmuTW0HpA==
X-Received: by 2002:a17:906:1d43:b0:92b:6b6d:2daf with SMTP id o3-20020a1709061d4300b0092b6b6d2dafmr16428068ejh.77.1680014836716;
        Tue, 28 Mar 2023 07:47:16 -0700 (PDT)
Received: from [10.105.135.205] ([88.128.92.162])
        by smtp.gmail.com with ESMTPSA id vq2-20020a170907a4c200b0093e9fb91837sm5424879ejc.76.2023.03.28.07.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:47:16 -0700 (PDT)
Message-ID: <806c881a-3343-9ced-95e6-13c3074423a4@linaro.org>
Date:   Tue, 28 Mar 2023 16:47:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: gpio: fsl-imx-gpio: update gpio-ranges
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
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

On 28/03/2023 07:29, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> one is not enough for i.MX8, so enlarge it.

s/one/One/

> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


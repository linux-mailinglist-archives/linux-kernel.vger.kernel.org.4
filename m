Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC686AB888
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCFIkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCFIkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:40:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A917AB9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:40:24 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p26so5077607wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678092022;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CI8nOCYcir+PVSzh9VSHPuyemxYicoPMWdGxXglPvJE=;
        b=fcqVpgvcb0JcmdIK+bIh331ssLKohV0jD6Zc63KVmewA51pi857VjnS+H8gKCW6Q0b
         m+ChcOgmK85mK4HwpOg7rnph2SwjcPjZgq9Paue6xGzR1aAf3zm3uMayYjmfZGL7c75D
         vBpfS5apHqfDddRQcBofvsL7K1CcISrAcsHKdGBxJQibrOYlsVc+KWF24aipy1eIfEC9
         UEaDd1f7ru1ZkHunggoN0Ar3VlXUXaqE5fn3zZiY+di9fymkJ0ubkW8K5ASNc0fhq6RI
         dewwExDuupL6aVwNXe7pRhdxYhn4N8FlMGozm+duNbaIkGTSpVgNEcVEjzPTdtPEB2a9
         xYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678092022;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CI8nOCYcir+PVSzh9VSHPuyemxYicoPMWdGxXglPvJE=;
        b=rg9lDiNijjymipM/akFEfKvB3NO+SO6HDv2SGKj4SnRpPGTXbBPvDTuLstZ6ERjOtK
         0N1/H/iClfXHnbyuCiWCEcUg+OeRZMXjB0a+jxQspkovnTMypItOzeFP2yUBdaKPrIRx
         Cm0cx6eWPDIwfiD1rV4oZPjg2Nq5Vh2kR61AcI7zy+T3HfbTt9ZNaf6iLW9oiW1thdFc
         Jo9b29sIjS8KgMAMKbFER8wXaQyFtYSKPEE/xWpXA49oxPHQSXDFZd0gV9all/e5fsjt
         8hoBIMul/o8utN5XdJvFOGcFfv4OYLW1DFvE52sqW+EmquFH3SER5PvHOK7U6X2x+uPD
         WNvw==
X-Gm-Message-State: AO0yUKUVzA49Uimsa/sh36+0Rrdgx3e96BSnJOcopOSHMHALPnuLOey8
        CZO7f2cVikNhJnF/NhPCroXuHQ==
X-Google-Smtp-Source: AK7set+HiklQ5Pj3Ecu5ls0YxiVIUf5iWSejsV4jU3r9p/lAti/h36lJwAbNeyprI3tPfy7n/lOkag==
X-Received: by 2002:a05:600c:1914:b0:3db:3e8:feca with SMTP id j20-20020a05600c191400b003db03e8fecamr6270273wmq.15.1678092022624;
        Mon, 06 Mar 2023 00:40:22 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id e41-20020a05600c4ba900b003e1f2e43a1csm9211195wmp.48.2023.03.06.00.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:40:22 -0800 (PST)
Message-ID: <3db5ae6c-a3f1-b64a-b605-4eac32fb4086@linaro.org>
Date:   Mon, 6 Mar 2023 09:40:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/3] arm64: dts: meson: gxbb-kii-pro: device-tree
 updates
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230210170721.1285914-1-christianshewitt@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230210170721.1285914-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On 10/02/2023 18:07, Christian Hewitt wrote:
> First we sort nodes in the current dts and remove some blank lines. Then we
> add the remaining bits needed for Bluetooth to work. And finally we add the
> AIU audio card to have HDMI and S/PDIF audio output.
> 
> Changes since v1:
> 
> - Add reviews from Neil
> - Drop unneded 'okay' from audio patch
> 
> Christian Hewitt (3):
>    arm64: dts: meson: gxbb-kii-pro: sort and tidy the dts
>    arm64: dts: meson: gxbb-kii-pro: complete the bluetooth node
>    arm64: dts: meson: gxbb-kii-pro: add initial audio support
> 
>   .../boot/dts/amlogic/meson-gxbb-kii-pro.dts   | 83 ++++++++++++++++---
>   1 file changed, 72 insertions(+), 11 deletions(-)
> 

This doesn't apply anymore on v6.3-rc1, can you rebase ?
Thanks!

Neil

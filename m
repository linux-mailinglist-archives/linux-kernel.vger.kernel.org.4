Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A19F694E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBMRch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjBMRcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:32:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4171CF63
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:32:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a2so13057784wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4PcfKaxRmL7zaCKK1nGyLbHIr82PFf8TM5OtSq5QjY=;
        b=YmEEeWgCK7MSOIeLFerVvG68/F8gyBS+Vs+WFrcAt5YbhWGiGuNIHZVpjIeAthRfAa
         f1HoUJqXlIJZBiLX10Xjj3aL4XpJuX8it63ohN8TVv1AhzfE27z0s3Vn++4f0DRlouyH
         872wY7Qz4YPwRQqHdJt68n2B5P64oivO0ex8MirMmZZwtMWWUQ0Tw7LhZWG3+pRXVmLm
         QYGkB13xGBkVb1zPvGGFY9XO+XtFMM1e4GhIb8gucWbdgggZnDi2RnXy931s4CfcMizE
         X1pVV/RWdHJvNJNrE2kTGGmZaAd+iMzvPs9gGPMPZCr1sR8W6HNhsYamRk734kf/xUUU
         TXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4PcfKaxRmL7zaCKK1nGyLbHIr82PFf8TM5OtSq5QjY=;
        b=MvHvT8ItfQSTj/CPOn4FoAgEeq5vzJPJpz+vQlAkmn+gwvV7FzNUPotPYbwhumXzXx
         k1lnAO/dUMT14KVQ3GPLsmWK2XkcVvO6in0z3FLTz4LOoQilSJi8MI+wfdOB7ab0tyOc
         vRdlFYHhjLkvFQ7mbpZewiumFvUj+6EHr3FHL818NcptbBgNO88nlAfbzbuM0Sz/LIy9
         9HLy4R4QxFHPYVtSJea4aqscDzjPTCPhSQGTv49pdykwfceSjknc6XKghDCG/A1s8+Ee
         iaHgX/4C+J2uu3VPmuFfwL1jpjV+W2FjG0pDC+fP+HYaLcwkNT6lt0s8Kk5EOz0bDTDk
         EILA==
X-Gm-Message-State: AO0yUKXWtoSc7BISSQ2TDdyoNaieUJQbW7B+PUae5G+2HcQZrmWUjwBb
        dVhAQYzJfOT+1KkbaErZiv5gHA==
X-Google-Smtp-Source: AK7set/bbSpFpv0+vU9038RpP1C1S2nRM5ejGZK+qdJ9AF+vxKYu0VTMlnJ7ID9TiDTlZEZRX5Xo7Q==
X-Received: by 2002:adf:fa83:0:b0:2c3:ea86:974e with SMTP id h3-20020adffa83000000b002c3ea86974emr20936235wrr.46.1676309547671;
        Mon, 13 Feb 2023 09:32:27 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b002c556a4f1casm3987926wrt.42.2023.02.13.09.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 09:32:27 -0800 (PST)
Message-ID: <9abac641-73d6-7457-4b63-c25666e536b6@linaro.org>
Date:   Mon, 13 Feb 2023 18:32:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v5 1/2] mips: dts: ralink: mt7621: rename watchdog node
 from 'wdt' into 'watchdog'
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
References: <20230213120638.850612-1-sergio.paracuellos@gmail.com>
 <20230213120638.850612-2-sergio.paracuellos@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230213120638.850612-2-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/2/23 13:06, Sergio Paracuellos wrote:
> Watchdog nodes must use 'watchdog' for node name. When a 'make dtbs_check'
> is performed the following warning appears:
> 
> wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0-9a-f])?$'
> 
> Fix this warning up properly renaming the node into 'watchdog'.
> 
> Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>   arch/mips/boot/dts/ralink/mt7621.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA5367172B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjARJMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjARJLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:11:06 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE826D6B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:29:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z5so32049234wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=caKf+QEHqFSWMTQRDg3esNGYaBBpYdAgePw5YEDb1YY=;
        b=QXEds+wcKF0mA18VdlKd41gB4WEAfFlmNGY077Sg7tSGw0iCf+b/3Mgy0qxPuglwOD
         ALxEJn5k0VJdZcqkOtdP4NTHWQxaTno9PFUWj48Z16CXsqUVkHbyY9j+8YpY4QrOoi9z
         Gw6EnzCtxvziWHag0k17ZjuZrhyhazWbgLe9ADibtfAoEkuovd/rT+rqxrIGfVr7QfEm
         PZQUrixZ7oCPM2n6VmhjlZ9BGv6nWE6hInMFWcKQu+aCH4TuFE8Az/P1mFkhTHLMmcxc
         7Uh7hCGh7Mwc8Q9CgZJHg8VS3we2cnafsmkU3R+6aLbhl/dE9+KboUwgJjFWiHbKwL4C
         ZwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caKf+QEHqFSWMTQRDg3esNGYaBBpYdAgePw5YEDb1YY=;
        b=BXqa+Nz99ab6bETefKdykIUaNM4ek+GJfP4LfjdcXEliPMLKxpiE05l6omds3uMkF2
         B6QEOaXzxU0jWQ+QenVPh0vdpxQQO6ILiUR3pv1BzmAjmYNz3gwdXyWG7i/3spFINg9Z
         PK1kWY23Ri74Aik1pTFZT7xK6ylvYdB+Lxwf1m3NjgkHsluxShURhxq/6OTMyuEuWYWM
         Hm+tIrA5Wm/boXFroZQim4U7O2tBHdNgWuOVFi5+dPbRD15PvWhN9pvew78kIEXJ1chE
         +NuGVBGnhKRbRVe1GPmrF2+FxK4ESsSPhRgQt1xfXqJw8WkD2DSFbc+mBDsJAtljF7H1
         o/cg==
X-Gm-Message-State: AFqh2koaouKFPrJMMvTe819NE2qSXZ4dKtD+XeY5YqIkGR4bwvDp8N8A
        Iv1xdEuja5VRb+4CPs6LdBktxg==
X-Google-Smtp-Source: AMrXdXsCleOnEX0pX0Ewi5xxAsal+1ms6kKW3o1DU5hZLa/dJV/l8ofYZ1a6VIwT3FwX4iLDL0zAPg==
X-Received: by 2002:adf:e38f:0:b0:2bd:d76f:23eb with SMTP id e15-20020adfe38f000000b002bdd76f23ebmr1454296wrm.29.1674030578937;
        Wed, 18 Jan 2023 00:29:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:37dc:5071:959c:93e4? ([2a01:e0a:982:cbb0:37dc:5071:959c:93e4])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d62cf000000b002bbedd60a9asm24987808wrv.77.2023.01.18.00.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 00:29:38 -0800 (PST)
Message-ID: <72214e57-74b3-7bba-61e5-ee727f4a32d0@linaro.org>
Date:   Wed, 18 Jan 2023 09:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 9/9] arm64: defconfig: Enable USB onboard HUB driver
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230118044418.875-1-linux.amoon@gmail.com>
 <20230118044418.875-10-linux.amoon@gmail.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230118044418.875-10-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 05:44, Anand Moon wrote:
> Enable the USB onboard HUB driver, used on Amlogic boards.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2: - none
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 851e8f9be06d..42c3528a2473 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -923,6 +923,7 @@ CONFIG_USB_SERIAL_CP210X=m
>   CONFIG_USB_SERIAL_FTDI_SIO=m
>   CONFIG_USB_SERIAL_OPTION=m
>   CONFIG_USB_HSIC_USB3503=y
> +CONFIG_USB_ONBOARD_HUB=m
>   CONFIG_NOP_USB_XCEIV=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_RENESAS_USBHS_UDC=m

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

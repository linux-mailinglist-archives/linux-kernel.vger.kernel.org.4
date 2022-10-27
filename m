Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7360FB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiJ0PAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbiJ0PAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:00:41 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD057AC11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:00:39 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id mi9so1513202qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBHDI3Ai6tJ/2wSsx3a8pbGEwv3D3cNXDPZBpWeFWJw=;
        b=JwsNdMMMJdZSDa+37FVxiNdJIjvu0HSsnrTpAxsDAzXg6WbZz/g3kffdckqKOcpR4f
         T25EG864kVLWIdpAlgIFWFOBgIoPspfWEFz2dJGFzN6Y2IqZ/bGdoT/k44Kv254AGFEB
         YhyKxEzhTGJ5sGl8AJ5oWgge02zBjn5NFqKJOD+tNnUiHlMgXCNDLtynq4c149uUO1QX
         mjM9OhLcd3CXF4GzmN8aEkwHfcRpvT+UfdXt3FbxqPoHZZ90/s4LVDmJ762hA4LFYhru
         HHYMkFss7u+k/KdOLbq82L1Z/ee+MvJLlUXuhJ8YsSH6Lial5ZAqZ3yueqeNCeKlLSea
         uYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBHDI3Ai6tJ/2wSsx3a8pbGEwv3D3cNXDPZBpWeFWJw=;
        b=f0ufbAJGBsqGbpa3mYZ9WyOcSMrfXLUlWAMinhf7sLM41pj/8qtVH97Y3+XvjnfOxV
         ueJonauE4xyVzloyew8++fZYnQtr9IublVzP06eIOcJ1osPLJ/HORXCtlWZXyDdOTM8+
         DG8KRwugJkSjPf7OgQKdxs2vf/wqm25+1IoWzOvxxQbm44hHfFSS1SBluuV+kA5wjR83
         bGh1/vGqcWdh+0lSdxvt/OPi5yOMf59VpqwUpc58uANaYZOCaBaj0b925RejUeHOEtNz
         wSxss71NM7hHuKDuvah49HVyF+zNYgjGV2PVkM0/6C4sHBuVIk0OXaFf/i3H79nGq2Pl
         dz4g==
X-Gm-Message-State: ACrzQf0x8JOD53hDZDPQ3aamlPR5NHTN2SoQgWmE/BYbCcxA1cjvXJfV
        7lah7xMx2OrWwOWSVo361DOZmg==
X-Google-Smtp-Source: AMsMyM47Cl5/WRHYlqSCVqKZWdt9kqanDgXMtXRMfaHpIxswrzLr7hXGDI7S1pmPhzhOg+w0VKv0aQ==
X-Received: by 2002:ad4:5ca7:0:b0:4bb:97ea:27b5 with SMTP id q7-20020ad45ca7000000b004bb97ea27b5mr6506429qvh.104.1666882838858;
        Thu, 27 Oct 2022 08:00:38 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id bl24-20020a05620a1a9800b006ed61f18651sm1123874qkb.16.2022.10.27.08.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 08:00:38 -0700 (PDT)
Message-ID: <00b1b451-5c0f-0749-de80-4b9eacc0b5fb@linaro.org>
Date:   Thu, 27 Oct 2022 11:00:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/3] ARM: dts: rockchip: rename "haoyu,hym8563" rtc
 nodes
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <f7127f87-05fd-5e20-eb2d-a3fd04674229@gmail.com>
 <84f14b40-0804-9734-963a-31e200687a8d@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <84f14b40-0804-9734-963a-31e200687a8d@gmail.com>
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

On 26/10/2022 19:00, Johan Jonker wrote:
> The "haoyu,hym8563" RTC node names should be generic,
> so change them.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm/boot/dts/rk3036-evb.dts            | 2 +-

Also done.

Best regards,
Krzysztof


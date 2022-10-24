Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0434F60BBD3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiJXVPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiJXVO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:14:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCFEEE0A7;
        Mon, 24 Oct 2022 12:20:18 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id bb5so6193204qtb.11;
        Mon, 24 Oct 2022 12:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOSW4zp7h0M1kGzDu+VDLbhY1Nz07dzMROKp50qg0is=;
        b=AOsdx80LfH0rCtKsPduGSBeAAxIc0bD6B2tviT3zmM+U5YoRbN8c0gOYVd0CqaCm0R
         9sdbMCqObzbNVjBFrKG8I0+eVd2H2FwJ0ymNtjpf2M0AjWx22inkKmxb3tQjU74cM15b
         +hmEc5wUnlFI6uHvObJbIf87xVHZj9gMvGPUiOOfw71fYhaAeMLxMVueGZq5rDcLWPyD
         mfoz8fiFccldajFBXFkoOgzXt56FOgBas82kcOwyjlpHlYPY5SZY43gcM6gWt1ESSFyX
         BOMTikRXAQ2UGexI13xvm3JaCj0SWJ1SdV+mS3NoyABicdm7SaX0mTQp9sYXE3MaVmx4
         XD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOSW4zp7h0M1kGzDu+VDLbhY1Nz07dzMROKp50qg0is=;
        b=ZU3bX7sjn2wXn/Uqky5hrc4Pb//N0h7TcQsKoqWSHnunUIpJq6bpMybFmmKNDz3l2B
         ummNcQK89nrfolkmYhqHhCuWIxERWtk9jVVSyMzg4j0y3V0Po3ggp0SfywV3uBFUeWbI
         mBPlx9AqNIg4X5KKBukJFr0w9oT4UKx/nY+YQhQy37YZn2slH/zH1Gs5PhAeFoB81vdE
         8TRcf2vI4vpQB7mnPCgABg6sccq65j1eTaNfIuZOiQK0/I34sOcjxo9wfhhull1pNXsa
         pGiANE4ypN8WeKsxpRUKZkti1XhQWkgoHUdyEa9mnO8F9HtQn9tnj6vx7Zt8fGZI5QI0
         Poxg==
X-Gm-Message-State: ACrzQf1nYHBwpPaXGka+1LgsPuQL2gD/koCZ0hlZCoRMybKp1kVV1TEm
        i6mnBwx9M7vWmYrOaVDSf+g=
X-Google-Smtp-Source: AMsMyM6AVe+NA415k75JCzANA73liFiHt+KIKB6eDL9eiBKdiUkrgH4qwdfMVkDalSZWj5rT7ZL/tg==
X-Received: by 2002:ac8:5e4d:0:b0:39e:cc0d:3428 with SMTP id i13-20020ac85e4d000000b0039ecc0d3428mr10980479qtx.44.1666639158575;
        Mon, 24 Oct 2022 12:19:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b24-20020ac84f18000000b00397101ac0f2sm432651qte.3.2022.10.24.12.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 12:19:18 -0700 (PDT)
Message-ID: <17868eda-d450-8780-18b7-e52af86b3d3e@gmail.com>
Date:   Mon, 24 Oct 2022 12:19:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/7] firmware: raspberrypi: Introduce
 rpi_firmware_find_node()
Content-Language: en-US
To:     maxime@cerno.tech, Daniel Vetter <daniel@ffwll.ch>,
        Emma Anholt <emma@anholt.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>,
        linux-rpi-kernel@lists.infradead.org
References: <20220815-rpi-fix-4k-60-v4-0-a1b40526df3e@cerno.tech>
 <20220815-rpi-fix-4k-60-v4-1-a1b40526df3e@cerno.tech>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220815-rpi-fix-4k-60-v4-1-a1b40526df3e@cerno.tech>
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

On 10/20/22 02:12, maxime@cerno.tech wrote:
> A significant number of RaspberryPi drivers using the firmware don't
> have a phandle to it, so end up scanning the device tree to find a node
> with the firmware compatible.
> 
> That code is duplicated everywhere, so let's introduce a helper instead.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks for re-ordering the rpi_firmware_of_match array and avoiding a 
forward declaration that I was initially confused about in v3.
-- 
Florian


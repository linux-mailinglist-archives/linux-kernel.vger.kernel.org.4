Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36560ADC1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbiJXOd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbiJXOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:33:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B103DDA27
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:07:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p6so8377501plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OcQnpNrMCokOqxXnkt75dzs4Ohw6MxbO8Z8Y+5zQ3L0=;
        b=lsW78Y05ToEn2ezNMb5iKS1GK+yziVNItOS1OsuFjh06YNV50hRM5EbNW3X/9fxRej
         x+N81HdgWrdNeTNlQetNQ9oPCbReiDgYkicaMV61HvcMoqUveOBvAarP2zB+ZlM/b75M
         MuqooHMK2t6plQbSl3NK/SBgIfFOX6c9iQb6/pLxePx7ezGTvtugXqVMWgIDbSoAJYts
         e/Gujh15O0wOFlI8nO7dTFvav/96dH6tmx8WGHKl2g+owsk+WHliWl1DAADVamFJ3Lut
         E/nk3rF2r0vGaF88UcCthhI+8J92MfeGBTkc+I5ZqBKDHTyoPBQZpe8a7OxBVhpZ3uMP
         +ELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcQnpNrMCokOqxXnkt75dzs4Ohw6MxbO8Z8Y+5zQ3L0=;
        b=uh6xtKw9ggyIulGFiWI5uxcRNlDBw2j4avqjmIAbqf3AW50741LqhqHV8T9tMxP/FC
         08WK2Mr/2sZOUIkzdL05q6OC1QHyvDY2hshFksOHUYiSyaAGbj9hIkHIWieqzl64DzbF
         daxnO4uQ1S9d+zdX4fjQgLPVuNVBiLQMmGKEETGJH8+pFSKan+5DIVwo8bnUcW9QpcHp
         eeD1I5ckBuFoJ/87bySCdJa93mD1wn73m/1TgKbXJaA/XLSPIQxbXKTbI4RsHcwp3ja7
         kCMk2iYj/4fp+69afZMhbsxGDdJBT620BqcCrUP+P0wwpX+1tOj7wZ6463P0fuSsfEEo
         WRxw==
X-Gm-Message-State: ACrzQf1cYGW/CEg/SUG4VruvsCW0dfo8fWttPyk/exGeywsnwc6BIQlz
        XkUUWjz2iOsIF8JSl1N5WsEgJHBQrYEXIQ==
X-Google-Smtp-Source: AMsMyM4q59j1NCTZB29qs7JDeTz2KUourBJ2N7k/9TLfVV6zFdyoDAZWdY3ejaHW41bYP+9DswpqJQ==
X-Received: by 2002:a05:6214:301e:b0:4bb:734c:9e9a with SMTP id ke30-20020a056214301e00b004bb734c9e9amr3358856qvb.38.1666614701801;
        Mon, 24 Oct 2022 05:31:41 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id q3-20020a05620a2a4300b006bb8b5b79efsm15140866qkp.129.2022.10.24.05.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:31:41 -0700 (PDT)
Message-ID: <68ef3154-3659-1730-34be-8b1bd538b784@linaro.org>
Date:   Mon, 24 Oct 2022 08:31:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 08/21] hwmon: remove s3c driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-8-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-8-arnd@kernel.org>
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

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c adc driver was removed along with the s3c24xx platform, so the
> hwmon driver is orphaned and can be removed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


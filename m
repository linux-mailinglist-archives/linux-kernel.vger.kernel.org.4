Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553CD6C8F79
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjCYQeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCYQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:34:22 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492474C24;
        Sat, 25 Mar 2023 09:34:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a5so4405031qto.6;
        Sat, 25 Mar 2023 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679762060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppTu8Aq115OftKgYz4qQb5h3hyK+WpzWrSbu8/+da+E=;
        b=SfEJkkjplPc0M/U6L0RVd/nsGkpjOymaXn3fxDJnXxIhFyHWA0dbVfnk8kQIPeLqhU
         FdK8aK14/g63QtCjIsmNhEZ/QrphJaboXpICM/0m7Ci7BVEfRayTfL55qWbkZK1gUUww
         yWwuntWp75+glUATxD6mQZn/T20Ey7IisOu8/ZMGWQ3ZC/35IPL3eIwjXu9Dh1v2BU52
         O8GxN8pFWIgg18Di2CdSB+9fxPZZ5AU238WIc74VTOc11zw5//l/NIhahFwSWXquvxHz
         ZxCb6X3r5eH8GsD0e+QJvDzUep6V6pjRQXvLgnniGiGx7W5gNIgOEm25ohZgUpfyUy7E
         /FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679762060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppTu8Aq115OftKgYz4qQb5h3hyK+WpzWrSbu8/+da+E=;
        b=zXIdblq9VTO2DgW6f9Uqs6cOHqCdlCCDaX8+UdnnnNWhPgQ7qjNVJbpdlFaGncHrQx
         +zU8Q8M6lYUCJ7SzSDYfOlPABli9Svle2NQlEKR16fB4LQQvCybtPsJvWnqBt0rphhdE
         GRH44KKUPPMnm0LX3pxXXlBRtvF+5Vae6JcVqsgeC8aeJiPFqbEvIrQy0C86YHdu7qvD
         LnpXX0dpPnSFmEjgWB31oqeeyGHClFwI4ZDMkgXDQnJscEYfmDePcOHKJzzyEgOuEDIy
         61Dq7cFE4b4AJIOYmluxyHpjrl7GpVDJmEZIRqb7T7Lqir+A1RvmHsWInNoPWBdaEvR9
         lQTA==
X-Gm-Message-State: AO0yUKUsD9SCp8ajrV66rohnCDfvTrUuh8S72P6m6llprv1cmXEgF7jY
        T7iN7QDEy2XJZ47nIlnZAZJrIC2I6m0=
X-Google-Smtp-Source: AK7set9DDmnGxIIWL9jDjVAZRo82a9+0IyZUtT1054DVmTxwFhOAtrTPMz8KSvZF9QeGSMElrRoUSA==
X-Received: by 2002:a05:622a:189a:b0:3e3:7e6b:50c6 with SMTP id v26-20020a05622a189a00b003e37e6b50c6mr12020852qtc.65.1679762060389;
        Sat, 25 Mar 2023 09:34:20 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id g1-20020a37b601000000b00743592b4745sm15122161qkf.109.2023.03.25.09.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 09:34:19 -0700 (PDT)
Message-ID: <81ad0473-dbe8-763d-2865-7153228d3f76@gmail.com>
Date:   Sat, 25 Mar 2023 09:34:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] leds: bcm63138: refer to ARCH_BCMBCA instead of
 ARCH_BCM4908
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Cc:     William Zhang <william.zhang@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230307082936.16631-1-lukas.bulwahn@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230307082936.16631-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 12:29 AM, Lukas Bulwahn wrote:
> Commit dd5c672d7ca9 ("arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA")
> removes config ARCH_BCM4908 as config ARCH_BCMBCA has the same intent.
> 
> Probably due to concurrent development, commit a0ba692072d8 ("leds:
> bcm63138: add support for BCM63138 controller") introduces 'LED Support
> for Broadcom BCM63138 SoC' that depends on ARCH_BCM4908, but this use was
> not visible during the config refactoring from the commit above. Hence,
> these two changes create a reference to a non-existing config symbol.
> 
> Adjust the LEDS_BCM63138 definition to refer to ARCH_BCMBCA instead of
> ARCH_BCM4908 to remove the reference to the non-existing config symbol
> ARCH_BCM4908.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

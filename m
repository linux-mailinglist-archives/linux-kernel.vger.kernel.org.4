Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43D96BBC44
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjCOShf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjCOShb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:37:31 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2FC5C121;
        Wed, 15 Mar 2023 11:36:57 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id qh28so1017620qvb.7;
        Wed, 15 Mar 2023 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678905395;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxNYErZCrfGfRXfeO3dgaPxxF1hWcdtOVMtdVcYuQQc=;
        b=Kn43xN6xfZwvD2Ctkiuxu7VjVm3lqxMlcj4SLzsDOhsWp2+HXgQnMG4Wr7sUqfPiGA
         cTzsoG6HZfaiM3eLhFkm6aQmCn035w0oqNJ0bK7QY9TPvjpf514DG56aQCb8IZ7mOc4r
         NFx7Te2chWKfy0RK++nT+SOKSX/dR8k0TxB9ZwdVey1dFEbbCxtxZ+rsUT88y43j7IQd
         o0FHCn1mVq8NMtvinHEazJRVAGyy7+zt00JFmPMCMmZOarQSKa5erQ+WOMlBBhZoPDto
         ZvjYx5HnNbF73Uk1DuFsj9+cUayRGgdEYTIdCZ+1i/nKdXQU+QWdj1FEdwCpHEIx8e/W
         XXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678905395;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxNYErZCrfGfRXfeO3dgaPxxF1hWcdtOVMtdVcYuQQc=;
        b=FfzPT5VYs+gvlgHyV/u/tNRZZrIkfQXKg/mCJ5FcLYynvuO7BgpthzvT3ZK1nt6hAR
         u3I7Bsz0/NccW17kHLFpijEcgdBpdde05AWptUK/RkM0mfa0qYitjnktNBfuLpngCfrv
         ps3y/jmlwZk6t2V5TchmrWGD1J/CGcuM+nt6WzTyR+svC8eNHB+O8IgA30rYKyWUs7Kp
         RSp6BZa7nLFIq8QKFf6oMQ6RQAHCFsh38SNhcWNUSBbdCqFmh740mKzUa0flxVQjoAs/
         cTxHcCwQhtcFZKn6k31uuCjVtWgA9jqIiXgDast+hNnuEmyVhUEEDTR4fQZP467WXnfx
         +1CA==
X-Gm-Message-State: AO0yUKVBDVNHe53AzRZcSkqzikNyoKAnOGRf7paFt59fdn8CBZbPkwb0
        3qb1PjjrBc4pIzJkRcY+nNU=
X-Google-Smtp-Source: AK7set+RtYb66umwPKKntudB0fcmO34SwQhaaHR0fuiHwZ1TPC7UhdryBvT46uIAEFhjOFJyH97Q5g==
X-Received: by 2002:ad4:5bac:0:b0:5b2:458e:9240 with SMTP id 12-20020ad45bac000000b005b2458e9240mr2463411qvq.41.1678905395213;
        Wed, 15 Mar 2023 11:36:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m125-20020a375883000000b007428e743508sm4172499qkb.70.2023.03.15.11.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 11:36:34 -0700 (PDT)
Message-ID: <4a258d74-0c9c-141a-078c-d49a7c0106e2@gmail.com>
Date:   Wed, 15 Mar 2023 11:36:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 8/8] gpio: raspberrypi-exp: mark OF related data as maybe
 unused
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
References: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
 <20230311111307.251123-8-krzysztof.kozlowski@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230311111307.251123-8-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 03:13, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>    drivers/gpio/gpio-raspberrypi-exp.c:237:34: error: ‘rpi_exp_gpio_ids’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian


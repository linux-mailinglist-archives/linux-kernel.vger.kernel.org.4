Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1381064AA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiLLWig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiLLWiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:38:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7A1BE83
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:38:07 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so31981402ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAU+Svl02vX8P7C+MvgoPJ/IkIPy/8R6crVlp3CtZS8=;
        b=KGbKqMw+k5ARwMUansd6r1EL2LzqciOBulHoy6yf41F90IYGcGFq2fo6JSKsveD8Gv
         GzC4CedyieGFaA2IJ7lL+jP/n9zzG6p0UVUR6ty07FvOh0JYo8/6OnL5GOpdsCAZsif8
         eprfDra+wCxStqyUvOvf1KSX/aUCORjWtHpSNQfsvVrhOXfbP2yqkFP+n9qCxxETFKdr
         Hh9Euc537yTD4WLG1EfbJgQmdv313Nd7YUqS1NF8Zb2x+Vot/XOKfcT4ZxCeVmym9BLi
         zLceBvm6XnZQ6OgNtg9/wnk60R+OenAHJYZ2W0ho4UGM0hbctReykpqB8Ow95zDEH8bs
         vNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAU+Svl02vX8P7C+MvgoPJ/IkIPy/8R6crVlp3CtZS8=;
        b=3iT82GroEAz9439JC9LN+ySnRaGmbNU3s4cOJFINWFQn3h/k18NSM7M8Gudy6Cnmbp
         +Bt3SV6q2wYjTnRNfZ38F2sSGE947Nb0A8uH/KoxVQYRLuhKp9ET/gGOH3k/SV8NBgCL
         TelrYsGNLB6dO5Isrt2FNegX3kJSNqGSjaPgWwALOiY68fL4+1IOfbdXo4K/S/lHQkq3
         hqa1m+Yn/mbvZF6dPMN4/5cJADk8x4cyybmMftEYCLTuAyyILe0bjA+hrN0yQjKNdd6l
         6TZO5osN263MiMb2gNKLeHExrEaxl0Tyy7mugctiSJMcLoMOnlcuTCKlXDeOB0Xqb+tu
         SDCg==
X-Gm-Message-State: ANoB5pnSyBschWKhc3cLaGA67ihK3ulJR551aP41w93xbOyU3gqUm7sh
        uP61DXsYkwWR/GUjN+cCTQ0+xw==
X-Google-Smtp-Source: AA0mqf42ULY+6d0wnAzTFhb/eBomHkD8Nig4sQrm4QH5BJOGl8XIARVkK9sNCSwpg4G65BLCZem+EA==
X-Received: by 2002:a17:906:2449:b0:7c0:f44d:984 with SMTP id a9-20020a170906244900b007c0f44d0984mr20711517ejb.74.1670884681663;
        Mon, 12 Dec 2022 14:38:01 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906829800b007c10ad73927sm3773445ejx.28.2022.12.12.14.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 14:38:01 -0800 (PST)
Message-ID: <9564ce71-ef11-2333-26f7-b0581c294d9b@linaro.org>
Date:   Mon, 12 Dec 2022 23:37:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v3 11/19] x86/ioapic: Use irq_domain_create_hierarchy()
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <20221209140150.1453-12-johan+linaro@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221209140150.1453-12-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 15:01, Johan Hovold wrote:
> Use the irq_domain_create_hierarchy() helper to create the hierarchical
> domain, which both serves as documentation and avoids poking at
> irqdomain internals.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   arch/x86/kernel/apic/io_apic.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


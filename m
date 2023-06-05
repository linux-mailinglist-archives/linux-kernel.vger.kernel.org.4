Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE3C721E58
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjFEGl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjFEGlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:41:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD01BF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:41:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9741caaf9d4so659776366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685947255; x=1688539255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKyJTEWAr2/bbgJ4qj5g0DH+qXUa8fA/In0KtxR+hDE=;
        b=j9sEsVQGcZI0ww4pUAZR4LvJgzBAxv+VHBf2ykJK4FV2Paspea3UMvQUD1Hat0/DK6
         C1ZtBMO0d3gCnu84BBRsvmgPvqeZWNbC0SiDrn8YrEbCDKDVrsHe+EKYYeg3fsAUF7vi
         DSMcugAkDnGFX/wvFCMlCWIAp3F4e5CINRNi6nZC2wLz/C8EA3k6ePtwqvAgx/SHDbsx
         wfXBw4epXXiMf3xILHbRp5rHLLAKMgzGSyhjm08P6v4i92CM2NgMsCPyX5CKBUVqB6Qx
         VLFd208uwr6/GMyOws242w3aXkOsKtMtTh4F1pwluQ09WVNCwATda+lT649Ol+DlX3Mf
         Hidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685947255; x=1688539255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKyJTEWAr2/bbgJ4qj5g0DH+qXUa8fA/In0KtxR+hDE=;
        b=fwZFgoxq4pdQOFp9EqvTU3LLMD7lzu1TcHOHzKzeIq0nl3Am26xxD12E3FWuVNNE6m
         pNSNwmI8TchA3fQxaFV8l4+uKAtS6h9BVaoQ2uKRoo7jDd1p2QOG1XIC/3Sa3qUovNDV
         F/yUgH0i4fPwai8WT0HQV3P+UQNbYcqrfN+oMirTBkHAfC9qeGDCmkV8VZ/pacD3E8jT
         dTq/4UWNSpLgKVfZ/fRmulG5UHclWHPo+yjzwAoQNX064+WjYPmn8JERZtR/2sIvdYYC
         CcGoa2H4fnA2/1mSn0tj6Y+No/pI6iJnbiVtHAIFG8WMeHz2JwQLXzIpPUG10YsOUuAI
         lZ0A==
X-Gm-Message-State: AC+VfDwvL1iJha36SM+la+hSVNgisOJpfVMxmypPtrhXRtFJ5MmiXklD
        AvrWiPnQYtSVnCzmUWbhr75WjQ==
X-Google-Smtp-Source: ACHHUZ5rD9LvlGRhmhSXQ6m7PkXkbDSH3OreIA9ygN8V+18zsEuiGBcHP+HOLFbqCky2LbZl2Bq7Kg==
X-Received: by 2002:a17:907:6d19:b0:973:ea73:b883 with SMTP id sa25-20020a1709076d1900b00973ea73b883mr5710250ejc.66.1685947255077;
        Sun, 04 Jun 2023 23:40:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id qt23-20020a170906ecf700b00977ca5de275sm2220115ejb.13.2023.06.04.23.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 23:40:54 -0700 (PDT)
Message-ID: <cb6db583-fec9-f20c-23b3-6fda437e65a7@linaro.org>
Date:   Mon, 5 Jun 2023 08:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 06/21] ARM: configs: at91: add mcan support
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        gregkh@linuxfoundation.org, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, sre@kernel.org,
        broonie@kernel.org, arnd@arndb.de, gregory.clement@bootlin.com,
        sudeep.holla@arm.com, balamanikandan.gunasundar@microchip.com,
        mihai.sain@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        durai.manickamkr@microchip.com, manikandan.m@microchip.com,
        dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
        balakrishnan.s@microchip.com
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
 <20230603200243.243878-7-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230603200243.243878-7-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2023 22:02, Varshini Rajendran wrote:
> Enable MCAN configs to support sam9x7 soc family
> 

There is no need to enable config items one by one. Squash these.

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7F45FC347
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJLJsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJLJsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:48:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B12A87A1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 02:48:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u10so25444585wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NB6mG33aDtm6Zk8BktYrxC+8hOs8DwGLvDzn08Z1nM0=;
        b=Wznf0FrIHwd9yD3BL0jRsJHyh27pJJRjliBl8pb+TQ0a2wOheEFN3cS5kQZzGjnUsx
         h7Kgw2wAb714Vx0msRAfJdExER0hHksZ73uyPwf0B6PHzfAHHUcY+695IuN7vCVAPJPU
         9W3Bel+OpP823Q9JZqDCnKEfwpskN2SOdBgLv1FqMUwGevEdCzJiHxiATvKEMf30gfED
         8ZgzuAuE3kfsWs1l1k+aLHG9ISr7L/Z8C22vSQm//Z6dVMWIjJVcqOQzwK45+MLwOu3Z
         1QX9dpoF8NImvgx8ocs1ngpqFys9qB8e1cmrHhX/LyD07raVySTomg7VpJtijnIkAliI
         on6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NB6mG33aDtm6Zk8BktYrxC+8hOs8DwGLvDzn08Z1nM0=;
        b=hWG5A56nP3ga+pj6s2CNz1JTjFd4Tt6z9IISfH0RZ5cm4MOW8jmLIIOt7awBNqklv7
         EW0X0DDWwo/G+8EcwAVO3ogjJhz0VZw3gKaQzynZ8yRlD9O2qg0r55AY5uLJiQ/CRDA/
         MuhB7kdarID7jkK1oC2rF8KNcK732YGKUoJqPkdY6F/HN+3Aj2sTtOFj3AXi+A3flfyK
         xeqrBOWOt0YpsHRSpSdSXbfQTncFJbtjREJdn5JPY5ZbFPhpiX06gfSYqN+IYSZp+gOI
         PDpOhuZeQhbWEL7j+MSSxia4AWxJQi3al5mroQFbcgoUc+1g8IZkNrMu2Y9XcvYATCsH
         VQqw==
X-Gm-Message-State: ACrzQf2eGbJIiSaMbTIG/T9XLTEPXM4nyQVyltY92To51dmQAhrzlM/g
        q+JxAJhqOT0t6kKnpPZIufINpQ==
X-Google-Smtp-Source: AMsMyM4Y0dsY1cOpURNMZw4WsCAg5nExJ4wCqKEZj2OCuMoWYv/BIE+7HRScn1kypH278RstTt/ONQ==
X-Received: by 2002:adf:ea08:0:b0:22e:46e9:2a8a with SMTP id q8-20020adfea08000000b0022e46e92a8amr18228046wrm.636.1665568108087;
        Wed, 12 Oct 2022 02:48:28 -0700 (PDT)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id ck15-20020a5d5e8f000000b0022afe4fb459sm13724434wrb.51.2022.10.12.02.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 02:48:27 -0700 (PDT)
Message-ID: <b0db2f52-6c26-a7e4-e16a-f2d9539c6584@baylibre.com>
Date:   Wed, 12 Oct 2022 11:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v6 5/6] Input: Add tps65219 interrupt driven powerbutton
Content-Language: en-US
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee@kernel.org, tony@atomide.com, vigneshr@ti.com,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, arnd@arndb.de, jeff@labundy.com
Cc:     afd@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org
References: <20221011140549.16761-1-jneanne@baylibre.com>
 <20221011140549.16761-6-jneanne@baylibre.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <20221011140549.16761-6-jneanne@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to add the Acked-by in the commit message:
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge through MFD tree.

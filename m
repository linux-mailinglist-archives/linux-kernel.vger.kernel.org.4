Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121BE611B43
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJ1Tzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJ1Tz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:55:28 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C47A1DCCC1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:55:27 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id e15so240298qts.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1cMYk/QcVt3otQQPwi0GgSCciLFitAoAgl4SvI2FMI=;
        b=RDmn6xvys03Iyp3Ip+PslfwuepFFKQ+KpxzcW2yVmKdPlB3U3KDAuRdnp3EwitvHHc
         VwPBVa8Fudjz4iJkOvdowQy5lHxDm3jRXTr59Wl17UPXNHAMitx36DJ3zbC/BmwTyD52
         yaPAOSRUfP/xlPabt1DefEVa9lDKKycepmtJojOMnlPqe59GjGagShGtdTsDRpgxJcBA
         s2Tym3U+J+BTBUPaDa8AxZxzmT8XPs/Be3p3GMzHc6oPFg3VTXATJuJZKghnZhkOncCU
         SxQoXMuiU9xSRSfkOD0vEHIJUuSLrFjCdDnHEIlE6vYiOeLpkhPorS13jTkpKMU5xtMF
         y6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1cMYk/QcVt3otQQPwi0GgSCciLFitAoAgl4SvI2FMI=;
        b=DQeOoFOYCzoijpeMvOMrxDzEyUpkQebGgL0kl5eQSejp/icBh1VoYPNYLsxyJazvwo
         eAv4MaajT7sGpedquNvwdaxSwDCHaMISam4MfZwanyMwqmfJVu5brCQSsJleIFwWxxNd
         uL72awoqPyb0ACp7g+IFwFsykk+H9Qq7n//NcE08IbjYK+1sVgiLy2kiQDphitSHpnQw
         c9lYLJ/PLASwffApFr5UYGohDkPlNhVBZ/CIiueSjpUAggVEPhdtk5UxG9vh9EiKOP1U
         Tn1d0m2itOb1IzfMpCmZN2IXAS6FzAHpovkK47MTrW11LljGTMXrDkoaJDFkTOYKg81F
         cqfw==
X-Gm-Message-State: ACrzQf3J7en70S5etrhrr3PD+d59GOhGOulRWclSVLJh3KFcbahpSxjt
        GWJWzfHtUhEdYwM2G0R/vOkjHw==
X-Google-Smtp-Source: AMsMyM7UmZZuftM3vBoeVqW3MDPKHX+uVi2DQLWsYOGwWOIJqd8CRjl22MSpLHUoiCpLIk1CyPHcjg==
X-Received: by 2002:ac8:58d2:0:b0:39d:ac0:b5da with SMTP id u18-20020ac858d2000000b0039d0ac0b5damr988334qta.631.1666986926468;
        Fri, 28 Oct 2022 12:55:26 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id d17-20020a05622a15d100b003434d3b5938sm2891298qty.2.2022.10.28.12.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 12:55:25 -0700 (PDT)
Message-ID: <bc7bd112-53f4-a372-d1ce-d3ca99928e8a@linaro.org>
Date:   Fri, 28 Oct 2022 15:55:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 06/13] dt-bindings: pinctrl: mediatek,pinctrl-mt6795:
 Improve interrupts description
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
 <20221028153505.23741-7-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028153505.23741-7-y.oudjana@protonmail.com>
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

On 28/10/2022 11:34, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Clarify the meaning of sysirq to avoid confusion.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


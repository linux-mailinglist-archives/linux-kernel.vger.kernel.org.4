Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AD5729F8D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbjFIQC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjFIQC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:02:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226AF359E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:02:25 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-516a008e495so4267633a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686326543; x=1688918543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUQxTR26d0ccXcUBQO+OAysHf269cJkNZLPlJlHVy1c=;
        b=gvig6xb73CxExMH0C/f1rpt0ttvjnX02N8OYyTgYmU9YqJIJtrOavyAoRvYu4cz67S
         ZtcNjsFAaT4szsYAjFAv0WdLLiGO+1396hPBd9JOhuSrKXAQGoy0L29YEHGqyRVDhfHl
         4+FFcPIRDLj+tQQbGMDEouMrIiH6U9werUsCODBbtNJddXP+1Ocp8dZYvLCX4wjfCTMK
         eRm/16pDVonVasZGTOuRBUIH/sVY/SEDwgtyz0FoqpH4s21cthAnJLLcyJwqdm7xN19d
         AbHDy6Sd6EQafVJgdYHChg0e3rTSp9ptBmcCQU8pOEdG6w/FYqLa4CTP0DNIAY/ZyN+z
         mrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326543; x=1688918543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUQxTR26d0ccXcUBQO+OAysHf269cJkNZLPlJlHVy1c=;
        b=lvCSqwuHdyB7iKLysuQjdN4qa7hzoO2Iicf8yJPdxF4ONP0beSg/N+GS43yBeQa6ho
         Z1fA1MXVrUvQsgD8/MG94TAqqVOp7vpLEgVDJzEB/rIMi0K/ppeOn4udyhfdtYF7YbyE
         5A/8Wwr98OXo3J40ABPxGIN+o/3ESLsKodYTofMX5WhBylDMDiKSGfUeWumIpQwevw8t
         ufBtnuEk/Wr8Ms3kwzAeNoQgIq0ELVvhDItiAtjJ+0BE3B7YLqXWRVoLOUtdnfsiy4ev
         1dqgLWh+5YHnoyLnXS+f2RM5tzCNdyhSJbAkVkC6S9G7pydoWuQTBhDRoa2tO6efm/0j
         fF0w==
X-Gm-Message-State: AC+VfDw85iJ5vTQmVTe4Cj+YasBcT5q2+Syxzt0zNHyT2Q0QibIyjS1r
        0I5YuGv6IeLTuFj8PeovhvB3CA==
X-Google-Smtp-Source: ACHHUZ4ODWUxic3zboT2VQDKWfVqEGwfvEBfCw9r1d4k/uz4bPoIYm22L2MySNNRQljP8vMZNwmCdQ==
X-Received: by 2002:aa7:d68e:0:b0:50b:c456:a72a with SMTP id d14-20020aa7d68e000000b0050bc456a72amr2335473edr.19.1686326543667;
        Fri, 09 Jun 2023 09:02:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l2-20020aa7cac2000000b005162b95d512sm1950196edt.15.2023.06.09.09.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 09:02:23 -0700 (PDT)
Message-ID: <f8188ce3-8c82-0293-6598-53cf0a8dfebf@linaro.org>
Date:   Fri, 9 Jun 2023 18:02:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/9] regulator: dt-bindings: mt6358: Drop *_sshub
 regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-3-wenst@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609083009.2822259-3-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 10:29, Chen-Yu Tsai wrote:
> The *_sshub regulators are actually alternate configuration interfaces
> for their non *_sshub counterparts. They are not separate regulator
> outputs. These registers are intended for the companion processor to
> use to configure the power rails while the main processor is sleeping.
> They are not intended for the main operating system to use.
> 
> Since they are not real outputs they shouldn't be modeled separately.
> Remove them. Luckily no device tree actually uses them.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B0F5E773E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiIWJd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiIWJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:33:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C8AEE65C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:32:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a8so18829049lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HmRlc+Hs05+wWYAlUZbO8wKKqWbps5u2XXFVd5In1P4=;
        b=k62JTALVIbxJxDPZBvTcfYIjMm9LvN78w/7pRi3AOa3ZfKNhxoyZtj+WVIaiMqxnCm
         FbbI5PoHbHvM572eUlY24+DDUSMCyz5rxDmA/13DDALISeE+i0mIsTb+Ci6LNDdKNqFc
         grq936CQefHpKiLerD8b0rV4GN9QGn40q7sp0w99JeWba1qQdgF6djE0+GmALUsVOM64
         eOx5XV/d/7qcYxpMdCKA8Krc3lC/5KHuvTCRKt4UzVDCHbmlSGqhe6GqJDAe/PNFLRkD
         JRo+27uG+A4gDcgMnhOXmToXRvCafB9hIZZ2KaHb8SMUfoQPIo7wu2Mib7ofB6Z0DpPQ
         prZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HmRlc+Hs05+wWYAlUZbO8wKKqWbps5u2XXFVd5In1P4=;
        b=XdIGKXRv0voYTMdWTGjMs5HArEPZc3Kw15vfAYZS8EXGWQeMBcM4hWMWD87i21Fd1f
         dmiaOJOfcHoWJSQRe4lJ1O6wXwNHUcVEvF72v0mUgr4joEnnBiFydkvHJga1skMi/xe5
         7ZPknom3qjA0W5Qt4gskW/MWrwsgkuMgHVOlanBwTyMdi1C6t7obQUJqxDRdIbA7bmbb
         wrGY8ifJwhfSAOzDlDScfqqXBwnUotsUtUbNVOMnmlZwiuLHmDZ7CVnvzokHy3scuLEO
         OAQC7o5rDDhRyqq/XuKmEJ1VsyANQ6afim+K9Y+cf0dBdzzYYZW+/+qEnEfaJ4Ob1WdX
         ReJw==
X-Gm-Message-State: ACrzQf0vUgPJR1kygZ3c8QTGhGYbMjqNu5+Gg604QBudApmOzTiHb/qO
        RY6jNg7PKyxaeHJN1GjIKkjAtg==
X-Google-Smtp-Source: AMsMyM41PF1DfX86gyr8+1V5cqnkGU7hwHacoJtPRCrhEh0T56pEuQ/5pXkVWm8izoaAmZbewxT9wA==
X-Received: by 2002:a05:6512:318e:b0:497:564e:5953 with SMTP id i14-20020a056512318e00b00497564e5953mr2805645lfe.220.1663925577452;
        Fri, 23 Sep 2022 02:32:57 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24e91000000b0049964f68457sm1358757lfr.262.2022.09.23.02.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:32:57 -0700 (PDT)
Message-ID: <af938440-b34b-5e17-33f9-d8da3fbdde07@linaro.org>
Date:   Fri, 23 Sep 2022 11:32:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dt-bindings: power: gpcv2: correct patternProperties
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220923075427.985504-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220923075427.985504-1-peng.fan@oss.nxp.com>
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

On 23/09/2022 09:54, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MQ has pgc 'power-domain@a', so correct patternProperties


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


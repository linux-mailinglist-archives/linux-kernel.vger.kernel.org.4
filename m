Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CAC7254DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbjFGGzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbjFGGz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:55:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BEF1FED
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:55:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977d02931d1so540756066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686120914; x=1688712914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7WJqHLFpKDGr46IBPNk/YN+JVm7bWWsWSgfm2qEj9Y=;
        b=HohK+OcdPy3Lt3JJz9wswXlggxK7OGaX0Jijzhh8gjAXDI8nmwvFWsy4IXfsLQN6db
         eF7ytakszmO+M6ZV3qo2LUqNO/X+EAa4sWi76uySo/6OgMEkuKH9pDsfDFr19RbU66gR
         MLdh4v0uAEfSQwRHv/w7sK+64PmB1d1CJvPlVhH//qpBxgapXcoUeidaKEm0qufnAexc
         Zpt6IF0rbV3sjQAq2LPIu6ZJXWE09u+uujE0Zy5nCRlOIi01ZoAdzZBZPXqGoSPOfawQ
         864iwKiark9ZfgzKwE8TqgYsJLvHX03pCaoPHJntMNThctV8QfmLdt+KAYHCZHySmHBm
         wHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686120914; x=1688712914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7WJqHLFpKDGr46IBPNk/YN+JVm7bWWsWSgfm2qEj9Y=;
        b=a74XrhIlUd8gwyglAjeEDenxqxnc8CAFIQ/Bu73RJRUk+mnwmdBR964NbqT+PHMmmx
         vcq7Bc6PVSP84iHa/psa5mrZrFTgcDb9Gb7JmMVspDjlPQ1r86tNbgQC1cSmZjcTiTxo
         YetQ3sJLIyV68ksHLgdqD0gwHwnm4YER22sVbaPkD6SLjtBvchpvhTbPQDlF3w2RrXno
         cFTV58g1nyLEVgcUfsfCMsmz5g7LTiZ2qVZAdlzxvZbV15tlQ4m48YcsbwWErQwX+j4g
         jMxmlYO9YZTv0Lf0NgG4d5Q8wqqWojwhUFCPv8kA+dI0qVNXC0BVmFUdeWWewN2VuUfI
         smxg==
X-Gm-Message-State: AC+VfDylBftg0B66MI+Vx2TGDSuFbcbQ9DxT6N+NYCk60y4X85r56yAj
        ilG47HdLjRzz0vtpUjg8KuZjkQ==
X-Google-Smtp-Source: ACHHUZ6O0DqToI5mmAhOt2e0Y5YVJ6BRwrPpK3l6U49K2oYJEzYQSbM73UejopnP8MGauekXx+fwbg==
X-Received: by 2002:a17:907:6d0c:b0:977:d932:cde2 with SMTP id sa12-20020a1709076d0c00b00977d932cde2mr5045534ejc.62.1686120913834;
        Tue, 06 Jun 2023 23:55:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id oy8-20020a170907104800b0096b4ec45e10sm6496158ejb.139.2023.06.06.23.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 23:55:13 -0700 (PDT)
Message-ID: <35b8f52f-9da9-adee-ae22-a4a9f2c49073@linaro.org>
Date:   Wed, 7 Jun 2023 08:55:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add prefix
 alliedvision
Content-Language: en-US
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20230606155416.260941-1-tomm.merciai@gmail.com>
 <20230606155416.260941-2-tomm.merciai@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606155416.260941-2-tomm.merciai@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 17:54, Tommaso Merciai wrote:
> Add a vendor prefix entry for Allied Vision Inc.
> (https://www.alliedvision.com)
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


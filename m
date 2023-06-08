Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167C3727F91
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbjFHMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjFHMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:01:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87946210C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:01:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977ed383b8aso97358666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 05:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686225669; x=1688817669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSfpWD4teVA0PB2ivylgMo2dut6dNPatdLRqxIkNQ+Q=;
        b=WoTNi+ai6NsW8KPLL3LglJc2enfwxbm4PzanNJzUP2kSg8rIB+8VAY8VxVGA8oHiBd
         aCpp7uniWV9tqmT9LxQoBX4diI+7/0VA1bGTXiIVMFDUryAz58F2dSqdQFRzIabkPtNF
         VNDGsZdS4ps1dVEBvYR8lsGyNwWK8Cr5ApUpLqNehriyJel3kUoJJ4shO6wHVkQ+dqCR
         5GmbTemDGR1vowPNxXZAKpRwY6gSO8OCu2T7G2gMkP5bSNHDgfEzSpfwaO2tfbHmy8p0
         xl0hr55EF2E2bIm4H1u8jMtYiKhvJtQItiOUuEnIMdZDwtYP2m7Z6v2WJRZ/sjvFcGRV
         hzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686225669; x=1688817669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSfpWD4teVA0PB2ivylgMo2dut6dNPatdLRqxIkNQ+Q=;
        b=IS4Ujhylj+CZdjiRuTlZv8XV3P5aGf4j9ox/LzIY2MlS8WXb37plyccPaXEtZEad1e
         3ROLLXKqdeTqHazzi8AVEQz23Dc6icon5HJiLcxHgRoMiInSfXwuyYr8KhFCxijTmp49
         5HzAKyeOpr9nuakTh6HeJp28FKZvxRBuRLCJyzgjCpZ7hQYGhMLmXLIaLQU/fK5P+QH/
         Ip5V0wvHvu3MADsyxPw2eE5e8Rodsh1luiZCPmQvUkI0j3dZtiD5T83I25WfoKODGljF
         KXNR16iNIHgmnu6vyL8Huy21s09KRxldLNFf2eMVuZvWH6UWHp1WmZr7FcKGwhws9ta6
         IjXQ==
X-Gm-Message-State: AC+VfDx8d4rGUaYKHdRZqAKJXrO/l84QpGMnXNGNDtet3whM2IRiLKKk
        gCwzPj3D1rPk/uJO/l0L3gwDoQ==
X-Google-Smtp-Source: ACHHUZ64DPz/2YQ7ZsaUzDtgwN8iEGLtqsNJZpVuVaw6nlFGzaquFSCCNzMzj3L2VCS98bdm8s2DJA==
X-Received: by 2002:a17:907:a413:b0:978:9011:5893 with SMTP id sg19-20020a170907a41300b0097890115893mr3107734ejc.37.1686225668903;
        Thu, 08 Jun 2023 05:01:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gg24-20020a170906e29800b00974638e4a98sm610936ejb.24.2023.06.08.05.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 05:01:08 -0700 (PDT)
Message-ID: <07c455ff-c44d-891b-e2ef-e5cc612975e6@linaro.org>
Date:   Thu, 8 Jun 2023 14:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/2] dt-bindings: nand: meson: Fix 'nand-rb' property
Content-Language: en-US
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230608044728.1328506-1-AVKrasnov@sberdevices.ru>
 <20230608044728.1328506-2-AVKrasnov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608044728.1328506-2-AVKrasnov@sberdevices.ru>
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

On 08/06/2023 06:47, Arseniy Krasnov wrote:
> Add description of 'nand-rb' property. Use "Fixes" because this property
> must be supported since the beginning.
> 
> Fixes: fbc00b5e746f ("dt-bindings: nand: meson: convert txt to yaml")
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


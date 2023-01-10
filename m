Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F2663C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjAJJJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbjAJJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:07:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC94EC9C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:07:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g10so8263635wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JbaxC7KPieHLp+g5p9tmnTTK4fIMEmiIEMJJms0GZ4=;
        b=zQAoaBT8syYTjq/VlJv6oSVm1PPkQlXAL2RZQE0RInE74XU48Z10cR7uTFMV3tPGi2
         B6JPTTK7nJvGTu6APUx3VIkQCfsUiCWXBkAdgb0kWyERoOrPTKZjpXPSX6WezXRsMMZy
         uUNRpc7GaUQz6GRaIc2O1PDNyttUlwJH+zJYsLlvg1YXhSiyzf6wtZdrosT3L5R39H03
         fl0oE7UEMnxUpqKpHoz7dk2XeVP/itmoeLA0qC580aUwBPH+RiJAZuGrO6rxccKsDoh9
         kS9tdJBHedoVZ/Z4Rt8xJ9gSrxlY5ftL1a0Nfu7dzZnNqJnHri/G4amtVqozh3U/vJn+
         wGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JbaxC7KPieHLp+g5p9tmnTTK4fIMEmiIEMJJms0GZ4=;
        b=M90Jl8oDQj975NmshHBz5fRZ9YoNb9H0R0I7pXKJOaS70qNs98/3jyzEToIsPuImv+
         AJn1G0/jTgoPSevb9kbt/r8PlrA/ZN23dO6xYa2WP9qZfc2T0TdTL8fXZWZvH9t+DLJa
         Py4HFGoZ3xceP2C0JrXYU7prU+4qnjuHf63w68EoPMWqhxskJCBxkNq3zinZUX0n5gAa
         oNCfhdktUwP6Jfqm6PQY+7zcRUaE/Axf4rC9B7qfVBj8lKZFAZyTXxyZndBQnHQaws/i
         YPDCLqPrTtevCW+UitMEQcvccDkSTX5cIu3glHHbugSscaiv2XhtSirB84kt/52JJMX2
         XBgQ==
X-Gm-Message-State: AFqh2ko18t0uP9u+kXcF+q+so5wlThe2h7Yt6IrBF9mP8pIAna2tqQl4
        nbL76hmqwTuRT4dladuR9GNb4g==
X-Google-Smtp-Source: AMrXdXs6ZSGkTV66Vz7LmN9fgcIN/7pcFQbA/DwdXkepR6WdHGhSJpt/3Tqxt+j9manNylw8VlkBKw==
X-Received: by 2002:a05:600c:1da3:b0:3d0:965f:63ed with SMTP id p35-20020a05600c1da300b003d0965f63edmr49170877wms.23.1673341672120;
        Tue, 10 Jan 2023 01:07:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fc14-20020a05600c524e00b003a3442f1229sm21206674wmb.29.2023.01.10.01.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 01:07:51 -0800 (PST)
Message-ID: <f2d70c17-e519-fbde-eb61-1acba70a59a0@linaro.org>
Date:   Tue, 10 Jan 2023 10:07:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/5] dt-bindings: hwmon: adi,ltc2945: Add binding
Content-Language: en-US
To:     Jonathan Cormier <jcormier@criticallink.com>,
        linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
References: <20221214220727.1350784-3-jcormier@criticallink.com>
 <20230109233534.1932370-1-jcormier@criticallink.com>
 <20230109233534.1932370-2-jcormier@criticallink.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230109233534.1932370-2-jcormier@criticallink.com>
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

On 10/01/2023 00:35, Jonathan Cormier wrote:
> Create initial binding for the LTC2945 I2C power monitor.
> Add shunt-resistor-micro-ohms parameter

If you want to keep that sentence, sure, but let's make it a sentence -
missing full stop.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


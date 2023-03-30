Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8FB6CFE9C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjC3IlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjC3Ik6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:40:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25706A58
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:40:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bi9so23530342lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680165654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJ3pf9HBxcQNgME3iTfrvYRl50eXH5YVOiEzPDMyG1A=;
        b=dHTXX3/vDsIc5grUat7Hk5JTJLCsuN0hNGKtLSGAtv4zFHDK/o7FXlkKDHBK1Buyz9
         E7kKRASGfvC1FQNaM31jVR90FG+yX9RppvEVjx4KdX95u4JEheBuEfkAqyCi5gRmujTh
         xYLEsxp/e1JxuAFVumNE2Xcf1rx8M/rdHlRSBem+FKufF+xaixQQIt5H0/6WUtbm1Mb3
         fHgLFnzWHlFQTgJQLb7SzGNyxym9PNygWM5fBiHvG76uAOXua4z8UREdOj679eUshu7Y
         G1ae8wldU7XLjny1UDhQyvbRHLneQJmBp6o3bakHsBZJ4ZbgHKCWTcLyTyinUHX4S6Ok
         kP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680165654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJ3pf9HBxcQNgME3iTfrvYRl50eXH5YVOiEzPDMyG1A=;
        b=H/fHQBLcBI6N34QxBZAon1UtAbRzkOa4P6X3lY445BNVq4PqTq3E9gGgbKQFtGqWec
         DsKKKZ9ZKW5oj/ysrVzx8KJbbGHIxkapGkq+WuYYzCdpHzf/4MdfX6fUj7vnRi63KUZI
         a1U+g/YmLvo/LVI4Z4lJAWgFgvggBzIOqTn6hvtYy36lz+VJFuZSDu1YhGMZGPaUWTUv
         7VFFzYDFQ7TUtTQXiJdo8pJa6B2HYjWaWelTHwHTKiM2VJLsKaTiizgCmRscAsxhdh70
         pzsGL48Ew4mDibEqKPwEK4HqO7LKC+I1fIQR+CFscxKyxzsjWA3X0KlRyYZhXizL7YU7
         Y+Vg==
X-Gm-Message-State: AAQBX9d5BspDY7pRD6ae+pbcGEuJ6epjksXFGqodMIIHNEg7EREv5NTB
        pZz+SLS+aprBHF/CJynjLef8aQ==
X-Google-Smtp-Source: AKy350bK7+ODGQ0kYuKKoaUg3Nd52eeMc0V8zS6d0C3VxYezKpqncAWnFMN6pwBt8TFgP3/7OfaYYA==
X-Received: by 2002:ac2:5304:0:b0:4eb:edf:fb5e with SMTP id c4-20020ac25304000000b004eb0edffb5emr5073501lfh.44.1680165654042;
        Thu, 30 Mar 2023 01:40:54 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t3-20020ac243a3000000b004d5a5d90d83sm5842141lfl.60.2023.03.30.01.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 01:40:53 -0700 (PDT)
Message-ID: <432568c4-e316-903b-1235-7142bfff0bcf@linaro.org>
Date:   Thu, 30 Mar 2023 10:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: Add TI TPS6594 PMIC
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        corbet@lwn.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com
Cc:     yi.l.liu@intel.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com
References: <20230330082006.11216-1-jpanis@baylibre.com>
 <20230330082006.11216-2-jpanis@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330082006.11216-2-jpanis@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 10:20, Julien Panis wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine) managing the state of the
> device.
> TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/ti,tps6594.yaml   | 193 ++++++++++++++++++
>  1 file changed, 193 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


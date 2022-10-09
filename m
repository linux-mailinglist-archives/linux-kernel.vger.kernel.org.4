Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF4D5F8C20
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 17:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJIPuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 11:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJIPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 11:49:57 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF13B10FC1
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 08:49:53 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id fb18so5351190qtb.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UTaEQXBIuOT/yJEl/9BxLHgCvZr318infBDEQ1R3EVM=;
        b=vW5RRZ1BvffOs+xY3myatYnU9fd32ouOhNA5gDz63DNh7NzsP4EabSGlAbT9mian/d
         Xe6RPqg9iU7Vlvu0BgMUZBZmQ100oZiDlFxWzV29hqlhjmuTvoehw1HrqLtfX64nUuOn
         1hHwzh/ZfoYu/DcyPmyieO4fc9WiDDe9C9n5HFwByPVMw7nmIeP9m8JsmT7+MdP0JbUL
         r2qTjwvX2gCSIfuP/5apZiR/AleKXvflo2rOldHLqRoZYzlEnuc6PjKqK8q/PrrcRUxy
         ykK0CUQ/0dnleLmolDmUvuFDJEp2ofCTdIgCtD1CN+eElberiPjQMy2Po3LqduRTXxjh
         MYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTaEQXBIuOT/yJEl/9BxLHgCvZr318infBDEQ1R3EVM=;
        b=W4bjmEbLVIUAF7UWnsA7vYlKPHNkOn6YBcgqu2uN1fTr2ExPl291RA4bsWTRiYgU0X
         HDNxacAftSWnG87MKKMttHOvfc906+vuI6WcBe61ZFbI3GDeeRuo52lL9P7MP7po3XgC
         Db4N4xAbjrQdcGJ4M2SxijNZ1WohgFtL+8+rrsudAY9hDWC6pZ0+apWccOrIwgcn1byI
         wFWLcNBZsQzQxp6N7Sycr+GPXpTsPpEGgEcc7A3sZpZcbmytsQydZnURiRKCUDM93fYs
         WbHYAGBHCdNbrBHz6xJ1V88FE7sPFka3tNo4tdEgqT+TJge3hH1/QVQK4Iq4RsTCFUDT
         ILOQ==
X-Gm-Message-State: ACrzQf2hNmEsIFsUqxmf1zuZuxgKYgHlIpdG72B9gvKTTGJDHJADveZm
        1ILjrFWihApV+m5bc910fCPr7Q==
X-Google-Smtp-Source: AMsMyM42w6KlKJcZFBQwD0FMs5SCWR7NisT5sT97RMYHRBk/4QpaCH+D//+vfHoxH8ZVaYU/UBXfzw==
X-Received: by 2002:a05:622a:34d:b0:35d:4338:463e with SMTP id r13-20020a05622a034d00b0035d4338463emr11810578qtw.559.1665330592882;
        Sun, 09 Oct 2022 08:49:52 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id x18-20020a05620a259200b006ced196a73fsm7718969qko.135.2022.10.09.08.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 08:49:52 -0700 (PDT)
Message-ID: <7eea96d9-20f8-2165-2f17-88d9843ce0ee@linaro.org>
Date:   Sun, 9 Oct 2022 17:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC v4 net-next 13/17] dt-bindings: mfd: ocelot: remove
 spi-max-frequency from required properties
Content-Language: en-US
To:     Colin Foster <colin.foster@in-advantage.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>, UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>
References: <20221008185152.2411007-1-colin.foster@in-advantage.com>
 <20221008185152.2411007-14-colin.foster@in-advantage.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221008185152.2411007-14-colin.foster@in-advantage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2022 20:51, Colin Foster wrote:
> The property spi-max-frequency was initially documented as a required
> property. It is not actually required, and will break bindings validation
> if other control mediums (e.g. PCIe) are used.
> 
> Remove this property from the required arguments.
> 
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


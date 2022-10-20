Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00B2605981
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiJTIS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiJTISZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:18:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01FC169CC9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:18:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j7so33108038wrr.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fsj+8WfOAZfb/OmR4M1+8IvYvMPpVpcsoTV/p/XqqZI=;
        b=qh1bsgdxEeRCQ6hZldQMcr3aLqpWdd1Clao0b8Ya5qOdGGbjkC94KnXF1WtRGghZA9
         kiCXAtUNfsM0/UJskrvFZvEjSjPHQHp8+w05atY2PKLSkHNQeqYq8rMnyIf7kp5yGD8g
         18dqXvtWAUjToox+VWRTYw2x1amBzMLfYOi20j2ybIQIU5SgiealQ0r7JKAzSpbFGSOQ
         g7MwnhfWhXcZSQVeYnUr8ynUaAfaxSvapGRddFhcinqCWnlAllOLxfCXSKSC/Y465mHt
         x2qon43dtp8zWqeV42EtzH2vZOW1Yft19khX2huV6LD49oCR6/WoDRQJNReRqi27KCAq
         +c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fsj+8WfOAZfb/OmR4M1+8IvYvMPpVpcsoTV/p/XqqZI=;
        b=tUFuZKhzPaWqrBkZKEozNS/v4iQi8wFU5op+3/zSEfvBKyxfWsaURQBna2wn8DKIWd
         LVDSFnm0LzD91Qebhhjp3HzetbOXWjmMAk/dzCHfb65Gz/unVvx3ZkzSsV94ORtGNZ62
         nHWw9o2Wreex4AqKoPD0nszD9IM+yZ72U3WmTZm28/Z40awKOOIz3/9nBG6ig6N0VCqx
         Iu1fdTWAwovbv1d05osYZZVqpuUWm0cuJ+2V6fa+oPgNViHZFlhI10dv/GDy7xay3iOs
         SfjBnSaNZByVmqPk8/nLkjWqKqfD8F06z84k5d/K/jPG0obs2XCoyZBpZy0pK2mK130f
         UGpw==
X-Gm-Message-State: ACrzQf0MQdHkMFIcxyLTsTrRKer93sCUtD8l1oc8EKxfW55KHOcCt/UQ
        FeJKAmQD+QJUgv7hq5bpUtcXUg==
X-Google-Smtp-Source: AMsMyM6UKfTDoyvlxHH9d/C28T5MXbvxRFj4MQ89o3ZziE5fhA0V9cNBU3VXeKSyrS1ckZcMeT35uA==
X-Received: by 2002:a5d:59a7:0:b0:230:3652:1aa with SMTP id p7-20020a5d59a7000000b00230365201aamr7627500wrr.308.1666253899934;
        Thu, 20 Oct 2022 01:18:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ef2:f28d:311f:c84b? ([2a01:e0a:982:cbb0:ef2:f28d:311f:c84b])
        by smtp.gmail.com with ESMTPSA id o13-20020adfe80d000000b0023580e7a2c4sm1462948wrm.86.2022.10.20.01.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 01:18:19 -0700 (PDT)
Message-ID: <a6942e7a-faa5-d839-aebf-0d28e7e14f06@linaro.org>
Date:   Thu, 20 Oct 2022 10:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/2] spi: meson-spicc: Use pinctrl to drive CLK line
 when idle
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Da Xue <da@libre.computer>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221004-up-aml-fix-spi-v3-0-89de126fd163@baylibre.com>
 <20221004-up-aml-fix-spi-v3-2-89de126fd163@baylibre.com>
 <CAFBinCAsCg6QQRH3VPY1OKuyfkxY0oCXLhAuMwO6=00gXKqQrQ@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCAsCg6QQRH3VPY1OKuyfkxY0oCXLhAuMwO6=00gXKqQrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 22:50, Martin Blumenstingl wrote:
> Hi Amjad,
> 
> On Wed, Oct 19, 2022 at 4:03 PM Amjad Ouled-Ameur
> <aouledameur@baylibre.com> wrote:
> [...]
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
>> index c3ac531c4f84..04e9d0f1bde0 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
>> @@ -429,6 +429,20 @@ mux {
>>                          };
>>                  };
>>
>> +               spi_idle_high_pins: spi-idle-high-pins {
>> +                       mux {
>> +                               groups = "spi_sclk";
>> +                               bias-pull-up;
>> +                       };
>> +               };
>> +
>> +               spi_idle_low_pins: spi-idle-low-pins {
>> +                       mux {
>> +                               groups = "spi_sclk";
>> +                               bias-pull-down;
>> +                       };
>> +               };
>> +
> We typically have the .dts{,i} changes in a separate patch. I suggest
> doing the same here.
> I also have two questions about this part:
> - why are these not referenced by the SPICC controller node?

Because it's up to the board to use or not those states, if some pull-up/downs
are already present on the lines no need to use those special states.

> - is there a particular reason why meson-gxl.dtsi is updated but
> meson-gxbb.dtsi is not? (my understanding is that GXBB is also lacking
> hardware OEN support)

Good question indeed, so indeed they should be added in meson-gxbb.dtsi in a separate patch.
> 
> 
> Best regards,
> Martin

Thanks,
Neil

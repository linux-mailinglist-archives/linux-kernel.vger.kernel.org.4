Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3382A721E0C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjFEGYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFEGYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:24:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF34DC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:24:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f5021faa16so5450139e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 23:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685946244; x=1688538244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+rq5XkqN28INce3TzLWsTQLy6BL9Bx5PmUS8c7Jaoc=;
        b=iIM6Ehv/5Tuame+j/7VHDY/RJzfdGmjMN/9anQ7EDq7HLd1EOta0j10Qed1nLMTQla
         Saw/Yz71Nz0LgIEQGt/WzYeHhMj26hjs58+WaadXcQzDoyy1d/uQUuuuOHOmKrJsD8RK
         K6z7cDAtyeF2MdOjIZAI/aKyVg6Sr0YsfTgwoZGzjnUaI2uhmevmfNTEmZT822OxOQ01
         OBQZEnYCn+oiWjqe3owQKt7QrVnJuuTzm3Fr6mwyy82Si2v0aIjv5NrrfpRnZaAV11wW
         g0s76nXLTAGBPtX8gvVsJc2FKlrEhJ1E+RbXysjiCPK0NTEj6iiBKwYJns9kEopyak4U
         kQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685946244; x=1688538244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+rq5XkqN28INce3TzLWsTQLy6BL9Bx5PmUS8c7Jaoc=;
        b=dapNs6R6guIQ8Fkz0mVzlBrlSJdX2iGAToBhKw3VGxSXkBGRxUwXpjD9dJvLKKQfk6
         bvCe5ZJJS7RddSNN5y10yp6H2j5p279OqRkcdchsRGT0Du1FZQWWNoPxsOslc5yte2gV
         mctP9QTR0oyitGVy42rzxwUs429UL/sTK8oGP1LhjqruVlbpqyrPKxi8RvTBb9XmDbHf
         9dDs+5IUwf4JDBLTTrx2+Ox96nFGD3+iHw0qD35gn5BwlXz3DIq4u1W+E5lI3JKn56HP
         xrQkQanz5Pd0g3zqu9tqZoAEoMuBqTp+76WGoz2hhDCH0GleRmuQzSzqib4FlzcxU8HK
         MNng==
X-Gm-Message-State: AC+VfDzanttJKsOZJdfAdU5DnOxWNCKdU+APeY6czBQ8AK6W8Eh3WiVl
        t2nKiMfB+rWkCszgHgilXqBHTw==
X-Google-Smtp-Source: ACHHUZ721HTzywDNwWlcZQjpy3ZTbwS6sBCP+LYgCL+Orn1Z1WX8P/q9HPfxZPhBQLsIqlR0HXoUsw==
X-Received: by 2002:ac2:5a01:0:b0:4f5:a181:97b1 with SMTP id q1-20020ac25a01000000b004f5a18197b1mr4917129lfn.50.1685946243884;
        Sun, 04 Jun 2023 23:24:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bc10-20020a056402204a00b00510de087302sm3511072edb.47.2023.06.04.23.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 23:24:03 -0700 (PDT)
Message-ID: <7e9e5588-46bc-51bf-13d3-7d47d2bee6ec@linaro.org>
Date:   Mon, 5 Jun 2023 08:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: Add Allwinner
 D1/T113s/R329/T507 SoCs GPADC
Content-Language: en-US
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230601223104.1243871-1-bigunclemax@gmail.com>
 <20230601223104.1243871-3-bigunclemax@gmail.com>
 <fbcc5688-387c-32fb-edac-17848c92b936@linaro.org>
 <CALHCpMizv52yj0rw0pR8pYjSys2UivS4L4GkWLgc-d91bdmDCA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CALHCpMizv52yj0rw0pR8pYjSys2UivS4L4GkWLgc-d91bdmDCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2023 22:20, Maxim Kiselev wrote:
> пт, 2 июн. 2023 г. в 11:38, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>:
> Hi Krzysztof,
>>
>> On 02/06/2023 00:30, Maksim Kiselev wrote:
>>> From: Maxim Kiselev <bigunclemax@gmail.com>
>>>
>>> Allwinner's D1/T113s/R329/T507 SoCs have a new general purpose ADC.
>>> This ADC is the same for all of this SoCs. The only difference is
>>> the number of available channels.
>>
>> Except that it wasn't tested...
> 
> Yes, you are right. I tested it only on the T113s board. And I will be glad if
> someone tests it on another SoC.

Please show me the commands how you tested bindings on T113s board. I
really would like to see them...

> 
> ...
> 
>> Please run scripts/checkpatch.pl and fix reported warnings. Some
>> warnings can be ignored, but the code here looks like it needs a fix.
>> Feel free to get in touch if the warning is not clear.
> 
> I got a warning about required maintainer property. Should I do
> anything with this?

You should do something because sending broken code is not correct.

> If yes, then who should be a maintainer?

Someone responsible for this hardware.

> 
> ...
> 
>> Hm? So you do not allow anything from adc.yaml related? Are you sure
>> this is your intention?
> 
> I'm not sure about it. I looked at other ADC bindings and didn't find
> another driver with 'additionalProperties: true'

I didn't write about additionalProperties:true, but about missing ref to
adc.yaml.

Best regards,
Krzysztof


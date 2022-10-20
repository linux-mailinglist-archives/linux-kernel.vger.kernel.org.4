Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3AA605F90
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJTMAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJTMAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:00:33 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88CB10B66
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:00:31 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z8so13495545qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A29LATjKRu0eJyZf1li9gtTtcrd9vRWs2MhC8cVGWxA=;
        b=zdXq2ZWOf+kBQAJ50NbogZcfiG0qZPePutWtHEhKeegdtOWL1wTmCHgw23EJp425+c
         Td5S4yCvuYmGHcOLZ8p4mkKYX64yDjk25aZs/f3qAdvWQXz9gfLVRsIMg/imY2DM2Ld5
         /ccleL9a37cuOaIdkZHK2wTXvmzdEZ6PZzUQzDG3ZhTTYTVrCtfHWqbWfBamI1vHFxoF
         ULLYcjA76tqAwvmw2j5J1+ubn3fWVabtXxoySbAr7bXlBvK+Bqca0rnVYOL/7nnnIxq4
         Oot108r5U7+S9oatZi8YvONoChoeoixOSz9/oOv6Vz8gv3KLYNui3BJ0evFo7R65nG3W
         1SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A29LATjKRu0eJyZf1li9gtTtcrd9vRWs2MhC8cVGWxA=;
        b=ElzKa8jkTxkjM37NiDg0D2REOEOb41p6CJ554JCu7yEA8VGdr+3Ayjv77E8ePniJnp
         Oq/NHxi0qotHA2HfUhVncnLCkEh2oQPfP6su6QEr3InEzMyKKNY9XLz5KYvXCu4keqH1
         UgaMmtIffY1XsR83YzIEM0f0KlUAgBDl1ypyL3V+bzEuqJjAr7UAOwl7L7qsWAFF3A6A
         J6cumjsO4lShvyBXGCgRK6bpbiuDCHZcWzeCDe7se86Zsy8nbhT0kT5HaOKsoiu7yKQ0
         M6vKDpKChWxw8e6np/IYVjMLE6tjAg01A5Bpd24OTZgW5nQHMTPcihbw1EumknjYmrQ4
         h+0A==
X-Gm-Message-State: ACrzQf2YG/PZU6/9r6BybUnPtmz3VTgEPB9C/eYJfGuFdicwrLXRpsZM
        k7ylBfyMxgLVWwoZ9JOHtOGjgg==
X-Google-Smtp-Source: AMsMyM6eVViG4LXv1H82MSpp3Hhgprwb3+orqfs74ID/Coou2aSueOhKs1MTstIJbBBjLCoS0NGi7A==
X-Received: by 2002:ac8:7dc4:0:b0:39c:f95f:57fe with SMTP id c4-20020ac87dc4000000b0039cf95f57femr8723185qte.612.1666267230880;
        Thu, 20 Oct 2022 05:00:30 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id a10-20020ac85b8a000000b00397b1c60780sm6092213qta.61.2022.10.20.05.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:00:29 -0700 (PDT)
Message-ID: <b682cf05-2d96-d7e4-6f86-b1776d16b132@linaro.org>
Date:   Thu, 20 Oct 2022 08:00:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/3] doc: iio: pressure: ms5611: added max SPI frequency
 setting to the example
To:     =?UTF-8?Q?Mitja_=c5=a0pes?= <mitja@lxnav.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019125254.952588-1-mitja@lxnav.com>
 <20221019125254.952588-3-mitja@lxnav.com>
 <a44cadfe-5e9d-8c6a-b111-abd550a909bf@linaro.org>
 <CACbQKWdyE2Q7wya4JwAv2+9-1M3oSrB3YfR+qfM3M7TiHjukew@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACbQKWdyE2Q7wya4JwAv2+9-1M3oSrB3YfR+qfM3M7TiHjukew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 01:40, Mitja Špes wrote:
> On Wed, Oct 19, 2022 at 5:49 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> 
>> Use subject prefixes matching the subsystem (git log --oneline -- ...).
> 
> Will do.
> 
>> Whether it is honored by driver it matters less. More important is how
>> hardware can handle it. This should be included in the bindings/properties.
> 
> The hardware handles frequencies up to 20MHz. That constraint is already
> written in meas,ms5611.yaml.
> What my patch 2 does is allow the user to set a lower frequency and the patch
> 3 just emphasises that in the example.

Then I am not sure whether it is worth changing. This is just an
example. Old value is correct.

Best regards,
Krzysztof


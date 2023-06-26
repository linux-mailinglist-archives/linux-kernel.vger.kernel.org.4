Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E588173D960
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjFZIPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjFZIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:15:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D90D3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:15:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so1153740e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1687767329; x=1690359329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGHIp8kHu6DlaBCXCBrSvc/vTmF8AY6pN2wBGIxEnlk=;
        b=V0EyxmfmCo2Hf6/R85d0aGj9BUo3B3nesAuH0xVCQ3J8Q3Y65/3/1kEBSmxXSa8UnC
         rfLypoH8Dh13y5ndsaRSDZFzsy3b/auCLtPBnrn8jAZ3gVufNemi8D3XFXqz5uCs2sT3
         zHf5iRFWVKngIk/Ww6HdJdQQXgq4dNpOD0fN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687767329; x=1690359329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGHIp8kHu6DlaBCXCBrSvc/vTmF8AY6pN2wBGIxEnlk=;
        b=ju/9Yg6hSppc+qxXiXAyrkrtjbJxPJiJuPTVbMwXheCw1yYUf5px5DiZQrO4tFwOww
         fe9gIqO1hDDE+rsFCYdqbhFyuJ8149M8ciel/W1cij7R8mgJh5vX6fId3c9ssl/kBge1
         EnnxAWDn90KKPkZFf8RO4rNR8K88yY/2rlko2/8jiTIQj+mc9kVyUuB7EWtZDxCIdmaE
         qmU3YReApQJ2mL/zPOewgrh0Lu9H+X52TnsaoDs8z5d3hVt+v4ntxLhZrbiRI+TLo9eT
         ZUrUZ1HJE7gnKEjuY+CpDWnOXAlS73UlWAtZeYWQOiHKqc0p8OvUT81mHNhxPkPcvPrH
         JXzg==
X-Gm-Message-State: AC+VfDwNKjFmGibi2vEZGB5Sqjlt7shqjIEkrdaTipHOCouHWOtcbFvi
        C6xh+Rx6zzr4XQUqgRb6/7OnBw==
X-Google-Smtp-Source: ACHHUZ5sFqSVHquJ2u3PCj1RybPPFSGEJ80M6/wIJ+raPGuyV4/OsGHJNEcQkSk6BuLksd0VWia5UA==
X-Received: by 2002:ac2:4c4c:0:b0:4f6:3ef3:13e8 with SMTP id o12-20020ac24c4c000000b004f63ef313e8mr10976540lfk.0.1687767328959;
        Mon, 26 Jun 2023 01:15:28 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z22-20020a19f716000000b004f4ce9c9338sm993754lfe.283.2023.06.26.01.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 01:15:28 -0700 (PDT)
Message-ID: <8176d552-9829-5442-3ce9-805744b8389e@rasmusvillemoes.dk>
Date:   Mon, 26 Jun 2023 10:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: ad74413r: add binding for digital
 input threshold
Content-Language: en-US, da
To:     Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230623113327.1062170-1-linux@rasmusvillemoes.dk>
 <20230623113327.1062170-2-linux@rasmusvillemoes.dk>
 <20230623-casket-outer-2c9d2a0c4795@spud>
 <20230623215731.GB1216324-robh@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230623215731.GB1216324-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 23.57, Rob Herring wrote:
> On Fri, Jun 23, 2023 at 05:44:50PM +0100, Conor Dooley wrote:
>> On Fri, Jun 23, 2023 at 01:33:25PM +0200, Rasmus Villemoes wrote:
>>> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>>> index 590ea7936ad7..1f90ce3c7932 100644
>>> --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>>> @@ -51,6 +51,14 @@ properties:
>>>        Shunt (sense) resistor value in micro-Ohms.
>>>      default: 100000000
>>>  
>>> +  digital-input-threshold-microvolt:
>>
>> Should this not have an adi vendor prefix, similar to
>> "adi,digital-input-threshold-mode-fixed"?
> 
> Yes.

OK. But I'm not really sure what the rules are for when such a prefix
must be added, so some guidance would be appreciated. There's

- DO use a vendor prefix on device specific property names. Consider if
  properties could be common among devices of the same class.

And my thinking was that a threshold for when a digital input should
count as high/low would be a rather generic thing, so not particularly
device specific.

Also, this very binding has a shunt-resistor-micro-ohms, and the
individual channels have a drive-strength-microamp (granted, that latter
one is a recent one of mine and may have slipped through review?). I can
certainly understand that when a property specifies a raw value to put
into some register (or field), that's very specific to that chip (or
small family of chips) - the adi,ch-func properties fall into that category.

Rasmus


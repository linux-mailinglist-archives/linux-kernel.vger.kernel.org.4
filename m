Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3BA6B3ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCJJkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjCJJkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:40:06 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0A913DEF;
        Fri, 10 Mar 2023 01:39:04 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id i9so5824607lfc.6;
        Fri, 10 Mar 2023 01:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678441142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0x3xu+IQqUy76/YHjIAn44nCTGMOHVCOYOpdZnB6Hg=;
        b=LGExTbYx2Ibv0WdLc88eg+o+ODcOiOPWXGcqcvzOjQepePVRlVTkGArtS+AMlR4HLI
         uJgUzNXtWUcCD0TU58WD2QcYfmIaxKeFNhp5R4NZNU6tH+yr3t8FGUcEMo5bh2kvsAGG
         MB4FlOJdF9m4aoxbK+jhqfIrzqbnoH+ZUKFlz/IlLgBH9YXUBsf4jzdmICNOT0txxwmP
         stmgAC5chef0+OH9/veBhGoFpufkOEhlDlwwKitZRbq7C/YfgWSgRwzMFo4TjX/GK1CU
         ClFyUvFncFgiF5hLRPINyf4uqU/Q+qqZBLISEgmZSU3mIDLZfsyIYrywEcZFLHBbuc4y
         BJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h0x3xu+IQqUy76/YHjIAn44nCTGMOHVCOYOpdZnB6Hg=;
        b=UCoHitWChcxGte0oO7+4BnVNc1wG4cV/7Z85ATL4tfMZeoBpywRqnW1ic0as9T961j
         F4wj0a9+SvV1SD8GDED9o2Xt0uD3VI+tiEq5uqh5yhPe04i8qO5VlMmfc94wZc03RIET
         oXStsdpxMKBgvk1IatNZWZoKYxOosc01jYUvG2UkhGWdECtUozQCJ1Szs9icci8+DYoT
         OTvalbZy9Xf4sDBFl1EQwJnhEiDgZy3tAagOOmcqH0lDdXC0Yonr8QVuT6izH5dvFK8H
         yvbJARH4ZyIjmgxoTgvDf3sQ5MFcs7E7FYZvMU/56AyF7L2Mhf8n1t3zrWB3z+7tUfjA
         8EwA==
X-Gm-Message-State: AO0yUKWOFhYabUZ1rQi/UTgF/VhsPpQjtBWUtgNkwo1tW4idcyuLRL9Q
        X8hmUVWLwpqdbz1Wd9oNf7Y=
X-Google-Smtp-Source: AK7set9TfOyAKJ2Um2caTpmFTf0qY1/GHjNxmHgcUGxF2MxzcHV39QM+kTMOkb+XaW2MgPHqjvRhLA==
X-Received: by 2002:ac2:4c90:0:b0:4b3:d6e1:26bb with SMTP id d16-20020ac24c90000000b004b3d6e126bbmr7152610lfl.29.1678441142207;
        Fri, 10 Mar 2023 01:39:02 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id g26-20020a2eb5da000000b00298798f7e38sm176139ljn.77.2023.03.10.01.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:39:00 -0800 (PST)
Message-ID: <c888eae2-f480-2fc0-ccd7-3e638ccca39e@gmail.com>
Date:   Fri, 10 Mar 2023 10:38:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V3] dt-bindings: nvmem: convert base example to use
 "nvmem-layout" node
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230310075145.3996-1-zajec5@gmail.com>
 <20230310075145.3996-2-zajec5@gmail.com>
 <9d8ef6df-c0b4-f578-26c3-b186d43c9660@linaro.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <9d8ef6df-c0b4-f578-26c3-b186d43c9660@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.2023 10:29, Srinivas Kandagatla wrote:
> 
> 
> On 10/03/2023 07:51, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> With support for "fixed-layout" binding we can use now "nvmem-layout"
>> even for fixed NVMEM cells. Use that in the base example as it should be
>> preferred over placing cells directly in the device node.
>>
> Fixed layouts are the core part of nvmem, am not sure why you want to deprecate this. Either we derive the cell information dt or via layouts or some post processing they should still endup as fixed layouts.
> this way the core part is always same irrespective of where the cell info comes from.

I really don't understand why my changes get misunderstood. It's just
happened another time. Yesterday Michael wrote: "your motivation to drop
handling the fixed cells".

Again:
I DON'T deprecate or drop support for fixed layouts (fixed NVMEM cells)
I DON'T deprecate or drop support for fixed layouts (fixed NVMEM cells)

I just want NVMEM bindings to move location of DT fixed NVMEM cells from
*device* node to *nvmem-layout* node.

Also:
I WON'T drop support for old binding. We stay backward compatible.
I WON'T drop support for old binding. We stay backward compatible.


>> New and other bindings should follow as old binding will get deprecated
>> at some point.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   .../devicetree/bindings/nvmem/nvmem.yaml      | 42 +++++++++++--------
>>   1 file changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> index 732162e9d13e..c77be1c20e47 100644
>> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> @@ -67,24 +67,30 @@ examples:
>>             /* ... */
>> -          /* Data cells */
>> -          tsens_calibration: calib@404 {
>> -              reg = <0x404 0x10>;
>> -          };
>> -
>> -          tsens_calibration_bckp: calib_bckp@504 {
>> -              reg = <0x504 0x11>;
>> -              bits = <6 128>;
>> -          };
>> -
>> -          pvs_version: pvs-version@6 {
>> -              reg = <0x6 0x2>;
>> -              bits = <7 2>;
>> -          };
>> -
>> -          speed_bin: speed-bin@c{
>> -              reg = <0xc 0x1>;
>> -              bits = <2 3>;
>> +          nvmem-layout {
>> +              compatible = "fixed-layout";
>> +              #address-cells = <1>;
>> +              #size-cells = <1>;
>> +
>> +              /* Data cells */
>> +              tsens_calibration: calib@404 {
>> +                  reg = <0x404 0x10>;
>> +              };
>> +
>> +              tsens_calibration_bckp: calib_bckp@504 {
>> +                  reg = <0x504 0x11>;
>> +                  bits = <6 128>;
>> +              };
>> +
>> +              pvs_version: pvs-version@6 {
>> +                  reg = <0x6 0x2>;
>> +                  bits = <7 2>;
>> +              };
>> +
>> +              speed_bin: speed-bin@c{
>> +                  reg = <0xc 0x1>;
>> +                  bits = <2 3>;
>> +              };
>>             };
>>         };


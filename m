Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB16D6B3A86
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjCJJcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCJJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:31:34 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9887F7ECC;
        Fri, 10 Mar 2023 01:29:04 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f16so4629503ljq.10;
        Fri, 10 Mar 2023 01:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678440543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mSwf0rGQ8x0u1j0oGWyGKKWuU21FbO9JFQh9IL0RB4=;
        b=hfhJgCsTeZMYnVjSLltrtOYM1zjhXQ/1SB/kxMOXgXprh3CSejpE/PXYN2s2sLpNhF
         4I388iujFO2UEEsr2RH3gESoAny3oj5Dfq7nCysmori96vVrvTwcX09lWKqT88OGNzIS
         /y2KgrJonfNQbTV7KhzJZ8SN2vXb1BVou92KbXQJLLP7f2uF9gXa14W8B9H9P87Lynam
         Cz85pakD/rhsd7Xqk5DuvjCEB1yTCQtRvmohgNd8HDVvi2mGfa6KJAPznysrWhiCtRUW
         wO/+HyCfQCWMXcHYLr0vicRRmdOs1C250Yl78Gs7Vizw6v6V6sHYj2ktfjaet6aNa4Jg
         1CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678440543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6mSwf0rGQ8x0u1j0oGWyGKKWuU21FbO9JFQh9IL0RB4=;
        b=Hak6fdO9cBKJICnuypbUquFsbAnCFl3nRgFRh14NSh6xlICD5YR6p5RKV9K/AxK/fs
         gIQmbfusZw+MDlPUOv8+MVQJTlbMmLxMgNSatjCFSAfUwEjRafFP5eejV2svY6JJfrwX
         +ORTsJ4V/d6Ux8etkXhzeNvf0UCLiB+lHBlc2yUn27jxe+mPcIFJnkiOAWdANcZXhANF
         w76thRMVJllLzYWqH5dZpLq24NRk/1/NNvk+u2f8lJKdvChrMvEY5ymG27wZmOJ5pn3z
         /tZWOXfQNVBjpwC9DBBeJLCM0TEeAnmyPpdNtmHSbsIfRNJYZHRK9O/8K/iBGBNdnnHv
         Fp0A==
X-Gm-Message-State: AO0yUKUAnSJbaLyXB+m0p34UjLeuuDkMu6NY3Rs+tsYZAw22D3t6xDjD
        A0FCXI4T8zHGOd/QnL0pCzA=
X-Google-Smtp-Source: AK7set8CAkp0aHOPveS0Dj8kKzbOESje0Rd2eijoXBTfbyNUA4abtdm2Pkfy0va5/evbEgevCgHwSg==
X-Received: by 2002:a2e:be06:0:b0:295:9c2e:7324 with SMTP id z6-20020a2ebe06000000b002959c2e7324mr9871637ljq.4.1678440542850;
        Fri, 10 Mar 2023 01:29:02 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id e7-20020a2e9847000000b002946fb5b50asm171446ljj.139.2023.03.10.01.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:29:02 -0800 (PST)
Message-ID: <bce301fa-745b-8aee-d981-a9e4662c5c94@gmail.com>
Date:   Fri, 10 Mar 2023 10:29:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V3] dt-bindings: nvmem: convert base example to use
 "nvmem-layout" node
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230310075145.3996-1-zajec5@gmail.com>
 <20230310075145.3996-2-zajec5@gmail.com> <20230310095902.33b1d314@xps-13>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20230310095902.33b1d314@xps-13>
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

On 10.03.2023 09:59, Miquel Raynal wrote:
> Hi Rafał,
> 
> zajec5@gmail.com wrote on Fri, 10 Mar 2023 08:51:45 +0100:
> 
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> With support for "fixed-layout" binding we can use now "nvmem-layout"
>> even for fixed NVMEM cells. Use that in the base example as it should be
>> preferred over placing cells directly in the device node.
>>
>> New and other bindings should follow as old binding will get deprecated
>> at some point.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   .../devicetree/bindings/nvmem/nvmem.yaml      | 42 +++++++++++--------
>>   1 file changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> index 732162e9d13e..c77be1c20e47 100644
>> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
>> @@ -67,24 +67,30 @@ examples:
>>   
>>             /* ... */
>>   
>> -          /* Data cells */
>> -          tsens_calibration: calib@404 {
>> -              reg = <0x404 0x10>;
>> -          };
>> -
>> -          tsens_calibration_bckp: calib_bckp@504 {
>> -              reg = <0x504 0x11>;
>> -              bits = <6 128>;
>> -          };
>> -
>> -          pvs_version: pvs-version@6 {
>> -              reg = <0x6 0x2>;
>> -              bits = <7 2>;
>> -          };
>> -
>> -          speed_bin: speed-bin@c{
>> -              reg = <0xc 0x1>;
>> -              bits = <2 3>;
>> +          nvmem-layout {
> 
> I believe we should not introduce "intermediate state" bindings when
> this is not strictly required, in order to avoid confusion with what is
> backward and what is transitory. So I would expect this to only apply
> after the switch to:
> 
> 	nvmem-layout@xxx {
> 		reg = <xxx>;
> 
> I don't care who will take care of it, but I think it would be better
> to have everything in one series.
> 
> Other than the "order" problematic which I think is important here, I
> agree with this series.

I fail to see how / why:
1. Adding new NVMEM layout
2. Supporting mutliple NVMEM layouts
would depend on each other.

We already have 2 NVMEM layouts bindings. I'm just adding a new (third)
one.

If having NVMEM layouts bindings puts us in any kind of intermediate
state then we're already there. I don't think my new NVMEM layout
changes this situation.


>> +              compatible = "fixed-layout";
>> +              #address-cells = <1>;
>> +              #size-cells = <1>;
>> +
>> +              /* Data cells */
>> +              tsens_calibration: calib@404 {
>> +                  reg = <0x404 0x10>;
>> +              };
>> +
>> +              tsens_calibration_bckp: calib_bckp@504 {
>> +                  reg = <0x504 0x11>;
>> +                  bits = <6 128>;
>> +              };
>> +
>> +              pvs_version: pvs-version@6 {
>> +                  reg = <0x6 0x2>;
>> +                  bits = <7 2>;
>> +              };
>> +
>> +              speed_bin: speed-bin@c{
>> +                  reg = <0xc 0x1>;
>> +                  bits = <2 3>;
>> +              };
>>             };
>>         };


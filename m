Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376F16E083E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjDMHvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjDMHvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:51:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2598A74
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:51:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q23so25721932ejz.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681372265; x=1683964265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HjNjxnqb6hU+2+eJjfWkIy3VP2/PGK4AKKbOuWrfBk=;
        b=VenKzUXum1WC8WhPJHgXJIgq+yV/KS+87msuPxRP/nzhzMZVWsVyhzTLktuOrfxMTA
         PRfYFt5e/0L/8SoVulBkt2IwjHvK5fJ9Hu15cTdV+HZMSiFtKX1ctjFHtu6BZG+sNGQV
         3mi2rGV9tH/BjX8S3jea9mAMJ6ikE5ZF1dFdoeZpjRFMZiIVhjQfy9Y8GaCZG4sXJDes
         uCfiYL0NrCqY+DXazd2063DLYo5icIqx/+uWF4RS081+SY59hqSGn4wSNwdmQt6jRJ5B
         jbdZaFjgmCNp+9d4gvs1+7617sBQLO9Zgm5ZDuZpvhe/WfADoWvKsa28L+Q/JwdcLwxd
         1vwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681372265; x=1683964265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HjNjxnqb6hU+2+eJjfWkIy3VP2/PGK4AKKbOuWrfBk=;
        b=Kp0JD7Og/QTNOf3StjCUZVcs0UrF4dXZEp1h/96/4/QmqZVu0xPF/pUlowqEFJUMDI
         X5Wra2gf2rpGpXS7wc4cVxnQEbweY3OOLB8/fcvdyeft9vs1xa5mBIwxnyNM6+INUgDK
         ZTilqfQt3xk0eCLV8dDEAze7FY4p65yyes1iFRuOoEKfME0AfjGBsuj9FcbKmP2hPvOW
         3Sfm2nZpJB66eXOU6zp4PHnDGBygtlLLtE9YGuSPL/47HlsnfuxrE/f68NckDWCuxpi+
         WvNlbudB/Cdf8zGqGba16JGrxLWNpi7KrzSAdWzSCHR70ShCwkW5t9YsuSV2V8K8yRwH
         pAeQ==
X-Gm-Message-State: AAQBX9dCMKozfbnA4yjhkONDhMaAIohFS7AQUaiPBHi6A0wRg0OJ9CvA
        TwSBLJ4rOY2EtfqnNNpH7cjwxw==
X-Google-Smtp-Source: AKy350YBW9sE5WmTvAC/oPxE0mX3fMqjuszHzpvJwO6zlZqO//+M1QHYDIrC0O9MYxm2CAmwQ4putw==
X-Received: by 2002:a17:907:6c11:b0:94e:afa6:5f4f with SMTP id rl17-20020a1709076c1100b0094eafa65f4fmr611716ejc.44.1681372265286;
        Thu, 13 Apr 2023 00:51:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7? ([2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7])
        by smtp.gmail.com with ESMTPSA id vv5-20020a170907a68500b008cecb8f374asm586500ejc.0.2023.04.13.00.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 00:51:04 -0700 (PDT)
Message-ID: <799bd591-0f9a-e8fc-85f6-093314b6af23@linaro.org>
Date:   Thu, 13 Apr 2023 09:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] ARM: dts: mvebu: Add device tree binding for
 Marvell Armada 38x
Content-Language: en-US
To:     Tony Dinh <mibodhi@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
References: <20230412025737.20280-1-mibodhi@gmail.com>
 <20230412025737.20280-2-mibodhi@gmail.com>
 <168130276446.1439316.3427548118074442016.robh@kernel.org>
 <CAJaLiFxNbz+EygSy8OMKafZ667ingeiTw8Z17p3dwtPTpiH40g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJaLiFxNbz+EygSy8OMKafZ667ingeiTw8Z17p3dwtPTpiH40g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 21:05, Tony Dinh wrote:
> Hi Rob,
> Hi Krzysztof,
> 
> On Wed, Apr 12, 2023 at 5:36 AM Rob Herring <robh@kernel.org> wrote:
>>
>>
>> On Tue, 11 Apr 2023 19:57:35 -0700, Tony Dinh wrote:
>>> Add device tree binding for Marvell Armada 38x.
>>>
>>> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
>>> ---
>>>
>>> Changes in v2:
>>> - Add marvell,38x.yaml. For now, add this binding to the Marvell
>>> directory to keep it consistent with other Marvell yaml files.
>>> At a later date and a separate patch, consolidate the Marvell
>>> yaml files into  marvell.yaml.
>>>
>>>  .../bindings/arm/marvell/armada-38x.yaml      | 27 +++++++++++++++++++
>>>  1 file changed, 27 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> ./Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml: $id: relative path/filename doesn't match actual path or filename
>>         expected: http://devicetree.org/schemas/arm/marvell/armada-38x.yaml#
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230412025737.20280-2-mibodhi@gmail.com
>>
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your schema.
>>
> 
> Thanks for the reviews. After running make dt_binding_check for it
> seems like hours (on a dual-core 1.8GHz ARM box), I got impatient and
> used
> make CHECK_DTBS=y armada-385-thecus-n2350.dtb
> 
> I'll move this to another faster box and run make dt_binding_check.

So many questions...
1. Why do you have to run it on arm? Not on regular machine for work? No
one of us does like that...
2. You are now mixing now two different commands. You were asked to run
DT_SCHEMA_FILES
3. Read the provided guide how to speed it up. It runs within few seconds.


Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DEB654F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLWLHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWLHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:07:03 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09031186B7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:07:01 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id cf42so6718150lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hMsumwP6KT2UUsGNA6AWGptXKAy5xS1cl3T0zVPx0k=;
        b=HJDOnXZy6oV7VlYeiWa5i593GbfluXa8NJ9ZMW0y3hQjI3oD/hX3sWxM5VylTJ7NrW
         K5+EBpnqltpOFjqy7Q7+LqOQ3VqZ/w7MWTSWrtXKoWUq/cDpHnARxs8Uv1wrAggY5fZW
         0wd/9wHzMU7sba7o45yGLFFCk169BUU153qyrM2CwuYn3GVFI6Us2CVnJ06v1hEHMb5z
         n5Wxc5lOfoEdMmtuN/FWh33xFSI0oAk2i8jN21x55VOH3v3rjw4I95dnkJAMliXvTm5d
         tKYcul2403olv7t1rK/bx2e8pgJzy95YzexHV0nmXNDM6CBHRiCUrCLY1vzLeiz9MQWe
         UlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hMsumwP6KT2UUsGNA6AWGptXKAy5xS1cl3T0zVPx0k=;
        b=KXr3rKrPODJ2BJ+ywDDW/euMuYtsHFc6KkbWPgRRkH6uXOty+GAJm463+7eOkA7zJi
         kfK3jjiaNBDlP584HKtaA/XYOhZ7RRtvZWiVi1Ro2htvZ63jWbgQx5JH1kAEze1qqdMA
         y16pKhbRGapwEDwGgn4Y0nlyjW09ud8bCpNcosHIzktbzSQgzYawG94T7WmS8EhG+11I
         NRBfC+dX8YsOh9ElCuX9NMiMYsHFtGRXyogDaGYfnbHumP0fI8Jlm6O9LubHjZ8pStha
         aickxo9gSgz37w/rLcTyofsPfjxOZ0zWCv0c/sL1L785vY4FEvZ9BwFOGV+1QTqQpfk3
         8Gdw==
X-Gm-Message-State: AFqh2ko9O3y92NFxv2ExkNp3fBbvFPu8kCPyJfTSszm795MLSeIkmoNw
        MWHRJcoHmXY/In+aETQBwvPebg==
X-Google-Smtp-Source: AMrXdXuiXxUqsVNqsObnU18wuXFBsbf9EZVBefCEZpE/VJxhS6U9Xl25fzkp53euOGSKLfCyH3rPfg==
X-Received: by 2002:a05:6512:602:b0:4c4:6a8e:30 with SMTP id b2-20020a056512060200b004c46a8e0030mr2558660lfe.30.1671793619322;
        Fri, 23 Dec 2022 03:06:59 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y11-20020a19750b000000b004b4b0a68f67sm478401lfe.185.2022.12.23.03.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 03:06:58 -0800 (PST)
Message-ID: <10750c3f-016d-905d-9c04-e41cd9248dd4@linaro.org>
Date:   Fri, 23 Dec 2022 12:06:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains
 property
To:     Felipe Balbi <balbi@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219191038.1973807-1-robh@kernel.org>
 <87edsua5q4.fsf@balbi.sh>
 <CAL_JsqKgGWN93QJ=V34=X3hC2bgdcd3vwO0Mne-8z8HOfVDz-g@mail.gmail.com>
 <878riy9ztm.fsf@balbi.sh>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <878riy9ztm.fsf@balbi.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2022 11:31, Felipe Balbi wrote:
> 
> Hi,
> 
> Rob Herring <robh@kernel.org> writes:
>>>> The Rockchip RK3399 DWC3 node has 'power-domain' property which isn't
>>>> allowed by the schema:
>>>>
>>>> usb@fe900000: Unevaluated properties are not allowed ('power-domains' was unexpected)
>>>>
>>>> Allow DWC3 nodes to have a single power-domains entry. We could instead
>>>> move the power-domains property to the parent wrapper node, but the
>>>> could be an ABI break (Linux shouldn't care). Also, we don't want to
>>>> encourage the pattern of wrapper nodes just to define resources such as
>>>> clocks, resets, power-domains, etc. when not necessary.
>>>>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> index 6d78048c4613..bcefd1c2410a 100644
>>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> @@ -91,6 +91,9 @@ properties:
>>>>          - usb2-phy
>>>>          - usb3-phy
>>>>
>>>> +  power-domains:
>>>> +    maxItems: 1
>>>
>>> AFAICT this can be incorrect. Also, you could have Cc the dwc3
>>> maintainer to get comments.
>>
>> When we have a user with more and know what each one is, then we can
>> extend it. All the other users (upstream), put 'power-domains' in the
> 
> Won't that be an ABI break at that point? You'll change the maximum
> number of power-domains.

Usually extending properties (in flexible way) is not an ABI break. What
would be broken here if it becomes three at some point? Does Linux or
other SW depends now on this being equal to 1?


Best regards,
Krzysztof


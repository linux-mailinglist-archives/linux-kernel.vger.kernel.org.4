Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E617E60B69C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiJXTFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiJXTEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:04:40 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BE751422
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:44:29 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f8so6535696qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSvXu+gDOhTNTjin0OY8IbTXcIFF0gLkR0gNINOAEVY=;
        b=Ofawpqmt1wvR6qRkmACgRChvaROTlZwjg9Q/uHnxpjvNWzHzLoEkXXSDzQxufmcuon
         URMQUvhuKpQLeqGBiy7r7+kF2P77Xw8wAMJFMtyulo1Q9TJu8ea/+a5Ct8f9FDhprWkX
         q3egOEXcTWvNJiH9ylpuvtDp+E1ZYWFt1rRJPP0aIkGMmcLuxMb/6pCDrMkWKfdpqB8j
         RaQlitvQnLkHATwNsZCJQTl24+rHDn4y5ZTw22gKQkqb5i3cQ5k+L52MkA2XWik08JiQ
         m3Eeu+v4fk9Nl7Q/9fUYcmG5x4Ct1ZWSRTKeJ8nAxiLrE09VQbeJAVIjeyad/UEVMB1m
         MxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSvXu+gDOhTNTjin0OY8IbTXcIFF0gLkR0gNINOAEVY=;
        b=62xFM4B/MMQeiu4wVwIoKbeEpEZ8aZAG/c6g1z2fOovuslm5zsiFVBDCkW+JA1In03
         cKCF7UpiPHhAnjyEgf+MAnUIMEB+4104TAXkFFcUW9wpuNMv6zHlZyOK+qqlDVn/Ig8d
         4gB9NchXw5BzhfOEYVWvfBIRSws2fqtpffYXIo7sJPZtcXecz+nEJjNWwco+U93u4AFe
         EW6RwQ9FIhUdY+cT+UU+9Ae+Br2Jy9ethG2qUU38XgFHFqC+jOYaLYAXplWNYDx03iGt
         5ciKdcktdPs4VKILTyBqhqGyeGwzZRCCNd1KJFqrra8fgPqCCBBN09Yo5QsXjafQxZ9+
         vD1A==
X-Gm-Message-State: ACrzQf17MfjUDINDKvRUrLVPrWi5i1b05o1SbMVl8AVqvxrrVWddijUS
        1ycTNyijFJDm9nC3jmPyVATMn4fI0maUhg==
X-Google-Smtp-Source: AMsMyM5QltID/w6i0aH33QyG9ZPWQRp5av4QDzHcJoZdh6g4+6HsPOFZa+kLevpL0SjCg9WoCSmC+g==
X-Received: by 2002:a05:620a:3720:b0:6dd:beba:b3a1 with SMTP id de32-20020a05620a372000b006ddbebab3a1mr22716083qkb.138.1666629117980;
        Mon, 24 Oct 2022 09:31:57 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id s14-20020a05620a254e00b006cf8fc6e922sm211619qko.119.2022.10.24.09.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 09:31:57 -0700 (PDT)
Message-ID: <2901a037-7b0c-1cf4-60fb-b3f6966454ad@linaro.org>
Date:   Mon, 24 Oct 2022 12:31:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: add TCSR node
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221024125843.25261-1-johan+linaro@kernel.org>
 <94e05a63-e7f3-a78f-d0a6-8efcae619726@linaro.org>
 <Y1aWPhP7/ft8s+bh@hovoldconsulting.com>
 <826176ba-d7c6-a64f-e15e-d2694571cb72@linaro.org>
 <Y1anKh24QaXcsS74@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y1anKh24QaXcsS74@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 10:54, Johan Hovold wrote:
>>
>>> The binding has been picked up by Lee now so I posted the dts change.
>>> Could have added a lore link though.
>>
>> This also would work and help a lot.
>>
>> It depends in general on the maintainer - for example Greg does not want
>> to deal with individual patches, especially if DTS is just one patch and
>> USB would be 10 of them. Our toolset is not good for picking up 10 out
>> of 11. For all such cases - please provide link to lore.
>>
>> If however there are just two patches - one DTS and one for maintainer -
>> then having them in one patchset should not cause additional effort for
>> the maintainer.
> 
> I'm pretty sure I saw Lee complaining about Bjorn taking also the
> binding update through the qcom tree recently when someone did just
> that. Apparently it was TCSR related too:
> 
> 	https://lore.kernel.org/all/Yzbk%2F6SQdpNQTahV@google.com/
> 
> Heh. That was you. :)

Yep. It was a patchset of 16 patches where one should go to MFD and 15
to Qualcomm SoC.

>  
>> As you can see on the list, majority of patchsets consist of
>> bindings+DTS. Pretty often entire piece - bindings+driver+DTS.
> 
> Yeah, and whatever alternative you go with, someone will get it wrong or
> complain it seems.

:)

Best regards,
Krzysztof


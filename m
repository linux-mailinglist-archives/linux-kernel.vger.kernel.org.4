Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC8B688815
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjBBULb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjBBUL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:11:28 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96847CC8B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:11:26 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h12so2755081wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 12:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKfaeFsL9aNMopdxufkp2IOj7NlS3f6gXB+wFqAzJTE=;
        b=vN3JI2ARCpraaEdQM11FGCQMOlnUl2EiBsUJBDzBVNgo+a+KL47mY0XwyQxzuuUwKT
         Kid2yDxAk9fG4c7EQ7W3dH0jMRpCc6rXZGwnA65wacGBSS/Xjh9mhYQ3rDYt7Ks0olqL
         qVY5H74w1ARtlNL5Z2YYH/FcM1TZsw7lBFQUHV4QCwLG/2CZtq8XBtNfTWTnaw7It3ri
         Y2NlZNStd0XgikC9ARIVVMsuwiXvcx1TH3l31zP7I4oK1ljbiwBNAdkwjIJD1uYARB59
         82F/ZqveA9BhXIJ1xZoUNwQPMBa7fLcMKEW/MUY7RcERm/uDTvqxcB6lkidtIwzs1O6B
         PigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKfaeFsL9aNMopdxufkp2IOj7NlS3f6gXB+wFqAzJTE=;
        b=NxqDtlQ0NJxMSGSx6nErWxxWTGWY5Dw1IKkJLRKKR1Is8mDZGi2kyB4ugJmmKO2NSB
         f2jr5gMx5Tn7KLDGRKQXeDk6epu3eL5ztwiDgf3ZEVgo+dI6WBKP8bHLjzRat6348yXO
         exW+05aFEzVxDEtff0QP5H7ppVJVSh+8mw6ZD+hmtEwlUUkTw/D8O5ocRCdvEv2NyN1B
         jZLNH13Tnk3R6y5Ot0sWoK8ZT381brxZWYT5ZwhxyKYSpu3oKvevRDYueteUYYiM0DW8
         QuU4vBAwvq6gQ+nDFZA/ALp0Er8x+2vHE9kKYure4oe3T97OXKdjY8ZQGJ9aSVjQnMdU
         OlsA==
X-Gm-Message-State: AO0yUKWeKSviXf5ITPj4cE26A2z/W/8/5Vm9SeKHOxxfkB0AschSRnYF
        1QgStycS0EJkpSxgaRRoGnURWg==
X-Google-Smtp-Source: AK7set8XUGbekPpUIIJngK7BITDv4/cpkt+nT79mBe4msI9gfzSCAJH5ZupP7KZdQ0oyf4bB2i+fYQ==
X-Received: by 2002:adf:e5c9:0:b0:2bf:e5fe:3674 with SMTP id a9-20020adfe5c9000000b002bfe5fe3674mr6256312wrn.24.1675368685149;
        Thu, 02 Feb 2023 12:11:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l25-20020adfa399000000b002bdd155ca4dsm316869wrb.48.2023.02.02.12.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 12:11:24 -0800 (PST)
Message-ID: <f4a545c3-ef1f-39f0-25fd-d9563a950ce2@linaro.org>
Date:   Thu, 2 Feb 2023 21:11:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
To:     Maarten Zanders <maarten.zanders@mind.be>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202101032.26737-1-maarten.zanders@mind.be>
 <20230202101032.26737-2-maarten.zanders@mind.be>
 <20eb5589-8287-90bd-3703-2818b61c6ba3@linaro.org>
 <b9c6c74b-65d2-46bf-bd7c-e031d420f31c@mind.be>
 <5fbb6d80-7280-604a-3e1e-4bd98e9776cd@linaro.org>
 <fa47912f-ec10-f22b-0447-0b7c998711b3@mind.be>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fa47912f-ec10-f22b-0447-0b7c998711b3@mind.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 15:12, Maarten Zanders wrote:
> 
> On 2/2/23 14:43, Krzysztof Kozlowski wrote:
>>
>> Strings in DTS are usually easier to for humans to read, but it's not a
>> requirement to use them. The problem of storing register values is that
>> binding is tied/coupled with hardware programming model, so you cannot
>> add a new device if the register value is a bit different (e.g.
>> LP55XX_CP_OFF is 0x1). You need entire new binding for such case. With
>> string - no need.
> I understand and this is why I started with the string in the first 
> place (as suggested by yourself in V1).
>> With binding constants (IDs) also no need, so was this
>> the intention? Just to be clear - it is then ID or binding constant, not
>> a value for hardware register.
>>
> For simplicity sake, yes, now the setting is propagating directly into 
> the register as a bit value. But this is how the current implementation 
> of the drivers work. If we add a device in the future which indeed has 
> different bit mappings, that driver will have to do a mapping of the DT 
> binding to its own bit field definitions. I consider this DT binding as 
> the "master", which is now conveniently chosen to match the register values.

OK, that makes sense.

Best regards,
Krzysztof


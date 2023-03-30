Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3746CFCD8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjC3Hdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjC3Hdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:33:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC6AE3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:33:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y20so23384731lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680161615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UrwCz/2ptkU0/AeoW0jXW25OTACtteoXP52Ppf7Hdg=;
        b=XUlVPhJAjGFo0Umn/pfktPavvi4lOjOlIWwN3B7jpn0n44XxUiGHEKHnNfPZplFzYL
         kr/T3vQqQPTGN4PYg3TGWtTePGZr10weXqyDWDy5S6a5l2fCwMDJk/W/nWBJWmcMLsB4
         zttLWhNlN1vnY4c4KEa58TDI8cz2aV/K8RZ6l6rr9CA5Mbj1XENaM6hx/qf+LaIXvS3b
         MGrv17oV9HPy9gPWGj/+tfYxaUqHG5DECmRjkqRqA8HqOfRMCTF0tzBxDMC7+xMFH77U
         4qV7LCRt8D5Ats/BNM9AxyROavqm6gYOfEllxzbquzaPAlSgnF+9Q4bpJZWC0ovd+Gl/
         4nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680161615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UrwCz/2ptkU0/AeoW0jXW25OTACtteoXP52Ppf7Hdg=;
        b=VErlZ35n9LDYLIU66KFiYA6KgrgVzKYlF+duwJnR+A2nkrIYgjS9Zb58t/OyaDHlEX
         BM0nbvvw3ohTBmefU4Yzm8Tk5wYmYODZvHx+JxdWxaEN+kdnpupKHcJ62qrdmaRSYtFZ
         6l1K78MhW9llSPAW4w6lLJR/M2CUBDH9z+xVsdHsayQx+bsRgpX1wOaTeWGfBP25LVmb
         qpOPmn60RyXmm5STjZAU7cxX91zBELgVJeo9uvgY7XXF1EmMiqHHWxOpnLj38XghCjvC
         HqHBqHB4+i79b7j1fjm+yn7Jg/VJdCv91bvxp8SFPsFCMjMPSfV/cRQhmWcrRm4VBYYv
         XvCw==
X-Gm-Message-State: AAQBX9cEVHd82FiHYzwbnSISy/UxyKaJCOs5d3lj84CevQEYjCzQDAf+
        6u77EbMu9Duerv9PUSRBKc38zQ==
X-Google-Smtp-Source: AKy350Zta9rmDKv1ETYbF6fe9ZiGwYOA5nVKHKSUOoMhK4VO0b6L3QzNCpN96G5xpCkPdDzJ3XITQw==
X-Received: by 2002:a19:c206:0:b0:4ea:f632:474f with SMTP id l6-20020a19c206000000b004eaf632474fmr5975137lfc.40.1680161615229;
        Thu, 30 Mar 2023 00:33:35 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q5-20020ac25145000000b004d3d43c7569sm5767526lfd.3.2023.03.30.00.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:33:34 -0700 (PDT)
Message-ID: <4c1fa450-79c9-2c66-4bb8-b880f2cf07a5@linaro.org>
Date:   Thu, 30 Mar 2023 09:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 07/12] dt-bindings: serial: Document ma35d1 uart
 controller
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-8-ychuang570808@gmail.com>
 <be0bf335-39fc-2eac-ed37-112881bac675@linaro.org>
 <7b5e42bc-0788-5208-e97e-10502da1c238@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7b5e42bc-0788-5208-e97e-10502da1c238@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 10:44, Jacky Huang wrote:
> Dear Krzysztof,
> 
> 
> Thanks for your review.
> 
> 
> On 2023/3/29 下午 04:20, Krzysztof Kozlowski wrote:
>> On 28/03/2023 04:19, Jacky Huang wrote:
>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>
>>> Add documentation to describe nuvoton ma35d1 uart driver bindings.
>>>
>> This depends on clock patches, so it must be taken together.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Best regards,
>> Krzysztof
>>
> 
> OK, I will combine this patch with the clock patch.

I don't know what you mean by "combine", but I don't think this is what
we want. You must clearly state all dependencies and patch merging
strategy/way.

Best regards,
Krzysztof


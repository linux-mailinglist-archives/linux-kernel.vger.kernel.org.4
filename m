Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A55715792
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjE3Htp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjE3Ht0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:49:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EA710E0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:49:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5147aee9d7cso5751233a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685432932; x=1688024932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hD/u8KvctJNZ9Q6wgoPTwjsd10fbyNIfr6gIoMYFm8k=;
        b=KhbpEb5ujpWhqfksp2CBPV4rcQPsr903YtN0YRWnnc84rzCpIYhZ6kiUX9Z/TLGX9T
         n9a2MekI+c3SzHD+uecC6SayG9whs9240GFuBGLJoiHeFbWv9bFiEFpHH1qLDAWUh+yb
         d2hhA2jMCCtaniqG0l3hPWT7BkBe5k/uMpjeW+TxqkVG2VEW82C+8EGi3aBxtiG78LeR
         58oZ9P1Zl9MJuBTeiy9c4Cijnx1NZSlNTcBksMtgcw9fbtdxfBSjuj2KfhjSvTGpDtls
         hKHAILnXNnl8V758NVRDNSTNWq4v/9GgJ0r6y8RErN8gcK+p1l38VffH2FT9m/NHp+Z9
         23gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685432932; x=1688024932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hD/u8KvctJNZ9Q6wgoPTwjsd10fbyNIfr6gIoMYFm8k=;
        b=IwWId2Sm/fokdCxoIKjpTYyRbRB+TFbXGARK8Bj49qRZZTGCKYHuLo3CYqArNOtzNa
         CCr3l46lvvmhYntpqb+rNONSZvU4XVaf9jM00fYE3guuhOF+hPpQBBStOdS3Hg6tX/pe
         kPcwAvBoHdGhi5ohHA8NuTlMTEmHcPfT7eeQf2U0Y7a+YYeGT30LWFoyxaFLVQDzLSUr
         IFMuhBUgF/FOoacl6AYu4aUdMlgWiNyTc9QOXF8ULTGiFpLVGIN58Y5/7zG8jsoRMcDo
         /iKJNPqQ6bnKXULlIU6iVcc6F1sGZXZToOpEkI8wrHDkigWfIJon4LmCQ2nDWlNZdMxO
         kF+w==
X-Gm-Message-State: AC+VfDwSBkQK2JwCUA8/pvMMGXDTHcopS+n6/pGUZUo0AE7f5ejzUOGP
        Y2dcXOfHoIcRYHcp0sXMySr0uQ==
X-Google-Smtp-Source: ACHHUZ7O8LfbLyaKQcZlRXwpwrnwZEfFVKCOKwVDTDCFB+1bWeIDzE8NQ0wsIzHShQIqw8DR35SAIQ==
X-Received: by 2002:aa7:ce04:0:b0:514:75ff:6a86 with SMTP id d4-20020aa7ce04000000b0051475ff6a86mr955152edv.29.1685432931881;
        Tue, 30 May 2023 00:48:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id c5-20020aa7d605000000b005149cb5ee2dsm2373329edr.82.2023.05.30.00.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 00:48:51 -0700 (PDT)
Message-ID: <8c28ea3a-68f5-1233-9e79-bd9e09d4f485@linaro.org>
Date:   Tue, 30 May 2023 09:48:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V8 7/7] dt-bindings: bridge: samsung-dsim: Make some flags
 optional
To:     Conor Dooley <conor@kernel.org>, Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526030559.326566-1-aford173@gmail.com>
 <20230526030559.326566-8-aford173@gmail.com>
 <20230526-cabana-humble-81e44944e378@spud>
 <CAHCN7xJdfO4+q071sur7wpVg+gU_Fzw9zfXvM9NDBFCN=Axiog@mail.gmail.com>
 <20230526-lily-underwent-1dc0be746be0@spud>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230526-lily-underwent-1dc0be746be0@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 21:30, Conor Dooley wrote:
> On Fri, May 26, 2023 at 02:24:21PM -0500, Adam Ford wrote:
>> On Fri, May 26, 2023 at 1:19 PM Conor Dooley <conor@kernel.org> wrote:
>>> On Thu, May 25, 2023 at 10:05:59PM -0500, Adam Ford wrote:
> 
>>>>      description:
>>>> -      DSIM high speed burst mode frequency.
>>>> +      DSIM high speed burst mode frequency when connected to devices
>>>> +      that support burst mode. If absent, the driver will use the pixel
>>>> +      clock from the attached device or bridge.
>>>
>>> I'd rather this description did not say anything about drivers.
>>> How about:
>>>         If absent, the pixel clock from the attached device or bridge
>>>         will be used instead.
>>
>> That makes sense.  I can do that.
>>
>> "DSIM high speed burst mode frequency (optional). If absent, the pixel
>> clock from the attached device or bridge will be used instead."
>>
>>> Or perhaps "must be used"? Ditto below.
>>
>> "Must be" implies to me that the user needs to set something.  Are you
>> ok with the proposed suggestion above?
>>>
>>> Description aside, the removal seems to be backwards compatible - but
>>> can every device that this binding supports work using an "attached
>>> device or bridge", or are these properties going to be required for
>>> certain compatibles?
>>
>> From what I can tell, the assumption is that the DSIM driver was
>> expecting it to attach to panels in the past.  With the additional
>> patch series, the DSIM can attach to bridge parts without a hard-coded
>> set of clocks.  I don't expect the existing Exynos devices to change,
>> but I also don't know what would preclude those SoC's from attaching
>> to a bridge should someone want to design a new product around them.
> 
> Okay, that seems fair. With your revised wording,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
>>
>> I'll wait a couple days for more feedback and send patch V2 with just
>> this patch since the rest of the series has been applied to the drm
>> branch.
> 
> Sounds good. Krzysztof will hopefully be able to take a look then too to
> make sure I am not making a hames of things.

We should avoid references to driver, because bindings are used also in
other projects where driver can behave differently. Also "driver" is
then ambiguous - which driver do you mean? Please re-phrase.

Best regards,
Krzysztof


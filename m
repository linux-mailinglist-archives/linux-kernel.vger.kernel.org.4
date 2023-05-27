Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDE67132C4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 08:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjE0GFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 02:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE0GFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 02:05:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C795F7;
        Fri, 26 May 2023 23:05:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso1764559a12.3;
        Fri, 26 May 2023 23:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685167530; x=1687759530;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=weCO8x8l3Juw6l9mP/1dLNluMB62SRUfdduhPwPRwKs=;
        b=SdQmwYWzkmMO8AWb1haTnxZndg0YJcUN+JsS6L5Et4rBcxZTYTTmE1si7S4ZjsqlBU
         JBleZ9gZ3TzzhZUvcgzCQRvWrRmFPyLEWobb1DFPoSPEhZxKQ7X5jFpdKKvTzOBntcgP
         g85zpyd/56hc4UGJ8o1JPmMHzAqyPNmQ2eOwqEoysDSP6tszcGKRLG35xvyK4XV3h6Vp
         qVfX1pdd7DVl/bmrjBC6gaa6Yil5lrG42ESJPMUayZe4lyQZ2RxAsL0FjZALJdLiUlAB
         xCURYMMqEqU8EEyQ9ylzllLJ+0hPL9qntJu1SBQqwXTTtmNDz8g3DDC8bMp/Tw4CKbfP
         V6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685167530; x=1687759530;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weCO8x8l3Juw6l9mP/1dLNluMB62SRUfdduhPwPRwKs=;
        b=hy+IHeNXUEwdLm5uAsM53q7TuYGVE7o0DQf6WtGK0iMY222JDFd9OtmXLLnWZjoCa5
         LQDRQcY8O4oBy5pQVJ9ecoKoM3Tbt9MTAU8SC8k/5oIeHslBYKwJcsNnvph9doJJWmqA
         lPdjY34H90XIQPYJN+lW2yiqtgIlsLbSkv2Y/OAkAmRV2yhLZ7jv8DppVw4UkffqFtnC
         KH4Yj1aruXVFGSv9edXohBupVbLSubkqmEugIdTtAcRy6/bdLfr7KtNFtTitz9kprQuS
         XSl4sb1moVu9N8TFpvBR0Q614rRqVDsZ9SopNQvBFZ7Awov+84II7cuUH4fsR5pd8ijv
         TwWg==
X-Gm-Message-State: AC+VfDx61vAtILfLk+YTwespGP1VCdcx4S7oyGypMxxMh2LSd6Fw5sMq
        9eCaPA5fb/eKn5IC+/6LInE=
X-Google-Smtp-Source: ACHHUZ7it/5Dzo6q+LTuAj4VcpeoTRV3nU7vfiGOmmq8/KbZZDZFVtTL/4vpN5p4NGF3N5RoEXfn/Q==
X-Received: by 2002:a17:906:fd8d:b0:96f:4927:7a96 with SMTP id xa13-20020a170906fd8d00b0096f49277a96mr3475603ejb.70.1685167529890;
        Fri, 26 May 2023 23:05:29 -0700 (PDT)
Received: from [192.168.94.52] ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906c01000b00973ca837a68sm1648361ejz.217.2023.05.26.23.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 23:05:29 -0700 (PDT)
Date:   Sat, 27 May 2023 09:05:19 +0300
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: media: camss: qcom,msm8996-camss: Add
 CAMSS power domain
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <VKZAVR.M3FJVE7XKKY71@gmail.com>
In-Reply-To: <631e5eec-853b-dce2-c474-62e76e83d7e6@linaro.org>
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
        <20230526180712.8481-2-y.oudjana@protonmail.com>
        <20230526-obstruct-venus-5833511a58af@spud>
        <838b134d-46cb-6237-49b0-0c287141ebb3@linaro.org>
        <20230526-street-pox-2ff5ee106c43@spud>
        <8d89c14f-b2c2-7db2-f637-aa6d90273f4d@linaro.org>
        <631e5eec-853b-dce2-c474-62e76e83d7e6@linaro.org>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, May 26 2023 at 10:36:32 PM +02:00:00, Konrad Dybcio 
<konrad.dybcio@linaro.org> wrote:
> 
> 
> On 26.05.2023 22:21, Bryan O'Donoghue wrote:
>>  On 26/05/2023 21:19, Conor Dooley wrote:
>>>  On Fri, May 26, 2023 at 09:05:47PM +0100, Bryan O'Donoghue wrote:
>>>>  On 26/05/2023 20:46, Conor Dooley wrote:
>>>>>>  +  - power-domain-names
>>>>>  Why is this now required?
>>>>> 
>>>>>  Thanks,
>>>>>  Conor.
>>>>> 
>>>> 
>>>>  Its an accurate description of the power/clock tree to have the 
>>>> top power
>>>>  domain be switched on prior to the clocks that depend on it.
>>> 
>>>  But what does that have to do with the *names* now being required?
>> 
>>  oh the names
>> 
>>  no toss that
> this should be
> 
> if:properties:compatible:blahblahmsm8996:then:required:power-domain-names

The only compatible in this binding is qcom,msm8996-camss, so what 
would this achieve?

> 
> Konrad
>> 
>>> 
>>>>  I think Yassine, you could probably include the majority of your
>>>>  cover-letter text in this commit to explain this change a bit 
>>>> better.
>>> 
>>>  I think it would be good to have that regardless.
>>> 
>>>  Cheers,
>>>  Conor.
>>> 
>>>>  bod
>>>     ^^^ I've been trying not to think about rugby since the weekend 
>>> :(
>> 
>>  Pockets O'Gara should have his paddy papers rescinded



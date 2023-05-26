Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B6712EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbjEZViz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242692AbjEZViw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:38:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0732710A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:38:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so1119520f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685137126; x=1687729126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ng9N+c2e3Bp89DkXhUcd8ADdwRno1HXC51mA1TZCgUA=;
        b=EtviSR0fErEt4WWVQjfkI6LVdNQwfETpMq9eitcy8l1haPH/ngYCo8N/Sr/mQP7rWQ
         dzWn/u4E5OxQqMjYDdMbKNIyZ+x5XgBfvzNlLg1dEAd1kGZ2H9kAf7BtkHR3/ulfsumo
         9nR7KJn+aCR2C8CIX26E5Nk4k77lDS/QqS0rloi0+6MewFdTmClazXlCtBON2XPQSUNn
         zWxt3QfHeaMUkowNi/GtntIQavK4Lrv9CYTNDj+AmiJ9HcknuTdSkJCiFUJaoa/RHa5A
         wMWYTJcRn+YxUKIc3HmWQ56hk1RZZk5cdUYhshTEOc8jZuBd9BBx2UogBVa5HFHzCA5C
         DwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685137126; x=1687729126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ng9N+c2e3Bp89DkXhUcd8ADdwRno1HXC51mA1TZCgUA=;
        b=kFlkoQnswEN5De1hOWbeKvfbO5NQYdnVpsV1Pr4RQY5jr4PbPabkSq7Y9ccUDFHlw7
         iAMOX9AC5yhQJwuwF5g8AhSQylLE9WlRTUIEe+eVym2WYiGvJ1LB8PRAGYPu48VLYo2D
         cTMhJuV9lfixx3aSpYE4n1lt3xirWeaLgNoS1gPorTnzxSFyPf0s8+/wKXrLGTFdzPO4
         KYP+jy148HjMaqoQW7VwG8zcnvrszV2OcLRhPj+ZPz9dwIWx+8BcY0jcub1wCy+5fTn5
         huQBoaVZanhsshLZHnmeI5FEkePDcJnc9ejD4z4C07GOSkM/gETzF6p/cXktRW3Fm9jh
         Yv4A==
X-Gm-Message-State: AC+VfDxK9wx6TJYPR33OcvkM91Kw2YDYyOF18T6/5g8r/M22n65gfqyK
        GU8JaSrnLxYqlpxohWcBqAbruw==
X-Google-Smtp-Source: ACHHUZ4RoW3fv+qUTi3BXgPtTHI02fQwYPSqH55n/ATO2lnC5wV9gvB0eua6YxhI1bQUJpM5igvwBw==
X-Received: by 2002:a5d:69c8:0:b0:2f8:96f5:cb0f with SMTP id s8-20020a5d69c8000000b002f896f5cb0fmr2379735wrw.23.1685137126404;
        Fri, 26 May 2023 14:38:46 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id a15-20020a5d508f000000b002ceacff44c7sm6107425wrt.83.2023.05.26.14.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 14:38:45 -0700 (PDT)
Message-ID: <5074b544-741f-9873-83ae-9c8d0d057606@linaro.org>
Date:   Fri, 26 May 2023 22:38:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/3] media: camss: Link CAMSS power domain
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
 <20230526180712.8481-4-y.oudjana@protonmail.com>
 <fa395680-0e6c-3eb0-9d5a-f90a95c394b8@linaro.org>
 <e755eabf-f8d7-c2cd-aa5a-bc48c7a5d5ae@linaro.org>
 <7bbbf520-d70f-5df6-33ce-a888bf364aa5@linaro.org>
 <7257f5bb-16a3-846c-fc84-262a775e54f4@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <7257f5bb-16a3-846c-fc84-262a775e54f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 26/05/2023 22:28, Konrad Dybcio wrote:
> 
> 
> On 26.05.2023 23:17, Bryan O'Donoghue wrote:
>> On 26/05/2023 21:57, Konrad Dybcio wrote:
>>> This code contains a whole bunch of hacky counting logic that should have
>>> been substituted with _byname, but now we're stuck with indices to keep
>>> compatibility with old DTs :/
>>>
>>> If CAMSS_GDSC (talking about pre-TITAN hw) was a parent of all the other
>>> CAMSS-related GDSCs, we could make it their parent in the clock driver
>>> and call it a day.
>>
>> I mean, it wouldn't make much sense from a hw design POV if that weren't the case..
>>
>> Hmm looks like its already there.
>>
>> static struct gdsc vfe0_gdsc = {
>>          .gdscr = 0x3664,
>>          .cxcs = (unsigned int []){ 0x36a8 },
>>          .cxc_count = 1,
>>          .pd = {
>>                  .name = "vfe0",
>>          },
>>          .parent = &camss_gdsc.pd,
>>          .pwrsts = PWRSTS_OFF_ON,
>> };
>>
>> static struct gdsc vfe1_gdsc = {
>>          .gdscr = 0x3674,
>>          .cxcs = (unsigned int []){ 0x36ac },
>>          .cxc_count = 1,
>>          .pd = {
>>                  .name = "vfe1",
>>          },
>>          .parent = &camss_gdsc.pd,
>>          .pwrsts = PWRSTS_OFF_ON,
>> };
>>
>> I feel this is probably a problem in the description of dependencies for the CSIPHY in the dts for the 8996..
>>
>> I.e. the CSIPHY requires some clocks and power-rails to be switched on ah..
>>
>> static const struct resources csiphy_res_8x96[] = {
>>          /* CSIPHY0 */
>>          {
>>                  .regulators = {},
>>                  .clock = { "top_ahb", "ispif_ahb", "ahb", "csiphy0_timer" },
>>
>>
>> should probably look something like
>>
>> static const struct resources csiphy_res_8x96[] = {
>>          /* CSIPHY0 */
>>          {
>>                  .regulators = {},
>>                  .clock = { "top_ahb", "ispif_ahb", "ahb", "csiphy0_timer", "vfe0"},
>>
>> But basically yeah, we haven't modeled the dependency to the CAMSS_GDSC via the VFEx
> I have little idea how CAMSS is tied together, but the VFEn clocks
> are assigned in vfe_res_8x96.clock and ispif_res_8x96.clock_for_reset.
> 
> FWIW the ancient msm-3.18 doesn't reference the VFE clocks in CSIPHY.
> 
> Anyway, looks like the issue here is that we're not toggling the
> GDSC early enough in cases where something that's not VFE needs it.
> 
>>
>> Hmm wait - why haven't we included the CAMSS_GDSC in the dtsi for the 8996 ?
> Since both VFE GDSCs are children of CAMSS_GDSC and (as mentioned in the
> commit message) the power sequencing used to be different, it just seems
> to me like we've been piggybacking on lucky ordering since the introduction
> of 8996 support.
> 
> For comparison, 8916 doesn't define it because it doesn't have it and newer
> SoCs use TITAN.
> 
> SDM630 doesn't define it, but nobody touched it since like 2021 (except
> Dmitry's fixups when he got his hands on the inforce baord) so it's
> probably broken as well..
> 
> 
> Konrad
>>
>> ---
>> bod

Hmm, so what I suggested is what Yassine has i.e. adds <&mmcc 
CAMSS_GDSC>; to the top-level camss node.

Without testing, this _looks_ right to me. I just think, like Conor 
flagged we don't need to add a dependency on the power-domain names.

I don't quite know whats the reference for downstream you are looking at 
but, just generally it is possible to waggle the CSIPHY, VFE, IFE - my 
guess would be that CAMX @ the time of 8996 always had the CAMSS_GDSC or 
the VFEx - and hence the VFE -> CAMSS_GDSC on by the time the CSIPHY cod 
ran.

Anyway my comments here still stand.

- I don't think we need to nor should be counting power-domain names
- I do think we should be adding CAMSS_GDSC to the 8996 top-level CAMSS node

Yassine ? Can you take a stab at that ?

---
bod

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB3712EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjEZV22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjEZV20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:28:26 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A121010A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:28:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so1291294e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685136503; x=1687728503;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWrYwqLO2cetwUA7DafSqXD88NMBHAPCQm2ei3HiVNM=;
        b=CuOlu2l2gmelHyKJeuTf7MNiFBEP4e2BSjTj6lkTWLlsKgAGzZm1slrTQQQySoOns0
         ientLCFYLx4Ta75o5aCl5br0XyblAJC+UNcVAlxGrS4wouicPkx+in/s+89Yf1LHB+n3
         r4ycMWqr2IATlJASXYKTpMHgIyfrf5kPrXmr0eGF4Sa2G+dv7m/5rC8A8omUeYYwsHGZ
         Mh5+8M1DTgYsQKYjESW4nmN4s+ON3EMtbG4onkGhRSHlO8JLKBKKvurS//ywAr3qfIyX
         v30gFBJC4V/yZ8NN/Fqnc73GaTn3ENtGu1XD+0gCDuqxwgyGYPyyc3WHoXifuxhPEG8m
         sCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685136503; x=1687728503;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWrYwqLO2cetwUA7DafSqXD88NMBHAPCQm2ei3HiVNM=;
        b=JPhzjMyEz2WEMhGI1pwtxEI7Ydw9w7GaTM0M/jKrx+ZFBWlW9yOg4WyjqXcsxAFxyU
         40c7Cxmxyq4jt9s1haOt1MDQeeqpBDxP0PSLn7b+aVoPlSxGXXpJ5MoXA6c30NTBHh2r
         5zzRBaAtZsc6+UM0tSVO8cgBv8taZUPTZ4r+jFvegBieoBwj43QEVgBcwQThc9b6mKi5
         zF1ndFgWIdNn+PiZjhllDrwfxeDOj6F+i8b4UdWJWrBa0uOw/Q4oWyQhq57IyuZyEK7s
         nEDP4oWLtvOsdi0JkBDezA+0FnGP+Ghsf9z9ShFCgp5gwLSihut0nRADPN5kRyGviR83
         0OPQ==
X-Gm-Message-State: AC+VfDzYzLRkvB/Xo/TD+kuj1XRGXx2+AMxZnV4Lb4oNCqRJ95EWrzjM
        fY/S1GmiOzKDGTR+1OPBwZltXg==
X-Google-Smtp-Source: ACHHUZ41HYIYBc7y+GfDWv666csmOfIZGa8LBxVMS0pcw3wzklkAUrHPe7LfHiLgXa0sPLVFzSBrdw==
X-Received: by 2002:a19:760b:0:b0:4ee:e0c7:434d with SMTP id c11-20020a19760b000000b004eee0c7434dmr979262lff.51.1685136502904;
        Fri, 26 May 2023 14:28:22 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c1-20020ac244a1000000b004db0d26adb4sm791257lfm.182.2023.05.26.14.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 14:28:22 -0700 (PDT)
Message-ID: <7257f5bb-16a3-846c-fc84-262a775e54f4@linaro.org>
Date:   Fri, 26 May 2023 23:28:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 3/3] media: camss: Link CAMSS power domain
In-Reply-To: <7bbbf520-d70f-5df6-33ce-a888bf364aa5@linaro.org>
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



On 26.05.2023 23:17, Bryan O'Donoghue wrote:
> On 26/05/2023 21:57, Konrad Dybcio wrote:
>> This code contains a whole bunch of hacky counting logic that should have
>> been substituted with _byname, but now we're stuck with indices to keep
>> compatibility with old DTs :/
>>
>> If CAMSS_GDSC (talking about pre-TITAN hw) was a parent of all the other
>> CAMSS-related GDSCs, we could make it their parent in the clock driver
>> and call it a day.
> 
> I mean, it wouldn't make much sense from a hw design POV if that weren't the case..
> 
> Hmm looks like its already there.
> 
> static struct gdsc vfe0_gdsc = {
>         .gdscr = 0x3664,
>         .cxcs = (unsigned int []){ 0x36a8 },
>         .cxc_count = 1,
>         .pd = {
>                 .name = "vfe0",
>         },
>         .parent = &camss_gdsc.pd,
>         .pwrsts = PWRSTS_OFF_ON,
> };
> 
> static struct gdsc vfe1_gdsc = {
>         .gdscr = 0x3674,
>         .cxcs = (unsigned int []){ 0x36ac },
>         .cxc_count = 1,
>         .pd = {
>                 .name = "vfe1",
>         },
>         .parent = &camss_gdsc.pd,
>         .pwrsts = PWRSTS_OFF_ON,
> };
> 
> I feel this is probably a problem in the description of dependencies for the CSIPHY in the dts for the 8996..
> 
> I.e. the CSIPHY requires some clocks and power-rails to be switched on ah..
> 
> static const struct resources csiphy_res_8x96[] = {
>         /* CSIPHY0 */
>         {
>                 .regulators = {},
>                 .clock = { "top_ahb", "ispif_ahb", "ahb", "csiphy0_timer" },
> 
> 
> should probably look something like
> 
> static const struct resources csiphy_res_8x96[] = {
>         /* CSIPHY0 */
>         {
>                 .regulators = {},
>                 .clock = { "top_ahb", "ispif_ahb", "ahb", "csiphy0_timer", "vfe0"},
> 
> But basically yeah, we haven't modeled the dependency to the CAMSS_GDSC via the VFEx
I have little idea how CAMSS is tied together, but the VFEn clocks
are assigned in vfe_res_8x96.clock and ispif_res_8x96.clock_for_reset.

FWIW the ancient msm-3.18 doesn't reference the VFE clocks in CSIPHY.

Anyway, looks like the issue here is that we're not toggling the
GDSC early enough in cases where something that's not VFE needs it.

> 
> Hmm wait - why haven't we included the CAMSS_GDSC in the dtsi for the 8996 ?
Since both VFE GDSCs are children of CAMSS_GDSC and (as mentioned in the
commit message) the power sequencing used to be different, it just seems
to me like we've been piggybacking on lucky ordering since the introduction
of 8996 support.

For comparison, 8916 doesn't define it because it doesn't have it and newer
SoCs use TITAN.

SDM630 doesn't define it, but nobody touched it since like 2021 (except
Dmitry's fixups when he got his hands on the inforce baord) so it's
probably broken as well..


Konrad
> 
> ---
> bod

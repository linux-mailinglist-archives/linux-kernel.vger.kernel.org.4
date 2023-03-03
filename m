Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BF66A9850
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCCN1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCCN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:27:07 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65006303E6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:27:04 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id f16so2296932ljq.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 05:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677850022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nJxtHbroqM/Ddx9d2oTpdj+DoHaP62srzKbXybL1GM=;
        b=tOA+O0cflEFx2RiZ8FbGpJxq3lOPnlQZp3jQKLtpqZ89uCM2+XBlHDTE73gAO5/5O+
         4Bo8rbgQRGp2KIisrWeyx+y6Xhujt9oOYr/R2SgLt3CjSKLrSF/b8PBJFXN4dCUOUM1u
         KkNBJ22AlA/YclVMrHDKMjuxooxXPeFE0j14ukk6Z6tGhKNTxqQW7S2G3M6haNpiPUZn
         8FHpJpLKpmh9y8OWX3ydBAuVjOFO1IdzINE9JM/KVDMiguNT/QUhCBgYca9WcFqdW2g8
         KsGB/rbUQIx1rCUIM/zsX3SRZQnldIz6MeaGtqPK/KI/k1Rb+LQDq13/3J8z/wjG5gOG
         Xwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nJxtHbroqM/Ddx9d2oTpdj+DoHaP62srzKbXybL1GM=;
        b=4ZoEKBi3Bpk2rQpQfUnGkfLTiYAYwcLjP2DaPaAqzwThK1Dw3hB/4mJjnAinZXdwe0
         SGHPOrCrYYamX81a18BiQ87JWh4dEWMQP/zsUIRdDRX4Idj+9sL6xapO4SczAtips34g
         1pfrj+hYzR4keptj+ifsmysKdbbArfrSTVi2KiyFIvwYput1TJhJSEeI3mX70PE4LlkX
         yzAqwIVrBCOj7mTfS/2GNYGhlLc5dBFbnB9Iw2Jwzhz5vWc7EIX/Tq4h6fMWLB2UqAm2
         vI7e2WLINLWNIDHPDDZMsI15lqQApyUsK5Fi+Y9/PPyi0jsOdAVIFW9Of5b2K09s5YDu
         ziMA==
X-Gm-Message-State: AO0yUKUKOn8+TicOZqVY1PLGZYMZ5JJ+gcv9b0hKUZ7PAjnl3AcvhfVv
        +l76Cb7DnPGC8lgYJR2vCAOEyw==
X-Google-Smtp-Source: AK7set9iwZOEO26r8kgcdgCsken1oZY71ltNn1/FRGVYWoSjGmN8yVUO/iHWh8bm9KIrEwSPqoOP8w==
X-Received: by 2002:a2e:881a:0:b0:27f:c02b:a04b with SMTP id x26-20020a2e881a000000b0027fc02ba04bmr576543ljh.42.1677850022557;
        Fri, 03 Mar 2023 05:27:02 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id z14-20020a05651c022e00b00295a8e7a328sm308728ljn.54.2023.03.03.05.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 05:27:02 -0800 (PST)
Message-ID: <8ce07abd-2d02-69d2-8dc6-fe11525aecda@linaro.org>
Date:   Fri, 3 Mar 2023 14:27:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 4/6] regulator: qcom_smd: Add support to define the
 bootup voltage
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>,
        Mark Brown <broonie@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_ipkumar@quicinc.com
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
 <20230217142030.16012-5-quic_devipriy@quicinc.com>
 <907628d1-b88d-5ac6-ed9d-7f63e2875738@linaro.org>
 <Y/aeu5ua7cY5cGON@sirena.org.uk>
 <39f73580-f263-de0e-6819-89c3f4c75c3a@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <39f73580-f263-de0e-6819-89c3f4c75c3a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.03.2023 14:21, Devi Priya wrote:
> 
> 
> On 2/23/2023 4:31 AM, Mark Brown wrote:
>> On Wed, Feb 22, 2023 at 11:11:42PM +0100, Konrad Dybcio wrote:
>>
>>> Thinking about it again, this seems like something that could be
>>> generalized and introduced into regulator core.. Hardcoding this
>>> will not end well.. Not to mention it'll affect all mp5496-using
>>> boards that are already upstream.
>>
>>> WDYT about regulator-init-microvolts Mark?
>>
>> The overwhelming majority of devices that have variable voltages
>> support readback, these Qualcomm firmware devices are pretty much
>> unique in this regard.  We don't want a general property to set a
>> specific voltage since normally we should be using the
>> constraints and don't normally need to adjust things immediately
>> since we can tell what the current voltage is.
>>
>> This is pretty much just going to be a device specific bodge,
>> ideally something that does know what the voltage is would be
>> able to tell us at runtime but if that's not possible then
>> there's no good options.  If the initial voltage might vary based
>> on board then a device specific DT property might be less
>> terrible, if it's determined by the regulator the current code
>> seems fine.  Or just leave the current behavour, if the
>> constraints are accurate then hopefully a temporary dip in
>> voltage is just inelegant rather than an issue.  Indeed the
>> current behaviour might well save power if you've got a voltage
>> range configured and nothing actually ever gets round to setting
>> the voltage (which is depressingly common, people seem keen on
>> setting voltage ranges even when the voltage is never varied in
>> practice).
> 
> Hi Mark, The initial bootup voltage is actually blown into the OTP register of the PMIC and it remains the same across boards for IPQ9574 SoC.
But what about IPQ6018 which also uses MP5496? That's also gonna
set the voltage on there, it may be too high/low..

 Initially the SoC runs at 800MHz with a voltage of 875mV set by the bootloaders. As kernel does not know the initial voltage, during regulator registration the framework considers the current voltage to be zero and tries to bring up the regulator to minimum supported voltage of 600mV. This causes the dip which might be of concern in SS parts where the voltage might be insufficient leading to silent reboots.
That's an SoC-specific thing, the same regulator can be used with
many different ones. We can't just assume it'll always be like this.
I see the problem, but I believe this is not the correct solution.

Konrad
> 
> Best Regards,
> Devi Priya

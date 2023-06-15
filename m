Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20BB731C23
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbjFOPD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbjFOPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:03:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B180B2947
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:03:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9788faaca2dso306098066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686841433; x=1689433433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eIUpajJMAwy418rKJ0IS2AVHFSQd4ioT0N5sYn1HKsw=;
        b=wws0s9sOWqH78J4plEK0DMSfmIMz8q2C9ZREkC6aOXahiUCgU8AWMEkvl6lbDYeSK7
         eXNR6CyQV92qJBS7fc80NpWJQvQQ4RHPxj9stCPpP4j05icTIEX+/hmVWJ7LtIzXp+ii
         ayAVGK4DpdCrA4dIfKDgYxBo6NYoNDNAs1hehzecj4r21Os5pVUMet3Q0XmOUxTe7sHX
         B0DfHmbTelULDqsF71tPtoT6eng4lzk4VbPNMe6K6SzLnG9NzcyUbze4ITphhSZGJiyO
         O9eSrcJ1SKREydlubgotCbhtffGpIM1I8mZcNNozQeg0Vgii8DHI+idas3vqYVLj+H7e
         9aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686841433; x=1689433433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIUpajJMAwy418rKJ0IS2AVHFSQd4ioT0N5sYn1HKsw=;
        b=et5sEjDObF1DRplfXvqTPVWsslfmAsfIeQLhkAlcgYkeyKETfwIfY4awqxZh4sUEQj
         1xQnssFSBT+fpbGXtQ5jrm17z5yxneLlXRhnyJ70HP55zh4h/fxGc4Sf1PUf8Lc+yqZv
         5Bzs08TzMk+ne8yn6MGBVjh1HzInH6MNzldGOuZvRNKTM2X8hFhGDwvUTWE7ucDBNLu9
         EQNTTK+S3IjbMKQOfzeu4DySvQNkC9BjWc/IQpDyai7LmhhS9HkIrn2R2Qw0EcWlTJUf
         6pgYe1fdTzLd3W2RfikmsP2OM+jOXX+PXp2PFZbWwlmwEXY4aUyDbPa9Xo/uO3A81ReZ
         tGiQ==
X-Gm-Message-State: AC+VfDwRalY8jK0sGEQYCi2i23rnRA7t4jf8HyUwxTrnQzQOwe58TQz3
        FKkNSFT9kHAMxENq0lDPeAxc/TvFkRSw8iXgTeM=
X-Google-Smtp-Source: ACHHUZ6UigF9ABwn0KpL8yQoTI2XH8/yDAVJunEkqw2JSKsJu7OxuMw9LdBImSR5X/l1r3Csk7A3Xw==
X-Received: by 2002:a17:907:97d3:b0:982:8de1:aad9 with SMTP id js19-20020a17090797d300b009828de1aad9mr2803224ejc.64.1686841433126;
        Thu, 15 Jun 2023 08:03:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g19-20020a17090613d300b0097889c33582sm9530851ejc.215.2023.06.15.08.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 08:03:52 -0700 (PDT)
Message-ID: <0ec6c988-d678-c96c-a7a2-af38e6701404@linaro.org>
Date:   Thu, 15 Jun 2023 17:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes
 up
Content-Language: en-US
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230602161246.1855448-1-amit.pundir@linaro.org>
 <358c69ad-fa8a-7386-fe75-92369883ee48@leemhuis.info>
 <0f6c9dcb-b7f6-fff9-6bed-f4585ea8e487@linaro.org>
 <CAMi1Hd3Cv1i06NhpY6Jqu7OvMpOdzTj6nTEMJNWLrMwMLsugZA@mail.gmail.com>
 <CAMi1Hd0=KV7k82ARadF45nqX+Cv6zPLCxfDvOyAPeXiFd8jpVA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMi1Hd0=KV7k82ARadF45nqX+Cv6zPLCxfDvOyAPeXiFd8jpVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 15:47, Amit Pundir wrote:
> On Thu, 15 Jun 2023 at 00:38, Amit Pundir <amit.pundir@linaro.org> wrote:
>>
>> On Thu, 15 Jun 2023 at 00:17, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 14/06/2023 20:18, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 02.06.23 18:12, Amit Pundir wrote:
>>>>> Move lvs1 and lvs2 regulator nodes up in the rpmh-regulators
>>>>> list to workaround a boot regression uncovered by the upstream
>>>>> commit ad44ac082fdf ("regulator: qcom-rpmh: Revert "regulator:
>>>>> qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"").
>>>>>
>>>>> Without this fix DB845c fail to boot at times because one of the
>>>>> lvs1 or lvs2 regulators fail to turn ON in time.
>>>>
>>>> /me waves friendly
>>>>
>>>> FWIW, as it's not obvious: this...
>>>>
>>>>> Link: https://lore.kernel.org/all/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
>>>>
>>>> ...is a report about a regression. One that we could still solve before
>>>> 6.4 is out. One I'll likely will point Linus to, unless a fix comes into
>>>> sight.
>>>>
>>>> When I noticed the reluctant replies to this patch I earlier today asked
>>>> in the thread with the report what the plan forward was:
>>>> https://lore.kernel.org/all/CAD%3DFV%3DV-h4EUKHCM9UivsFHRsJPY5sAiwXV3a1hUX9DUMkkxdg@mail.gmail.com/
>>>>
>>>> Dough there replied:
>>>>
>>>> ```
>>>> Of the two proposals made (the revert vs. the reordering of the dts),
>>>> the reordering of the dts seems better. It only affects the one buggy
>>>> board (rather than preventing us to move to async probe for everyone)
>>>> and it also has a chance of actually fixing something (changing the
>>>> order that regulators probe in rpmh-regulator might legitimately work
>>>> around the problem). That being said, just like the revert the dts
>>>> reordering is still just papering over the problem and is fragile /
>>>> not guaranteed to work forever.
>>>> ```
>>>>
>>>> Papering over obviously is not good, but has anyone a better idea to fix
>>>> this? Or is "not fixing" for some reason an viable option here?
>>>>
>>>
>>> I understand there is a regression, although kernel is not mainline
>>> (hash df7443a96851 is unknown) and the only solutions were papering the
>>> problem. Reverting commit is a temporary workaround. Moving nodes in DTS
>>> is not acceptable because it hides actual problem and only solves this
>>> one particular observed problem, while actual issue is still there. It
>>> would be nice to be able to reproduce it on real mainline with normal
>>> operating system (not AOSP) - with ramdiks/without/whatever. So far no
>>> one did it, right?
>>
>> No, I did not try non-AOSP system yet. I'll try it tomorrow, if that
>> helps. With mainline hash.
> 
> Hi, here is the crash report on db845c running vanilla v6.4-rc6 with a
> debian build https://bugs.linaro.org/attachment.cgi?id=1142
> 
> And fwiw here is the db845c crash log with AOSP running vanilla
> v6.4-rc6 https://bugs.linaro.org/attachment.cgi?id=1141
> 
> Regards,
> Amit Pundir
> 
> PS: rootfs in this bug report doesn't matter much because I'm loading
> all the kernel modules from a ramdisk and in the case of a crash the
> UFS doesn't probe anyway.

I just tried current next with defconfig (I could not find your config,
neither here, nor in your previous mail thread nor in bugzilla). Also
with REGULATOR_QCOM_RPMH as module.

I tried also v6.4-rc6 - also defconfig with default and module
REGULATOR_QCOM_RPMH.

All the cases work on my RB3 - no warnings reported.

If you do not use defconfig, then in all reports please mention the
differences (the best) or at least attach it.



Best regards,
Krzysztof


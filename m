Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2023960B3D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiJXRRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiJXRR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:17:28 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F77EC4C2C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:52:18 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id v11so6834029wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbYWh19oqjl9qufiNkiAKjgBrsixD4hrUgK/lx/eaIw=;
        b=ZljYUwbRicggq5owBUsRvQQGmBsfjljS7xKN601RfnV55E/3srGhhd6RxmzgZycbgf
         YTzTIaDo99mdVE7shr7uzfuj1GeXZjjwMFNnCDjVKxeUpLDnGvDz3O2JJyIa/cEFtckU
         UoPZ6soKEW65uNuuWBP3xQbqK9UJHAEm6bvk4Q42qeKhlkUdd4exOb/qLbACFC91rxtT
         Q6VgQLl+5rbJHYgTZvnWVSnARZluav3+aOLLeaH9AMsus326CJiv4d95sA2PuZK6Q6f3
         DlEREprsK2YE/TtYd5Mlryhf4gKA5eSRfNztDDY7VCU+hC8b3MAe1ad+r8dbQj9voDai
         LaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbYWh19oqjl9qufiNkiAKjgBrsixD4hrUgK/lx/eaIw=;
        b=cpTStpC+Nf8OYRtsaNhs8ACFbx85ywPwRIRmM/Gta6uCNujsh6D1nUZcoF7aziID//
         S1hN5WZ1Ah0aBSJ36dT7hdTYFyQw+cVu7+kKecmOuRNrsrQWJxuW1DectTHD55gZdEIF
         Ws+X93K6bfwWLdeJVC+fPpNS4e4Yz7GPpfAbTmWjSZTpyKHgw3HZtXtL3/QgTXJvTzOo
         /zFZrWBxKk/hGF0e0hUexfGCMyC9FuMMuTzgz/4QxyuFN0pek/neZfiMGEDfSgIlVSDI
         m3UgByWzMtSIt6RtJnF3HGZBVhrgP70xzddqnVdSKV3u4ynwdDaYCEmwlQctelx0IemE
         ykVQ==
X-Gm-Message-State: ACrzQf1Nv2ccSpOrPrp+TDLndvxmScQ1cjgpymVTtvp667e3OT61j6Xn
        bJID2rYVIxblu0ioWltH3yjHlQ==
X-Google-Smtp-Source: AMsMyM40Oq8Znuzox+9igtVUTEqUmEn9IM1c7G0BS8F9O2VpyN1FvznnRIBZT7q3I/66sNecRZ079w==
X-Received: by 2002:a05:600c:4ed0:b0:3cd:3422:62d8 with SMTP id g16-20020a05600c4ed000b003cd342262d8mr6494541wmq.154.1666626360313;
        Mon, 24 Oct 2022 08:46:00 -0700 (PDT)
Received: from [10.35.6.130] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b003c6b9749505sm9292541wmq.30.2022.10.24.08.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 08:45:59 -0700 (PDT)
Message-ID: <fe408c77-31ab-5fef-cb1d-ccccb41a7881@sifive.com>
Date:   Mon, 24 Oct 2022 16:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 01/10] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm-dw-apb-timers-pwm2
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <20221020151610.59443-2-ben.dooks@sifive.com>
 <22c39fd8-e98a-a091-f2c8-12a235f7be8c@linaro.org>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <22c39fd8-e98a-a091-f2c8-12a235f7be8c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 16:36, Krzysztof Kozlowski wrote:
> On 20/10/2022 11:16, Ben Dooks wrote:
>> Add documentation for the bindings for Synopsys' DesignWare PWM block
>> as we will be adding DT/platform support to the Linux driver soon.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>> v5:
>>   - fixed order of properties
>>   - corrected clock to two items
> 
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
> 
> If a tag was not added on purpose, please state why and what changed.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Given the number of updates I should probably post a v7 of this series
with all the tags updated.

-- 
Ben



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB4A63C2AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiK2Oei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiK2Oeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:34:31 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32193AF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:34:29 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id x6so3317622lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yb4TSztLyoh4rIPeJX6N8PljKLgPvaOweLMv0t2KeKo=;
        b=MFmeuTaqhysIJMoAymRaSNWqDORiLpwZc2g/jhyKH4uzOsVSy2XFdhXSxKw6YsEXQ2
         qr4VsxkTe8Ju6uBUJcp1OLQDMMvF/i1Ik4yYs7rMySNM/QrKgVtXj47aVtW1MFQQU4Xr
         RqxMMpOlMoOPxNr3VuejX5YC9Ij1qpRMT0ANuNlrwhlN3N1zCz4DUpIz7oskgGIKI9wu
         SMTFCEIIx29L73IDZWxHFP1K5DYiGa1RpN24Qkov6a/c1IIch1cD5bXqSTAfBvQIPGO4
         IbS5y7X7Gq0LTNgAEubBjRylZERLFAi6l5dCRoszXBg+Y4+qUnXU+GZuQj5NVCJkKIC9
         777w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yb4TSztLyoh4rIPeJX6N8PljKLgPvaOweLMv0t2KeKo=;
        b=bo9nxCdUJWIfRM3X2cWTccZf78+Iz26HBgCPugtPF0VyN6PaI994tq8WcycNbrSCZX
         7IEPSd61Y8tbpx8Xl5w0IP2aVL97hHOafLb1aSSWsmPBPq4zcERX//oYYhdoPtucBYi6
         eHrDCEH9X9QtYgXESt5cVcwqE69XSKf7Kdzr+d8Y2rzTcVz4pCOpF1ghHG1VeXofZqBj
         psJMdmBANvQoxQfR4cqxeIt7/lUGq4UF1H3q+13/YJR4w68+oUfwb3GIRiM1Ajdw4fAl
         XyS6Whbv2bTsWJPxNy8g6TKaO5SdR6wQLlC4gjJ0PxqUJK6htL9GoFJtYpLufJAZ398R
         0E8w==
X-Gm-Message-State: ANoB5pnDyyuIIFTbsbh5r1lGYoyW+vRZk2dUf2Bg7Vlz5KpPYL0ymRVJ
        nIHrUF598D0kG/cp6n8Mf7j1Dw==
X-Google-Smtp-Source: AA0mqf4Chw0LBirQnmKUx27euTDQ7XNz3zaqy80g5zFnYAsoozD6M4CZTVp58Bq40rr05Yo5WQ+EEg==
X-Received: by 2002:a05:6512:2a8d:b0:498:7c7:b98f with SMTP id dt13-20020a0565122a8d00b0049807c7b98fmr18078871lfb.625.1669732467866;
        Tue, 29 Nov 2022 06:34:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r10-20020a2e994a000000b00279a5b85791sm669608ljj.88.2022.11.29.06.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:34:27 -0800 (PST)
Message-ID: <a297079e-2dc9-d311-5415-a58332e7a711@linaro.org>
Date:   Tue, 29 Nov 2022 15:34:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20221128142912.16022-1-marcan@marcan.st>
 <20221128142912.16022-3-marcan@marcan.st>
 <CAPDyKFobMvef_BWGMR=7avODh2r5XNMGpwO3xYgrN-u=DqRwbg@mail.gmail.com>
 <41c6882a-bff0-378c-edd3-160b54be7c1d@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <41c6882a-bff0-378c-edd3-160b54be7c1d@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 15:00, Hector Martin wrote:
> On 29/11/2022 20.36, Ulf Hansson wrote:
>> On Mon, 28 Nov 2022 at 15:29, Hector Martin <marcan@marcan.st> wrote:
>>> +examples:
>>> +  - |
>>> +    // This example shows a single CPU per domain and 2 domains,
>>> +    // with two p-states per domain.
>>> +    // Shipping hardware has 2-4 CPUs per domain and 2-6 domains.
>>> +    cpus {
>>> +      #address-cells = <2>;
>>> +      #size-cells = <0>;
>>> +
>>> +      cpu@0 {
>>> +        compatible = "apple,icestorm";
>>> +        device_type = "cpu";
>>> +        reg = <0x0 0x0>;
>>> +        operating-points-v2 = <&ecluster_opp>;
>>
>> To me, it looks like the operating-points-v2 phandle better belongs in
>> the performance-domains provider node. I mean, isn't the OPPs really a
>> description of the performance-domain provider?
>>
>> That said, I suggest we try to extend the generic performance-domain
>> binding [1] with an "operating-points-v2". In that way, we should
>> instead be able to reference it from this binding.
>>
>> In fact, that would be very similar to what already exists for the
>> generic power-domain binding [2]. I think it would be rather nice to
>> follow a similar pattern for the performance-domain binding.
> 
> While I agree with the technical rationale and the proposed approach
> being better in principle...
> 
> We're at v5 of bikeshedding this trivial driver's DT binding, and the
> comment could've been made at v3. To quote IRC just now:
> 
>> this way the machines will be obsolete before things are fully upstreamed
> 
> I think it's long overdue for the kernel community to take a deep look
> at itself and its development and review process, because it is quite
> honestly insane how pathologically inefficient it is compared to,
> basically, every other large and healthy open source project of similar
> or even greater impact and scope.
> 
> Cc Linus, because this is for your Mac and I assume you care. We're at
> v5 here for this silly driver. Meanwhile, rmk recently threw the towel
> on upstreaming macsmc for us. We're trying, and I'll keep trying because
> I actually get paid (by very generous donors) to do this, but if I
> weren't I'd have given up a long time ago. And while I won't give up, I
> can't deny this situation affects my morale and willingness to keep
> pushing on upstreaming on a regular basis.
> 
> Meanwhile, OpenBSD has been *shipping* full M1 support for a while now
> in official release images (and since Linux is the source of truth for
> DT bindings, every time we re-bikeshed it we break their users because
> they, quite reasonably, aren't interested in waiting for us Linux
> slowpokes to figure it out first).
> 
> Please, let's introspect about this for a moment. Something is deeply
> broken if people with 25+ years being an arch maintainer can't get a

If arch maintainer sends patches which does not build (make
dt_binding_check), then what do you exactly expect? Accept them just
because it is 25+ years of experience or a maintainer? So we have
difference processes - for beginners code should compile. For
experienced people, it does not have to build because otherwise they
will get discouraged?

> 700-line mfd driver upstreamed before giving up. I don't know how we
> expect to ever get a Rust GPU driver merged if it takes 6+ versions to
> upstream the world's easiest cpufreq hardware.

While I understand your point about bikeschedding, but I think your
previous bindings got pretty nice and fast reviews, so using examples of
non-building case is poor choice.

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A465BE1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiITJPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiITJO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:14:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BAB6FA34
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:13:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id b24so2198649ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=s6DaKp+q+N9t8jckxnbwiJ1uyOA1+2q0Un6B7SB1SKQ=;
        b=qK8klLdIwLxJgPxTvR4NFqK/I1FiB/oIBLmyAZzqzXAGqtzI5o+VQ0s6PD0iq6krWp
         bsRXBjF2RMCGnIsUII3/ggpc5iVI6uw7U31Hjq0pdWQPW0by9VmwsC1l/xdSrN3rCTzg
         Ze33RmRHKKYk4Z4YX9sUnm5lPHZrp8nDdddxDOMHNSwXamViuyG+yrnRyJRayTEWZyrw
         Jl6AI5wE8lHUYI6MkY473+IzqA5nzsDsNTSix9jvyj7WZF/YEH9pWE+KAn42h9kW+ECS
         wLIbUReYSQ8SQexYIzExYFJoa2z0q5pQRYeoQ0rD/+rAnDHr3MwOErJIQ3yFqoKX30SR
         w3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=s6DaKp+q+N9t8jckxnbwiJ1uyOA1+2q0Un6B7SB1SKQ=;
        b=qIdH05qY0ND68AopMCXUBQgQLJ/5cuakpktKtq9SFOhRH1On9Utz8c6nalcDsbGxXj
         KCFf5rJEFMMojAGU6LhCxJcf7GRoqmiujwdvahJtSTqJM1Vicm1rFluH4F9z9kcMMDJL
         8F7Qc8kQaRN6TlAbduxq5najiAKTBUKmTSVW6+Czy1KjtRsFWRiz6JiCFIIagO9xjK41
         gf0pFQsnH6sMe+efEg/chXGM7M/0u+AmQ6sq0LpWbsh/bHl55jmrXkTsCG+gUK4KtSbv
         cV4+2jock2A/PEcsVC6Eo1Gb/ghHJvUnILpaJwhocqHJZEfokchUBVr+5rx4r0IEKO1S
         BzcA==
X-Gm-Message-State: ACrzQf2isZN+JnW5OCQAwKDae/k9yhMpsOuwdA3uM799T6yEKc6lSSwn
        8oKyFTgeEMMWjObbJLusqfNdYm8M5JNflHIHuiWPWQ==
X-Google-Smtp-Source: AMsMyM4G9ygVE9dect/jsAIWKGnyYwOumnSQWwCDYSSb9xGAipWNePq3qpEppYq8jH259Fyk5eN8xN8GFhN6neB0xR4=
X-Received: by 2002:a2e:9b89:0:b0:26a:a004:ac3 with SMTP id
 z9-20020a2e9b89000000b0026aa0040ac3mr6217102lji.104.1663665204948; Tue, 20
 Sep 2022 02:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220919220804.1047292-1-bhupesh.sharma@linaro.org>
 <36bd1c19-8fbd-0903-704d-447117b2007a@linaro.org> <dfe1bc9e-2ab9-d2dd-7daa-dddb8d66fd77@linaro.org>
 <2ad436c8-8b7a-80ed-9c91-d2293eff70ab@linaro.org>
In-Reply-To: <2ad436c8-8b7a-80ed-9c91-d2293eff70ab@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 20 Sep 2022 14:43:12 +0530
Message-ID: <CAH=2NtxQh7T3CGrdJ=d+_Tj=46sJv5WapoSPbgZMq4yGrFiNwg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] dt-bindings: qcom-qce: Convert bindings to yaml &
 related changes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        thara.gopinath@gmail.com, devicetree@vger.kernel.org,
        robh@kernel.org, andersson@kernel.org, bhupesh.linux@gmail.com,
        Jordan Crouse <jorcrous@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sept 2022 at 14:24, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/09/2022 10:48, Bhupesh Sharma wrote:
> >
> > On 9/20/22 12:58 PM, Krzysztof Kozlowski wrote:
> >> On 20/09/2022 00:08, Bhupesh Sharma wrote:
> >>
> >> (...)
> >>
> >>
> >>>
> >>> Qualcomm crypto engine (qce) is available on several Snapdragon SoCs.
> >>> The qce block supports hardware accelerated algorithms for encryption
> >>> and authentication. It also provides support for aes, des, 3des
> >>> encryption algorithms and sha1, sha256, hmac(sha1), hmac(sha256)
> >>> authentication algorithms.
> >>>
> >>> Note that this patchset is dependent on the dt-bindings patchset (see [1]) sent to devicetree list.
> >>>
> >>> [1]. https://lore.kernel.org/linux-arm-msm/20220919195618.926227-1-bhupesh.sharma@linaro.org/
> >>
> >> If it is dependent on the bindings only, keep them together. However I
> >> don't think this is the only dependency. You add here several
> >> compatibles which are not supported.
> >
> >
> > Please go through the cover letter where I mentioned that:
> >    'As per Bjorn's suggestion on irc, broke down the patchset into 4
> >    separate patchsets, one each for the following areas to allow easier
> >    review and handling from the respective maintainer(s):
> >          'arm-msm', 'crypto', 'dma' and 'devicetree'
> >    This patchset is directed for the 'devicetree' tree / area.'
> >
> > Basically now the patchset which had around 23 patches in v5 will send
> > out as 4 separate patchsets one each for 'arm-msm', 'crypto', 'dma' and
> > 'devicetree' trees.
> >
> > So when all the respective subsets are picked up, all the compatibles
> > are in place.
>
> and none of reviewers can find them, because you linked only bindings.
> Keeping bindings separate from everything is not good approach. Either
> they should be with DTS or with driver changes. Otherwise how can we
> even look that they are matching DTS?
>
> Keeping them separate even makes impression there are no ABI breaks and
> bisectability issues...

I see your point, but as I mentioned this was as per suggestions from
other maintainers only :)
Perhaps a good topic for the next LPC maintainers meetup - i.e. would
maintainers be more happy with subpatches for their specific area v/s
being cc'ed on a single patchset which touches other areas as well
(but are required for enabling a feature in its entirety).

Thanks,
Bhupesh

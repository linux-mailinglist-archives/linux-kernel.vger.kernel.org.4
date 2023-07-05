Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5AB748DCD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjGETa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjGETaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:30:21 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B66A1732;
        Wed,  5 Jul 2023 12:30:16 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-78372b896d0so269751939f.2;
        Wed, 05 Jul 2023 12:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688585415; x=1691177415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zr8NlcrVZF+DGU6x6DDrs6qz+39jnm7/l7Zp+WArtPU=;
        b=T597Y0QmSt9vZnHyqUbDfwxOM5YMOD0Aph4PVCK8EHUMtjU/qyMEwVDBz94njdCmi2
         Rb3fDgaGdBWIno7OPJ6WbOhj8SRQwI9kLjRFh5uc8gO9E1r5QoRqRCydvEpB2hSzVLbw
         Aur74wmxVr0ZwA2/TXNlbp2q0nFKFul2qv4LHfVrAL3qlveehhRjjK4HFmbEgWbpYMsi
         BqVbEvTS9i6zCZ+HJQiZbj3DdEeMV20yyDoNuAIW79yMyGIUvNwGY2sWcablJMtkEQ4F
         8SIy9DlX9NoeFkR8AdsjGRcBwufmJYbP6oMW7gTIzk6Ynoh3ebzlpJHKPHdqX0C9vUAd
         sHXg==
X-Gm-Message-State: ABy/qLYergGt/1AuQtEuyE3X3XjHMDTxP2/ADstwMS3KTUsiXEy2GNSw
        2s0aoJgevXn9+YUFXOf0djg62HSP5g==
X-Google-Smtp-Source: APBJJlF22tTHKhJlfwbm/7ASMiZpp4lqbi2HXqFLRetXvka2tgu9d9LnOVgkTLLTi1mnXArtTSerBg==
X-Received: by 2002:a05:6602:29bb:b0:783:7193:b019 with SMTP id u27-20020a05660229bb00b007837193b019mr102895ios.4.1688585415242;
        Wed, 05 Jul 2023 12:30:15 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z1-20020a02cea1000000b0042b61a5087csm966034jaq.132.2023.07.05.12.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:30:14 -0700 (PDT)
Received: (nullmailer pid 1701874 invoked by uid 1000);
        Wed, 05 Jul 2023 19:30:12 -0000
Date:   Wed, 5 Jul 2023 13:30:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V7 1/2] dt-bindings: firmware: bootstats: Add the dtschema
Message-ID: <20230705193012.GA1642540-robh@kernel.org>
References: <cover.1688533340.git.quic_schowdhu@quicinc.com>
 <b3105990e021a71039f621e6c4e70ab05fb348fa.1688533340.git.quic_schowdhu@quicinc.com>
 <d339d413-5242-0d5a-96f6-c2f670e5e5dc@linaro.org>
 <968fb5d3-6cd8-7850-47e7-682e26f9ee5f@quicinc.com>
 <a0631800-f3d5-ff13-b316-9bc027275a82@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0631800-f3d5-ff13-b316-9bc027275a82@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 11:34:35AM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2023 10:33, Souradeep Chowdhury wrote:
> >>> +    $ref: /schemas/types.yaml#/definitions/string-array
> >>> +
> >>> +  abl-time:
> >>> +    description: The property to store the duration of abl in ms.
> >>> +    $ref: /schemas/types.yaml#/definitions/string-array
> >>
> >> I have no clue what this entire binding is about. Nothing can bind to
> >> it, no usage explained. Properties are not used to "store the duration".
> >> This does not look like suitable for DT, drop entire binding.
> > 
> > This binding was created as per the suggestion on version 6 of the patch 
> > by Arnd. The idea was that these 2 devicetree properties will be used to 
> > populate the bootstat values from the bootloader and exposed to the user 
> > via /sys/firmware/devicetree/ directly.
> > 
> > Details in the link below:-
> > 
> > https://lore.kernel.org/lkml/7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com/T/#mbdc9ad95fcbb5ad7b56c6996a3933899b42d982c
> > 
> > Can you suggest any alternative way to represent this as a binding?
> 
> Then you should clearly state in the binding how this is going to be
> used and who is going to populate it. Not only in the binding but also
> in commit msg which currently has 0 rationale and answers to "why". Your
> commit msg explained only "what", which is usually obvious and much less
> important. Your commit should stand on its own and should clearly
> explain why we need this feature at all, what problem it solves.
> 
> And before you claim that there is some discussion under link or some
> cover letter - these do not matter. Commit and bindings matter.
> 
> What's more, I don't think that Arnd's advice is correct here - DT is
> suppose to describe hardware or firmware. These properties are coming
> from firmware but they are not describing any firmware or hardware
> characteristics. Instead they are debugging of current boot status.
> 
> I will leave the decision on that for Rob, however anyway binding is
> very vague and incorrect, so I would expect he will come with the same
> concerns regardless whether it is suitable to DT or is not.

My main concern here is not so much having this info in DT, but whether 
it's just the start of various properties. Either because there's already 
more data and these are just the 2 things you care about now, or because 
once we enable this it's an invitation to add more properties.

Boot timing information seems like something multiple platforms might 
want and only having 2 stages isn't extensible.

Rob

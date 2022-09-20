Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBF35BE4DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiITLod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiITLoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:44:04 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564A17435C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:43:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f14so3311539lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/0Ndn+NlDdssGkzqLaRqbOpdIWEheyXaXTlI3yhLY30=;
        b=c6cFS2OdCtcAaac9snrBgj/g9rqNTclDUaVWthxoYVT6YzoHV42Z9Sk+5aYsIWRfAU
         4kAngnc1/q0Y2dWlSkS0JjJ0ayw7dQ4fOjmbhT/IbAhfnx/jP3RqhcnLoxzSidhBVkA+
         eTMijuVuTqmrA2yrnxJX8fZOypXGHIqjxXuQIJcZd/A6GAyOVVCNixNr5PglTohNoDXH
         FTgvn4phqMGQldmfggdUOgR7cPllwj5GUkPDsOqI/1PvdC4SBG2MEJVZigR0GoRMRdWc
         A6Q2wYFOIi+cl/Yk8cMnApy7As0ucfIITfHDb//g1e79XS8pdHlsUx0o07J14jHn19wc
         I3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/0Ndn+NlDdssGkzqLaRqbOpdIWEheyXaXTlI3yhLY30=;
        b=aoWqKUUrbMGF1YmAcZfR55U42EDnR5asaZ+JJFTOhTV7N0KADnkBzflsrcTbJhbWyx
         HLGxGanYmnuIQNil0iVz4foM5n+lUwCnlPCS1Y42pePTTCh1I1ZsmP+uhMeBoDA+rXns
         9VRWJ4BrUIlUKV9mHcIeZLEmi7ZL3D7+4wvZ/0dJicJb1yKFgG+KJnrJueppZ5wPjRxk
         V2EyAN+AWnYFYcUH9eHgzFyEeXJHHiMEboQ+m4kFxUL/bUQPXjww+gVX/UxMqgj9Witb
         dvVh5kcN9rkCTt7Y1GBrUxE/MA/VnBO3soexhro4Xt8ailbPOhrDGPozl9LPFb9xl6Xe
         v8bA==
X-Gm-Message-State: ACrzQf13FHoy0gWMJMUlaCZjgydPSasYusRujegcOftUjZCkdUaL/624
        fBfxdzuasCL9ukNRxbrGpOxjUrOz8b7+NLaUBN2www==
X-Google-Smtp-Source: AMsMyM48be/YU4xcy+Id6lduQHEoJJB939r65gfNY5HefhFYNQzgsT/f/AW/lnjxjRQwxXpis/dgWZjNj02u4AnyjwA=
X-Received: by 2002:a05:6512:3e10:b0:498:f317:e57e with SMTP id
 i16-20020a0565123e1000b00498f317e57emr8364693lfv.328.1663674230091; Tue, 20
 Sep 2022 04:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220919221509.1057574-1-bhupesh.sharma@linaro.org>
 <20220919221509.1057574-2-bhupesh.sharma@linaro.org> <bb577304-f048-8fd5-fc7a-47a0897ba792@linaro.org>
 <00dd028f-d636-0cda-40ce-01d5addcbec9@linaro.org> <ccc318c0-ee1b-d538-6d2b-bf85a3c9c6fd@linaro.org>
 <CAH=2Ntys+JSurmZn5qN2Kuphi_5q6Ge7cZgd9KMTvAyLnd6JSA@mail.gmail.com> <a8077058-5493-7b57-0530-c7221a03a799@linaro.org>
In-Reply-To: <a8077058-5493-7b57-0530-c7221a03a799@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 20 Sep 2022 17:13:37 +0530
Message-ID: <CAH=2Ntxhdf2KhGcLLCbwo7vpkH2ofpnGGGJhXNVsqpuDCtqY5Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/4 RESEND] ARM: dts: qcom: Use new compatibles for
 crypto nodes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        thara.gopinath@gmail.com, devicetree@vger.kernel.org,
        robh@kernel.org, andersson@kernel.org, bhupesh.linux@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        Jordan Crouse <jorcrous@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sept 2022 at 16:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/09/2022 12:48, Bhupesh Sharma wrote:
> > On Tue, 20 Sept 2022 at 15:09, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 20/09/2022 10:57, Bhupesh Sharma wrote:
> >>>>>             crypto: crypto@8e3a000 {
> >>>>> -                   compatible = "qcom,crypto-v5.1";
> >>>>> +                   compatible = "qcom,ipq4019-qce";
> >>>>
> >>>> There are few issues here:
> >>>> 1. Compatible is not documented.
> >>>
> >>> Its documented here:
> >>> https://lore.kernel.org/linux-arm-msm/30756e6f-952f-ccf2-b493-e515ba4f0a64@linaro.org/
> >>>
> >>> [as mentioned in the dependency section in the cover letter :)]
> >>>
> >>>> 2. Compatible is not supported by old kernel - ABI break.
> >>
> >> You cannot fix this with dependencies/ordering.
> >>
> >>>> 3. Everything won't be bisectable...
> >>>
> >>> I think its a question of dependencies b/w the patchsets intended for
> >>> separate areas. Let me think more on how, I can resolve it in newer
> >>> versions.
> >>
> >> DTS always goes separately so this also cannot be fixed with ordering or
> >> dependencies. However if Bjorn is fine with it, it's good.
> >
> > Sure, I get your point. SInce I haven't sent out the crypto driver and
> > DMA driver subsets yet, let me stop and respin the series with the
> > dt-bindings changes clubbed with the crypto driver patches in a single
> > patchset. I can keep the DMA and dts patchsets separate and send them
> > out separately.
> >
> > I think that should help maintain the ABI and backward compatibility.
> > Please let me know if you think otherwise.
>
> I actually don't know what's in the drivers, so maybe there is no ABI
> break by kernel... but you are changing the compatibles in DTS thus any
> other project using them will be still broken.

I have sent out the crypto and dt-bindings clubbed together as one
patchset in the v7 version (see [1]).

[1]. https://lore.kernel.org/linux-arm-msm/20220920114051.1116441-1-bhupesh.sharma@linaro.org/

Thanks,
Bhupesh

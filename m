Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE07735DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjFSTR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjFSTRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:17:54 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A8E6F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:17:50 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1ab19a88324so477822fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687202270; x=1689794270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8zImbnBQFMDKIM0YdvwrqiC2mb8pGhWcFi44OEk/RIw=;
        b=JKVFzF5xBUridH+k+rVDVjw2s476Kt1itYIA01lAg6HrkVOFhpLjfydbn27p1QA7Dl
         YqtjCdIDsKB96ALEfWABG5HAo2INvCvYLtDD5+Myx7/QRzL04sQkirLIiiKeo10eBkbv
         qXCW7fO8ucVZX9jfCtH51/mZs2kcklSU/aq7JD7Qwz6DUcRftDDufmPtzXrM0UOOzJKN
         DaUZo24HL/OdJlYDiCqOxlrRxxBKyXrXSZc0pJaSnVGEzwI+jBRe3Q9TcHedDCobYmW9
         maV9+7tY8cVpPyOgmmwcra11SjS7rG+ZAWOCaymtrv8/TaS5pVckz7c79aAjJs54Yahd
         iKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687202270; x=1689794270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zImbnBQFMDKIM0YdvwrqiC2mb8pGhWcFi44OEk/RIw=;
        b=RAVmAYC0coqmJLwEO6/C1YczFgn9fRwKn2MpCIRG04kK+ca8D5luZ9gc7hr5trq5FP
         U9n9EWipj8dyWlNj/rvXfuxTzEGX7l7+exswBQ09Ey4gneC5PtEnnCA/V7U29NxSntJm
         lfxSez6v+lfc98fx2Wt6LpT7pEHg3WQmQa9kE2Zdqf4xZVtLgGkemreO5CmXQXsIfkS3
         EPY7Bgd0QKC0a9Hx9BnGsHjVN10Q/ZbkGn9GXKkXCTOWlXBFbXNRk028i0wOg7iRiLpS
         XDfvkpupUb6Fk65HWfuGH9UuYjRQOx+dmkrJTiTCiFmeCoRBeCpocsnnxog3y/TLxoa3
         6PQQ==
X-Gm-Message-State: AC+VfDzwvdBXuYmBbCbD4YDN6ZFA/LkxWhYpZwO4lSZTGU3NX38mUAbz
        Fro9TpgR64VLPEY8ilGEYR0tohbY0gIsptAfTwIXtfbnCVxlE3Lc7us=
X-Google-Smtp-Source: ACHHUZ4EoJHonRnkpBcMRDvvYrnaOQD5/SNwVtHP/utQGpKyWvpkNr7VDsE/y7ZY3fYsF+VRzezQIE3/aEiYXA62ApY=
X-Received: by 2002:a05:6870:716:b0:1a6:64eb:4a36 with SMTP id
 ea22-20020a056870071600b001a664eb4a36mr4200002oab.2.1687202270229; Mon, 19
 Jun 2023 12:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230616035813.255062-1-jaswinder.singh@linaro.org>
 <165dd295-1b3a-5062-772a-613a7bf6fd45@linaro.org> <CAJe_ZhdV3yaKUVD43duO4hkGMByJhq7x9bN+eBXJdBXdxgDneg@mail.gmail.com>
 <e2b98d80-8e9a-6083-3bc5-677bef0d3263@linaro.org> <CAJe_ZhfeYmxjR7Hcht0F9rc97VG2JCFEEFB+S5kUhSCmsut3Cg@mail.gmail.com>
 <661800ab-c363-49f2-4889-c458a7b298c4@linaro.org> <CAJe_Zhe9CKNC_B6y_YxEY_Nz765GQghg1ivYSOROJH8A7FKcnA@mail.gmail.com>
 <1531062a-ce5f-8af0-b569-1b9eac3e7eac@linaro.org>
In-Reply-To: <1531062a-ce5f-8af0-b569-1b9eac3e7eac@linaro.org>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Mon, 19 Jun 2023 14:17:39 -0500
Message-ID: <CAJe_Zhct9KGVD1t9CTaFhL05oxa9Rawf5g1OVmWOd-NYVNAErA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: socionext: add bindings for the
 Synquacer platform
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023 at 02:18, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/06/2023 01:18, Jassi Brar wrote:
> > On Fri, 16 Jun 2023 at 15:34, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 16/06/2023 22:06, Jassi Brar wrote:
> >>> On Fri, 16 Jun 2023 at 11:47, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 16/06/2023 18:23, Jassi Brar wrote:
> >>>>> On Fri, 16 Jun 2023 at 05:15, Krzysztof Kozlowski
> >>>>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>>>
> >>>>>> On 16/06/2023 05:58, jaswinder.singh@linaro.org wrote:
> >>>>>>> From: Jassi Brar <jaswinder.singh@linaro.org>
> >>>>>>>
> >>>>>>> Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
> >>>>>>> Specify bindings for the platform and boards based on that.
> >>>>>>
> >>>>>> A nit, subject: drop second/last, redundant "bindings". The
> >>>>>> "dt-bindings" prefix is already stating that these are bindings.
> >>>>>>
> >>>>> I can remove it, but I see many mentions like "Fix bindings for"  "Add
> >>>>> binding for" etc in the subject line.
> >>>>
> >>>> Can we fix them as well?
> >>>>
> >>> ??
> >> What else I can say to such argument?
> >>
> > It was not an argument, I agreed to remove it. I just observed that
> > the nit-pick was arbitrary.
> > And frankly
> >    "dt-bindings: arm: socionext: add Synquacer"   is as misleading as
> >    "dt-bindings: arm: socionext: add bindings for the Synquacer"   is improper.
>
> "add Synquacer boards"
> it is both precise and correct. No misleading.
>
Ok. I am going to do that. Are you going to enforce this practice for
all submissions in future?


> >>
> >> Bindings without user (so no DTSI and no driver)? Just few, not countless.
> >>
> > I disagree. But I don't have time to write a script to find
> > compatibles/enums and properties in yaml/txt files that are not in any
> > dts/dtsi file.
> >  By that logic synquacer's spi/netsec/i2c/exiu bindings and drivers in
> > kernel are illegit too?
>
> Don't know which one you talk about.
>
Documentation/devicetree/bindings/
  {
     i2c/socionext,synquacer-i2c.yaml
     interrupt-controller/socionext,synquacer-exiu.yaml
     net/socionext,synquacer-netsec.yaml
     spi/socionext,synquacer-spi.yaml
   }
and corresponding code in drivers/


> > The synquacer dts/dtsi are in u-boot upstream. SR testsuite looks up
>
> Sure, can you point it? U-Boot upstream is a valid project. Just like
> many other upstream ones.
>
Location of dts/dtsi in u-boot upstream is
     https://elixir.bootlin.com/u-boot/latest/source/arch/arm/dts
see { synquacer-sc2a11-caches.dtsi     synquacer-sc2a11.dtsi
synquacer-sc2a11-developerbox-u-boot.dtsi
synquacer-sc2a11-developerbox.dts }

regards.

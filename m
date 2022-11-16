Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA9F62C4E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiKPQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiKPQlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:41:13 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D645B86C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:36:56 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id z17so11971374qki.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FtljCHB188MWW7ntwygEmLROpjqDhHXkcOH9eK0i0kc=;
        b=P0uqb9u3+Rlilpl3jrAhOGWhd5y3qWKYnVl1/SVdkIRLvUlOqPGEpAjLOOQX++wdx7
         /LoVebMzv/Xu8bEUL5AbhiK+G690vOMJyGOMrt+yuzBXhql2d97N90hNc5mvBmaFlDEv
         6QNxaASnWmqxfkPSYAyUzR/j+XAUJegWqNGFM4BCqItHroXZgWCj6+ZmE8ob6FBWzW/8
         pZ3qXLMmncGNNsX+3ekz871N6mfHHcyV4d6Z7q8d5dBPr8F1l9VW39SwKKqoQeC4teOe
         69UR4JJu6D1d384rUSP3WuR/7dQOGraEpTvKs+tV0OsLPjwbxhm/w9SDkzP79o3ak3km
         VJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtljCHB188MWW7ntwygEmLROpjqDhHXkcOH9eK0i0kc=;
        b=lsyDnKA48xepVKQXC1zIe26wsjWNKjutINIMCvkdSvowrjx+C9NQZU8BXV8tw9iTFc
         SbTkVTO0HAjhM0RaPpaNpGBDm1j4LmLowKeqsR3P58K7LfewUpNgRTZ6QuMFoRQm89tQ
         3POSxFSzJtgMx5MD55jniOO9q5HCA+jxqICnn2tJSO7TGH2mgad8QlNagZGKjy6Ch3kJ
         XtmMiI80/PlcR5QHFvr2ZmfY2BU2KqM+1+if+PMhlmsp82gjLKwmB0111zWp5Psc08Se
         m8scpFBEwu88vwIut1EmIhLMtaxW/u4n2qJLET1wS6PZZP3CJnXmjrBFmjewQJ1lGIAF
         1T7w==
X-Gm-Message-State: ANoB5pkhZ0gjRARTlv8n7ALLJM9jwH/FVUDpAW8BHtJGg4S0FzVFElm6
        S8LBXTdbHS7BFy9zCGeSYGMKeBmLMDjmSOdugxhPDQ==
X-Google-Smtp-Source: AA0mqf7bLW2y6/427DIYlB9ij6KH4wOQE35+6awS0UCcsLcFc9wmdZ86fYzUVQVEUNvCNj0BNRL3rWTIM/1u1gKIJ/k=
X-Received: by 2002:a37:84c:0:b0:6cd:f16e:320a with SMTP id
 73-20020a37084c000000b006cdf16e320amr20206780qki.495.1668616615885; Wed, 16
 Nov 2022 08:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20221116154935.163810-1-krzysztof.kozlowski@linaro.org>
 <92993d1d-e7b0-199c-5652-5158988a65b9@linaro.org> <CAGE=qrpAUcGwS5EQgMA9oA0c56=1C+2X5TjyyEFrf4xd5r7k+Q@mail.gmail.com>
 <8d9c6187-64d0-a320-8ec6-e9ae51ce93db@linaro.org>
In-Reply-To: <8d9c6187-64d0-a320-8ec6-e9ae51ce93db@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Wed, 16 Nov 2022 17:36:45 +0100
Message-ID: <CAGE=qrpY6QVE_K62sqY=HigsfSyfqqqGw+1nzpRaXuSbXC5nhQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: use defines for RPMh power domains
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 at 17:34, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 16/11/2022 17:30, Krzysztof Kozlowski wrote:
> > On Wed, 16 Nov 2022 at 16:58, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >> On 16/11/2022 16:49, Krzysztof Kozlowski wrote:
> >>> Use defines for RPMh power domains instead of hard-coding numbers.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> ---
> >> I sent exactly the same patch yesterday.
> >
> > Then the same as me I think you miss remoteproc@4080000. :)
> Uh.. unless I don't get what you mean, I think we both covered it.

Right, different one: mmc@8804000

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E9F67F054
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjA0VW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjA0VWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:22:54 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922EE05E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:22:51 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-50e7a0f0cc8so21852727b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4vdOAOoqQyamu824Bg2jVnX0JB8+cggVMUUOa+AlpfM=;
        b=RIrwC5Z1pwvW6IXth4E7ECGZv6907LRLEhB9RED4jcLIwd3gzD49gsKzWm2b6OLsU4
         s1GU4eUxxSslsNtgxFClhqTiqgqjjvx9D8xoWht7JDPu6fjJUSA+xxEcO082iDUoJEWT
         JB87HTDSpM0uTAZfoNzx9FtRXJg45QGLC+lvqHyMIb5ymDA5YVWJK+kE4uSqr9tw7Zua
         An3tDk6d8hD0v1I5ZBReh2dgyUCNOulYRGtxM+0uj9u8F6L2QbQVTcNN2ORWJOqCZH6r
         2QG1SlDbCTxqWhi76j7jFHhAYVKhtEL3Af3qVbeApEVNgWJcTAMI6u1GUy35S4DAwB2U
         N6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vdOAOoqQyamu824Bg2jVnX0JB8+cggVMUUOa+AlpfM=;
        b=LFgtcOLUHzZDaYxWtjHlydfnwwgFX1U6NsjFXR4T8ezG2/J1iS1FdJP0C9Do4Goytb
         om2q0VmzYNFvUO8t7cAOeFFMuTdEWUOMyQAoO3+JnHFq2UM/7Jz8LXM3HkjmG5+5DOK9
         EEfKjlZn5nkF/ndq4g6UmUTGJoH/Pa7WGHuULy3l+vO713dslCrHpBELqtpdc31+Mdjg
         mjNzheBZjOMfL1trl4cB0cw0fVqlbp/nXv9CsVZ6bVaxsPeatPfDDT7hDb5Mx8Zelheu
         9oH84haOruDmA9U67d+0mqEWf4Si2+q22HuFL9zGCz2IJmOcCx7/p+VBD0Mp3ZMLNOiO
         kjyQ==
X-Gm-Message-State: AO0yUKWWZWvb982T24IVE+tohQK5nG9wjyjQipSdGT3qGMRP0DIyynp5
        52dmiqpnpaFbIC4Z3HnUI9FDq4FBy4OtDu3Mg/lhGg==
X-Google-Smtp-Source: AK7set/Llav9UuJGUJ9624v7B8atuwarYYb+oB+F7FA5Lg+flMxFV4At7bePUiuLQUxF10HlFhWaE0Yc2vleylJ3laA=
X-Received: by 2002:a0d:d890:0:b0:4de:3f6d:76d0 with SMTP id
 a138-20020a0dd890000000b004de3f6d76d0mr1314848ywe.280.1674854570555; Fri, 27
 Jan 2023 13:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20230127192139.299228-1-brgl@bgdev.pl> <52508584-47c5-2497-68c8-2c0044911aca@linaro.org>
In-Reply-To: <52508584-47c5-2497-68c8-2c0044911aca@linaro.org>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Fri, 27 Jan 2023 22:22:39 +0100
Message-ID: <CACMJSevqcaqjLQJ6_5Xn=hMbrsjdxGVM=9RYwYQ8hW_Uy-tRzA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: firmware: qcom,scm: add qcom,scm-sa8775p compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, 27 Jan 2023 at 20:56, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/01/2023 20:21, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a compatible for the sa8775p platform's Secure Channel Manager
> > firmware interface.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
> >  1 file changed, 1 insertion(+)
>
> If you send bindings separately from DTS (which is fine), please provide
> the link to the user - either DTS or driver for this compatible. Driver
> does not use it, thus to the DTS.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>

Can you specify what kind of link you're expecting? I'm looking at
previous commits for this file and not seeing anything. There's no
upstream user of this compatible in any DTS yet.

Bart

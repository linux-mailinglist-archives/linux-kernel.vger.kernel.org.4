Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABBC5EA6A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiIZM5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiIZM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:57:09 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AB6160E77
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:31:05 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3450a7358baso64753977b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WvDse09bmVqe1v4bAMTxO1zF42M4yNVVMYmxZQhWitQ=;
        b=xdf57XKzjdyAQ9JfIDTR4dZFijfC7ZSxuluOmfABDC/fyCasGGVkK0noDxxxMT1bYs
         eNd6miXruXqog21Vm8KOZGauYAKx1TCMmnvIBVFNx+tLH9svmLyr6KOc20Sy0H2vAy02
         Mx0zddjMpJBKfG7Z/0yWkrMMgb0fngqUytR6U8Wa5SXKt268V8Ntd28P/BpIRClN+lD7
         ya2jDOizOmDkWhU9Q38TO+O1P/3pyY4MKUdAEgNNbbZAz0ypEykROEhdjSGa11AxUhpZ
         6i/0mWtyMzvrS9QcZs0bSYJ1DQnhNyZppq0yfCXExyPnUxedti+OfULym6lLY2NHipky
         60KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WvDse09bmVqe1v4bAMTxO1zF42M4yNVVMYmxZQhWitQ=;
        b=yiYV4Ht/HWMDDUQYJILVygrjOqGiO0jxxoynJBHoAJ76nKRkDimAP2G9AqI8dzx10G
         KhV3a8QFjx0C0on2/Ge4y2VLsDT9coD2nBNf8nfPTnNSvRnTvpOPOC+KzdMDcYTgUJiJ
         CWVxi9WpQf0hGXgwP8+DRIaZmmio0kmfRzsV29/N9xjFBqDcM5lDi5p6Utd7gRGsMj5B
         3dPEI8RhxC4+3EUAPykwtr3m8ErtaJZQV5DUdJxl92eI9Q8qjpl3NnS1bVSDAwwzuxhM
         1bQWjLRZR2/0c9i4+UC/3hf+K8En6q4XPm1XsJLc8EuJpFPeBH6j9qLN38orpo5dHO7f
         1E7g==
X-Gm-Message-State: ACrzQf08czU36a27QXGhLF7WDjJDNQrrKBZc5cNJUbLv5STMDiPJuF4O
        kLPKh4+Z6INKnOuIjJZrtV473xxIgt55eTu4RZrK9IDyGO8=
X-Google-Smtp-Source: AMsMyM5Tz7DUFDW33OpYyhT8+unBKHG5TNYkQGqQQnVd2QORmiiOiYZshfL+0/MqqJBQPrposOqCWQOY4K7zjY7ltNg=
X-Received: by 2002:a0d:d68a:0:b0:350:a7f0:7b69 with SMTP id
 y132-20020a0dd68a000000b00350a7f07b69mr8231573ywd.132.1664190989438; Mon, 26
 Sep 2022 04:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220720073326.19591-1-krzysztof.kozlowski@linaro.org> <7fdcff6a-9db9-a9d0-4013-7d3ff5fd5d8c@linaro.org>
In-Reply-To: <7fdcff6a-9db9-a9d0-4013-7d3ff5fd5d8c@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 26 Sep 2022 14:16:18 +0300
Message-ID: <CAA8EJprom=CfxPQke5JjZi0CSSvvB=cw1RxOO8StLThpASG3ew@mail.gmail.com>
Subject: Re: [PATCH v5] dt-bindings: qcom: document preferred compatible naming
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
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

On Mon, 26 Sept 2022 at 12:30, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/07/2022 09:33, Krzysztof Kozlowski wrote:
> > Compatibles can come in two formats.  Either "vendor,ip-soc" or
> > "vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
> > DT schema file documenting preferred policy and enforcing it for all new
> > compatibles, except few existing patterns.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
>
> Guys,
>
> This is waiting for two months. If you do not like it, please respond
> with some comments.

I'd say, this is good, it documents what was agreed before.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

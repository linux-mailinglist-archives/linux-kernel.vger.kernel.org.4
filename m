Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA4E6F3043
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 12:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjEAKiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 06:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjEAKiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 06:38:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DD318E
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 03:37:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f19afc4fd8so12786765e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682937476; x=1685529476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XUFrN73mOh0JgUZRe7aXQZS5NNy9xGVMTM/WhLZlcp4=;
        b=byoHvCMmhUlW5EU6O9UVDBWuiZ6f6/vcO7hXQEvXxj+870kLIHd+U6kr5e59Z7bh89
         FtV7Tt5AmfXcrjhtnn0mlc7mDLfCnJM3zJQCLN/KDNpTIsH5djQcv7wjdhyB0TJ2PkNK
         k0LgSEBPVizKU9LOfBTBoXnMRQOvbq1fWkdh9SyVSHzuGsmJYqqEfLp+O8lSANRsIJ+2
         /Kbtq9OzzX53T5WxnsMMjLqAV1x7CzF8EH5zA+gdjINvkGNIl/Se0G/M/5Zp8AieIlnf
         QNR6fcV31aHtNrCIxH9vZgkaK3BlN8aPCqrXeSRzX5+cgVwMJCnF7E07WmRGLzkRcvsW
         zOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682937476; x=1685529476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUFrN73mOh0JgUZRe7aXQZS5NNy9xGVMTM/WhLZlcp4=;
        b=k5KJjwLuEnDu2iSwCEqy4Aly7hcg9szRNxjPeb4NtsV23UYGCmzFGLpyocu6xzEZ0p
         oBhdQel9ldw7lCReJw2ukDjnRXyuTpBKcDeQF+sV3ss31uhDLMjnYE58D2Ll3Xqz5vQC
         xKQkWBeWAJiZojIe+MWTWldRkWJS660bevQ7LFIktR8qu1XLOUlE2MAD5girhnaZcAt2
         R1O2/erYlXoZbcOnPCwufSKi1XWOSFSESI3DN+GAZZOkn1qQ13EvQxV9FId//uxo5cW5
         sR0pPrssOmgITQPlGs2WjqVVdITQmHpcKCQ3EcxJFVcBMFC5kQfpZVxdglcUNpmJCMIH
         OXig==
X-Gm-Message-State: AC+VfDzUOQC+x1QRPep2VWJPmxMLVakvRCrLQZYkKf5aYA5ZMxksSDNd
        MARbl2IBIV0Ir0vEPuCSdqlwaCIW++fP4GgthBMmUg==
X-Google-Smtp-Source: ACHHUZ5IdM5Qveq9OfQ8rEUvlCr0SKGNHHh0wMsIpYCugnf3wnjOK6EF+kdiJZBvF1zZRAdR4PIJ3D7CiLgO5Pymows=
X-Received: by 2002:a7b:ca47:0:b0:3f3:1cb7:b2a3 with SMTP id
 m7-20020a7bca47000000b003f31cb7b2a3mr8615957wml.9.1682937476525; Mon, 01 May
 2023 03:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230501102035.1180701-1-bhupesh.sharma@linaro.org> <6a37f442-3448-93d0-99dd-705f2727f80a@linaro.org>
In-Reply-To: <6a37f442-3448-93d0-99dd-705f2727f80a@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 1 May 2023 16:07:45 +0530
Message-ID: <CAH=2Ntw0ihy0j=Yx1PTjr1O9asgeFCp8CGVwvnJ97aJ7Ky8Epw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qrb4210-rb2: Add SD pinctrl states
 & fix CD gpio
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 May 2023 at 16:06, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 01/05/2023 12:20, Bhupesh Sharma wrote:
> > Add the default and sleep pinctrl states for SDHC1 & 2 controllers
> > on QRB4210 RB2 board.
> >
> > While at it also fix the Card-Detect (CD) gpio for SDHC2 which
> > allows the uSD card to be detected on the board.
>
> Separate commit is needed for the fix with Fixes tag.

Ok, will send a separate patch in v2.

Thanks.

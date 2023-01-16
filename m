Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB3F66B702
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 06:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjAPF4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 00:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjAPFzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 00:55:54 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA1E903C
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 21:55:53 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4c131bede4bso367263827b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 21:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+daLfxi8Ns5qDmIM85s09QTJvJFZ/n3H5RvZXOfUl0g=;
        b=IUkt+lN7A7IoDQPc/iGxftg+aaXqQ2dU4uBpYuT9m99uYJWJlgob/74I6G+RBWZ9Sh
         lZX1mBVqXGtGTaW2kZzzR3IhC57x5tb/i2NBH9ihXtcREqG8iyAkhkkbuzDKgkkNMDWT
         na1PXaNGWc/eBa81J4uMhJas1BqQ9lzuV/am1ZVNa3z7IxvR+TbDbz/Fp171PWAzc/mM
         YYv2ncNdzgp66RL1s1VJG2N7ViFAV1Uqzb/xVyzqUZ5CKHDX+/9b4auklG/gIx7Z3Zej
         DN6Nw+XTKNWor+Uq51V1dxYoexb1GJXw0BOMgrE1KUIrrz9agvBWisifhhNc15Ldjyxa
         29gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+daLfxi8Ns5qDmIM85s09QTJvJFZ/n3H5RvZXOfUl0g=;
        b=AXzshP61rAd66o1Gu6mtyRWNsbmHDpUZo7M5tC9ZEhhLWIXMoNCe1D3V/8lai0aXZZ
         nkTRePgX/+mbRPpX/8WSDqO3gFWxBlDq66IvH7IMoaVXn3CgJWglaf3leeBRHEPkV5mm
         4nJPZYR9SqsmzJzxGm0YeRHKmBLQjzqo6s++MF3+8djFVYa0smCkWxcFZZxtITY5iZ6E
         kTGFiLzD3Ig4niidWsvz6x+h3l87QE1/V0YXpQ6TVJVZFoTTButiS+blLXEygaFvT3LS
         hWENENfo5GulAitpWSeqc+Ksu+BxtcXeFlx0Hk7LJzSmgxZ+14T0oScugxG3tl/BQrNi
         1zrQ==
X-Gm-Message-State: AFqh2koTV5Xwte1q66Lf6/abyDO8ftKwwn9C4kVroEl5lKtzsjpcZZwH
        X+0XR8HA3jL5a69Ylt1rayQtmpl73IHYnvhr2VHFdA==
X-Google-Smtp-Source: AMrXdXsywB8wnhpDlO6nEJpmrDCZXmry8C3GEbuCRPVZ1B4e9vvXn4rdj8YMuEXVa6jUakAt+fpSQ+gxuzlzozQZLpk=
X-Received: by 2002:a81:608a:0:b0:4a4:7135:9214 with SMTP id
 u132-20020a81608a000000b004a471359214mr97195ywb.378.1673848552367; Sun, 15
 Jan 2023 21:55:52 -0800 (PST)
MIME-Version: 1.0
References: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
 <20230113162245.117324-2-krzysztof.kozlowski@linaro.org> <e3c367ba-b752-d116-0b84-fd2437e565b8@linaro.org>
 <5e784285-c391-91f4-c9d1-a53443fc4264@linaro.org>
In-Reply-To: <5e784285-c391-91f4-c9d1-a53443fc4264@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 16 Jan 2023 07:55:41 +0200
Message-ID: <CAA8EJpr+0fnhy+aHwmdKQA_xk2Qkse0L5u8JdCJNDZqqdYwhrg@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sdm845: move WCD9340 codec to
 separate file
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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

On Sun, 15 Jan 2023 at 13:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 14/01/2023 21:33, Konrad Dybcio wrote:
> >
> >
> > On 13.01.2023 17:22, Krzysztof Kozlowski wrote:
> >> WCD9340 codec node is not a property of the SoC, but board.  Move it to
> >> separate file and include it in the specific boards.  On all others,
> >> keep the Slimbus node disabled as it is empty.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> > Generally this should be SoC-independent, for example some newer
> > MSM8998 devices shipped with the 9340 codec that most 845 devices
> > used, but earlier ones used the WCD9335 found on MSM8996
>
> OK, but I don't get if you expect me to change anything?

Maybe it might make sense to name new include file just 'wcd9340.dtsi'
rather than 'sdm845-somthing.dtsi'? Same applies to the wcd9335 codec
found in msm8996.dtsi, if you are going to extract it too.

Note to Konrad: I don't see slimbus support in the msm8998.dtsi. Are
there any pending patches?

-- 
With best wishes
Dmitry

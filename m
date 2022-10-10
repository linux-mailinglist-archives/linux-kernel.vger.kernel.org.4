Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85855FA477
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJJUBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJJUBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:01:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3935A8A1;
        Mon, 10 Oct 2022 13:01:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qw20so26492091ejc.8;
        Mon, 10 Oct 2022 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6b+KaCx09GA3QolK3KuClvOKT2GfkyeZNoDE6Qz59iQ=;
        b=QD2c9mI0hGjr2S9pTnRJ9VjvS2XsFp/HC+3XbVw5FaU0fn064zySsdyw0FnVYHnOTa
         d31u0tzok+8mMKbnXeWJBE/oVqKHFOTryaQMmln0OwzuPo9Eruihnr8DcMxZzfKPXL/0
         PSPCR4C9pf5roOKoz7BJNFbBCkWN3/pBM24gfos7762pplcw99vOEhOUR8cYxV2RzmD8
         uKQ5gVupjmX1RHkkPpwMgsuJz0TIFB3+p0g6ndzf1Gy6/+YK1vX/TMj3JD0OpsU1bwDd
         FeF/B4Q97F7qLEcl29dmuCt3tVQtC50A4SQ7M24/IQPQUg366aNxrlCBKtHr3eal41pO
         1Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6b+KaCx09GA3QolK3KuClvOKT2GfkyeZNoDE6Qz59iQ=;
        b=YNMYc8odvayXgFcQNfcyOHidPEpTAxOzElcObFWV5ipHOVsiCi+H/m2NTYnEt48tYz
         dga4oZOmxsZ3TVQpjdyve2VfNbckESvwOYYLsQnSvlvE2I4hrwIFBHovz9MMnQoaWuhu
         uhUR6cStyyrlRb8+l9ACNNVPmOcbCyG7oV+0ajhcWeYfTDrQuD0ai82WbrloYqKqr+0p
         ECNx5Bas1PBnKOlpYs7PHVizsiTsO40YFORWOfOfeBg+A/boYREC7/yJg/xJQJYO2A8m
         S/0VyN6//MoDoZvUAATEzLDxWBQjc5hq7gP6PnpoeKFrUbpiI5oKTm2ezMM6Rceb6dGQ
         97FQ==
X-Gm-Message-State: ACrzQf2r8GGOtk8F2BU7ma2lHw5aYIbA+cY7jdnsnScCR/sdBH0Z8Zhz
        var1s+veshoA95w4nGV6IqqnzPAejjut3fWs59HrdsQj0qHdjQ==
X-Google-Smtp-Source: AMsMyM7o7nc8gZq5drAITDcdLLEM/8u5lmS/UZSANjBN8uxmCSuzRwxy+MShw9wfOHL1Hb34dYP1sbXDHuq/plwOVL4=
X-Received: by 2002:a17:907:6ea1:b0:78d:4c16:a68b with SMTP id
 sh33-20020a1709076ea100b0078d4c16a68bmr15994226ejc.447.1665432067395; Mon, 10
 Oct 2022 13:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221009230044.10961-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y0PBdDtFzcsmbtMv@shikoro>
In-Reply-To: <Y0PBdDtFzcsmbtMv@shikoro>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 10 Oct 2022 21:00:41 +0100
Message-ID: <CA+V-a8sOxyQj8J06kqnRN5G=L6KPdusJ-qLWntVa8kgFBh-MEQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] arm64: dts: renesas: rzg2l-smarc-som: Drop enabling WDT2
To:     Wolfram Sang <wsa@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Thank you for the review.

On Mon, Oct 10, 2022 at 7:53 AM Wolfram Sang <wsa@kernel.org> wrote:
>
> On Mon, Oct 10, 2022 at 12:00:40AM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> > used from CA55 CPU would result in an unexpected behaviour. Hence drop
> > enabling WDT2.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> I'd squash patches 1+2, but that's minor.
>
OK, I'll wait for Geert before sending a v2.

Cheers,
Prabhakar

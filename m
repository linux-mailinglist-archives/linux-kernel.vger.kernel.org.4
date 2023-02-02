Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578106880DF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjBBPAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjBBPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:00:06 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6096B402CF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:00:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j5so2136853pjn.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hjtSMcHdo/6LQulLVHOl8CPb0d7hVaersYbne3X+bik=;
        b=zD1E9RVv6wVZMCze1+4pkl1PKVfZrFaNrEnCtfVqtxMutX3tSn1R3IuVi8wXqBa6P4
         zkHB7WD8EZJordFXOW310lBfbWLS0loyhQaRJ6GtbcTFQSuSUiH6WjThav0zun+OIEBw
         P4fIgWFFWP1gxlgS/Zgouibh4BGlxtBcI94SM/T7TEjdyfB2KyPPeA3iseJAVpIFdP6D
         iClQL/jWN05/4EayDiAEXERg3PdellksQkzqpSzHLnuFPOGMixExvAE2MjIJ4rOPqfuF
         KKPMa4p8jy/9VjI5YRF6hwbkBRK6khrRF+sIpnaGaGcBr3pDvPRz75Oaqi5SNzAFJSWN
         TmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjtSMcHdo/6LQulLVHOl8CPb0d7hVaersYbne3X+bik=;
        b=6XUK/bcFjKHN9JhXrEl8Lv+AfDx0Y1TQi4Y6Ev5MHdltlCBsKfl2O0jKBXhzkvgcfp
         l2u3PCU/EmhKdBZpe9tdzbw36SmsPtR/HxB/gzzNZmdPByfpQ00iBqrZyVTFZITEmBSr
         Cnos9GZUUHu114juGKDoMeh9LtoGWAKkkff2gMznUUSU+vbDHk2ffKyEK2NstU5s8lXt
         k6lzJiiI/H9c5lFlKC7LJRBk2tbIj1ZB+zuK5y+KuH9gfktyS5qkKnWPd7ygglnYMUGO
         QJxGtkxdhA3js7lt8ZzeebyYlTca048XTTYmQQjHzWHG4e3U+qt/pWl1PG/BE8AbwSLx
         4gwQ==
X-Gm-Message-State: AO0yUKW45Gj2BnJPz/vnYWqBqkZG3kzkEPrSoOp4Bkr7M1RLKho+lU+y
        Hm5w+3ni8ptMzTIp2GvpOPCaglqk+262/V29Hg1HAA==
X-Google-Smtp-Source: AK7set9YKduFWnTdTRlctnFptPfKDcEe5mltzTPrSDe8AB+1hnqam2H1UBHfk2HaxsG9DmoA9IT8Hmk2x9+IrlfWkjs=
X-Received: by 2002:a17:902:e807:b0:198:a084:faa9 with SMTP id
 u7-20020a170902e80700b00198a084faa9mr1529979plg.33.1675350001791; Thu, 02 Feb
 2023 07:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20230129023630.830764-1-chenhuiz@axis.com> <b43f26c9-f76c-c898-aadc-ce3ee7b7823d@linaro.org>
 <b125f25d-94c7-dd5b-28d3-3948c36ef4e0@axis.com> <a1d2ac4c-0763-5c92-be21-22820c376438@linaro.org>
In-Reply-To: <a1d2ac4c-0763-5c92-be21-22820c376438@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Feb 2023 15:59:25 +0100
Message-ID: <CAPDyKFqX+1HBPmgXC9Apdb02F25J9ZTKRByqZQZn6Xx4Kf=Efg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Add cap-aggressive-pm property
To:     Hermes Zhang <chenhuiz@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@axis.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 31 Jan 2023 at 17:57, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/01/2023 07:54, Hermes Zhang wrote:
> > On 2023/1/29 18:58, Krzysztof Kozlowski wrote:
> >> On 29/01/2023 03:36, Hermes Zhang wrote:
> >>> This commit add a new property: cap-aggressive-pm to enable the
> >> Do not use "This commit/patch".
> >> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> >
> > Done
> >
> >>> MMC_CAP_AGGRESSIVE_PM feature for (e)MMC/SD power saving.
> >> Why this is a property suitable for DT? IOW, why this isn't enabled always?
> >
> > This property will benfit for the power consumption, but it also may
> > degradation in performance as it will prevent the
> >
> > the card from executing internal house-keeping operations in idle mode.
> > So it's better to config it from DT.
>
> Why? DT is not for policy. How you described it, this is policy or
> system tuning choice thus the job for Linux (OS), not for DT. So I will
> repeat - why this property fits the purpose of DT (describe the hardware).
>

I guess the HW perspective here, is that it might not fit all
platforms nor the actual eMMC/SD card to support this feature.
However, it still seems like a policy rather than a strict HW
constraint.

Perhaps there is a way to figure out in the host driver, to
conditionally set the MMC_CAP_AGGRESSIVE_PM for the host, when needed
instead?

Kind regards
Uffe

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E576066DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJTRRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJTRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:17:18 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EE31C4ED4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:17:14 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c23so11878qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OfS3PAbgU5fdM3mlH/Doym0ZOyotvOhqPPNXIfWXxXU=;
        b=fvQf7cxLfylCVvbDZ+x8m5934hC7/FjZTwkxfhh3MiC6/bogZ5zzLWAZmnQ/U/RXr8
         aTokiieV2OWXALr13T7iuZxD0GUieMX70xMSKxgP3ZdNp9KqoqfZs49i0g7hHNcIZPCy
         noaz6+u2fWcFmfmZfT8dZ49Y31BW5mTLP9SpWDtUhPUNIPXO14sfY4stxlTTGX1hXMzi
         rrvv+SThHT9aCh8hoLSFm+MS8BZKqf8YzglB8CIh5HEqB2GQojYxdSYF68hV/982nNO1
         cILj3V/9UgNtWfPTl/P5qPMm1gcHG7LGlHdjZOndXsH+E4xx158NwCgw/yLE34tgKzZ1
         Jmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfS3PAbgU5fdM3mlH/Doym0ZOyotvOhqPPNXIfWXxXU=;
        b=VY18rmU5d3t7EJiBPM5U7IziSiI1cnslOVbUtCu6NaJ3sfZpuJZAiNgYktWXGCp5rP
         lh8tBkMIEVIHKrAxKAvqz/znib/08sDKAVRJ4vq2lpkJZz+Lbq2b3I4vlvpBrGqJHD+J
         g2mzz3xWcPwTt/kgky5Lhb0d3ir4OgECg9naSW+LSZ3PEcbYPJjagaRdGDsG253SRqkT
         Xyk66cePCzSj+svv0ktZkyotjCXjpQn3bCONJIKSf1qnlaTBxFY6avpPm1UXpOvm86VG
         S8qSwDvRgfIWmanrQJA5JtjMaaSBeNpDwnHW8t4O/4wKlyQkDIHqcinZpH4fr02N0ccU
         LPCQ==
X-Gm-Message-State: ACrzQf2UCIJpiWWwiCOy+ADclMzN+vo81r1yS4pZm204C9efgcIDinkF
        piy2qJ3MejgJafQAIc5dyXPAs+l7GKzmynEwEcs=
X-Google-Smtp-Source: AMsMyM5kZtjjaVCQaySLvbFxD66drooBMyE2rJEbxk5ad+kV8Pq/WTP4J7aNmMAWfqB2HNK0Cwfoa2OQWAwZ0ngtzVU=
X-Received: by 2002:ac8:7c46:0:b0:39c:fa92:a27a with SMTP id
 o6-20020ac87c46000000b0039cfa92a27amr9724358qtv.61.1666286233828; Thu, 20 Oct
 2022 10:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <1666283513-17005-1-git-send-email-u0084500@gmail.com>
In-Reply-To: <1666283513-17005-1-git-send-email-u0084500@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Oct 2022 20:16:37 +0300
Message-ID: <CAHp75VfWawPZyqVQ5TJVPQiW+QANWvnougdiDfvthuNhfrzTbA@mail.gmail.com>
Subject: Re: [PATCH] mfd: mt6370: Add the overbound check to prevent the null pointer
To:     cy_huang <u0084500@gmail.com>
Cc:     lee@kernel.org, matthias.bgg@gmail.com, chiaen_wu@richtek.com,
        cy_huang@richtek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, Oct 20, 2022 at 7:31 PM cy_huang <u0084500@gmail.com> wrote:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> This potential risk could happen at regmap_raw_read or
> regmap_raw_write when accessing the over-bound register address.

Functions are referred to as func().

> Below's the issue reproduced log to access over-bound register with
> regmap_raw_read function.

Ditto.

> [   41.301385] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
> [   41.307296] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)

Please, read Submitting Patches, and trim your commit message accordingly.

-- 
With Best Regards,
Andy Shevchenko

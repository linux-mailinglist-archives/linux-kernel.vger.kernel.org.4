Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BC15FCE7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJLWeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJLWdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:33:54 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9A5118741
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:33:51 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-333a4a5d495so1923457b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FwLUfxB8SXrw3NQDomUAd60ArMa52KC+Lg79Tj4TeiI=;
        b=s73IStGtmlEJucueszS7Vxm4EKvpKoXKq1IIpWNCmBF8DdU1OE4b3Z0dpdUMPfVSMo
         lybvPLkLHBt1lIhm893t9PY8KQJyoWUwNUkxBke6xsoFs6WRhAQO8zthnBbx3LATUC2M
         yxBCXh0nhYj64VTPSaCZ2cT+Z2Xxqtp1iF7YcU4u/hgXhLZUE5QL6A9yXO/De8zLOZrj
         7nsXS4c0r/LE6uw5QFl35BAYrS3a7ihwGY9spFAx3LXsw42qw315Q8qFf8T5B53TWFWU
         j74zPkaZu9JvCWHOWpgPrbohPSZrQR9r8l81918TH6xNdEuZ0TsqI6ekF6LJumBk8HGC
         2Bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwLUfxB8SXrw3NQDomUAd60ArMa52KC+Lg79Tj4TeiI=;
        b=2/bP/tzVJQCC3RUuo4wRA6AheZoDgyUVC9XlpStT6yBGOFeNbrK3XcLsOjAM88p+uY
         GJrapTz2DHM+3rT6UgHJJdWIfV5/DDWiAmr4ays78wIwFAsfrf1vqKPoo2i1pHC5xRQ4
         EV4q1mdlYqoJuM+LsWw/UswGHJgaeu0B01gkGi4K+Z3vM1AeDkS45h1KO+YP4w3cwuN9
         sjkHD4pYsu2M9ebPl3WEN1JJ1oooYOHa6s9NZj0JfPZiYRQGwoJYUltwrz9+8arrA3RP
         KwBpvJTLrciZFVHkhGhQtViu6GWuJiLo4GR0fzoisiWALbh4hS3vzQHyMMZD9WT4605/
         m7IA==
X-Gm-Message-State: ACrzQf1KtbXLdqDuQuXi1+Ay4oLbv7k2DCDrk+MmVw9ihmKvp6TYOJjf
        pOJJ69zZpWsIkl33bPJTg7oOOjFqJiq2mel90RNcXA==
X-Google-Smtp-Source: AMsMyM6Y0BgqVhw4oJ7krmkQ/dx4v7WLDCTnjrAR82SA5sw+4uSyqbCHFQJqpZW/bGq+yV9SodBTrZm24+EfX0EKpTc=
X-Received: by 2002:a81:a43:0:b0:35e:445:a024 with SMTP id 64-20020a810a43000000b0035e0445a024mr30116302ywk.378.1665614030216;
 Wed, 12 Oct 2022 15:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221012215613.32054-1-luca@z3ntu.xyz>
In-Reply-To: <20221012215613.32054-1-luca@z3ntu.xyz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 13 Oct 2022 01:33:38 +0300
Message-ID: <CAA8EJpr2GS9XAd12-9abd0FBn0DKDpos9np00=M49BptYVz63g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: remove bogus ufs_variant node
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

On Thu, 13 Oct 2022 at 00:56, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> This ufs_variant node seems to be a remnant from downstream devicetree.
>
> As it doesn't seem to be used by anything upstream, remove it from the
> dtsi.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ----
>  1 file changed, 4 deletions(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

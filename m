Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B785BD87F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiISXzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiISXze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:55:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B2C4E600
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:55:32 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dv25so2244180ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yfATfabNUJHTE7KoWz5tianqb2se6NNt8ssnLCiM3vM=;
        b=HV77nvu/6m5fXE76OY/pv1J5LagXGgFIHxHVja+vZD5GGHJUZUVtbSeyHyOzP3BI1k
         q8KZbVHHluXEvWGmq5aB60t1fzHiWETXVO+ymCXT+XNgpK6+dyax8t3CtXb979Vu6wk9
         rebhZrc/2rOf9d5Q0uY9dSRlcwxvDNuVdAaK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yfATfabNUJHTE7KoWz5tianqb2se6NNt8ssnLCiM3vM=;
        b=U5KfGI0e7htDwE5MpG3Gp6Jjc+Rli8En9SRCEKoUeBV2LYIQp+OrWVqd0NWwtMlAHd
         Ie48TW1cWF7z9aTIceHYcFJqDlbQ8EYAXlHlZwMwsjrDrpQSDtrsLAoYf5WYfUifJ2XO
         QKwKTitV4kYKBpuzbpXuYcUP7OCEHGGhqTH419nNT7bvxSXFxfza1Ki4WypvYF0oMkhN
         QuDkLSX4vyBfgtigeW40X0e7MrP+rn0hxIyR4givWcXT9lSzjTmGL19nBVVzxwLJcezF
         LNBxfP6YAFg7+WNKn4UETcnfxir+eNST6M0RBBzar9SQNBO0h687DRpsA2990Ea4sdE1
         JkdQ==
X-Gm-Message-State: ACrzQf2byngsc38Mx/HT4pho2B8+PaQXETWqWKAowd8zYX/vGF8SB8PX
        xNsZPErj4DkR0F3BbZhhY4/FgO0taGSA7D7S
X-Google-Smtp-Source: AMsMyM4U3kpTUix9y9ecww6Br6Asfb3pJBp87PrXfUW7rj/6XHoMxe8DTDVxLkDGi7++oK7tFAtjTQ==
X-Received: by 2002:a17:907:a044:b0:770:da0d:171d with SMTP id gz4-20020a170907a04400b00770da0d171dmr14257352ejc.742.1663631730285;
        Mon, 19 Sep 2022 16:55:30 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090631c900b0078197a9421csm857940ejf.85.2022.09.19.16.55.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 16:55:28 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id z6so1649528wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:55:27 -0700 (PDT)
X-Received: by 2002:a5d:6c62:0:b0:22a:2f59:cb7d with SMTP id
 r2-20020a5d6c62000000b0022a2f59cb7dmr12106298wrz.405.1663631727515; Mon, 19
 Sep 2022 16:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <1662754496-31143-1-git-send-email-quic_sibis@quicinc.com>
In-Reply-To: <1662754496-31143-1-git-send-email-quic_sibis@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 19 Sep 2022 16:55:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMC28U5eZhqUyr6gcNiFKmHfNLjmVAb0Asx4u0mLXZtw@mail.gmail.com>
Message-ID: <CAD=FV=XMC28U5eZhqUyr6gcNiFKmHfNLjmVAb0Asx4u0mLXZtw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add Google Herobrine WIFI SKU dts fragment
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 9, 2022 at 1:15 PM Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> The Google Herobrine WIFI SKU can save 256M by not having modem/mba/rmtfs
> memory regions defined. Add the dts fragment and mark all the board files
> appropriately.
>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>
> Depends on:
> Add LTE SKUs for Villager: https://patchwork.kernel.org/project/linux-arm-msm/cover/20220830182923.3720287-1-dianders@chromium.org/
>
> Instead of just having remoteproc_mpss node disabled, we go ahead and
> delete it on wifi only SKUs. This is done to avoid the dtbs_check
> failures that we would end of getting if we delete the memory-region
> property present in the node (since it's a required property). I'll
> send a follow up patch with IPA node enabled only on LTE SKUs as soon
> as I verify that it doesn't have any affects on suspend/resume.

s/affects/effects


> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> index 344338ad8a01..480cb88f2154 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> @@ -9,6 +9,7 @@
>
>  #include "sc7280-idp.dtsi"
>  #include "sc7280-idp-ec-h1.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"

This is unrelated to the WiFi only separation, isn't it? This looks
like it's fixing a bug in commit d42fae738f3a ("arm64: dts: qcom: Add
LTE SKUs for sc7280-villager family") which removed a fragment from
"sc7280-chrome-common.dtsi" but then didn't add it back to all the
previous users. Not sure how I missed that. In any case, feels like
this should be a separate commit with a Fixes.

...also: instead of adding this include to crd-r3 and idp2, though,
why not just add it to "idp.dtsi"? Right now all things that include
"idp.dtsi" are LTE SKUs, right?


>  / {
>         model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev3 - 4)";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> index ccbe50b6249a..6a2ffaac33bc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>
>  #include "sc7280-herobrine.dtsi"
> +#include "sc7280-herobrine-wifi-sku.dtsi"

I think this is wrong and evoker is a LTE SKU. I'll send out a patch shortly.


> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> index f1017809e5da..ee3bca264f67 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> @@ -5,7 +5,10 @@
>   * Copyright 2022 Google LLC.
>   */
>
> -#include "sc7280-herobrine-villager-r1.dts"
> +/dts-v1/;
> +
> +#include "sc7280-herobrine-villager.dtsi"
> +#include "sc7280-herobrine-audio-wcd9385.dtsi"

I don't think this is enough. villager-r1.dts also has some other
things that you'll end up missing. I think you need to move the
existing "villager-r1.dts" to be a dtsi file and then include it from
both the new "villager-r1.dts" and "villager-r1-lte.dts"

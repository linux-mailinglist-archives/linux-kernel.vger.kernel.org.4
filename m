Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22776867B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjBAN5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjBAN5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:57:39 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F5D508
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:56:57 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cw4so12629216edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 05:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pKitcKKw73X1uo1uIzQcYZyxxtvSIaIwF803pkaRmSE=;
        b=FhJUuGyjgf0pkYLwIlP1FpcxIZB3jRzpwHy0CX43ITrZwZiv83McD06EZgYXSO4r11
         dJobdMR8ZOSWRtyrc0Xmp8Yp4nb+hSM/6X5B0n+kJcqwp0/OagZwS+NJE7+L3tr2Vd76
         2PddzgUBgIgwgAv7OoNTXaiAN/+iEq6wD//HY3qidEe5Kjq9oSaIYl3kw259xt92DBpx
         YVpu7Z0QdUjOfnlV0STj1kPGyRHw1K3qJoYft1KBKvD0f4YhaM3aQC1xMkP2oznRJAXf
         20BIwqusiH/5Juk5cXptDlDRFa+kI+LQoMHKQWAf69g58OWBPQaQ99yEWc1MsNOFf/N2
         o7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKitcKKw73X1uo1uIzQcYZyxxtvSIaIwF803pkaRmSE=;
        b=ZmRpCG+GMfzyEXoJE9EkhVXF+GQxE9O/FYnnmoQBxIMkYndZNmqrYxjNzvyKZftFCh
         Vi3xs95CzvXhGiEAhXc4+wxoQS+7OQx5pmQp3n/0z8ZKFWbN+uKb0+2wuMXlR1T6j06G
         /Bl5pLZAjiZ+tDlEqP9X8bdPWg6Um7XATYKJnH43APDzM/PwRtGd6j6UDCzwkaZaFu58
         Xe0xl2YRipYEOYkBIUvOQGCbgFZAeENH8WH0xIvdVrv41P60GrUwQe6rTBxVQh8r3wIb
         GA9sgaG3Iq6NUYbZpEqqTgFd8FVeVvGkCVO/zLyRDJjDLJl222vIGNRkgigBzgjHgyiX
         Ey3A==
X-Gm-Message-State: AO0yUKVU+mRbbFBaewL9sMsgRvb2uhNs/BPHDvEej9zdeM0CrwiAvJDg
        ORiNiFZ2PajYbMe1cDVt1Ilnndf8hz5dppuDAFar1g==
X-Google-Smtp-Source: AK7set+fW2KmoaBx/FnBrFLbvMtCz3uygU6NdCIHnSnRTpwoLCvXeW88aNhs0BlU1KBStOhx9bPS0QWyidRRPGNGZ8w=
X-Received: by 2002:a50:f60f:0:b0:4a2:27c2:aa9a with SMTP id
 c15-20020a50f60f000000b004a227c2aa9amr643917edn.61.1675259803909; Wed, 01 Feb
 2023 05:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20230126161048.94089-1-bchihi@baylibre.com> <20230131140439.600164-1-bchihi@baylibre.com>
 <ab3357ad-01ec-8a1a-d627-a1543874f0ef@linaro.org> <CAGuA+oqXN3eoVyYkjuZjefPa-q542b7QLkBv+E-0a7k3U8BbFA@mail.gmail.com>
 <ad24739b-f8e7-45ad-ecd7-6d3329f01986@linaro.org>
In-Reply-To: <ad24739b-f8e7-45ad-ecd7-6d3329f01986@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 1 Feb 2023 14:56:08 +0100
Message-ID: <CAGuA+oqGDSQhUGaK8D+NQATJ_c8d0egULdQ+-S0fjHwW4moYKQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: thermal: mediatek: Add LVTS thermal controllers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Feb 1, 2023 at 2:37 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 01/02/2023 14:34, Balsam CHIHI wrote:
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - mediatek,mt8195-lvts-ap
> >>> +      - mediatek,mt8195-lvts-mcu
> >>
> >> What about other devices? You called the file name as generic for all
> >> Mediatek SoCs, so why only one SoC is here? Is there going to be more?
> >> If yes, why they cannot be added now?
> >
> > Yes, there is another MTK SoC mt8192 that supports LVTS,
> > I was asked in v10 of the series to remove the unimplemented SoC.
> > It will be added later with the driver that supports it.
> > just let me know if you still want to add mt8192 bindings in the next
> > version without the driver.
>
> The binding should be complete, if that's possible, so if you had mt8192
> already there, it could stay. Anyway it's fine then.

OK, I will put back mt8192 dt-bindings.
this is the link to the v10 patch
"https://patchwork.kernel.org/project/linux-pm/patch/20230112152855.216072-3-bchihi@baylibre.com/",
it will be the same in next version (v13) of series.
it would be great if you review it in advance, so I could take into
account the new changes if needed.
is it possible to resend this patch under v13, to simplify the review
and avoid breaking the series again?

>
> Best regards,
> Krzysztof
>

Best regards,
Balsam

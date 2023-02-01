Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3945B686195
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjBAIYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjBAIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:24:01 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953E75DC1D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:23:59 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id j7so18777007vsl.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 00:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QxrSISGq+nm987pWEjhCXdxOzzXqLRcFMhyKMBMFxIs=;
        b=M7NIH1HYH98LP7pSFAXoZ89ifYgjXxayxeDyr95YBO+LdJYZ3gx4DJGhBeSRPS/3bO
         BEyjEIIjI3GgSyi5sJJHumoQIWNIw+OpJS81aydLD93zjbk7A0r33jy/PsYi5k8FRPJ+
         OIjSnkWY3wAvTGrhpbnK13wF4PxTcRfCvqo+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxrSISGq+nm987pWEjhCXdxOzzXqLRcFMhyKMBMFxIs=;
        b=5ZpdJ5xV9Pj/FVOZNAodd0NAHirmfet2o/xSI+bULSh+Q6P5pWMvDrQCMKA9Tm2QTc
         jT/wNOOsfbny3PElPFhHEWKbrMtRejpTfVVK6BA9QTanD+1/aV4dYqyQmzh/Gr+Hf9hx
         Bfgwpih5AnNq4OsbTujXMowGJ5DAH9ObMqZq8k3IO/bE/VZ2YqGij5MantSuJokKUdUX
         iMwzINo4hKS+GnP6ZRCjf+LGzfsRdDV2GINUQ0DI4GHOinJBCiHR11kYi8ltOLeW8cXJ
         zJ4Ufq01cJdmvNknvuVd4m2bjxtzzN8J0EEr44HyMeRqC0MMQzqsm8TSEehODvN86xO7
         ANQg==
X-Gm-Message-State: AO0yUKU+Hb2PWI+lOzLPI4uZG1OEOFpc2G+YI09vP9adH18LuyGsZNQy
        ZbMETjdXXn1q8tw7fmlg0t7WjKnTLQGF7w4kXcOeV4wRyxpz/QrA
X-Google-Smtp-Source: AK7set9FuoQIF0gvgaW2XnYZ7Gcfgt0mCFA74ijOGFQCMA+N2fIYaPkYKfEBXw+x5mqQ5DmuMj693skMwY6aFK0oNVM=
X-Received: by 2002:a67:fc92:0:b0:3f7:93c4:9e56 with SMTP id
 x18-20020a67fc92000000b003f793c49e56mr335385vsp.85.1675239838728; Wed, 01 Feb
 2023 00:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20230130033305.31830-1-allen-kh.cheng@mediatek.com>
In-Reply-To: <20230130033305.31830-1-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 1 Feb 2023 16:23:47 +0800
Message-ID: <CAGXv+5E2r5T+Okrsz4biksCRF7DfPkBSbbgeKCsidg1MgOL3FA@mail.gmail.com>
Subject: Re: [PATCH 0/6] media: mediatek: Update video decoder nodes for
 MT8195 and MT8192
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yunfei.dong@mediatek.com
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

On Mon, Jan 30, 2023 at 11:33 AM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> This series is based on matthias github, for-next. Since there is a
> dependence in the following series, I send it for them.
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=702423
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=702078
>
> Allen-KH Cheng (3):
>   media: dt-bindings: media: mediatek: Rename child node names for
>     decoder
>   media: dt-bindings: media: mediatek: Remove "dma-ranges" property for
>     decoder
>   arm64: dts: mt8192: Add video-codec nodes
>
> Yunfei Dong (3):
>   media: dt-bindings: media: mediatek: vcodec: adapt to the
>     'clock-names' of different platforms
>   media: dt-bindings: media: mediatek: vcodec: Change the max reg value
>     to 2
>   arm64: dts: mt8195: Add video decoder node

Whole series is:

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

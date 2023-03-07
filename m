Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D026E6ADBDC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjCGK1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjCGK1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:27:02 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0740584BD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:26:46 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id f13so11861300vsg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678184806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAifdSfv0qu9/9RmW88ObONMsIk5lXQf5X6sr56a9BE=;
        b=HJP2dq5eXMi9C5VywdM47zJbV2wVa0N9nsZp/eflBdCu8ikIWZJM5r3y3UGBH1Dlgg
         ovaGRHIAavdwMr2Qq7xZieDNL2aXPJBNp1mqtE5DwSN4Gt7Tu1IBjw7nTVEj8ylkFhJI
         G3qzV/86brm1FEBBhZbPlFtVo43BQKrW+Gx+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAifdSfv0qu9/9RmW88ObONMsIk5lXQf5X6sr56a9BE=;
        b=eoUujCCMm89jsNdKNUID2dqjwY6Id6hNA9pihgapHoWpPfg4Gx9dzHOJ3AKemaYlRd
         FhAeo+oy+NL/36MvYDzNxj8kRmMMEn6hST59cHIG3RYOSytMFTMpTiBxWvdIRt89eW3G
         NMCwlAhU3zr5K2ZOLSgEDm2J+LfWi6ow0yaMcEd0/hTTvqBtT2szUeLE0wV3jJz91dEH
         cz1nODpyDTCykj5vdsBTKXthzwhpGbkMeV00hhxUg6LVT16QM/K/4UbNTxDwFPeJP0B8
         L7nCGoxs35nPg8Kh3ujAEdYeeBWfcu6/8crskSXyO4vvQoArv0ilGQEm05K099cUOypj
         m7qw==
X-Gm-Message-State: AO0yUKVDj20Bk5dAqBLWOItsQYedYKEplBPE4+Fn4289CEqanQ/b3eyb
        zSwNXoOsjrHe4o9YRsCCeAEHHQrffK04rQoLd3MOfg==
X-Google-Smtp-Source: AK7set+cFs1AwNyjrHfT4eFsJP6dSFO3pQ1xfcD0fVPi5XjmERq9rViR6hefLiK6x6lPDIOISJKm9Sftmn5yEh7+j64=
X-Received: by 2002:a67:e2c7:0:b0:412:2f46:4073 with SMTP id
 i7-20020a67e2c7000000b004122f464073mr8848432vsm.3.1678184806025; Tue, 07 Mar
 2023 02:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com> <20230228102704.708150-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228102704.708150-5-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 18:26:35 +0800
Message-ID: <CAGXv+5FcnLYZnWGtngkj2y0mozPopT=16X2rApFqNhRYxfMjPw@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] dt-bindings: gpu: mali-bifrost: Add new MT8183 compatible
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 6:27=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Since new platform data was required in Panfrost for getting GPU DVFS
> finally working on MediaTek SoCs, add a new "mediatek,mt8183b-mali"
> compatible.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
  with `make dt_binding_check` and `make dtbs_check`

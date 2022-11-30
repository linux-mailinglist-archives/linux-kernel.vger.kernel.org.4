Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE2263CDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiK3DMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiK3DMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:12:01 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CB16F0D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:12:00 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id k185so8416181vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdXRg/ymYsT6ceuUYZ9gb05rgN9bVA7aUAY63bAbLnU=;
        b=SoIN7hD1Jx/EisJhAV5UvLlwF4O+R/hauxyTGykE6Td5nZVT5ngcr4kH1PVsIcObpm
         8X6yalURb9S/7usDf1wKbqxEBYxUzvfRZ08nTcMmiTZR07H8wU805uhOr1BDDG4wiUlR
         vBqkZoOzaTYU7osj2zZfD4SSENw8iEIlSQpZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdXRg/ymYsT6ceuUYZ9gb05rgN9bVA7aUAY63bAbLnU=;
        b=4i7y38ubvf+rtkUtHj8hJxQeBUDYjv/IXvrXpbbjt8sbD7mPly+qt4tPX3E6Lp+axC
         XOUhefmeSDhHOkHrg+O85Q0dwc8g0MZBCvPuLW+wM5S5frRkbCwn0qPbSPqGbwpdTJO9
         sn7ycnCxdRsaJsc1We/LnWOa0CbSYvK0jLW9iIMFMsc3R1D89Qf6/AtRWqpleyiQfje4
         KzRnQvhoBnKciZn9c/3qXlFEV9rQq1RMx5jsljGdGwbtnCixAmd6gG2JuyC1UYItAdR9
         55bMAdrjQotrhKgoTvYHenwc7mcr79cLABOemzBSwAlO4HfKy/l6RGYpNV45Hn9lOZoa
         SsUQ==
X-Gm-Message-State: ANoB5pkbb0ME/7GLzldKbg8NNAtS/3IexAMTODLGS5ff42wRKwXJkKy6
        nqiMIwh+oWykCL/ZFvxOuoXXVm/88so0I95YlYQA2Q==
X-Google-Smtp-Source: AA0mqf4Ce12nXsx/KQEPYzoekZ8nkYEFv+RVatzvCHZ9e59KlrV+mHE/FyqwDJKS2UEJT28N79F40nXp1jsnNDpw4w0=
X-Received: by 2002:a05:6102:b16:b0:3a7:a88a:6bce with SMTP id
 b22-20020a0561020b1600b003a7a88a6bcemr25118213vst.65.1669777919916; Tue, 29
 Nov 2022 19:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20221102190611.283546-1-nfraprado@collabora.com>
In-Reply-To: <20221102190611.283546-1-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 30 Nov 2022 11:11:49 +0800
Message-ID: <CAGXv+5GY5f4UWR982cY0vzUuk7aB4BSa_FcKtku1ELatMr4Dwg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] MT8192 Asurada devicetree - Part 2
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 3:06 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
>
> This series improves some more the support for MT8192 Asurada-based
> Chromebooks, by enabling some missing functionality, namely the internal
> display and audio.
>
> In addition to that, aliases are also added for the i2c and mmc nodes,
> which should've been done while adding the devices in the previous
> series.
>
> Some notable components that are still missing support are:
> - external display/HDMI audio (waiting for [1])
> - GPU (waiting for [2])
>
> As part of testing the audio, an UCM file was used, which has already
> been submitted upstream [3].
>
> This series depends on some missing dt-binding properties on rt5682,
> which are added by another series [4].

Hi Matthias,

This series has been floating around for some time now, and has been fully
tested by multiple parties. The rt5682 dt-binding changes have also been
merged.

Could you queue it up?


Thanks
ChenYu

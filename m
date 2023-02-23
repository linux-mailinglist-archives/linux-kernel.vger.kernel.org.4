Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC28A6A0143
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBWCoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjBWCoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:44:09 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85122449D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:44:02 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id v27so4791951vsa.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=glBWgfS+Z8AsJzCa0azp9rra0TmC5WFPpp9wbSwIysQ=;
        b=TlXON0dnZS3i2VneFhuywAEetx5CXx1Yt7HMbvQ90/JuEusyf7pnz6RQIpVd7zC3o0
         n4VlSAzuWvRIT/CCUnkBdl+Zu47u8j1gifDeC4ygpLSlzXO4n8hRdHdU6zHPr8CNCmF6
         xYxOGJMOjTDNqwpbiTnDtDSQcydd71K1J0p4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glBWgfS+Z8AsJzCa0azp9rra0TmC5WFPpp9wbSwIysQ=;
        b=z7fPRXjAHE7OnM63J4IEYbLB7AzkDzauuWH8lN7aK3SdOuVbXo/i67Ho/lrBG4p4h+
         4ZgHUoAW9AHW5nHCfdyv2w9+hahp1k474GzZzrIynNqV+Lc6jWvWG0Vnvz3TZAN7UYtJ
         NFkkQS3Wtj1hQsv7gah8XJGNV9rlu/ARbxCFH3v2VFhYjLGPx9aYTxaQTdv3xKxjxcC0
         n+4GM6hyVSnkTu1t44oxeP4GKweiJa2aE0dtAT8GrFZ/Lo0CvToZ7eydwJ6Zfjl7TugE
         ONByryksApCFIM4rcTCtLJZGcVgB3VqLKI2Ibpv/k72m5ZRo8ZubrJVW1O8uNL511i0n
         2GYA==
X-Gm-Message-State: AO0yUKVsTVApvwiBnsWkOei202WSkHtdb29ZBVg3sRLShyxmJ/TRr3ji
        nma82uWaJZjR7GghmBFtFsKYztlVn2ZhEaqNQJw6vjwJNQuO2j51
X-Google-Smtp-Source: AK7set9FQsaQ4wwwGwa1iJ35QZxS7z/tqpoggFV3jIIY4bRVdaLuYXMbSLMPdYFq5+nMU1dh82/hbSINPKYjn7/TdoE=
X-Received: by 2002:a05:6102:570b:b0:3fc:58d:f90f with SMTP id
 dg11-20020a056102570b00b003fc058df90fmr2241014vsb.60.1677120241810; Wed, 22
 Feb 2023 18:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com>
 <20230221153740.1620529-7-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Ed-5Nq0zNzCGzez3fnW2yxW7zFx9B6k58Y4yb8P+hvpw@mail.gmail.com> <88a3fa09-60cb-bb3c-c392-286efd983627@collabora.com>
In-Reply-To: <88a3fa09-60cb-bb3c-c392-286efd983627@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 23 Feb 2023 10:43:50 +0800
Message-ID: <CAGXv+5H3XMF7ov_WfNFA=HC0frD003MRdVuBOFiBvu8zxE_rwg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] dt-bindings: gpu: mali-bifrost: Add a compatible
 for MediaTek MT8186
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 5:13 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 22/02/23 09:37, Chen-Yu Tsai ha scritto:
> > On Tue, Feb 21, 2023 at 11:37 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Get GPU support on MT8186 by adding its compatible.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >>   Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> >> index be18b161959b..43a841d4e94d 100644
> >> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> >> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> >> @@ -15,6 +15,11 @@ properties:
> >>
> >>     compatible:
> >>       oneOf:
> >> +      - items:
> >> +          - enum:
> >> +              - mediatek,mt8186-mali
> >> +          - const: mediatek,mt8183b-mali
> >> +          - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
> >
> > The MT8186 has Mali-G52 MC2 2EE, while the MT8183 has Mali-G72 MP3.
>
> Keeping in mind the obvious - which is that G52 and G72 are both Bifrost....
>
> > So we actually need a new entry with two power domains.
> >
>
> ...This is my node for MT8186:
>
>                 gpu: gpu@13040000 {
>                         compatible = "mediatek,mt8186-mali",
>                                      "mediatek,mt8183b-mali",
>                                      "arm,mali-bifrost";
>                         reg = <0 0x13040000 0 0x4000>;
>
>                         clocks = <&mfgsys CLK_MFG_BG3D>;
>                         interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH 0>,
>                                      <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>,
>                                      <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
>                         interrupt-names = "job", "mmu", "gpu";
>                         power-domains = <&spm MT8186_POWER_DOMAIN_MFG1>,
>                                         <&spm MT8186_POWER_DOMAIN_MFG2>,
>                                         <&spm MT8186_POWER_DOMAIN_MFG3>;
>                         power-domain-names = "core0", "core1", "core2";
>
>                         /* Please ignore speedbin, that's for another time :-) */
>                         nvmem-cells = <&gpu_volt_bin>;
>                         nvmem-cell-names = "speed-bin";
>                         #cooling-cells = <2>;
>                 };
>
> There are three MFG power domains... MFG2 and MFG3 are parents of MFG1, on that
> I agree, but we can avoid adding a new entry just for MT8186 and use the MT8183-b
> one while still being technically correct.
>
> Besides, Mali G52 and Mali G72 are both Bifrost... so I don't think that this
> commit is incorrect. For the sake of simplicity, I would push on getting this
> one picked.

I'm aware. In case it wasn't obvious, Mali-G52 MC2 2EE has 2 cores, while
Mali-G72 MP3 has 3 cores. I think that is reason enough to do a new entry.
Otherwise you are describing power domains for 3 cores for a GPU that only
has two.

> Unless there are any real-strong opinions against...

Yes.

ChenYu

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B756ADB2B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjCGJ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjCGJ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:56:06 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE62E46172
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:55:53 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id f13so11796446vsg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678182953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RP4oTBHTQfU+cSOnEmCaBzJhcvOEi+tlYyv1N22EK0=;
        b=NHiNggQW7NfCAAvBD5ei7LCdwF00j9A7BOiqv3LttCcsdwo/weQ9LhfU9Nz3t9K0Fi
         e8StI7dy46pVfR2lKDF71AlvtMc8TJEB65CXOk8EKH/8P6OLO2iqz7I0gly94Gqxs964
         0aI9kk4tURcrj9YAdXnCi7av7TMDe/aaony7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RP4oTBHTQfU+cSOnEmCaBzJhcvOEi+tlYyv1N22EK0=;
        b=H3uzZjWqmUZvPxpMdozyfljQt++xvz+Sg1cc6c1M76i4p5QIttaSo71QjioXGJFCLD
         5eI2EmuP+lizBGqE4roSjw3Ul1ZGNOoNCZI7y4KPBh2K4nrLkZ+Nvd/EZ3bDvQ52viMN
         er4vCG4Er++/SF666Ca+FKOcvdpysoVEUbPouyRylD1Yd11QpsahvfY8+FHYL90VpVoZ
         RbIgnEdLn8R633GJvd2gD5LeepRoqcPYKALI5oX2u4rFYeouHtiWuyKr9/Ub7d0EjbEr
         kpwPu9EBTvbIVtBPXcpjtUTzC598Sefc7GbC02CuiumXnZJmiV6PySV/aB2aYIXWJ4ce
         TdrQ==
X-Gm-Message-State: AO0yUKW5b1RXLOiazzl1urDxNFPAlKnQHArATEQoE/OBWIPkaUQ4Aqtf
        atv6+6ID3tBfjjfxgcMfpBbzH/BGkE0SeXrEpQGn/G3s8oaRYK0cd18=
X-Google-Smtp-Source: AK7set8nGUBgc2L2PJPdJBoEOnCnChdp+HTmYAB9+1VzdkOjzou3mYdfP4Z3384VdFLyRn6Da7w1948dOB0dW551ajc=
X-Received: by 2002:a67:f349:0:b0:41f:641c:f775 with SMTP id
 p9-20020a67f349000000b0041f641cf775mr9639372vsm.3.1678182952854; Tue, 07 Mar
 2023 01:55:52 -0800 (PST)
MIME-Version: 1.0
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com> <20230228102704.708150-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228102704.708150-7-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 17:55:41 +0800
Message-ID: <CAGXv+5F_YQLPqJYUoLA=zSeJyPzPxBESt4GyjYE=fEFt-xxfRQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/12] dt-bindings: gpu: mali-bifrost: Add compatible
 for MT8195 SoC
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
> The MediaTek MT8195 SoC has a Mali G57 MC5 (Valhall-JM) and has the
> same number of power domains and requirements as MT8192 in terms of
> bindings.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
  with `make dt_binding_check` and `make dtbs_check`

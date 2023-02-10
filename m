Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892CA691AED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjBJJK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjBJJKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:10:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDCA1C5B2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:10:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id d40so2932638eda.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JO1AgozF/Zya9WC0NgRmz45Iqf3MdEInH4N2K136jyM=;
        b=ZyFniiCCjmt9CvFd63F1Zj3IXNi4mNYXxXKEnzHLxPlFTMzNhXgAL3mcNuX5cYUWEW
         XLgUon3TpGuOxN5yFBKHZWe5rBLfxrjBjRkVxf8O9KheaOLF+XS9EoTuMNMEfPc1n0bG
         MDJvJGNT7D3w1/12SrGKArBX/1Vntjt1I19b1FyqOOW2athWYZaaYf/6UDVjWsYb0lTn
         YGVnI8UiVgl3HmOuryhDtX/pWrRHQJ9cfaT6GEsrsnD029W1HFFHZW9dhw34yvyh0u6u
         qEbrE6+qN40u0WDcfwsWEk26o50aD4BioUHqSaOaj+Aj7nKGSWgBi/xYTszNMgBq0sv1
         aJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JO1AgozF/Zya9WC0NgRmz45Iqf3MdEInH4N2K136jyM=;
        b=SuljnDDci5NG6hORIDwIavp9A2CbWJobOEu/q8HwHmWY7ScF7+ZDxc4jbt3AZcmKs4
         6ZkbGEHd90qi40MZty/fG5zsNBBJ8+HowTRHKLvmBdq+peSlmn5Pk9BJ5Vs9dYwdSQlZ
         3GrXg7GEqHz4b48dePFLedWVjPvpvKxjCC68NvlNks7gRz4iaBrQ0vgXVh4MXWoFbj+q
         HQF4sLX23ludp9HUPWPdEtcnBeoI5Z/yBkvtEEaz826vS5ZI5R382qPABRv0CcCw9X3Z
         pyrpgk6blQsXw84PoveIsowR3lJRvb+nfjnqSMRbNISJCZOP6c1FqL1UXwOZRMnIoyeZ
         DTAg==
X-Gm-Message-State: AO0yUKXFSxS8nGXnYODP2m8Qk6kjN2MK0ayAYV+HVj7YxSfdFi5ajVyi
        P0Jz/qeKPYjXj9amRbbFLNUk+UpYbek7Q3h7FCpzGQ==
X-Google-Smtp-Source: AK7set+IPEknsk8g/iIkwkkIan5htfnLkZaV7RhcstO9zjt8469/p979SjeKGgF3Upg96TNj1/y34dRtZXAYJDOE77o=
X-Received: by 2002:a50:d7c1:0:b0:4ab:2517:ca8 with SMTP id
 m1-20020a50d7c1000000b004ab25170ca8mr791593edj.7.1676020227744; Fri, 10 Feb
 2023 01:10:27 -0800 (PST)
MIME-Version: 1.0
References: <20230209105628.50294-1-bchihi@baylibre.com> <20230209105628.50294-3-bchihi@baylibre.com>
 <167596964747.647630.15058465615417584783.robh@kernel.org>
In-Reply-To: <167596964747.647630.15058465615417584783.robh@kernel.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 10 Feb 2023 10:09:52 +0100
Message-ID: <CAGuA+oqjQPQoJOzXdNxO+831noyGmiLcvzG1sGv6SFkr92XFCg@mail.gmail.com>
Subject: Re: [PATCH v14 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal controllers
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        rdunlap@infradead.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        linux-pm@vger.kernel.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, krzysztof.kozlowski+dt@linaro.org,
        ye.xingchen@zte.com.cn, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Feb 9, 2023 at 8:07 PM Rob Herring <robh@kernel.org> wrote:
>
>
> On Thu, 09 Feb 2023 11:56:24 +0100, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add LVTS thermal controllers dt-binding definition for mt8192 and mt8195.
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >  .../thermal/mediatek,lvts-thermal.yaml        | 142 ++++++++++++++++++
> >  .../thermal/mediatek,lvts-thermal.h           |  19 +++
> >  2 files changed, 161 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> >  create mode 100644 include/dt-bindings/thermal/mediatek,lvts-thermal.h
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you for the review!

>

Best Regards,
Balsam

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA8E68D9AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjBGNuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjBGNue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:50:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307A1125B8;
        Tue,  7 Feb 2023 05:50:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE9D7B81979;
        Tue,  7 Feb 2023 13:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638D1C433D2;
        Tue,  7 Feb 2023 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675777830;
        bh=DMSQcB2gRBiYrCLNnIJNq5P5lvWtVkLpSH0UjyUj4+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X3rJisH4D9N4h5LfmaiMiCPlCAXxUJhpyx9ew/Qn4HmiBs6tdOUxfBIzfz0Il9GJJ
         1VPzI5KWWmjwHjSFgiaRzN+g3npE+qNoFO0ws6s69xFX2zJ2DvsnSUX5W2hgVnmA+f
         q2caFLVBY4pxxrvmAniqU2DWA8NuV8AMfHPjP5oDCnpllUL7nJ82oCpvm4beCQ5tS2
         wswnZswe2QOC6sNtMrUq+EDhlHdOtd1ouUVKCjDSV9Qlqwzmv4805Jt9HVu4XEpjIu
         k3ZANYH4/7Dcvoq20Cp8nnKYgsSJ+Vr+iEalXRugEJNv+2IAy8STA/HR0tno/PAshc
         fxjvzA/xhEn6w==
Received: by mail-vs1-f54.google.com with SMTP id p10so16329676vsu.5;
        Tue, 07 Feb 2023 05:50:30 -0800 (PST)
X-Gm-Message-State: AO0yUKVCBrLB7G6h9+a5YoyABl4l6MX/6tb110n7mZLMjpCQRyPjNgza
        EueimZvFTB0lESZ0P0EPnT9YIkB2+ivHRFt6cQ==
X-Google-Smtp-Source: AK7set9Mqs4Sx0a58l7EyhlbieUTrJF9RKPUKmeczwiTxCkbvS2g0I4TZU3iyOJf9Ok5Nh88ak3V1dtUt64keTdUzkc=
X-Received: by 2002:a67:7206:0:b0:3ea:c8c:48a5 with SMTP id
 n6-20020a677206000000b003ea0c8c48a5mr659074vsc.53.1675777829362; Tue, 07 Feb
 2023 05:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20230206153449.596326-1-jbrunet@baylibre.com> <20230206153449.596326-3-jbrunet@baylibre.com>
 <167571334291.1212116.1869881432057405431.robh@kernel.org> <1j7cwt3jm1.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1j7cwt3jm1.fsf@starbuckisacylon.baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Feb 2023 07:50:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+OMYwJ3_bjhOgGq--SAotqAW7fnzQfEOnHR+_cxSW1RA@mail.gmail.com>
Message-ID: <CAL_Jsq+OMYwJ3_bjhOgGq--SAotqAW7fnzQfEOnHR+_cxSW1RA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] ASoC: dt-bindings: meson: convert axg tdm
 formatters to schema
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 3:33 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Mon 06 Feb 2023 at 13:59, Rob Herring <robh@kernel.org> wrote:
>
> > On Mon, 06 Feb 2023 16:34:44 +0100, Jerome Brunet wrote:
> >> Convert the DT binding documentation for the Amlogic tdm formatters to
> >> schema.
> >>
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >>  .../sound/amlogic,axg-tdm-formatters.txt      | 36 --------
> >>  .../sound/amlogic,axg-tdm-formatters.yaml     | 88 +++++++++++++++++++
> >>  2 files changed, 88 insertions(+), 36 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
> >>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
> >>
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > ./Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml:
> > Unable to find schema file matching $id:
> > http://devicetree.org/schemas/sound/component-common.yaml
>
> This is a false error because the bot does not have the patch applied
> by Mark from v1 here [0]
>
> [0]: https://lore.kernel.org/all/167543616131.928818.17902040818579023398.b4-ty@kernel.org/

State that in this patch and the bot's advanced AI capabilities will
not send the report.

Rob

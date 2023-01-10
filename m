Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD3666428A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbjAJN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbjAJN4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:56:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52B78E9B0;
        Tue, 10 Jan 2023 05:54:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58F40B81673;
        Tue, 10 Jan 2023 13:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9F3C43392;
        Tue, 10 Jan 2023 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673358858;
        bh=8athQYKzItHrIfysk/XYefpT73/HmLvECDAebZyDEbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F4bUWcF5Om3rHbT5VQh1MbkQav/lohmxw/q6U0CPwebeUqgb8TFfZ+ygbWpVb478H
         GoITDNrceooz9LIpciEmsu4LjAiI/Xn+V+SUTl3KyfwmDfQtaO1ubyB1GOW1Wn39tS
         zGMgIad4wHD6LFkKPLT8dHMk1t2dTGDaNz7F0aWsGJhKZqrBgUXKeig6nkL8QII4aP
         QwD5T0TJMJqmiAPrxlsWpHrAkHCU39gNktjyAoWcoGtkhFhGYjYpMYMnXeX5GywtUX
         ZFR/SJGZA82BPCTFki57S+GCE5aHBDe1Ffj2i55wz6MCUfBluNVI6uwlQN1UxvUb+3
         HjN/17j90EY4g==
Received: by mail-vs1-f53.google.com with SMTP id 186so7010895vsz.13;
        Tue, 10 Jan 2023 05:54:18 -0800 (PST)
X-Gm-Message-State: AFqh2kqClu3Xy1KSApFY4Dl0lfgXXFvLUPqqbIOWuQhjLgWAkQmHuHFD
        vzcQaaP1fhDYRF9OV9dpvt+hfulk4cNMYdGG6g==
X-Google-Smtp-Source: AMrXdXvA82g7mwi9IXWmKma4CVZ2hlSkTz0TzYJNaUZEOJlNGxfJo6dNGgiRuG9PLb1REzByty3ZTlUETswh9b5Ge+Q=
X-Received: by 2002:a05:6102:1594:b0:3b1:4b76:5b44 with SMTP id
 g20-20020a056102159400b003b14b765b44mr8655767vsv.53.1673358857070; Tue, 10
 Jan 2023 05:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v3-3-660c3bcb127f@linaro.org> <167327376817.61320.5444570222214850129.robh@kernel.org>
In-Reply-To: <167327376817.61320.5444570222214850129.robh@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 10 Jan 2023 07:54:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLEOREcgDcDvT2CSJuAMro_ayJxVt46+ZBritAOGSTQ6A@mail.gmail.com>
Message-ID: <CAL_JsqLEOREcgDcDvT2CSJuAMro_ayJxVt46+ZBritAOGSTQ6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] dt-bindings: display/msm: document MDSS on SM8550
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 8:30 AM Rob Herring <robh@kernel.org> wrote:
>
>
> On Mon, 09 Jan 2023 11:15:19 +0100, Neil Armstrong wrote:
> > Document the MDSS hardware found on the Qualcomm SM8550 platform.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  .../bindings/display/msm/qcom,sm8550-mdss.yaml     | 331 +++++++++++++++++++++
> >  1 file changed, 331 insertions(+)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dts:21:18: fatal error: dt-bindings/clock/qcom,sm8550-dispcc.h: No such file or directory
>    21 |         #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1508: dt_binding_check] Error 2

Now failing in linux-next... Why was this applied before the dependency?

Rob

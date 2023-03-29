Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC0F6CF3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjC2TxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjC2Tw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:52:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB4446A0;
        Wed, 29 Mar 2023 12:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54D13B82371;
        Wed, 29 Mar 2023 19:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE76C433A8;
        Wed, 29 Mar 2023 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680119546;
        bh=mjLUdufgtgjPzwdtcadGyC411S2foJg6r/cD6VhlXN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d7Q26T37B1IZA2JdcWXPbfJEAmg3km2dTpj1PmXkLIwjEikOJZ1c0VF/7LpOvkoAb
         Ue/YeK2zH/lKZO3SHMLqBdCnPUhINYp9Wf8hasNAS+gjQh2gmJTia8+v9l+oGUI5GM
         EaIbH0eZY42BaWZSJ6YKGYAusLrFQtGE7LYTJRLu+Yvp1OWm84X8rdpvcBIwl1Bb2M
         k1L8lhvm7l8Kt0lwZosWOhGQqUk2mAyPmb6RSaXu7eClit7TIwUDZsEGuyl3PFwchy
         xQuBlNgnybuPrDJNJ3AgRhCARO8BvTCwDNdBavaS5mfduSShOZsWjo1kLJBUk0DGrx
         WBx6XqMb/cvjA==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5416698e889so314038057b3.2;
        Wed, 29 Mar 2023 12:52:25 -0700 (PDT)
X-Gm-Message-State: AAQBX9fnBwnegiIHntq3yqrtw/eHJUqu1RTz+gPTi4SAXUDeliW6LLX6
        366gblWrUnZ9vUoqfwP+CecXcOqpioS5rE1M0w==
X-Google-Smtp-Source: AKy350YmTOlpc30ipg9mtdb/RKboI8SpnHxYbSbWPKuwuA23l/hU01zX5J4huXLPc4DktXCK19e9vRvERkA2b90bHlw=
X-Received: by 2002:a81:b50f:0:b0:544:b8d8:339e with SMTP id
 t15-20020a81b50f000000b00544b8d8339emr10288144ywh.5.1680119544920; Wed, 29
 Mar 2023 12:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org>
 <168004255469.1060915.1800625604847213121.b4-ty@linaro.org>
In-Reply-To: <168004255469.1060915.1800625604847213121.b4-ty@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 29 Mar 2023 14:52:13 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+VoBkpCT_iUD1Nq_SazCVDa49rn0qtX3Qnm1KBB3gkcg@mail.gmail.com>
Message-ID: <CAL_Jsq+VoBkpCT_iUD1Nq_SazCVDa49rn0qtX3Qnm1KBB3gkcg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] drm/msm: add support for SM8550
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 5:38=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
>
> On Mon, 09 Jan 2023 11:15:17 +0100, Neil Armstrong wrote:
> > This adds support for the MDSS/DPU/DSI on the Qualcomm SM8550 platform.
> >
> > This patchset is based on the SM8450 display support serie at [1].
> >
> > In order to work, the following patchsets are required:
> > - PM8550 LDO fix at [2]
> > - DISPCC driver at [3]
> >
> > [...]
>
> Applied, thanks!
>
> [2/7] dt-bindings: display/msm: document DPU on SM8550
>       https://gitlab.freedesktop.org/lumag/msm/-/commit/4557e40338d2
> [3/7] dt-bindings: display/msm: document MDSS on SM8550
>       https://gitlab.freedesktop.org/lumag/msm/-/commit/0e4205eb8663

And now failing on linux-next just as my bot reported:

Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.example.dts:2=
4:18:
fatal error: dt-bindings/interconnect/qcom,sm8550.h: No such file or
directory
   24 |         #include <dt-bindings/interconnect/qcom,sm8550.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:419:
Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.example.dtb]
Error 1
Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dts:=
25:18:
fatal error: dt-bindings/interconnect/qcom,sm8550.h: No such file or
directory
   25 |         #include <dt-bindings/interconnect/qcom,sm8550.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.

Please fix. And quickly please. Fixes in the DRM tree seem to take
forever to get in...

Rob

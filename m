Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11376665E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbjAKO5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbjAKO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:57:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E39EE04;
        Wed, 11 Jan 2023 06:57:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C136761CFB;
        Wed, 11 Jan 2023 14:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E045C43396;
        Wed, 11 Jan 2023 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673449031;
        bh=mYNw1iEQYVCp6RrmRe30DB6Teu7zpACGkO9NWFvDUyo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QaloOrONmjzv1NxnkIb/LFrLyvGzezX8IP6p+BTQwpjrgl1QKH4PNtYIph6Jnv0xy
         UqOi2i1ffFiBdoNLDsJU/yJRjn4S75GCJFPM+APpHSv8iwblX7qs0DwIJmVqMOQ9nd
         paa4QZw7H6L/ukm8SfqrMVRzDyuyvYwIGV5Agq7ONdhtiai7GwcH4fQa5PeL70rkYs
         BbPdVEUoOUGJvCXQ9g+u/QUYjT+E2l+aYeGrKLT3sU1Ya/8URcBmlRWw5u4YXSUjrF
         T4EfIVGYmI/YRxH3Asw5p1CtqiaEHckGigxorO6ARYWSTJlxmsu8+7ojwyblGxbtPD
         b0X+2109HR02Q==
Received: by mail-vs1-f48.google.com with SMTP id v127so11565399vsb.12;
        Wed, 11 Jan 2023 06:57:11 -0800 (PST)
X-Gm-Message-State: AFqh2kotW6GkwpSdr5NckfFqdfgG4Xvz2GjPkHQdb7IGNKf3p5c+tNl3
        Kv++CunV2XRnvQ8BKhjVPO4dRxLAi4PWOutLJA==
X-Google-Smtp-Source: AMrXdXsFn/ZNP2w63VaXh+QFHScOBYUxYSxX/aRHG1VxYtf9ib6mpqOY1EwCEur2HVupJ0D2QHWb7s3fHG7o5hrVc/k=
X-Received: by 2002:a05:6102:3546:b0:3c8:a6ed:faa8 with SMTP id
 e6-20020a056102354600b003c8a6edfaa8mr9164668vss.85.1673449030052; Wed, 11 Jan
 2023 06:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20221130135807.45028-1-konrad.dybcio@linaro.org>
In-Reply-To: <20221130135807.45028-1-konrad.dybcio@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 11 Jan 2023 08:56:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL4Wymiov3bgXBo+1RJeMMjJ_+iCCo7oboSmU8P+0ew4A@mail.gmail.com>
Message-ID: <CAL_JsqL4Wymiov3bgXBo+1RJeMMjJ_+iCCo7oboSmU8P+0ew4A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: msm/dsi: Don't require vcca-supply on 14nm PHY
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, patches@linaro.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 7:58 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On some SoCs (hello SM6115) vcca-supply is not wired to any smd-rpm
> or rpmh regulator, but instead powered by the VDD_MX line, which is
> voted for in the DSI ctrl node.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml | 1 -
>  1 file changed, 1 deletion(-)

What's the status of this patch? It is in linux-next already for some
time, but it needs to go into v6.2.

Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE32661BBA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 02:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjAIBGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 20:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjAIBGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 20:06:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE1F2B;
        Sun,  8 Jan 2023 17:06:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C84760E1F;
        Mon,  9 Jan 2023 01:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC8FC433D2;
        Mon,  9 Jan 2023 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673226392;
        bh=tlRZazSe1O2B8FEEg+HiuRZDrhfj2FBiyRjllnV96V0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VqWvfUJcpwRx+/3m8sVHTUGTC4vqXK1IrJ0sO2vZywZmUZigSNmSsL4PHgrjmvr6a
         ULcWC+gtcGxjmtZK2OYxbDHOieGEP8DTp1sJj5V7UlF1oZFTBAvLmsP+sAv5Pa+1bs
         wdG7Z3jBSglf7B4/1nnzLn0/WmqeRriOlBr+U6C7TGq2urhkjk0L+Q94FKLFZJEgcO
         AcWq50PkPuBDiK3Rjw5WWHXsii9yXN2I7u7h2+OYuQFZY/GxOI4jgdEDmv+AMCCUsj
         tfDSb8rAp31f4mnab1NK0tM7bcD2eg5H8cXFK1UpUayuZJR7kBh8oy+fOjrRxvPM//
         n+2/oG82kLLcw==
Received: by mail-vs1-f49.google.com with SMTP id v127so2732154vsb.12;
        Sun, 08 Jan 2023 17:06:32 -0800 (PST)
X-Gm-Message-State: AFqh2kq3wNUvzTYgTnlknUn5Lg5Psrkxaz8GeaUvEQsMDuEbLcxePJYa
        p7eZhzpR+hzVoEs8rzGXGHxJyxqonW3tcqLJPg==
X-Google-Smtp-Source: AMrXdXs9yLe8vmAfRKeC+qDk0q2CFms7XnXgDkSOXmN5uQqar3n7fHqlTLnhmdmCYS0BrbZQIQMODt3gjGX0jgH5xjg=
X-Received: by 2002:a67:fbd4:0:b0:3c9:2ac0:5b0b with SMTP id
 o20-20020a67fbd4000000b003c92ac05b0bmr6827189vsr.26.1673226391623; Sun, 08
 Jan 2023 17:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20221005-mdm9615-pinctrl-yaml-v5-0-910019fb8b9b@linaro.org> <20221005-mdm9615-pinctrl-yaml-v5-1-910019fb8b9b@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v5-1-910019fb8b9b@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 8 Jan 2023 19:06:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLrDGW118vEV9dnpTkeJmE+S79u0WXajuTOVi31WmF87Q@mail.gmail.com>
Message-ID: <CAL_JsqLrDGW118vEV9dnpTkeJmE+S79u0WXajuTOVi31WmF87Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: regulators: convert non-smd RPM
 Regulators bindings to dt-schema
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:05 AM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Convert the non-SMD Regulators bindings to dt-schema, the old text based
> bindings will be deleted later since the RPM bindings are not yet converted.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/regulator/qcom,rpm-regulator.yaml     | 128 +++++++++++++++++++++
>  1 file changed, 128 insertions(+)

Looks like patch 2 was applied, but this one still needs to be respun
and applied as linux-next has warnings now.

Rob

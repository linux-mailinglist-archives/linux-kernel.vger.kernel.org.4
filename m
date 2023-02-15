Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D91C697E07
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBOOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBOOJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:09:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24486B45C;
        Wed, 15 Feb 2023 06:09:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0CA4B82239;
        Wed, 15 Feb 2023 14:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849CEC433EF;
        Wed, 15 Feb 2023 14:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676470180;
        bh=MYhOAEbjlmEV72d4Y+wbUnJSCyy31d4OR9meqpFLgMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OyTRxe7V4vdQUFAlReUDb2pTJwiqN1iOeTpFEjTo2yVKKgpefOtoM9e4BsgjHYzDg
         d4fIIFTzmxWo5/nb32KTzS2eeJaNKLrlGG6gll66+V7qYxBPzj6us4+rgUnnAaOaW1
         G2K+tGSz5zIRIR60TupiIqGUQSI3oTB4DG3ETv5D1bI7o6PG/+dPouzACJaYn5RPHu
         NlDVkZMiIQ7+Tvyusc5BbRf9x82tr0gJ50AOP+a+n+3do4o5PDIG5FAwqoqHWMOWaP
         nqU4OihiVDbKSqPUsUxB8VY/BKfpg8FaqaAwODE/Ivof8U9FYbp7+bd2V0paR22Wzb
         1Am+A1snUaPkw==
Received: by mail-ua1-f49.google.com with SMTP id s21so1534355uac.13;
        Wed, 15 Feb 2023 06:09:40 -0800 (PST)
X-Gm-Message-State: AO0yUKWIzndtSOJ80qZA39SG0xxt0mGI+WwCXnJ8RwoBBPLxf+BUvn2B
        Cnbu7BfOcZKOaaPUON3O5nW4i67W1eIDerc+bA==
X-Google-Smtp-Source: AK7set8eUNQpS7lJ5nErj1IiR33ZGzYaWTVPtCM5cZxTLKp8Gtd1AHcNI6ym2Cxr2WOkM6UTp27i5UTovF6FcXK2BKw=
X-Received: by 2002:ab0:2818:0:b0:68a:5d77:362a with SMTP id
 w24-20020ab02818000000b0068a5d77362amr266020uap.61.1676470179519; Wed, 15 Feb
 2023 06:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org> <20230208101545.45711-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208101545.45711-4-krzysztof.kozlowski@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 Feb 2023 08:09:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLdrpwJ4VhH4MK+RDjZZtWWosXOC48yW+STwtJR6QCAjg@mail.gmail.com>
Message-ID: <CAL_JsqLdrpwJ4VhH4MK+RDjZZtWWosXOC48yW+STwtJR6QCAjg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dt-bindings: mailbox: qcom,apcs-kpss-global: drop
 mbox-names from example
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 4:16 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Qualcomm G-Link RPM edge bindings do not allow and do not use mbox-names
> property.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes since v1:
> 1. None.
> 2. Previously was sent as separate patch.
>
> There are no strict dependencies. This can go anytime. The next patch
> (glink-rpm-edge) should be applied in the same or later cycle (could be
> via different trees).

Except that without this patch there is now a warning in linux-next.

Rob

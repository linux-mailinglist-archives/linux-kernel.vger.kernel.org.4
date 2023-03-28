Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1236CC8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjC1RAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjC1Q75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DCC9ECF;
        Tue, 28 Mar 2023 09:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A129D618C7;
        Tue, 28 Mar 2023 16:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE429C433EF;
        Tue, 28 Mar 2023 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680022796;
        bh=5JSnUi0WPwXlNlLr2PLygtWZxa1SAMU3aE2taoy2XJ8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pG0CxzYc2iEAdKBPDBguoug0WhMNqYnXGWZ0vBpoy+o6qPYkfq/te1U0HzBubmaQY
         Qc8D+RBVRs1+W1SNXJeXhNKBBI9XldesJIStEjChrgsxA4gbMXGDDthNbKmnJm75t/
         rbiuw9xpcFMA4l9jMzA9x3O4cQgTvHfYJBzKd5tHBS2YxTcl56WOqzpvinvMcLQ6QR
         ZZZNr2QWvUVX9A5g2OoAj4eUUfQqtuziuEXpF+e38ZnF2Wj0hWFv1NPx+LQ0f+d+u7
         6i1mCDUrzUQp9f8kbWzJZ1qdkaw6r3WKLHPJQlx2L24KbYY/2fUPQel4IbrAAIC++G
         gXkxDvMHR41aw==
Message-ID: <1cfd584a48e1bb453596948a0187ecf1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2484518b-bcf6-7fb1-6bfb-b96b3682397b@quicinc.com>
References: <20230327132718.573-1-quic_devipriy@quicinc.com> <20230327132718.573-3-quic_devipriy@quicinc.com> <0af15083921c5d3c89392209654f0c9b.sboyd@kernel.org> <2484518b-bcf6-7fb1-6bfb-b96b3682397b@quicinc.com>
Subject: Re: [PATCH V10 2/4] clk: qcom: Add Global Clock Controller driver for IPQ9574
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, arnd@arndb.de, broonie@kernel.org,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel.ziswiler@toradex.com, mturquette@baylibre.com,
        nfraprado@collabora.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, shawnguo@kernel.org, will@kernel.org
Date:   Tue, 28 Mar 2023 09:59:53 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Devi Priya (2023-03-27 23:15:35)
>=20
>=20
> On 3/27/2023 10:18 PM, Stephen Boyd wrote:
> > Quoting Devi Priya (2023-03-27 06:27:16)
> >> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq=
9574.c
> >> new file mode 100644
> >> index 000000000000..b2a2d618a5ec
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> >> @@ -0,0 +1,4248 @@
> >> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +/*
> >> + * Copyright (c) 2023 The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/err.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_device.h>
> >=20
> > What is this include for?
> This include actually don't seem necessary. But, I see that of.h &=20
> platform_device.h are being included via of_device.h
> Would you suggest to drop of_device.h or the other two
> headers instead?

Include headers for things you use. Don't try to omit includes if you
see that a header includes other headers that you're using.

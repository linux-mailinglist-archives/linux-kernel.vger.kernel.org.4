Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1949F67BC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbjAYUdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjAYUdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:33:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621BC3A5BC;
        Wed, 25 Jan 2023 12:33:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F077E614E9;
        Wed, 25 Jan 2023 20:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CA7C433EF;
        Wed, 25 Jan 2023 20:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674678819;
        bh=wsjRGZiJ95mfZhrNrrhImuvGdTKepleHqa6vGZ53w40=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=INyhl5IQs1Ls9C81AVf4YP6CSKgtMGCQc+LWD+xTeq10lioc4DoLmomsK6LVryBhN
         FVKjqa1JCL8xhpuTqO3XlSkWKSOwvtEQUz696CNUudMieBnaqN8Z6haNo9dTwJcSZM
         qKnWBSgowJReNvleQsgNjOrvzkjVDbxLn93q2SIg8vkZzkg93P7CWV7Op8W/YizzUi
         Xjy/UhbJSRSRtNFiUDTJEHBFa5LHDFIwcQnf3Ul00fH2Jl08UTkuuaDRe96szRJ8eT
         D+QLd9/eLQr80Kun6Pmd4ZYV+2TzUAZGCofPce/eKqaWfsFRP2QTeCNleSS434E+xd
         CGBcv3u6uq0qw==
Message-ID: <cfe72e2e9419e64c364174e799595bae.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230123201812.1230039-2-krzysztof.kozlowski@linaro.org>
References: <20230123201812.1230039-1-krzysztof.kozlowski@linaro.org> <20230123201812.1230039-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/3] clk: qcom: gcc-qcs404: fix duplicated num_parents
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 25 Jan 2023 12:33:37 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-01-23 12:18:11)
> num_parents field is being initialized twice:
>=20
>   gcc-qcs404.c:63:32: error: initialized field overwritten [-Werror=3Dove=
rride-init]
>=20
> Fixes: 2ce81afa0c7c ("clk: qcom: gcc-qcs404: sort out the cxo clock")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

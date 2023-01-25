Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6959A67BC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbjAYUeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjAYUeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:34:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430473EC5B;
        Wed, 25 Jan 2023 12:34:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A0F61610;
        Wed, 25 Jan 2023 20:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2675DC433D2;
        Wed, 25 Jan 2023 20:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674678851;
        bh=t+u9kmMnbhr6gB+WyS18CXjHnlswxBh6X6wqYmk4V9c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B8tORDkXn8kDsnn+WYOPOPJZ3TXxB+RZcsJtfsaoVnCYsl159hR+Uhy5KyO51U/4C
         sHvdSUKt92hUapMxtVruh3ShWkGi0tKlTbq/5Rz5jaqlTudWFLVmVUmqRT1YnQW3u5
         bKLJ4HFxMCocQPdc+NpwtLDh+5LkLNoLwZCDZFBIa6TET2LArcFKNI0KImJlK5fdus
         gucUS5tlpDJU8F1Do0jkt66pVEMbO4DPauEmPkzq5QCqbMjUnv74poxcfsjlus9u4r
         FF4tWy0+wrvDK83iAj7KkF8Mfqu9ctJUvz5mIKGkCOFrxO/bAVDQ1VRa9uaeJ0zZ0v
         xjSlFtMEL5V5A==
Message-ID: <15a833aab49fbb2367d2299dab1c539c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230123201812.1230039-3-krzysztof.kozlowski@linaro.org>
References: <20230123201812.1230039-1-krzysztof.kozlowski@linaro.org> <20230123201812.1230039-3-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 3/3] clk: qcom: rpmh: fix double RPMH_IPA_CLK assignment
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
Date:   Wed, 25 Jan 2023 12:34:09 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-01-23 12:18:12)
> RPMH_IPA_CLK is assigned twice:
>=20
>   drivers/clk/qcom/clk-rpmh.c:578:35: error: initialized field overwritte=
n [-Werror=3Doverride-init]
>=20
> Fixes: aa055bf158cd ("clk: qcom: rpmh: define IPA clocks where required")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

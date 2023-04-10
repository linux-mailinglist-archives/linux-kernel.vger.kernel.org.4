Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF06DCBFC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDJUCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDJUCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:02:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFF61FC4;
        Mon, 10 Apr 2023 13:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09FB061F0D;
        Mon, 10 Apr 2023 20:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDEAC433EF;
        Mon, 10 Apr 2023 20:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681156918;
        bh=zS9bDGyb5KIyUvMyO4cCULhWJVvcjPYxsjkGaR6IpEA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aYYG3s/jYQ4jWxNHds6LtrGf9w8J5k4Vvqa12JyzNH40pMUSkoaD7G6vefRxEYh4i
         7bXHtbod1W1TP+7Oxmg0von2A6CG43wfOLJvyvMenv2nqXIfby8jvwzHCsF+AnV916
         mfnxPdX5F6wgMuUhvT41V3aphNJJAw5AD7pX0Hw/eFHIYbmzw1Z3fFiWisyobkxT59
         UYY9uFsJo//wBAIQAxE/eC3vEXA+mI/CdjjPjXQjI5hgBMyMUr2zJrcS0FOC1LJCX8
         puAjBrqUsbTZVyHPB8IBW4SFKyoypkoPuUXx2XwpcJk+aB87gQs9mFfQpCj+AhseKM
         BOJTvcw2zdPDA==
Message-ID: <d39d2f42e04cf97046d23f0823558e73.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230406200723.552644-2-brgl@bgdev.pl>
References: <20230406200723.552644-1-brgl@bgdev.pl> <20230406200723.552644-2-brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/7] dt-bindings: clock: qcom: describe the GPUCC clock for SA8775P
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Date:   Mon, 10 Apr 2023 13:01:56 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bartosz Golaszewski (2023-04-06 13:07:17)
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Add the compatible for the Qualcomm Graphics Clock control module present
> on sa8775p platforms. It matches the generic QCom GPUCC description. Add
> device-specific DT bindings defines as well.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

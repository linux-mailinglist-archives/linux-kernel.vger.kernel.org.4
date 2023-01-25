Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A454767C099
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjAYXHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAYXHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:07:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9FE2D165;
        Wed, 25 Jan 2023 15:07:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7C21CE2242;
        Wed, 25 Jan 2023 23:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01B9C433EF;
        Wed, 25 Jan 2023 23:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674688018;
        bh=PjeCAAQzy2hv4PRzPfGGMrvM85OsyVQXdAVmcvzztoU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aHUY7Ee6sr8EiJIQdf5ySMwjqzjdWFXGb2xlZB2AzXnNvYz6gUNObiNVc3+X6qQYf
         yJ+E2QqheccH2Qo+YjeDJdE43+G3c5b8TdCwNMFEaU2k8Vv9/VIU1iIE+LlFZZNxZP
         02DwWUuRyUBBoXB3Sley0c7h1VRlFgwtR0nU+uZT3WW6UFMsfnO6nrqmTzd/I/RGHy
         U0YjWV7X5S3qsMlw3Ex1QpBB5vpUETrOtzmyfEJoIHSAPL0xuGpdIs1bCthhGvgFL8
         uUl29FIOdqEWTZT9hORc1qlwcvnq7TfuPaQXpnAWJgBoyCqZqT9AOU2psbeXKUypox
         veIyfhlRFKDsA==
Message-ID: <d3e56398d41df3a376bb9b182105acda.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230123103338.230320-1-brgl@bgdev.pl>
References: <20230123103338.230320-1-brgl@bgdev.pl>
Subject: Re: [PATCH] clk: qcom: gcc-sa8775p: remove unused variables
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        kernel test robot <lkp@intel.com>
To:     Alex Elder <elder@kernel.org>, Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Date:   Wed, 25 Jan 2023 15:06:56 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bartosz Golaszewski (2023-01-23 02:33:38)
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> There are four struct definitions in the driver that aren't used so
> remove them.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: ed432b1ed00a ("clk: qcom: add the GCC driver for sa8775p")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

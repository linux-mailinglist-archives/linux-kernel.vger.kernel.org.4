Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032CB6104C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbiJ0VwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbiJ0Vv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:51:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5895F7E8;
        Thu, 27 Oct 2022 14:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1F2CCCE28B8;
        Thu, 27 Oct 2022 21:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BD1C433C1;
        Thu, 27 Oct 2022 21:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666907513;
        bh=RZ6n1Wp1PFsVBBCVQ2iVN1FUb/bU4XwPpbmTXT863Tg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ewRxx0zdavdB66BZ0fWaMPTW3B1JFxeqVPvtGokff08K5irMIPkJcgWtIVeGxD0B3
         GiMKIQgYm3xVcQlE8A+WIFFC1ZNrVs7+j4PifSJ5EK6xVvsGVIrV6ccYK4gAoSOJ92
         G2loe1Bf56KTcp5m1LJmvSnHbZQ/i2SSbbzOxUh8YXgxFmPPtMZaaDCS7EQyPMqKtu
         BeD/C9KeMf6nSSdjRRVM3MNShIxsM8CMgpk18caNbFF0crPwYSNhMK7bTZ2cy1+5ax
         JYp+ZYY20gQNCMlRzS672zURk+kws7qzBIbTbqxfko55F1u5SL6RLHLtRE8Vg33Z2d
         SQ/wbahJTWCHA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221027192024.484320-3-lis8215@gmail.com>
References: <20221027192024.484320-1-lis8215@gmail.com> <20221027192024.484320-3-lis8215@gmail.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: clock: Add Ingenic JZ4755 CGU header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
To:     Siarhei Volkau <lis8215@gmail.com>
Date:   Thu, 27 Oct 2022 14:51:50 -0700
User-Agent: alot/0.10
Message-Id: <20221027215152.D4BD1C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Siarhei Volkau (2022-10-27 12:20:22)
> This will be used from the devicetree bindings to specify the clocks
> that should be obtained from the jz4755-cgu driver.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---

Applied to clk-next

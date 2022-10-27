Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC92D6100FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbiJ0TAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiJ0S7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:59:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF34A13E21;
        Thu, 27 Oct 2022 11:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BD0962446;
        Thu, 27 Oct 2022 18:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56CAC433C1;
        Thu, 27 Oct 2022 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666897186;
        bh=5LelGyYEVPEQ0kKK6CKg5/j0BgoV1R+GlAik/GSF7Tg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FsZB24K70bjK4hpYiEyZRMcpNYQIYpAXfGWnBLC2ZkA5WW+3xTAZVTY3FcUyGxGW9
         lajdFrE+zoJoDy9tt8z3BvKyecRY4yGFiu+WakImJ4m10Wn6geBLHIuY7Bd30Eu4nj
         7Rs0JrFFzDzM4PUE9Yicm3nymrZIaPUHWh0BDKNQVou41ezwXFX7c0BbYb+7rwMcoV
         Ci6kOocNr6BCpkiJGxfABhEmPy/YQZ4Po2x+M+VSF3OJJ5ZPWnchQfNDH1kHqaMG14
         GjWicVwhndmviqQdcPu3dLaCqfpqzag77LtTUnh9IpnILDrcquSZE7i3zQl5Cn5/SJ
         kpEwmMbQC8DwQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221026194345.243007-5-aidanmacdonald.0x0@gmail.com>
References: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com> <20221026194345.243007-5-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: ingenic,x1000-cgu: Add audio clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        paul@crapouillou.net, robh+dt@kernel.org
Date:   Thu, 27 Oct 2022 11:59:43 -0700
User-Agent: alot/0.10
Message-Id: <20221027185945.E56CAC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aidan MacDonald (2022-10-26 12:43:43)
> Add bindings for audio-related clocks on the Ingenic X1000 SoC.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Applied to clk-next

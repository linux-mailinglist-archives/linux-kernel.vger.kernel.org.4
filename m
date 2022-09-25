Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2945E91C1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 11:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIYJCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiIYJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 05:02:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9B231232;
        Sun, 25 Sep 2022 02:02:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCD5E60B8D;
        Sun, 25 Sep 2022 09:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEF8C433D7;
        Sun, 25 Sep 2022 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664096536;
        bh=y2MniWHq42iu8husXkRTmBXF+BGsF3nBO+KzKLhcwFg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=kn/wbpwaKEA2ElZvYTqbqEQJjOfYG6DNozN27fjsPy1SapvgidtwggIl7aJK1De3t
         Xqtl8+wqZH5cbnWy2QRRuXCdKiHforEqiRybJ86FhiD97t3ifRYvPfm8ace0iO84nZ
         D0LDDTyNWdosoGVEwR2WQXu9EJwmSeYAqWqyaFkp/T6g2XjHahWln6unu7Zlc58Fnw
         BRWTOgMIuqXDzxygueF/HDBw8lygG9hfAHj0/2nKmXBP9cCJR/o1Zvq/+teybTXDu8
         IdeRYu5JPJgnCKwo/XXWfYauKBvfRbSheXv9H3/RimewO72xaNAW1WyunA5+PAn875
         eRik4k0yZj+iA==
Date:   Sun, 25 Sep 2022 10:02:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
CC:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_dt-bindings=3A_mfd=3A_dlg=2Cda?= =?US-ASCII?Q?9063=3A_add_missing_regulator_patterns?=
User-Agent: K-9 Mail for Android
In-Reply-To: <e20375a8-4496-315e-67f8-feb8ddfd6d3e@linaro.org>
References: <20220916190009.2292223-1-conor@kernel.org> <e20375a8-4496-315e-67f8-feb8ddfd6d3e@linaro.org>
Message-ID: <7605FF4F-896B-42A0-8A8F-4540365F9394@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17 September 2022 17:44:06 IST, Krzysztof Kozlowski <krzysztof=2Ekozlow=
ski@linaro=2Eorg> wrote:
>On 16/09/2022 20:00, Conor Dooley wrote:
>> From: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>>=20
>> Commit 5621d3977e29 ("dt-bindings: mfd: Add missing (unevaluated|
>> additional)Properties on child nodes") exposed a flaw in the original
>> binding, where "merged" versions of some regulators were missing,
>> leading to warnings on the HiFive Unmatched Devicetree=2E
>>=20
>> Add the missing patterns (and merge some of the trivial ones)=2E
>>=20
>> Signed-off-by: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>> ---
>> I opted not to include a fixes tag for the conversion since it just
>> converted what was already there=2E I figured the original text binding
>> is just incomplete rather than "broken", but if you don't agree the
>> fixes tag would be:
>> Fixes: c7f15d43a5c5 ("mfd: devicetree: Add bindings for DA9063")
>>=20
>>  Documentation/devicetree/bindings/mfd/dlg,da9063=2Eyaml | 2 +-
>
>
>Acked-by: Krzysztof Kozlowski <krzysztof=2Ekozlowski@linaro=2Eorg>
>

Hey Lee,
Is it too late to pick this up for 6=2E1?
It's the last remaining dt warning in for riscv=2E
Thanks,
Conor

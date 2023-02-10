Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906D5692B8E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBJXnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjBJXnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:43:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DD24481;
        Fri, 10 Feb 2023 15:42:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56413B8262A;
        Fri, 10 Feb 2023 23:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E64FC433D2;
        Fri, 10 Feb 2023 23:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676072566;
        bh=KuFZz273t8eFdNzJCXor8Ci1dkQEjshWhlEAOiITbYU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LgeXh7/NY4tcx6vNj/e4IkqHfx+EwknUghMOeG30GRk983bAJrBpBD+7EtKw1ST17
         6t2AcOdXfx3UVB2gINFY8Ufozn2u4s5SUbbTqomZmqhhD3f+Cf3KsXj2ECSAZquV+J
         afl/igjYUW9sQEV3shDJd3oc4weC4nrQ4RM/knj1Y6KrG/67McFaNCi+IpjaCN68h/
         f08UWY1tgpyTfmNI0fbIgM1oe2txVDp+eJ6sLiKvvtFYhN6rtcqNuut9nxnGe4WepB
         uQtvbqJ4NYQxh64RYlCj6+MHSreHi7t6guTAJ0rNghIuwlCtVrz2SBfsOfYo4k7tKR
         erBpEAT0jMVxA==
Message-ID: <da9c2d34a0dd4209f4c89d0699aa1d0a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221129034157.15036-1-zhuyinbo@loongson.cn>
References: <20221129034157.15036-1-zhuyinbo@loongson.cn>
Subject: Re: [PATCH v10 1/4] dt-bindings: clock: add loongson-2 clock include file
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev
Date:   Fri, 10 Feb 2023 15:42:43 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yinbo Zhu (2022-11-28 19:41:54)
> This file defines all Loongson-2 SoC clock indexes, it should be
> included in the device tree in which there's device using the
> clocks.
>=20
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next

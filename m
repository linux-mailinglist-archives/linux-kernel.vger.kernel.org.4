Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92161692B4C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjBJXej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjBJXe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:34:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A31880E6;
        Fri, 10 Feb 2023 15:34:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBB74B8261B;
        Fri, 10 Feb 2023 23:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCE9C433D2;
        Fri, 10 Feb 2023 23:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676072039;
        bh=iAF9W38J7qGv/XEwwo3TiiIU8PezgQlEmj3/XKmrSQ8=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=Jn6Iq4aFz6eNIuuI7xIfmLfDhBmXy1ZOkQuVayhTHUMm6np+AlRirqORoIFtypmMu
         7pOW/+G3W6C3JZOCVztUK6lYFKZmqGexApDnuBR3/iq+gKKCWdpr0/ThnHQTnmI8On
         PRN7qFSav1FxeGeQ4zbbV0LdoR4Gric/r1okGkChrTcYSTOpE3gE0POB1oZuB6m5Ll
         em4b34NkGszK8lKLckAdAi4LGRv5cqqDRPJ1CV6komN+migumCiAkOeYAnAp/8313c
         /h91rclNHHmpkbMTfmv55DaUbMJ4nGoy818tjywa9dz2U86b4bOX3QqXRkZEkwosxM
         s5UFp5E9IkW2g==
Message-ID: <44842ac43c23c9cebfdb3b94ff3760d8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221129034157.15036-3-zhuyinbo@loongson.cn>
References: <20221129034157.15036-1-zhuyinbo@loongson.cn> <20221129034157.15036-3-zhuyinbo@loongson.cn>
Subject: Re: [PATCH v10 3/4] LoongArch: time: add of_clk_init in time_init
From:   Stephen Boyd <sboyd@kernel.org>
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
Date:   Fri, 10 Feb 2023 15:33:57 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yinbo Zhu (2022-11-28 19:41:56)
> The Loongson-2 clock controller driver used CLK_OF_DECLARE to
> register clock subsystem that ask of_clk_init was called in
> time_init and this patch was to addd such support.
>=20
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

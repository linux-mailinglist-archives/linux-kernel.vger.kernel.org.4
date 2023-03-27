Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6186CAE76
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjC0TWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjC0TWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4596FE9;
        Mon, 27 Mar 2023 12:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5189614A6;
        Mon, 27 Mar 2023 19:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3770FC433D2;
        Mon, 27 Mar 2023 19:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679944960;
        bh=yjMqxNQU7lUX4uC4Mct8A5dMe4z3ieteuQwS+cdRzig=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QWrREjCbOoW2ZSnTjrPP2I5fhtqXP7KkXUCjsZ0kJe6j71P4ox2lAm2uKLtzb8vTQ
         nFjMVKh3B3Qc9N2cXbp67T6OHTSbEAFgwtoUMARR02d+Lh2FrOhK18VAhAekjbl0gV
         OT9I1IIAwDRXzUknj3OUtIN4Zj5/gN5LtDcJk6xA8vuu0zN1qHvxrCd8mLsBM1954i
         wgjVhzzjdwBB9zYz5bsz+56Bn16llbtWhWREABWUXbX4IPfuDUG8MA56HlSqHez+ZS
         YXKQdOC/gFK8liW7LDPBbYPOquDVjVe5HHAktSjAus3McW/EdmJrNi1AOs/6Db9nLt
         dP71SjwgfG/BQ==
Message-ID: <749fc5bfd507b2316fc95c77eff41e03.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230323025229.2971-1-zhuyinbo@loongson.cn>
References: <20230323025229.2971-1-zhuyinbo@loongson.cn>
Subject: Re: [PATCH v16 1/2] dt-bindings: clock: add loongson-2 boot clock index
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Mar 2023 12:22:37 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yinbo Zhu (2023-03-22 19:52:28)
> The Loongson-2 boot clock was used to spi and lio peripheral and
> this patch was to add boot clock index number.
>=20
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next

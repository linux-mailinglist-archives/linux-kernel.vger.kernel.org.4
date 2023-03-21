Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747536C3E91
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCUXfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCUXfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0707B4A1C9;
        Tue, 21 Mar 2023 16:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A21F461A43;
        Tue, 21 Mar 2023 23:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08280C433EF;
        Tue, 21 Mar 2023 23:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679441700;
        bh=yppEdnyn3l0bkWt80AgXtS9D7pP3J+7NasAmtSPyhqs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Cz9xySntcGlWSjnt/rJuaj4LNvNWDclflDI8TNx39VGq3ijn+NVmm0RRYTDGUl4Io
         kiRs4KoBop9vH/wlPT7P7KuXHV1hK35kUizOrJF2a2XNztCG6ORZEDn9nJNogSJNZ3
         Jjvcy7u3hxwR4S/E92JEoaWHOUKvQNUKdh/aBfMInjF5jM7D2ubX5OF0GW0Z9R8AZO
         pKYV8OgjXBldZjjI14poJoLobe4Iw4zaKKA93rZaOOQIIIK07PRVkHUsv2q2U6+3OT
         5zed7+kjQ0YC2btNiuDxRJ1k/pvJu/p03z09RdNIFJ0z8cLELh8AXbR0zaNpO1Te4n
         6hgoxgN+xAWDw==
Message-ID: <e39b470005a7d61c3eefa5e152acbd8c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230321111817.71756-2-keguang.zhang@gmail.com>
References: <20230321111817.71756-1-keguang.zhang@gmail.com> <20230321111817.71756-2-keguang.zhang@gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: clock: Add Loongson-1 clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Date:   Tue, 21 Mar 2023 16:34:57 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Keguang Zhang (2023-03-21 04:18:14)
> Add devicetree binding document and related header file
> for the Loongson-1 clock.
>=20
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next

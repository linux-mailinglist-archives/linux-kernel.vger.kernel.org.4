Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF26C3E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCUXgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCUXf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:35:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E494D600;
        Tue, 21 Mar 2023 16:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 423CE61A43;
        Tue, 21 Mar 2023 23:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95252C433EF;
        Tue, 21 Mar 2023 23:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679441744;
        bh=HccvHcDWeFU2X6XzPqMIZuu7ivOyOkKiAIKRkencmNw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OvAT7M8Nce6SpimmtDjX0QWwOBjtr4Me3YVA5hzVKxeGDnVxSX+6Hs+n4jTAUB3KE
         J0lxJbN10bcTINa4SstIUnAu1Ly+TXsg0wODh9Db65wryXwtGlMFGqpUlljCFGxtMx
         cTjPl0Gc+zGfsD+w2cZ1dhbvGpElm8W4lh7trjPuDaMqyjTkarhHZtf/869g+V0EJn
         Qdfh/OJ8TA+IgxQaKOvBgArW+jo/6VWpKWwmhB5g4MsYV5HrtzLZxEvFNSqFcAj+Vo
         LMsTDV+CJei+58V3Qk19Hku2ZH0y2lZf+wpG2aSYl2c8CFWizhfQXFr6+u6LVL65se
         U3WIB3KVW8OEQ==
Message-ID: <8ca046cc2cf7469ace705b0eb333768e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230321111817.71756-5-keguang.zhang@gmail.com>
References: <20230321111817.71756-1-keguang.zhang@gmail.com> <20230321111817.71756-5-keguang.zhang@gmail.com>
Subject: Re: [PATCH v5 4/4] MIPS: loongson32: Update the clock initialization
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Date:   Tue, 21 Mar 2023 16:35:42 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Keguang Zhang (2023-03-21 04:18:17)
> The Loongson-1 clock driver is under re-implementation
> to add DT support. As a result, ls1x_clk_init() will be dropped soon.
> Therefore, call of_clk_init() for clock initialization instead.
>=20
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---

Applied to clk-next

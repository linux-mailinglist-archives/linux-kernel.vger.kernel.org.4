Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123975FB9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJKRia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiJKRiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:38:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD891181F;
        Tue, 11 Oct 2022 10:37:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BD8EB81636;
        Tue, 11 Oct 2022 17:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7966C433D6;
        Tue, 11 Oct 2022 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665509864;
        bh=QM63ZDQNXsf5+hqV7DXo+MBY7rPucxb/MYLvPbMHN90=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ys8ilSF5/7FIO2415Z9A7arjNTk5lkH1gFW4V3UY8mM64pXhoBkwRPjePNgR5QHGX
         vvnxioXNks72Ew8ZLcCh5esSbFxoYgeCZBcml+81kZ0PJjIqszgIvFUOruwnhIY6db
         O2I33MkGlzmdFnNVbO953DwywggwoBEfy6QQjmOShRPMh3Q/d/cG01riAlRqiSMIUD
         SnKDMLg58MI44uO3Su/ztag0PgmDBlNReJSiZ/0zmIuKqIYiNee486IrPf9UA6Z7GN
         orD6wd2NsacS0JcIfmVIPgMTAsikQ4/ne0s2jGyS9Ljn4KTHS7/6pq6vs6H1DMo3Zl
         x3LEMY+7ta6qQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221011162919.3025038-1-robh@kernel.org>
References: <20221011162919.3025038-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Convert pwm-clock to DT schema
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>
Date:   Tue, 11 Oct 2022 10:37:42 -0700
User-Agent: alot/0.10
Message-Id: <20221011173744.A7966C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2022-10-11 09:29:18)
> Convert the pwm-clock binding to DT schema format. A straight-forward
> conversion.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

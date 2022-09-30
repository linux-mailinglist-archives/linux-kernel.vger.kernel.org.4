Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267825F14CA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiI3V1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiI3V1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:27:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCBFA0303;
        Fri, 30 Sep 2022 14:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 160D062512;
        Fri, 30 Sep 2022 21:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3FDC433D6;
        Fri, 30 Sep 2022 21:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664573226;
        bh=HupthDcR+PdMQGfNtpwUOFBAiJ3P0Fah5fWYlvdqkS8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E3ZmocAyWzvBEDJlPrkQmMS4LbR7VLaCuhH4UAfvfPVQRa2+4FDoY6l2MoMRuv0h8
         42MWyv3yftmnsx33uBmpywnx0wmDxwvtJ0jWke6+p/PZGfUN7BbwoKxKBhBZhZA7AJ
         CtXbxHih2/85/n/QESQn2LEFxCOVAfxAmZWkU32zbMxfAfRfPxIyk1V/RlRN5rqpMw
         5HU6z42k60me5c5krYfqex9k6g/RmXGL80az7vj8hwtSrq3or/pp9+ublNKYgvDNE/
         bPv+HkbFUfwT9mgmhwgwOuMaE/dDfyzZz8MO8X7LRrHwhA4T+1bI/Rv6aaHggcEiON
         azuWSUqoPOKtg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220929225402.9696-7-Sergey.Semin@baikalelectronics.ru>
References: <20220929225402.9696-1-Sergey.Semin@baikalelectronics.ru> <20220929225402.9696-7-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH RESEND v12 6/8] dt-bindings: clk: baikal-t1: Add DDR/PCIe reset IDs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Date:   Fri, 30 Sep 2022 14:27:03 -0700
User-Agent: alot/0.10
Message-Id: <20220930212706.6C3FDC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge Semin (2022-09-29 15:54:00)
> Aside with a set of the trigger-like resets Baikal-T1 CCU provides
> additional directly controlled reset signals for the DDR and PCIe
> controllers. As a preparation before adding these resets support to the
> kernel let's extent the Baikal-T1 CCU IDs list with the new IDs, which
> will be used to access the corresponding reset controls.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Acked-by: Rob Herring <robh@kernel.org>
>=20
> ---

Applied to clk-next

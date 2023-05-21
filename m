Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A8070ADB1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjEULq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjEUKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 06:46:38 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613921A6;
        Sun, 21 May 2023 03:46:21 -0700 (PDT)
Received: from [91.65.34.120] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q0gZo-0008Cg-NT; Sun, 21 May 2023 12:46:12 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Michael Tretter <m.tretter@pengutronix.de>,
        Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH RESEND 2/2] arm64: dts: rockchip: Add RGA2 support to rk356x
Date:   Sun, 21 May 2023 12:46:11 +0200
Message-ID: <2290673.ElGaqSPkdT@diego>
In-Reply-To: <ZGUfTP1EXtlJbtxJ@valkosipuli.retiisi.eu>
References: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
 <20230119-rk3568-rga-v1-2-43d4d14365e6@pengutronix.de>
 <ZGUfTP1EXtlJbtxJ@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 17. Mai 2023, 20:39:08 CEST schrieb Sakari Ailus:
> Hi folks,
> 
> On Fri, Jan 20, 2023 at 10:14:22AM +0100, Michael Tretter wrote:
> > The rk3568 also features a RGA2 block. Add the necessary device tree
> > node.
> > 
> > Acked-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> 
> Can this patch be merged via the media tree? I don't expect merging the
> other one via a different tree being an issue either, so alternatively to
> the 1st patch:
> 
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

thanks for the Ack. To prevent conflicts with other additions to the
rk356x.dtsi file, I've picked now both patches for the rockchip tree.

Thanks
Heiko



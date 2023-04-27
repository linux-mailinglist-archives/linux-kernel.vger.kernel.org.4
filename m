Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21D46F03D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243446AbjD0J60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243410AbjD0J6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:58:22 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7637D4C0E;
        Thu, 27 Apr 2023 02:58:19 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pryOG-0003kL-9j; Thu, 27 Apr 2023 11:58:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: fix nEXTRST on SOQuartz
Date:   Thu, 27 Apr 2023 11:58:08 +0200
Message-Id: <168258947019.413434.3793815124340047357.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230421152610.21688-1-frattaroli.nicolas@gmail.com>
References: <20230421152610.21688-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 17:26:10 +0200, Nicolas Frattaroli wrote:
> In pre-production prototypes (of which I only know one person
> having one, Peter Geis), GPIO0 pin A5 was tied to the SDMMC
> power enable pin on the CM4 connector. On all production models,
> this is not the case; instead, this pin is used for the nEXTRST
> signal, and the SDMMC power enable pin is always pulled high.
> 
> Since everyone currently using the SOQuartz device trees will
> want this change, it is made to the tree without splitting the
> trees into two separate ones of which users will then inevitably
> choose the wrong one.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix nEXTRST on SOQuartz
      commit: e5d8752e957872a844ed46736b15f30b08af6591

As fix for 6.4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706B865A3E0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 13:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiLaMBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiLaMBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:01:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D68DF0C;
        Sat, 31 Dec 2022 04:01:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 279CF60AF7;
        Sat, 31 Dec 2022 12:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF360C433D2;
        Sat, 31 Dec 2022 12:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672488108;
        bh=qxHjy+zKK9wtZ6F9aaLA1vU4VqtvVsM+K7aYfjSbsd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fl+Xqq+za4DdxLdF/ED08Y8aaYK7tnfVaWeEiqwkqRRh/nezleEiJEolg4jhIFXhY
         49NVpLVqQlMG/JLwrPmYaDeznGneb+okUL/HVMRxhJetN+5AcvrtcrKPvc9lE6GLu4
         QI4JsW5qrqBgLWgTG6Z9rqsaYutwMr0CbjOnKdO3UN6TMDmizwm/8tLgZXfEOfDfaj
         mcm9uIfkAy9CEpoMHPc2B3K4P6+/COcolgKKRTjErMLSZJGr97Tkt76KuCKQYj5P4d
         xm2jlcoA0nM4J+gkRggDB2Uv3aGDh7Z5ybx7/gl/5xUJAOTxbZ7AAAMps7yjn4d/7n
         0uV0YjmvTdQ3g==
Date:   Sat, 31 Dec 2022 20:01:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: imx8mq-librem5: use multicolor leds
 description for RGB led
Message-ID: <20221231120141.GQ6112@T480>
References: <20221130113124.1558335-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130113124.1558335-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:31:24PM +0100, Martin Kepplinger wrote:
> As Documentation/leds/well-known-leds.txt says, "Phones usually have
> multi-color status LED." Fix that for the Librem 5 mobile phone board.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Applied, thanks!

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABB36B79DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCMOGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCMOF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:05:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A8234009;
        Mon, 13 Mar 2023 07:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B516B81115;
        Mon, 13 Mar 2023 14:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE00FC433EF;
        Mon, 13 Mar 2023 14:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678716355;
        bh=t5Oanjx38P5rlKCXJTYpQ2tv03MD0ogYaDtLUrxva5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7R1EYEHSRCrPENVxqD2p56+4tvIF4ZrQaiPfCIu3TuxPmMNaMDIIrSaAQAcd/4+b
         vh6di64Qo+YuOgB2F1VSnx4DMXD3zac37R2Y4NMC0ZcKIrDbHG53k6Jie04pgtdwhJ
         YuauOnlHW2AARd2sXWYGAfcbD/tguembEYVpJijBt2CU3QwRA1H2UMNE4meV+jVzhv
         w1CEByZfnqMYMTC/1WXBvRsmfH2WGH6Ec/O4ggsCELLvtWJEBIDIt4PgqsuBM1ZK0u
         zEV/zfzudjG0ao0ca5LCTzAa+bEoSRsVXLDhZP1RAaYHGps0YqILd8q+FOlkUYxj0t
         GOtgoZNWV7bKQ==
Date:   Mon, 13 Mar 2023 22:05:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: imx8mp-verdin: add 88W8997 serdev to
 uart4
Message-ID: <20230313140543.GQ143566@dragon>
References: <20230213120926.8166-1-francesco@dolcini.it>
 <20230213120926.8166-6-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213120926.8166-6-francesco@dolcini.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 01:09:26PM +0100, Francesco Dolcini wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Use the serdev feature to load the driver for the 88W8997 bluetooth
> driver.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thanks!

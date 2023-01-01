Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A448D65A8DB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 05:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjAAEr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 23:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAAEr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 23:47:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CAE63B3;
        Sat, 31 Dec 2022 20:47:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AFA4B808BD;
        Sun,  1 Jan 2023 04:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F25C433D2;
        Sun,  1 Jan 2023 04:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672548471;
        bh=E78n8FthkWtWz3kVzKm8GIMXrI3giqoMwGiWS5gbtcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMu67YSo1g3rg1UhC23LgybWU6A1Z55+djqTgoEFTtuC5Mrk4SALB+ZcvBjyhvzdV
         i0k6DYddIvetxCo5cCxRNcu7yPgdbRviN2/7zB3GPNFXkZkUW2IAb6lHbEMjFFyBA6
         HDOkEAkS3YyK4g3g03NYiH692rA5UkGFbdbt9iPVZc2VJqanW5ATNz4Wr2YbI3Jnms
         zBimNtU5bJKQjjlzdSxaY7FpsWZ5Il8k0PcJ7HdnaD1re+BYSFw5FdjL6p/2gdwAgN
         P62CEf0eI3BVHbZmS5Y01sOjs7WZInn0xd2BI/tdNoTZVZmU+2zVra4qdgmJOSmbVh
         29K1umHAYjeag==
Date:   Sun, 1 Jan 2023 12:47:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        marex@denx.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: Enable spba-bus on AIPS3
Message-ID: <20230101044742.GV6112@T480>
References: <20221218170545.1472746-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218170545.1472746-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 11:05:44AM -0600, Adam Ford wrote:
> There is an SPBA bus on AIPS3 which includes ecspi1-3,
> UART1-3, and Flexcan1-2 according to the TRM.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!

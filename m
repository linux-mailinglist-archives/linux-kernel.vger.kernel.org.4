Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240F665A425
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 13:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiLaMoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLaMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:44:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01096DD5;
        Sat, 31 Dec 2022 04:44:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B7E60B36;
        Sat, 31 Dec 2022 12:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D0FC433EF;
        Sat, 31 Dec 2022 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672490651;
        bh=+maSMcbw1umW6UcS4yiZMqTsiENF4ZQIAfRRxx0hl8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJ6lXVZzCkNV5c41dNHWQnaUPiMfJWc/qsEgwzf9k7Yd2EDCxyawu92hvgu2M4B5t
         BVVXHWvJB9u9Ed2l5tvicUF2ziJTLa6JxTpIt01FrcgDTOtyGJog8aH1G2tlmdK35B
         OTjUktRAMF/Tu4SnLWUEsrbET9hZyIHuDGwJ/6i63RaKlarZtSWZIiVVFg4VaQfpj7
         a3maQxOkZfCJLoOI3QxibQOFJOEvn/zzT1PWxN6DcyAsJsccFFFQr/0LqJLFSIVyez
         snOoYXLOBP19g/V9P/rbOjpWlN1ML2tig1S9okteOLI0107YfgHG8jR26ubp+vlnyZ
         2EFDqy4fWgCEA==
Date:   Sat, 31 Dec 2022 20:44:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, cstevens@beaconembedded.com,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon: Fix ecspi2 pinmux
Message-ID: <20221231124403.GW6112@T480>
References: <20221202191037.167718-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202191037.167718-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 01:10:37PM -0600, Adam Ford wrote:
> Early hardware did not support hardware handshaking on the UART, but
> final production hardware did.  When the hardware was updated the chip
> select was changed to facilitate hardware handshaking on UART3.  Fix the
> ecspi2 pin mux to eliminate a pin conflict with UART3 and allow the
> EEPROM to operate again.
> 
> Fixes: 4ce01ce36d77 ("arm64: dts: imx8mm-beacon: Enable RTS-CTS on UART3")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!

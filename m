Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF0630AE6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 03:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiKSC71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 21:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKSC7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 21:59:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF0C809B4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 18:59:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0126B82667
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 02:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC4BC433C1;
        Sat, 19 Nov 2022 02:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668826761;
        bh=1bpKyTHp8Io2f8+fgLohAbIzpI0/+f42qIdRcsXdQmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hogrf7LOYKtF0bBGNrT8xzkIEdtEkL07MuSzR/oKfXG4CemKCWbkfzb/VCm3ctiTz
         SwsPP5IETvOZgbSQfto3MkPG3YzlFhQmlvn+0qQ3+MsfPM7IdHZK+va/hhi8ebBJt9
         dfWsOPICYxfXrhu2TRVc5rQlpQ6iVwUYIkj0CzjKLgRZpCsTx/eLnoQy/c6r26hBc7
         pBGGGjHkDR2HBoIeJ5hs2ofFS7WnoXwjsFEM+fo/WPhHS+eIK8K9kbLrbVHV2aQ2UV
         eXGMaNpcNj+6qr+1nijkHA238b/sbCIQRb1rMKgQ5Zh8aK/lG2ur13sYU6xedvOoTk
         elYOxFwmijSzA==
Date:   Sat, 19 Nov 2022 10:59:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V6 01/12] arm64: dts: imx8mp: add mlmix power domain
Message-ID: <20221119025915.GB16229@T480>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
 <20221117095403.1876071-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117095403.1876071-2-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:53:52PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add mlmix power domain
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Acked-by: Marco Felsch <m.felsch@pengutronix.de>

Applied, thanks!

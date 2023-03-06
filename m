Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CAD6AB4D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCFDCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 22:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCFDCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:02:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF5ABBBE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 19:02:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 809FF60B60
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F27C433D2;
        Mon,  6 Mar 2023 03:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678071763;
        bh=oswIgDVqyDWGFLB8f9j0gOGkR+wEvpxz0jXrYFIo2Zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ryw0dHWiVCGlccEKVr655e0tWplroUBW8xueN/ny15Lu22U+QA0OUfsfxiwha+OKe
         F9XxJXApuxHw07yC9ch+ExzA/TYhhp1h5zP3l3RDVuZr/LrKEfcUswxRc2fPEKdTrF
         5bCdV54DtFJ7ZThmbATxhTcxbtvyOYJec/ax+09MnRtiQv7lMTUfSaXIF2vWJAtFCz
         gY0JuaeCHN7iTeQIZuBc6Z/aBKvKTvVPGU8c5znnDdzteMsEPS6JiPLk3GAaRZ4dzh
         gFu/+5Z5wA8m6m/ePtNFoZZm7evhCHWVMVhKo4rxrCajtQyS6zDAkrOJTThqK4+QMh
         hcSEqdE++7+fQ==
Date:   Mon, 6 Mar 2023 11:02:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: imx-weim: Remove open coded "ranges" parsing
Message-ID: <20230306030231.GF143566@dragon>
References: <20230201215854.245717-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201215854.245717-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 03:58:54PM -0600, Rob Herring wrote:
> "ranges" is a standard property and we have common helper functions for
> parsing it, so let's use them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!

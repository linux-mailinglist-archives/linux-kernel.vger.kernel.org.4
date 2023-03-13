Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727376B7124
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCMI15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCMI1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:27:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A4431E22;
        Mon, 13 Mar 2023 01:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 388A9B80D54;
        Mon, 13 Mar 2023 08:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAFBC433A1;
        Mon, 13 Mar 2023 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678696072;
        bh=suoZPsBB40APNlrO/42ROolHUJbftaSf2PiploG/tFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEFVksVib4gyDYDUkhKU5X5T1iem7q7NcGkCdoFb8411IrsV6PMA43sJL2VqNY/FI
         96XtjoLmM6Cv0xS1a9JgQ9qT4kha8UtzeE1PUXOqCAph/HuSv/BUV+6jFt2a1E80+Q
         zQFVzcTLWkn9oD+mvds0xwmO+xnAE5A6vyiYx+04sxy6hCfJn6Ye3eCodMIJ+H0esr
         0CzTapxzzUBACcyYcxXQlti0Fsaxkmk3nBn13RmnEKu2WB2SSrLdt0um6cdZiRoyQP
         Hp33k+o5xylRAq9XQRzkhfogBSE5O5RDYNz5zSaPSA7EsSXPuSh7VJw6wpmPHFGt36
         qEiG+t1on5JPQ==
Date:   Mon, 13 Mar 2023 16:27:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: arm: fsl: Fix copy-paste error in
 comment
Message-ID: <20230313082745.GN143566@dragon>
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
 <20230210154855.3086900-2-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230210154855.3086900-2-michal.vokac@ysoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 04:48:50PM +0100, Michal Vokáč wrote:
> The imx6dl-yapp4-draco board is actually based on the i.MX6Solo SoC.
> Fix the comment to match reality.
> 
> Fixes: 24ef3b6e22fe ("dt-bindings: arm: Add Y Soft IOTA Draco, Hydra and Ursa boards")
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Applied, thanks!

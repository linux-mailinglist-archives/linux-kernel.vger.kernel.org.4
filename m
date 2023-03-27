Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB06C9ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjC0FMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0FMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B315911A;
        Sun, 26 Mar 2023 22:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E5EF60FA5;
        Mon, 27 Mar 2023 05:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BC8C4339B;
        Mon, 27 Mar 2023 05:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679893929;
        bh=JYIpZapgW+cJAI2YJGyIqRTEYlCNOtn1+Rj0W0oiGIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fu8CyC+0GTdcdtt5JQTPPJK7OcV0aeS+DJJZx6L2Or8b8j/0tkXZ3H1EXZ+WQ1Ww0
         exwjCYbxq7KOLFjoJBSeC31V0Xes6p2M2CBT5+5T6BemKkMnymt9uzGhksCsDq4ijq
         5E22fflCy5OwtxCyEBwUpUmWmEwg3OLHZWm/D7Rtmb4Mb6ad7r433vmlIi9d65MikL
         bAiupR9CuSa83z45NkHW/O9Uq7L+NitqVk79zhI32Efyy5QWWLnyL0+PerkWB188e2
         h7de5qIRKzyJ/zg9JT6vwaH/GHMKL3CRuRKnquUV/Ila155rLolAN+YvRQwNkkMhwH
         j4aP24fDNfpQA==
Date:   Mon, 27 Mar 2023 13:12:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        marcel.ziswiler@toradex.com, alexander.stein@ew.tq-group.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: tqma8mq-mba8mx: drop
 disable-over-current
Message-ID: <20230327051202.GN3364759@dragon>
References: <20230322080722.3054508-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322080722.3054508-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 04:07:21PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> disable-over-current is for chipidea IP, i.MX8MQ use dwc3, this property
> is not valid. Drop it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied both, thanks!

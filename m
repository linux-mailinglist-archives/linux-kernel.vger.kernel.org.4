Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FDA709E74
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjESRoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjESRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:44:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B085F9;
        Fri, 19 May 2023 10:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F72961503;
        Fri, 19 May 2023 17:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E54DC433D2;
        Fri, 19 May 2023 17:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684518267;
        bh=4g8OqdutIps7VawfkwADZsolWCHLUkVTD2tZ2EN5CEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDGdGSvnlVWsmUkEn52K7K/O5LispEQrhycaR9lIiZr/ew2psx/UIjRdWecIe5PIY
         s0hjY27ZXZvxbY6F+a3mNdyF/BLDvgXG5SvATuaBt326RCmAvbJ6M/9gvaRrnRJBpy
         Z+coKW6MGJXUeAAhAFXhHoS1XnqJ1Q2UdTR5FdQ4WzkzNJNUuPORw3oD72++KkcMJk
         e8dhkpnKCG2vAV75yneUWoI/8hiDmDma0nBlcFBAg63ch/rCDa4ATyyONKA/3MFzkg
         RDi89A/fmnD3nZJAq1he3sVixBfAz2JMmsCBzJ9O3cLlovAWSlSx14MKHHoyjvuJ1b
         g8jlrkGBf4imA==
Date:   Fri, 19 May 2023 23:14:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v5 0/6] phy: cadence: salvo: some fixes and workarounds
Message-ID: <ZGe1d/8tGGl+rTNa@matsya>
References: <20230517161646.3418250-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517161646.3418250-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-23, 12:16, Frank Li wrote:
> 
> Sorry I have not realized some patches were missed at upstream kernel.
> Version number continue with previous
> https://lore.kernel.org/imx/ZGOCT0Mdg3Jtar6c@matsya/T/#t
> 
> Peter's Fixes:
> - Bist issue
> - fix corrupt package from devices when start transferring less than 20us
> - fix the FSM in controller seeing the disconnection at L1 use case.

Applied, thanks

-- 
~Vinod

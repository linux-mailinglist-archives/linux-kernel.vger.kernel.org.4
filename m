Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6616D7D5D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbjDENHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbjDENHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:07:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DE7E55;
        Wed,  5 Apr 2023 06:06:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40DF26282F;
        Wed,  5 Apr 2023 13:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914F0C433D2;
        Wed,  5 Apr 2023 13:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680700018;
        bh=PqbrZHDrw5aAy0zgaBM5C8inqRe6LHE86al3loKoR2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BkXF+cVqsWjAio3Lnye5G2Ql1UmqzujvEeHrn0IZVOWb+Us9vpXCbLikfoVlkVqMo
         rbNYDCvBvgUga15M/BJKgWPk4YylpoHlquVNI57XOjrjGn5fEoKG0BnMb8zm0RweOD
         ApOU9KRDM0KQXEhrQtXz02wJohus0HtcB585/UqbeiybeAuJhUG/vxzM1Gz9WpX9e6
         U8Tc63qE8N+Slamukk9Pv3uZQ1juTMER65Mn3Wc097ODmnGzxtk8BqIRzT7lwxSxL2
         A6HZPrTw38jT8QT/VDAUeTuLpqKrdIW4YEXMhmuEclfP4m7BCsVFvKgjSmLt6fqxJ6
         gboL71FJqpwAw==
Date:   Wed, 5 Apr 2023 21:06:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.hauer@pengutronix.de,
        xu.yang_2@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jun.li@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V7 10/10] ARM64: dts: imx7ulp: update usb compatible
Message-ID: <20230405130649.GA11367@dragon>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
 <20230322052504.2629429-11-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322052504.2629429-11-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 01:25:04PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per binding doc, update the compatible
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

ARM: dts: imx7ulp: ...

Fixed it up and applied all DTS patches.

Shawn

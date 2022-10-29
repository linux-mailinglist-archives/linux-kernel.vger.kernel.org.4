Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30C8612142
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJ2IG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 04:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJ2IG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:06:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF30F7297A;
        Sat, 29 Oct 2022 01:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B76D60CF1;
        Sat, 29 Oct 2022 08:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A876C433D6;
        Sat, 29 Oct 2022 08:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667030785;
        bh=3qTjb32MvL2XVV0Vp9JfBDkcoyxlQrtGS1MXC7/qQX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VElpRI6psTLMCYE6xbD/yCkRstlm1dKTP3uKiJLaP9RoA8OiUah/vfUsgAZdqWe7S
         AVBGIbwdU4nTw1rnx1KbYXlmMQlTn02Jbtah0FbhrKlf+iz5qwzGGRAqvkYNSkudXq
         j6mk6VzCr4BAFHQYV69SuF2+mFJAj8KruYJwlJZFJ4UGfOJDAxPlqNjgIgRadLkTbO
         TG/Guya5z260fGw4ImrIMYx7INRI3HwgSg7MQmhK4Dt5SQyXGnHJj5DVu4Lp5neRUu
         /9zZpbUcz3PsPwmRQ1VwdFI4vg1tbuUqKDUb5cT/sOgdn+MfkXeUnih/lXhr84nbWU
         mRQFltJKBI++Q==
Date:   Sat, 29 Oct 2022 16:06:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/7] arm64: dts: imx93: nodes fix/update
Message-ID: <20221029080618.GO125525@dragon>
References: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:16:55PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> First two patch are fix, other patches are update
> 
> Correct s4mu interrupt name and gpio-ranges
> Add nxp,no-divider property for sysctr
> Add MU clock for Message Unit
> Add LPSPI/TPM nodes
> Add gpio alises
> 
> Haibo Chen (1):
>   arm64: dts: imx93: add gpio alises
> 
> Peng Fan (6):
>   arm64: dts: imx93: correct s4mu interrupt names
>   arm64: dts: imx93: correct gpio-ranges
>   arm64: dts: imx93: add nxp,no-divider for sysctr
>   arm64: dts: imx93: add MU clock for mailbox
>   arm64: dts: imx93: add extra lpspi node
>   arm64: dts: imx93: add tpm nodes

Applied all, thanks!

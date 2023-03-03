Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4356A957C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCCKoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCCKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:44:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5723412F31;
        Fri,  3 Mar 2023 02:44:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E736E617CB;
        Fri,  3 Mar 2023 10:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E0EC433EF;
        Fri,  3 Mar 2023 10:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677840242;
        bh=/1KYU0/P2SYQY4zZ6AMAH5Fdd4UTOrKDv//73pWpK/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMPk7yyYtjM7NmFhOEqmUuu+sim6btQHZd1PNqGD0yEphq64RRuIDehMbIjgDiWgv
         icL5uebhgkn37SfnQgp28R/dutSPYMtms8Zq1ZJOF+Mw0nfN2mCfgUHfNKU0+EP1f7
         rHgb3s7JPWCIirdz1DWqM2n/uC8U0mzMcj0iYqguhB25EGfXKn0tV//vIxXar5uCSG
         F3RyCPNJYFjT4WZXGMP2uBWgiJARo5M30FGV2NGAYnZDH5bhNqHr1RCUQk/iBcRici
         L4Yz42U1PH11j90/3jEKs4bM2FSFnkMa1+sdWrzSzUQp7ENTfsd2Z03LPyRejeQo0X
         alUBV9ZBYCllw==
Date:   Fri, 3 Mar 2023 10:43:57 +0000
From:   Lee Jones <lee@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] mfd: qcom-pm8008: Convert irq chip to config regs
Message-ID: <20230303104357.GT2303077@google.com>
References: <20230216222214.138671-1-aidanmacdonald.0x0@gmail.com>
 <20230216222214.138671-3-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230216222214.138671-3-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023, Aidan MacDonald wrote:

> Replace type and virtual registers, which are both deprecated,
> with config registers. This also simplifies the driver because
> IRQ types are set in one place, the set_type_config() callback.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/qcom-pm8008.c | 50 +++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3EA721EF7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjFEHIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjFEHIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:08:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D7E5A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8DF861F9F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F951C433EF;
        Mon,  5 Jun 2023 07:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685948801;
        bh=JrRk8+31vboG/VQHuPBXvcmI4AOcYJ94E5CXxrXjCIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FiNs5MlC02+V1hliD8D46cJ6xPDu55/uvF0FE4SVAAmg6b2AnTZ4ugLr+EbsEMkd9
         IMj7yFbrA+nY+g5g81mkl+7Mg8Bgx5TtgPPXv1Ku1Z7T2CqPU1JfF2cKcZGudIJ1ln
         JdB/5Tv6KpVLXHoibY1MoxTlL34iwRmL2bI9N0n3MBhT2hxsUlUOnY9FTsWHaZ7hWg
         R0fP1lXP/di3AMjKzi23o4ZbIVzOw6wtmE3ZXJbZtTSGZybI7uHXDXT+VLvLu7YOiS
         i8D4I91LM5q+BSG+s6ipDSadzK5mI190sYeLbSI0GO6cGi62VH9FFGi23DQVnJ2RKf
         EqosM3B6EombQ==
Date:   Mon, 5 Jun 2023 12:36:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net] net: stmmac: dwmac-qcom-ethqos: fix a regression on
 EMAC < 3
Message-ID: <ZH2JfDee+01/cajH@matsya>
References: <20230602190455.3123018-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602190455.3123018-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-06-23, 21:04, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We must not assign plat_dat->dwmac4_addrs unconditionally as for
> structures which don't set them, this will result in the core driver
> using zeroes everywhere and breaking the driver for older HW. On EMAC < 2
> the address should remain NULL.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

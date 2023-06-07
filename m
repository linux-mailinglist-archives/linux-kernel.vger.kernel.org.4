Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44D3726669
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjFGQta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjFGQt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB91FCF;
        Wed,  7 Jun 2023 09:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A03BF61755;
        Wed,  7 Jun 2023 16:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C83C4339C;
        Wed,  7 Jun 2023 16:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686156564;
        bh=sPQfBEs+boCICdljlPBIqh6xD9H5WlMiLwV1L8x3Bl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tza99j3Xr7OwMypJ1xp/n7ZysXrZ9SNMGZhCXlPbAx9eRALgF1bCNRPunfaedKfDq
         N8oqFNdiMLkslnznfnMbdl1xwVPM10YPvsq1DuuNhGVymOnXlqXSnPwBUhU6vtvPKL
         wH1fjEXy8DRQwSEATgiNK1SkA2cw/P1HnEKGbO/QaRJRpiqL2Y9N4dKwV3QvJUV+xy
         4KD2H5NF1T9aFg2ayUdtIsdc0c4soIvd+tlrg98C/yI+OYagyAsJi7uwc5G2MyT/D5
         f729US8K44B33nuwA1gTnZV9Yr51NwrwRnD/nIAjHcu+cWXHbIDDVQ+77yzkb1YTH5
         YnseoP5b8gtSA==
Date:   Wed, 7 Jun 2023 09:49:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
Message-ID: <20230607094922.43106896@kernel.org>
In-Reply-To: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Jun 2023 20:54:25 +0530 Manivannan Sadhasivam wrote:
> This series adds a network driver for the Modem Host Interface (MHI) endpoint
> devices that provides network interfaces to the PCIe based Qualcomm endpoint
> devices supporting MHI bus (like Modems). This driver allows the MHI endpoint
> devices to establish IP communication with the host machines (x86, ARM64) over
> MHI bus.
> 
> On the host side, the existing mhi_net driver provides the network connectivity
> to the host.

Why are you posting the next version before the discussion on the
previous one concluded? :|

In any case, I'm opposed to reuse of the networking stack to talk
to firmware. It's a local device. The networking subsystem doesn't
have to cater to fake networks. Please carry:

Nacked-by: Jakub Kicinski <kuba@kernel.org>

if there are future submissions.

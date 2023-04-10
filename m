Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0426DC908
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDJQE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDJQE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:04:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E04D26A4;
        Mon, 10 Apr 2023 09:04:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AABEB60FFF;
        Mon, 10 Apr 2023 16:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231EBC433D2;
        Mon, 10 Apr 2023 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681142608;
        bh=MDHcorSYIoqQfGJLNR4MXBHMIP2dHZGW4zFG/rUVs9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bai20Ogui0L/1vQU86vimU9agwmOd0a0gv5s7sjr4ljSy894+L4FNsKD97GkUpuHy
         xDv5N/x3ee9xTJMGBgzvJohKjPDM0+72OPxA7g8tIKiZ/PwQmXIzF1hZ0qLbsovbfC
         q0Wdo/fiimDJ9GiH7C/+KlfViWtdGbfNroTxiNBQ1dAaYo2SXV3aXltKP0L2vyJkST
         GIlr+YOAkpedOgjqr3ajQBnzsDBDrq5pA+hIGkuOcnucP9S4RLhRsYUYWMY46kdqW0
         G6Mh+AeambtGF9m2CsviZqpy3PE4Ouqt2wcqvnxyXam7wANZaDwqReLuo3NdNoYm3a
         LEcTJbd9lcynw==
Date:   Mon, 10 Apr 2023 21:33:21 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     mani@kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] MHI host syserr fixes
Message-ID: <20230410160321.GC4630@thinkpad>
References: <1681142292-27571-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1681142292-27571-1-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 09:58:10AM -0600, Jeffrey Hugo wrote:
> Two small fixes that address an issue where it is observed in stress
> testing that a MHI device could appear to enter a bad state and be unable
> to recover unless the module is removed and re-added which should not be
> necessary.
> 

Applied to mhi-next!

- Mani

> v2:
> -Add fixes tags and cc stable.  Fixes tag is expected to give suitable
> indication for backporting.
> 
> Jeffrey Hugo (2):
>   bus: mhi: host: Remove duplicate ee check for syserr
>   bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state
> 
>  drivers/bus/mhi/host/boot.c | 16 ++++++++++++----
>  drivers/bus/mhi/host/main.c |  2 +-
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

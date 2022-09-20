Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45F15BDCF6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiITGPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiITGOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481F13E95;
        Mon, 19 Sep 2022 23:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A692A62389;
        Tue, 20 Sep 2022 06:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8A0C433D6;
        Tue, 20 Sep 2022 06:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663654489;
        bh=bOC4ReWblLf0yM+WfwoTzP1oEwc2VdlQSw/5YFxtAH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2kZjW6O/9CZTd0eRgMOTP3VEPgZGCZZc52wAJZSSNh9LnGHPDSjNxM64fDl80UQ4
         vlX3lBtSx6GrRqlcU/wa1BvEr4fXNciwezYwsLjoakdsJEp7ZCZW7UvwMCJjXe98rr
         SXQ9kLrN8P++lNBTaeTR2m43xAH5S3dTSZYu2DaiikKWIJZG+up15ZRuziStVMqSY/
         MXI/PCkZI9QWCAlQUxmlPeVRL5K4Nww5uDBB4Hxi2r0miPuYkIyynYGe0nKCxDXCKF
         e/YBX/5qD1xHRhJy9/GwIMXylMSWCdGMGL34DY0OPaSEYDC+8nEiDnXPaQwsYD5cbA
         fl7/OimSY03dA==
Date:   Tue, 20 Sep 2022 11:44:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom-qmp-combo: fix sc8280xp PCS_USB offset
Message-ID: <YylaVAVRgDmgqYf6@matsya>
References: <20220919095700.2228-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919095700.2228-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-09-22, 11:57, Johan Hovold wrote:
> The PCS_USB register block lives at an offset of 0x300 from the PCS
> region on SC8280XP so add the missing offset to avoid corrupting
> unrelated registers on runtime suspend.

Applied, thanks

-- 
~Vinod

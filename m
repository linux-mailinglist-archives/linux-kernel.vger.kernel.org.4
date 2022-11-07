Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368E561EE0D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiKGJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiKGJCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:02:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1660B16599;
        Mon,  7 Nov 2022 01:02:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A56F460F1C;
        Mon,  7 Nov 2022 09:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6004CC433D6;
        Mon,  7 Nov 2022 09:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667811753;
        bh=ViJ+rTwa2j3DEYuVpCX6JtP/l6UkQwZqRriZXqJuLx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNqWuwEqwTDL+wAW3Jub1iigGSfw4ccaPv22kfWddbp0MT0Q0TOkxDXOFVjHBn0kL
         WfDtZ2jPL7ieBwUPtKgKQ8a4tTbw5UE14j0Va2M4IAC2DrKsp6+x7mPco+Y+62J+VE
         VDs8qoizzrBP41VAM0vbcugD/3eD8C8g0va+ytqc=
Date:   Mon, 7 Nov 2022 10:02:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     mani@kernel.org, loic.poulain@linaro.org, dnlplm@gmail.com,
        yonglin.tan@outlook.com, fabio.porcedda@gmail.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: host: pci_generic: Add macro for some VIDs
Message-ID: <Y2jJpT5//xBUOQMq@kroah.com>
References: <20221107084826.8888-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107084826.8888-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 04:48:26PM +0800, Slark Xiao wrote:
> To make code neat and for convenience purpose, use macro for
> some VIDs. These macros are supposed to be added to pci_ids.h.

No, they are not supposed to be added there at all.

And they are not a "macro", it is a "#define".

> But until the macros are used in multiple places, it is not
> recommended. So adding it locally for now.

Again, these are not macros

thanks,

greg k-h

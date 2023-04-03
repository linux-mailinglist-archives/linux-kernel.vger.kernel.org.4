Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231BB6D4BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjDCPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjDCPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BFD10D5;
        Mon,  3 Apr 2023 08:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CB4061CF4;
        Mon,  3 Apr 2023 15:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41A0C433D2;
        Mon,  3 Apr 2023 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680535349;
        bh=DojAgqfHgXk+7VGLNIvaVSufroaou6EC2kWQLU85/DU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rw2QW4h1x0nmDmfKQCgBH6BpAQN5gobtI5OCVTgbe57v1zFn2+/KmgcdvggsPSM1X
         rH7yvyOezEbVzw2lcvx1mC72EiN+OpKmpiXZpOAJWXdjbjuhPVS44/CEAF3m2PEYKz
         GJFy+ouIazeCwxAkq2vsEcVux+GYxs+/Jo++X7c8RhS39Zy6i8lMHYhzYQlsPER7fo
         OkwAwM/FbzhaEJqNYe6XOFltw14E8973cA7njrTAX+/4/jt98eEmUUnqfXP4qiaR1i
         lpGi4VRTHroRF0EHSXfYfqjoDj7g5PrtmI6VFKajpsXNyy22SsXrfFtXxSp9Q7a/fp
         Gkpu/1BLNMELQ==
Date:   Mon, 3 Apr 2023 16:22:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wolfram Sang <wsa@kernel.org>, Min Li <min.li.xe@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] mfd: rsmu_i2c: Convert to i2c's .probe_new() again
Message-ID: <20230403152224.GB8371@google.com>
References: <20230331121525.42c861fe@canb.auug.org.au>
 <20230331070344.czphnnmvu2ojzo5l@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230331070344.czphnnmvu2ojzo5l@pengutronix.de>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023, Uwe Kleine-König wrote:

> This commit reapplies commit 601e6d48ee35 ("mfd: rsmu_i2c: Convert to
> i2c's .probe_new()") which was accidently reverted by commit
> 1b3b1d6c27cc ("mfd: rsmu: Support 32-bit address space").
>
> Without this change the driver fails to build in combination with commit
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") which
> is contained in v6.3-rc2.
>
> Fixes: 1b3b1d6c27cc ("mfd: rsmu: Support 32-bit address space")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Looks good.  Thanks Uwe.

Applied, thanks

--
Lee Jones [李琼斯]

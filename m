Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7BC62058B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiKHBDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKHBDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:03:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D402A1F9DF;
        Mon,  7 Nov 2022 17:03:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 670A361355;
        Tue,  8 Nov 2022 01:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFEAC433C1;
        Tue,  8 Nov 2022 01:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667869430;
        bh=CeEwZDuDWBslatsCCvilP+bDrtgwh6VrBk+qsqlVx0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cs6iBK7IgWbTpM8BrUWxla9Yobk9iVCs2UisrT3hXDcdbDUvJUL6n9wXO7R5VYtd6
         glUgS31R1Z4mdHscRdShc4BY42U/muIwlnjRbPlqlvCimdjIKkfiWtVevvPVWM6Fkx
         oJ05RPuXgBYRG1eayFFBD6KDskTlwLyzy6TuOGpelRReUlzfjIRkb3SHwDgY1tUsbr
         AeqWFusGVcgppk8qK2Hg3zoBvT7ZL6+YZoYA7udSIgs7IZLejQAmRAd4NUynQO06Rk
         h8pTAq0Mwm1/i2dooi6EiAHneXdYAZMgL7PGQ49ODQQQMm2+0t4zKGFaOSEdmrVQEK
         nqCBf5DNJsxVg==
Date:   Tue, 8 Nov 2022 09:03:36 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Gao Xiang <xiang@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the erofs-fixes tree
Message-ID: <Y2mq6AJgq4OoGkKi@debian>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Gao Xiang <xiang@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221108073459.610a2e2e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221108073459.610a2e2e@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Nov 08, 2022 at 07:34:59AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   40f72c923c28 ("erofs: fix general protection fault when reading fragment")
> 
> Fixes tag
> 
>   Fixes: 08a0c9ef3e7e ("erofs: support on-disk compressed fragments data")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: b15b2e307c3a ("erofs: support on-disk compressed fragments data")
> 

Thanks for catching this.  It seems it's wrong in the original patch,
let me correct this manually.

Thanks,
Gao Xiang

> -- 
> Cheers,
> Stephen Rothwell



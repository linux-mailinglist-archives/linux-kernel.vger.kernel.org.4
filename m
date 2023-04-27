Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46876F0A60
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbjD0Q7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244167AbjD0Q7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:59:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8864208
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FA3D63E77
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D98C433EF;
        Thu, 27 Apr 2023 16:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682614757;
        bh=gXVCIjK795CMJBxtAMMAS6lZc6cKoQ6vRJ2AV/G1sGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2h01U57jEZ29PaSERHSaqLFvx4D5gFHIoyWwzKkvarfBQuZoz5hBlAQzDxiZr2U2
         NktTdNFmRqD6yZjUWREZ3cE1nUKA0MntIkHbssnz2o7HAlicMz3Mhm5Ic4hT8ezYmf
         Kpxk5LYwQbkWVBZr6QQChtFGdpejkwwDWstv8tZOB/7EOdtTuQLlRvUfefiA7aDeyu
         cT3GUPG8xPDWTHvU0CwD2NWdQUgY386Vk0OTHjVNt59ti4ft0z65LgqGWVhGg6/pg2
         Qi0V3FK0F6R/ssNPnrq1nMPK1yn2pz+/9rfkPReMgXf1jniC2iR78D+of1whGmsady
         xFZsK2B6lnUJg==
Date:   Thu, 27 Apr 2023 17:59:13 +0100
From:   Lee Jones <lee@kernel.org>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 RESEND] mfd: remove redundant dev_set_drvdata() from
 i2c drivers
Message-ID: <20230427165913.GD620451@google.com>
References: <20230425024526.6443-1-aarongt.shen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230425024526.6443-1-aarongt.shen@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023, Guiting Shen wrote:

> the i2c_set_clientdata() is the inline function which is complemented by
> the dev_set_drvdata() internally. Do not need to use i2c_set_clientdata()
> and dev_set_drvdata() at the same time.
> 
> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
> Reviewed-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/mfd/88pm80x.c       | 1 -
>  drivers/mfd/88pm860x-core.c | 1 -
>  drivers/mfd/aat2870-core.c  | 2 --
>  drivers/mfd/lm3533-core.c   | 2 --
>  drivers/mfd/max8907.c       | 2 --
>  drivers/mfd/max8925-i2c.c   | 1 -
>  drivers/mfd/wm8400-core.c   | 2 --
>  drivers/mfd/wm8994-core.c   | 2 --
>  8 files changed, 13 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]

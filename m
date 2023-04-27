Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E246F09C5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbjD0QWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbjD0QV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:21:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B8610EA;
        Thu, 27 Apr 2023 09:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3B7763E3D;
        Thu, 27 Apr 2023 16:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7372EC4339C;
        Thu, 27 Apr 2023 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682612517;
        bh=JiVVx1DtdOQF5TVqOPyCPt4x4HrBUjTJovXEhSgv+nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/K2kwEXv2OBiR3ef3WGjtEy0ugeAkANUVtiygVU6REmR+QgUCc1SCKRHjNgjUHIl
         sFBfe8ssUBmPA8+UwLJAxGPh+7NaCstpdqID8+2hcaJDIHbJCse+1FG8sB8eYwfgEj
         X8XIc9yyHXTR5vcWoNzYhnRySP3cbhpjsrx0jWqKcJpHR9HTPnis8K1vuapzhtp8Vk
         1r7zqizW5vK2hXKgz9wSk81ESxwBGoBEPLbX6aOf7EUUy39IAu5/hPA1kFtG1Qry5c
         IweljPEfR99Mhw4mDdPo3chW8nUjMDl84o9SZj9oknn/M4SJedBrVDcNQ6Oh76fxxZ
         4rHNmUxpC0IDg==
Date:   Thu, 27 Apr 2023 17:21:53 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: rc5t583-irq: Remove the unneeded include
 <linux/i2c.h>
Message-ID: <20230427162153.GD50521@google.com>
References: <128025bf5b81f5424db2202b0c8cfd9722c28aab.1682319383.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <128025bf5b81f5424db2202b0c8cfd9722c28aab.1682319383.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023, Christophe JAILLET wrote:

> This driver does not use i2c, so there is no point in including
> <linux/i2c.h>
> 
> Remove it and add the needed <linux/device.h> instead, which is much more
> lightweight.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/mfd/rc5t583-irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]

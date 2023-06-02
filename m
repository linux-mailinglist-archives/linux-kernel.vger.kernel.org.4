Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8371FBAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjFBIPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjFBIPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:15:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA03B99
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4177461755
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A820FC4339C;
        Fri,  2 Jun 2023 08:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685693713;
        bh=3DrAPakm7QPcNozEpbQPRCwge0hxHh7K2DVUgbcJvmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngJfci9HSxC7F2gxMRmt3TJliFJKAvAUCarRClDbQQS+ycXDsEu4YOAZj46y+XW5t
         H/VtGUCdTC56HU7o0nh2puBjaWv2sDr7DpLmZ3Y+nscXyZFn2Q6cjqJE+5iXamMkts
         7kncdogxCmdRVmGIUeqrxT5BE5RU+Vpl3YQYXNnXNbJlscxKJ09CzdIydpGaMHCAU7
         KOk4ZftPA+ur/aFygCm7W1YTfRp1UMDnmWNIt85gr0j349Rdcv+ZSMyAjqLF/3Nrfm
         Rvekt9IyGE283Y7PXhsf133Pg/bEWYgiaNfsKQYXiekKqv9b8ZkJ20YGyTKaFFTZiW
         qU0zb3aeZcRZQ==
Date:   Fri, 2 Jun 2023 09:15:09 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: max5970: Rename driver and remove wildcard
Message-ID: <20230602081509.GO449117@google.com>
References: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
 <20230427113046.3971425-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230427113046.3971425-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023, Naresh Solanki wrote:

> The previous version of this driver included wildcards in file names and
> descriptions. This patch renames the driver to only support MAX5970 and
> MAX5978, which are the only chips that the driver actually supports.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/regulator/Kconfig                     |   6 +-
>  drivers/regulator/Makefile                    |   2 +-
>  ...ax597x-regulator.c => max5970-regulator.c} | 126 +++++++++---------
>  3 files changed, 67 insertions(+), 67 deletions(-)
>  rename drivers/regulator/{max597x-regulator.c => max5970-regulator.c} (76%)

This does not apply cleanly.  Rather than mess you around, I'll apply
the MFD driver and provide a PR for Mark.  Perhaps this will apply to
the regulator tree.

Testing now - please stand-by.

-- 
Lee Jones [李琼斯]

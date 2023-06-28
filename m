Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C37417EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjF1SVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:21:45 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:56240 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjF1SVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:21:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C424361403;
        Wed, 28 Jun 2023 18:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7604C433C8;
        Wed, 28 Jun 2023 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687976496;
        bh=QCiRNpvCjRMEbgvpzeXiqnZIZU08GxFBBYgBZdY5tDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RrevFurZ03NOPYg79TiatLkR5xncPxFtmCuJHVwYKjFD0Ak1rdz3qB0NdKLrs2jon
         59BsdFSfUWhXnJSOrt4jR82GrU1RHrAzMZW5w6Dh9Rdr7SYftApXGimGBk6/GoLC5G
         K2O21funxsuqGwa8ZVBG14QYpFAkEsPOMHScjFdU=
Date:   Wed, 28 Jun 2023 20:21:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     stable@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 5.10 1/1] media: atomisp: fix "variable dereferenced
 before check 'asd'"
Message-ID: <2023062825-oops-unguided-501f@gregkh>
References: <20230627102334.18781-1-abelova@astralinux.ru>
 <20230627102334.18781-2-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627102334.18781-2-abelova@astralinux.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:23:34PM +0300, Anastasia Belova wrote:
> From: Tsuchiya Yuto <kitakar@gmail.com>
> 
> commit ac56760a8bbb4e654b2fd54e5de79dd5d72f937d upstream.
> 
> There are two occurrences where the variable 'asd' is dereferenced
> before check. Fix this issue by using the variable after the check.
> 
> Link: https://lore.kernel.org/linux-media/20211122074122.GA6581@kili/
> 
> Link: https://lore.kernel.org/linux-media/20211201141904.47231-1-kitakar@gmail.com
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Tsuchiya Yuto <kitakar@gmail.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  drivers/staging/media/atomisp/pci/atomisp_cmd.c   | 3 ++-
>  drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Now queued up, thanks.

greg k-h

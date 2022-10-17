Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774016010DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJQOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJQOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:14:05 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39276525B;
        Mon, 17 Oct 2022 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1666016041;
        bh=YD4Pv7tW+FbXtDk5sIYlLG/ZFT1v2pzYm+qsOBhsZBI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HrU7zBQPP0nvPbsR2IWrc7XbPrP0tfGGFWiqaqWTXfZp1xHeAvFWPX/vQHRvjn54s
         vtiaPaEZTq1XVB2kxQVUx8uln+lagto2dwK0QbYWzas65xhp71VWDeZil65pO+97He
         i+FhAw/Z706sOD2hjLJBHhec1ouW/qW3bbC9lb+A=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 691041281F8A;
        Mon, 17 Oct 2022 10:14:01 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q5psDtmI60sg; Mon, 17 Oct 2022 10:14:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1666016041;
        bh=YD4Pv7tW+FbXtDk5sIYlLG/ZFT1v2pzYm+qsOBhsZBI=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HrU7zBQPP0nvPbsR2IWrc7XbPrP0tfGGFWiqaqWTXfZp1xHeAvFWPX/vQHRvjn54s
         vtiaPaEZTq1XVB2kxQVUx8uln+lagto2dwK0QbYWzas65xhp71VWDeZil65pO+97He
         i+FhAw/Z706sOD2hjLJBHhec1ouW/qW3bbC9lb+A=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 405FE128185C;
        Mon, 17 Oct 2022 10:14:00 -0400 (EDT)
Message-ID: <0c6f49e95cbb9e2de9501b11b1391a5fd7b132c1.camel@HansenPartnership.com>
Subject: Re: [PATCH] scsi: mpi3mr: add explicit dependency on
 CONFIG_SCSI_SAS_ATTRS
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Michal Kubecek <mkubecek@suse.cz>,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Oct 2022 10:13:58 -0400
In-Reply-To: <20221017140533.CC46F6043B@lion.mk-sys.cz>
References: <20221017140533.CC46F6043B@lion.mk-sys.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-17 at 16:05 +0200, Michal Kubecek wrote:
> Starting with commit 42fc9fee116f ("scsi: mpi3mr: Add helper
> functions to
> manage device's port"), kernel configured with CONFIG_SCSI_MPI3MR=m
> and
> CONFIG_SCSI_SAS_ATTRS=n fails to build because modpost cannot find
> symbols
> used in mpi3mr_transport.c:
> 
>   ERROR: modpost: "sas_port_alloc_num"
> [drivers/scsi/mpi3mr/mpi3mr.ko] undefined!
>   ERROR: modpost: "sas_remove_host" [drivers/scsi/mpi3mr/mpi3mr.ko]
> undefined!
>   ERROR: modpost: "sas_phy_alloc" [drivers/scsi/mpi3mr/mpi3mr.ko]
> undefined!
>   ERROR: modpost: "sas_phy_free" [drivers/scsi/mpi3mr/mpi3mr.ko]
> undefined!
>   ...
> 
> Add an explicit dependency of CONFIG_SCSI_MPI3MR on
> CONFIG_SCSI_SAS_ATTRS
> to prevent inconsistent configs.
> 
> Fixes: 42fc9fee116f ("scsi: mpi3mr: Add helper functions to manage
> device's port")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---
>  drivers/scsi/mpi3mr/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/mpi3mr/Kconfig
> b/drivers/scsi/mpi3mr/Kconfig
> index 8997531940c2..8ada8e8d25ac 100644
> --- a/drivers/scsi/mpi3mr/Kconfig
> +++ b/drivers/scsi/mpi3mr/Kconfig
> @@ -2,7 +2,7 @@
>  
>  config SCSI_MPI3MR
>  	tristate "Broadcom MPI3 Storage Controller Device Driver"
> -	depends on PCI && SCSI
> +	depends on PCI && SCSI && SCSI_SAS_ATTRS

This should probably be select not depends.

All transport attributes are designed to be selected.  The reason is to
avoid people having to figure out what attributes they have to set in
Kconfig before they see the HBAs they're interested in.

James



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE93740AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjF1IJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:09:38 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:48366 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjF1IEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:04:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 190BC61328
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EAFC433C0;
        Wed, 28 Jun 2023 06:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687934834;
        bh=o4V8CwUewtbCKpJ1zET7N53tYmp15mah+SS3GWd3hIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2QRt8yl39g9jJDA7BDTpU5ot96H9+zf/7P3USKSmb5uI4QbDguSZGESQJNoEnjKtc
         KYG7BahQBQ7Md0IoP+oOQp8moVDiIUcsRRIZK9De1qH3Rkn/2MMrfqstAcOk2DSAYi
         eLor5T3WBsBE2t8ZLow2iYsrmwcyfPosCnAo1sWc=
Date:   Wed, 28 Jun 2023 08:47:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsi: master-ast-cf: Add MODULE_FIRMWARE macro
Message-ID: <2023062852-spirited-excitable-dabc@gregkh>
References: <20230616122040.1035518-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616122040.1035518-1-juerg.haefliger@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 02:20:40PM +0200, Juerg Haefliger wrote:
> The module loads firmware so add a MODULE_FIRMWARE macro to provide that
> information via modinfo.
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  drivers/fsi/fsi-master-ast-cf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
> index 5f608ef8b53c..1316bfd121fe 100644
> --- a/drivers/fsi/fsi-master-ast-cf.c
> +++ b/drivers/fsi/fsi-master-ast-cf.c
> @@ -1441,3 +1441,5 @@ static struct platform_driver fsi_master_acf = {
>  
>  module_platform_driver(fsi_master_acf);
>  MODULE_LICENSE("GPL");
> +
> +MODULE_FIRMWARE(FW_FILE_NAME);

No need for the extra blank line, right?

And what commit id does this fix?

thanks,

greg k-h

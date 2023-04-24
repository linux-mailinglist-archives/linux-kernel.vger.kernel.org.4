Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8E36ECC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjDXNFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjDXNFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:05:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E483E3C0F;
        Mon, 24 Apr 2023 06:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682341519; x=1713877519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XYOGH4XAmoo3Gyc8RQbwimLR7yjg6nALj5ZROFhLSYY=;
  b=GklAjTPzB+19/yi7HJUk9NDM4LayfVHBKpMFPkowy+VN+qZsd9jx0R00
   QMidf3opoQQLueS2tu1U1iDEeKhpcZlduSqRD/EwsaHYBEnXjnG1Av6A7
   M0E3Mz6jNKA0or6Ocwmgu/0TUVQdL0hQlvTYRekt+htq7QOHCIlMWIVia
   lpthkOM9fruwn6/GIo1Z8k8gyiJtG9L6u8EMTbH7vcMoGrGYO7KrH6M1Y
   OZVgEtaogjC7Kf7SzNa4BoSkysfsLKyhoblZ0vFk/vRGQjonKNaKo0M9A
   OJvpAYUy2mprnI99dRU7pKyjeKZO6quxUqslPKi9CHqtxN13DiSoWE1b4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="432719557"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="432719557"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 06:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="836959746"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="836959746"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Apr 2023 06:04:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 24 Apr 2023 16:04:40 +0300
Date:   Mon, 24 Apr 2023 16:04:40 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: mux: Remove some unneeded includes
Message-ID: <ZEZ+aPo3Ccq64l4+@kuha.fi.intel.com>
References: <1db1e8bd253cbb652835c0cef6a0a2bb9a4970eb.1682325582.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db1e8bd253cbb652835c0cef6a0a2bb9a4970eb.1682325582.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 10:39:56AM +0200, Christophe JAILLET wrote:
> This driver includes many header files that are unneeded.
> Remove them and add <linux/device.h> where devm_kzalloc() is defined.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Based on one of my script, this reduces the number of included files
> during the build process of this file from 551 to 345.
> ---
>  drivers/usb/typec/mux/gpio-sbu-mux.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
> index f62516dafe8f..c07856069d43 100644
> --- a/drivers/usb/typec/mux/gpio-sbu-mux.c
> +++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
> @@ -3,14 +3,11 @@
>   * Copyright (C) 2022 Linaro Ltd.
>   */
>  
> -#include <linux/bits.h>
> -#include <linux/i2c.h>
> -#include <linux/kernel.h>
> +#include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/platform_device.h>
> -#include <linux/regmap.h>
>  #include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_mux.h>
>  
> -- 
> 2.34.1

-- 
heikki

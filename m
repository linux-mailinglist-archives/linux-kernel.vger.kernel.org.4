Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052E66D8481
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjDERFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbjDERF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:05:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B49BB4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 10:05:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 184so7517237pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680714325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0J8BjN3v3zbxtn9Ff5pgyzXShUCpXpsxAXyIsMTyb8Y=;
        b=dSzQwxz/6d293u1whcOfGyDSj4AjNaIWfhA9/jIoXyfnoPgPjpUPkZ205+XxFN7bTl
         kDSO6T+zB9Z/iOcafUQ1EC1GaZJm+M2/XcaDRR+21rmCH9ueVQp0+gIOHC2Qz+QJT9T2
         p+ne9Juq/vR7tJS5muRlJs+wzTiTp5lbgnY7OjIhwtQTWKyIeLiXT08yDkMvKikMWM5I
         atv/1pj1CSO6kxr/nyx3XgNbfbLJ1RkLokTfTIOkhkuxAuqYRQ1SQjsC8801rn2Oiwpp
         NcY/mCiYFxeRSZUcYm0Ur3WaJk/XNUDH38FHS3Mlzy6DqAkurhYWBJZ/GuQoZNFiYM7y
         vV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680714325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J8BjN3v3zbxtn9Ff5pgyzXShUCpXpsxAXyIsMTyb8Y=;
        b=lCuYKauNSApVi34XXaL0Mbnn9k9zPXJyMjxcg790DLw52UJ77bBAOtVJu8652JjhFJ
         xYhrWAf+xXXEWhbfuSN4iS7p0vcs+WRQVZJKhvvV0KU2fC0EksHOIJO6I1GETsWVSCIR
         7s2cc6MzGqkKFwf+JFXtpIRHtyXqjXBz75Ioap9MhW3M2g9uGOOp79IBDdkU9WyA9BYT
         FrGPNi5cYdt5Lm/zhmxIefJqjvlAmDMouVdMOxGAwkL+bTMLzCY/PXyxrnkGFt5ECv2v
         8YFUiOe+XyuSjgRRV2waWM4QV3+oRqtsef5xQjBe1c2qaduLt4S17f7CuybYM40qkgqr
         Eo9Q==
X-Gm-Message-State: AAQBX9dgolrvbo1SCKhF6QPaNB7qbgRtFZgpeZQSVN+HuqXbArjXjDgO
        k+LifpmQIUUcS4cNUybRX2aGUQ==
X-Google-Smtp-Source: AKy350bSv7SP2W/HmJsUQFAOmeQBv/BRCMSDf3erD7SPH10bbiAi7s+W6emdyhqEG+1Eb1kaR2EYFw==
X-Received: by 2002:aa7:978f:0:b0:625:4b46:e019 with SMTP id o15-20020aa7978f000000b006254b46e019mr3264493pfp.9.1680714324848;
        Wed, 05 Apr 2023 10:05:24 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c807:a26a:a179:b5ec])
        by smtp.gmail.com with ESMTPSA id x24-20020a63db58000000b0050fb618800dsm9535377pgi.67.2023.04.05.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:05:24 -0700 (PDT)
Date:   Wed, 5 Apr 2023 11:05:22 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Tarak Reddy <tarak.reddy@amd.com>
Subject: Re: [PATCH v3 2/2] remoteproc: enhance rproc_put() for clusters
Message-ID: <20230405170522.GB3812912@p14s>
References: <20230328164921.1895937-1-tanmay.shah@amd.com>
 <20230328164921.1895937-3-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328164921.1895937-3-tanmay.shah@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 09:49:24AM -0700, Tanmay Shah wrote:
> This patch enhances rproc_put() to support remoteproc clusters
> with multiple child nodes as in rproc_get_by_phandle().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303221441.cuBnpvye-lkp@intel.com/
> Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v3:
>   - remove module_put call that was introduced in the patch by mistake
>   - remove redundant check in rproc_put
>   - Add inline comments in rproc_put that explains functionality
> 
> Changes in v2:
>   - Introduce this patch to fix rproc_put as per modified rproc_get_by_phandle
> 
>  drivers/remoteproc/remoteproc_core.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index a3e7c8798381..d8f28c6fe3a3 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2559,7 +2559,22 @@ EXPORT_SYMBOL(rproc_free);
>   */
>  void rproc_put(struct rproc *rproc)
>  {
> -	module_put(rproc->dev.parent->driver->owner);
> +	struct platform_device *cluster_pdev;
> +
> +	if (rproc->dev.parent->driver) {
> +		module_put(rproc->dev.parent->driver->owner);
> +	} else {
> +		/*
> +		 * If the remoteproc's parent does not have a driver,
> +		 * driver is associated with the cluster.
> +		 */
> +		cluster_pdev = of_find_device_by_node(rproc->dev.parent->of_node->parent);
> +		if (cluster_pdev) {
> +			module_put(cluster_pdev->dev.driver->owner);
> +			put_device(&cluster_pdev->dev);
> +		}
> +	}
> +

This looks good to me now.

Bjorn, please have a look at this set when you have a minute.

Thanks,
Mathieu

>  	put_device(&rproc->dev);
>  }
>  EXPORT_SYMBOL(rproc_put);
> -- 
> 2.25.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCB7626584
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 00:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiKKXYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 18:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiKKXXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 18:23:38 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6236086D7E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:23:11 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id m6so6138672pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XWmlbARZcZXJxW3BdSTeuh0BWy57Rr7NJv8STsh8cK4=;
        b=YYGhhRqDVLq1f58Yb13zQqDbHQfehve9NicwRFtgLil3We7gG7Rjr6lramnkNg9Q/e
         KyVH/rH2nrZotF1eq3/6eQXJ1YtnwDXOylz04N32Ieny/jkIbfzo3IYJJa2GKwc3jc47
         6lvCcLGaIfk1L0QYOlP1XoXN6EHbwMRgZPY1/KH6uprAFVO9xgy7blfrSmBDT7PqCxue
         ptXG/PDjvYQ0AUUIStsbVQ75MEwF7kzn8YZgXVpdVS29DcfH6hZ5qbKE6YEV8Dh1jkoi
         NIp7U71us5KLt27QNPuLxbffOSnWASkuTYiAus2bC4zookTVxbvY24stK5ZWoSG7GEZ1
         S/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWmlbARZcZXJxW3BdSTeuh0BWy57Rr7NJv8STsh8cK4=;
        b=teYGuvgyPo0WwS7nxnlv+ju+tYUa6TTf4DyumnPp+BsPRO3g2ziOkXYPv14sZr/RYX
         lk8ShHvFALrs7mexA4RqqTV2kjcEJBKeEIb1kLv5mbppkMThFRfiXqfW97rmW1t6zwrF
         FJ1DnMM//m9GTuMFezdT3kiu+7VfMIkz2633MXT/kZZ0//crdnh92lYbkRbOjkjNpa4P
         LrAEHesarSC5CHVu/DHf05s/sOh0j+X0JTxDzg87oucG2wLWuHy6QxVU1LppHGzNX0UO
         mrNffTXYylu7rdHW2o+080aZxj8kKV4hnZugC8KC315X2Bmh5TxJYrbUjh3V49IUe+me
         5CRw==
X-Gm-Message-State: ANoB5pmYwNbzR+1Ra+V9Bz593ufihSxlxOEhFz/PpEdOTOe0/2ze1D7G
        PPsXCDwiClBgYrtWC5m7wh4=
X-Google-Smtp-Source: AA0mqf4+KAVpjQr9onHHy1y9sqIAKiJoXisjIfvNhF1dp5u8bzGeyPUwZFknKQmXlogl1Wzwnyk8Fw==
X-Received: by 2002:a63:e02:0:b0:46f:81cc:5ecb with SMTP id d2-20020a630e02000000b0046f81cc5ecbmr3488527pgl.459.1668208990628;
        Fri, 11 Nov 2022 15:23:10 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:de05:ad1e:65ae:ea4d])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709027e4900b001886ff82680sm2245724pln.127.2022.11.11.15.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:23:09 -0800 (PST)
Date:   Fri, 11 Nov 2022 15:23:06 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Force synchronous probe
Message-ID: <Y27ZWnj1RDqVlUvO@google.com>
References: <20221111231302.3458191-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111231302.3458191-1-briannorris@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 03:13:01PM -0800, Brian Norris wrote:
> This reverts commit bd88b965ae8c ("platform/chrome: cros_ec_lpc: Mark
> PROBE_PREFER_ASYNCHRONOUS"), and then some.
> 
> It has been reported that there are issues with 'cros-ec-keyb' devices
> that are children of this. As noted in the initial patch for its ACPI
> support (commit ba0f32141bc5 ("Input: cros_ec_keyb - handle x86
> detachable/convertible Chromebooks")), it's possible to probe an ACPI
> child device before its parent is probed -- hence the need for
> EPROBE_DEFER. Unfortunately, poking your parent's dev_get_drvdata()
> isn't safe with asynchronous probe, as there's no locking, and the
> ordering is all wrong anyway (drvdata is set before the device is
> *really* ready).
> 
> Because this parent/child relationship has known issues, let's go the
> other direction and force synchronous probe, until we resolve the
> issues.
> 
> Possible solutions involve adding device links, so we ensure the child
> doesn't probe before the parent is done; or perhaps some other larger
> refactoring (auxiliary bus?). But that might take a little more effort
> and review, as there are many other potential sub-devices of
> cros_ec_lpc that could need patching.
> 
> Note that we don't have the same problem for non-ACPI cros-ec hosts,
> like cros-ec-spi (commit 015e4b05c377 ("platform/chrome: cros_ec_spi:
> Set PROBE_PREFER_ASYNCHRONOUS")), because its sub-devices aren't created
> until cros_ec_register(), or they don't exist at all (e.g., FPMCU uses).
> 
> Fixes: bd88b965ae8c ("platform/chrome: cros_ec_lpc: Mark PROBE_PREFER_ASYNCHRONOUS")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> 
>  drivers/platform/chrome/cros_ec_lpc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 2e4dba724ada..7fc8f82280ac 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -557,7 +557,12 @@ static struct platform_driver cros_ec_lpc_driver = {
>  		.name = DRV_NAME,
>  		.acpi_match_table = cros_ec_lpc_acpi_device_ids,
>  		.pm = &cros_ec_lpc_pm_ops,
> -		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		/*
> +		 * ACPI child devices may probe before us, and they racily
> +		 * check our drvdata pointer. Force synchronous probe until
> +		 * those races are resolved.
> +		 */
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
>  	},
>  	.probe = cros_ec_lpc_probe,
>  	.remove = cros_ec_lpc_remove,
> -- 
> 2.38.1.431.g37b22c650d-goog
> 

-- 
Dmitry

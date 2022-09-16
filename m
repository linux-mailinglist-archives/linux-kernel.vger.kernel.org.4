Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286155BAC26
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIPLQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIPLQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:16:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552ED4DF0A;
        Fri, 16 Sep 2022 04:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663326982; x=1694862982;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=m4tsBtMFhubibrEIErC2HWPG+eT5O01SBn3yQEp4Il4=;
  b=Wy2WjMNV3FfVkjxulrZvqC0Co7DSi5jjN2+ok8P2fyD734UQwKUbvJgs
   JtP8Km+AgkfP+9Lr+b6xWHXj/66qdf6pwbRVv7+dpOcaPWsSlYF+Xwh2t
   wfP116lBgX7YKm7EBDGbXPmYEVnxbNxqekEMoIDSVTPDVD4JyVQY86fKN
   /k22mmRNnMFAIiOLnAqOXz+UjnEMMxefZBgmSv2rVv/9XlPVpBrGTqdAc
   uG8tbDm7SFjZzZOcRJPYy+vBGB43MlhBcOsCEN6+g4+5HEh9nYFEPw0D1
   x0K63E2jU4nuYzenpWgldUoNlT7xCUQnJkTaSP1ioBEPYz2o0hrrwq4B9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="297694644"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="297694644"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 04:16:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="617635758"
Received: from lroque-mobl1.amr.corp.intel.com ([10.251.209.126])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 04:16:19 -0700
Date:   Fri, 16 Sep 2022 14:16:18 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Thierry Reding <treding@nvidia.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: omap: Use serial8250_em485_supported
In-Reply-To: <20220916110955.161099-1-matthias.schiffer@ew.tq-group.com>
Message-ID: <1176cc1-342f-ca4d-12a3-b237adca4ccf@linux.intel.com>
References: <20220916110955.161099-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-866213968-1663326982=:1788"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-866213968-1663326982=:1788
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 16 Sep 2022, Matthias Schiffer wrote:

> 8250_omap uses em485, fill in rs485_supported accordingly. This makes
> RS485 work with 8250_omap again, which was broken with the introduction
> of the RS485 config sanitization.
> 
> Fixes: be2e2cb1d2819 ("serial: Sanitize rs485_struct")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---

Yes, good catch. I really don't know how I managed to miss it.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

>  drivers/tty/serial/8250/8250_omap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index ff51ff91b9237..38ee3e42251af 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1337,6 +1337,7 @@ static int omap8250_probe(struct platform_device *pdev)
>  	up.port.throttle = omap_8250_throttle;
>  	up.port.unthrottle = omap_8250_unthrottle;
>  	up.port.rs485_config = serial8250_em485_config;
> +	up.port.rs485_supported = serial8250_em485_supported;
>  	up.rs485_start_tx = serial8250_em485_start_tx;
>  	up.rs485_stop_tx = serial8250_em485_stop_tx;
>  	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
> 
--8323329-866213968-1663326982=:1788--

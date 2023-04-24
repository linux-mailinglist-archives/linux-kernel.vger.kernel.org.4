Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9034A6ECC82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjDXNDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDXNDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:03:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB00246BB;
        Mon, 24 Apr 2023 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682341405; x=1713877405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VjU7Cs6ANuFlGDdmxAbDJxukg8c4rW+a7F2xcN11/eI=;
  b=IuzbjBDdecBs15jwxtYBsTQ2gFkqKjVU8s9M/ZfqTBsl1P3TC1ql/vOd
   O5xQk7MZkuiJqDEvTbfm8XaBz4a8Q/6/vOVbTx/zXVDjPbGma4VT9pvB5
   TjY+yK1O6y8YlSHaQJuClvArFwb8fcqbK2GTbCbHr96dJO4drx/JGk2cY
   qx1ZS+bqmKP4c0PtBY+N0EzXVxGtGnPmrlmTOhxTW3cn31lkbvpn/kHyp
   u15w7X2JTTWuVP/fEtVEOf6iZjU1pasOGwsZlB1irVgQwEwo6HvVnZDAk
   w2xTq/iVo9dqYRrrB0L4EfP7v9JOjdYb9DGz6WCaAjAX86DtYf4BzaYHg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="432719123"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="432719123"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 06:03:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="836959081"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="836959081"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Apr 2023 06:03:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 24 Apr 2023 16:03:21 +0300
Date:   Mon, 24 Apr 2023 16:03:21 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Suhui <suhui@nfschina.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: remove unnecessary (void*) conversions
Message-ID: <ZEZ+GUsvaqWg6A3W@kuha.fi.intel.com>
References: <20230424041940.132866-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424041940.132866-1-suhui@nfschina.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 12:19:40PM +0800, Suhui wrote:
> No need cast (void*) to (struct fusb302_chip *) or (struct tcpm_port *).
> 
> Signed-off-by: Suhui <suhui@nfschina.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 2 +-
>  drivers/usb/typec/tcpm/tcpm.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 1ffce00d94b4..4b7b8f6af3ca 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -190,7 +190,7 @@ static void fusb302_log(struct fusb302_chip *chip, const char *fmt, ...)
>  
>  static int fusb302_debug_show(struct seq_file *s, void *v)
>  {
> -	struct fusb302_chip *chip = (struct fusb302_chip *)s->private;
> +	struct fusb302_chip *chip = s->private;
>  	int tail;
>  
>  	mutex_lock(&chip->logbuffer_lock);
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 1ee774c263f0..ab3a54662ed9 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -737,7 +737,7 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
>  
>  static int tcpm_debug_show(struct seq_file *s, void *v)
>  {
> -	struct tcpm_port *port = (struct tcpm_port *)s->private;
> +	struct tcpm_port *port = s->private;
>  	int tail;
>  
>  	mutex_lock(&port->logbuffer_lock);
> -- 
> 2.30.2

-- 
heikki

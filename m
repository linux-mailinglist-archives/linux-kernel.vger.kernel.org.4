Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0246B7264
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjCMJUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjCMJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:20:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB0048E04;
        Mon, 13 Mar 2023 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678699221; x=1710235221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=z48Dt41jUPpWFgRiFOFaWk0SesIyGwE2aOV5PIzs1Bg=;
  b=aoSHmyii2qVulkj8R9/5V8tdnejs8HT2KFQtoB6JkBJtlg7rxRjxnQKb
   3FkZCcvwmcIgls36t/h0ah2i7Lg/AhSjMfGEBaGz7misCuMPpF9rrCHSi
   JM0WmqMGmBN4enJKdJ5oeK5972LKAxg1yeaVfhltAeA8qf9TQfyB7E3u5
   VlieSvCOOQY9KExMbIN/gLuSFQNGUgPLasBJEm1Wj+CYwytcyx1tyrXlg
   yc/q28rzNs2DQqty2yN2WPbZQcRnXSy0mRumVkbd3Znx94Zq7Y2oMcLFk
   p7dYnM51xbkuh+Paz47VTi42qkK+Ltm+BZHReOXvHMJXW/uWCwyFuHsDg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="338649237"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="338649237"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 02:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="821877478"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="821877478"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 13 Mar 2023 02:20:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 13 Mar 2023 11:20:16 +0200
Date:   Mon, 13 Mar 2023 11:20:16 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: fusb302: mark OF related data as maybe
 unused
Message-ID: <ZA7q0PkvhB5i4CS8@kuha.fi.intel.com>
References: <20230310222937.315773-1-krzysztof.kozlowski@linaro.org>
 <20230310222937.315773-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310222937.315773-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 11:29:37PM +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>   drivers/usb/typec/tcpm/fusb302.c:1816:34: error: ‘fusb302_dt_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Should this be marked as a fix?

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 1ffce00d94b4..592b0aec782f 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1813,7 +1813,7 @@ static int fusb302_pm_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static const struct of_device_id fusb302_dt_match[] = {
> +static const struct of_device_id fusb302_dt_match[] __maybe_unused = {
>  	{.compatible = "fcs,fusb302"},
>  	{},
>  };
> -- 
> 2.34.1

-- 
heikki

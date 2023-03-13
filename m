Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830C96B725E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCMJTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCMJT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:19:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9A11EBDA;
        Mon, 13 Mar 2023 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678699167; x=1710235167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JpuCRu1GG8Ay6QwoKuqG2ToqnJydDbTDsesR+u7/c0o=;
  b=BRPU9koiFCSU6YgvA+pQhYj6BjYoJfT/1mWfbZsNo+4pScAecVlyMRfF
   TMVpdFIVYWNd7p7bj0THABVp0oz3J7EW+yWhjawE2j6Ah8IpF13B0ICYY
   zY7hYvCfVfpZRsceg29lgioC4+Dp6p6EaWTDCVTmB06rk1Odz35hKAn4A
   fgKEDDSY7JOXje+iXHsHjqd1WNu5wrN94cm9yJJYvQf3RjZ/aKtZRd8cv
   0DpaNm8f0qlW+J9NLjzYEkYhBKWeKRQKXNESdn2D4WBj8YEcnwhJHDBlq
   g+hY7jYMUxfLxNQrUnnTWoPPDDgL/pAxL2KbRqNvLitoXDe8SGcUZTxgn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="338649075"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="338649075"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 02:19:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="821876852"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="821876852"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 13 Mar 2023 02:19:24 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 13 Mar 2023 11:19:23 +0200
Date:   Mon, 13 Mar 2023 11:19:23 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: hd3ss3220: Drop of_match_ptr for ID table
Message-ID: <ZA7qmz7DjRiIE9BB@kuha.fi.intel.com>
References: <20230310222937.315773-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310222937.315773-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 11:29:36PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).
> 
>   drivers/usb/typec/hd3ss3220.c:284:34: error: ‘dev_ids’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/hd3ss3220.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index 746ef3a75b76..8bbeb9b1e439 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -290,7 +290,7 @@ MODULE_DEVICE_TABLE(of, dev_ids);
>  static struct i2c_driver hd3ss3220_driver = {
>  	.driver = {
>  		.name = "hd3ss3220",
> -		.of_match_table = of_match_ptr(dev_ids),
> +		.of_match_table = dev_ids,
>  	},
>  	.probe_new = hd3ss3220_probe,
>  	.remove =  hd3ss3220_remove,
> -- 
> 2.34.1

-- 
heikki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0CA702DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242219AbjEONKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242205AbjEONKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:10:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F58C2D49;
        Mon, 15 May 2023 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684156178; x=1715692178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mN86vB30umdkiNNMC51DwKrQ3kdN0DjtgJpVmuFVIzQ=;
  b=gd9wM+5Dca1tgxoyNkWbESnCBRtn7HfST/g98KwzyJRtUWYrjZqwgW9W
   uxbm2tmtEFTPejZyTE3qPvsxHFlQVipf/MLn3PR1FSIdT5N+fvox7hEKZ
   YmFDog9L7U9vuqbFbZSRAOXPIRhHv94Q6p4b6w8jvBuXQ6O8yDRE4LFdP
   EMLs1YHfJE7GjVmsMeSt7mxDezNB18TkYdanWPpEjVsndl4xMFyI0v68s
   9yAnl2BsqRXkUYjeX57EpCRPLuR84VVyo7l9A6842oz5Zjd4f2I3s4rLS
   T2xWgLBNlIhSVR35uazOrHfsiym7wHDagbx0tbgLUqejJJKD1HDIqPNLq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="437536261"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="437536261"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 06:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="845256782"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="845256782"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 15 May 2023 06:09:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 May 2023 16:09:14 +0300
Date:   Mon, 15 May 2023 16:09:14 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     bryan.odonoghue@linaro.org, linux@roeck-us.net, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: qcom: set pm8150b_typec_res
 storage-class-specifier to static
Message-ID: <ZGIu+tmiMRH64luT@kuha.fi.intel.com>
References: <20230515114043.3452010-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515114043.3452010-1-trix@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 07:40:43AM -0400, Tom Rix wrote:
> smatch reports
> drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c:323:29: warning: symbol
>   'pm8150b_typec_res' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> index 191458ce4a06..937e855a6c4c 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> @@ -320,7 +320,7 @@ static struct pmic_typec_port_resources pm8150b_port_res = {
>  	.nr_irqs = 7,
>  };
>  
> -struct pmic_typec_resources pm8150b_typec_res = {
> +static struct pmic_typec_resources pm8150b_typec_res = {
>  	.pdphy_res = &pm8150b_pdphy_res,
>  	.port_res = &pm8150b_port_res,
>  };

-- 
heikki

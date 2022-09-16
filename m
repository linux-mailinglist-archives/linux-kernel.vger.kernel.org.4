Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53F95BAF36
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiIPOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiIPOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:24:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BD82CDC8;
        Fri, 16 Sep 2022 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663338283; x=1694874283;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xjBzwUqb8jHwtsdnaFdl5y3s0GzS9ZhCO/JEXoWOV0w=;
  b=U7Z9WWVmOsRnw+QpULUinJWEtvKDshbfoteQpe8yknGlM/uQBYoRa3b2
   /EaLqjVYVN0NXanYxuurLXnANSx2xrB52d1YM1Dvnm6DDdE4btKchaPYr
   eFvezVGWVNZIlvJuiUFM2cOUF58U/Yh3r+OZOC81+HuaOqe5bcvDuZH6i
   2w5DZSYn79DK7egWs6vZ6DsY6EhIksL+08xxCddic2gSrW+m+3UbUYTWr
   6Mhdhursfpei2y8o+Q+COHHJmNM2ma1WKOi8gxINME3k3B03LYw3xt76O
   GmeS+SrnvRAr/PiFYp2yVpY7DYmDzQg64PEDYgX+MJKRtQWc7vrkLFEI1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="298994157"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="298994157"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:24:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="650889151"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56]) ([10.252.61.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:24:33 -0700
Message-ID: <78c9421e-d66a-3477-9dff-f819e1ac9414@linux.intel.com>
Date:   Fri, 16 Sep 2022 16:22:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] soundwire: qcom: do not send status of device 0
 during alert
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com, quic_srivasam@quicinc.com
References: <20220916135352.19114-1-srinivas.kandagatla@linaro.org>
 <20220916135352.19114-2-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220916135352.19114-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/22 15:53, Srinivas Kandagatla wrote:
> Device0 can not be in alter status. And for consistency reasons do not

typo: alert

> send status of device0 to core.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index d3ce580cdeaf..a04a8863b228 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -428,7 +428,7 @@ static int qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
>  
>  	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
>  
> -	for (dev_num = 0; dev_num <= SDW_MAX_DEVICES; dev_num++) {
> +	for (dev_num = 1; dev_num <= SDW_MAX_DEVICES; dev_num++) {
>  		status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
>  
>  		if ((status & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {

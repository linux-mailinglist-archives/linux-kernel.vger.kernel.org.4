Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54EC67B94F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjAYS2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbjAYS2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:28:47 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C43F13DFB;
        Wed, 25 Jan 2023 10:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674671325; x=1706207325;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QUntNSy9QS1Y5mSs6Ip9AYoFE6rHpgC6NI4Y7knMq7I=;
  b=om3Lfh8Wl99M45hrHvgWiHqaX3nKHccwjmcgzRNtgjEKynli5mFxbhTL
   E2J0/3ges9MvkqvHPWy6+4iXHhZ3gtae5GUBGYIxawfm2GxtZq1qlk/Pf
   RssLoZ7Wo5Z2mtYc+m0OL7IpqZCSVTfk6R4bhDLvM9DUl6NlSd3rO37Ch
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Jan 2023 10:28:43 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:28:43 -0800
Received: from [10.110.65.87] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 10:28:43 -0800
Message-ID: <59bf1f6e-60df-160a-a343-11a482eec586@quicinc.com>
Date:   Wed, 25 Jan 2023 10:28:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] soc: qcom: socinfo: Add support for new field in revision
 17
To:     Naman Jain <quic_namajain@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
References: <20230125081407.31833-1-quic_namajain@quicinc.com>
Content-Language: en-US
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230125081407.31833-1-quic_namajain@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/2023 12:14 AM, Naman Jain wrote:
> Add support for new field coming with socinfo structure under v17 to get
> hardware platform's oem variant id. This is to enable OEMs to have minor
> changes in the board, but to use the same platform subtype as the one
> supported by Qualcomm. The new field is to be used in platform overlay
> file. Default value is 0, reserved for Qualcomm platforms. Also, add
> debugfs support to read this field for a device.
> 
> Change-Id: I18f80084bc75466f3fcccd55fd21b37d69245aa6

I don't see SOB line. Please remove Change-ID. Run checkpatch?

> ---
>   drivers/soc/qcom/socinfo.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 10efdbcfdf05..10cdd32ce74d 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -174,6 +174,8 @@ struct socinfo {
>   	__le32  pcode;
>   	__le32  npartnamemap_offset;
>   	__le32  nnum_partname_mapping;
> +	/* Version 17 */
> +	__le32 oem_variant;
>   };
>   
>   #ifdef CONFIG_DEBUG_FS
> @@ -196,6 +198,7 @@ struct socinfo_params {
>   	u32 nmodem_supported;
>   	u32 feature_code;
>   	u32 pcode;
> +	u32 oem_variant;
>   };
>   
>   struct smem_image_version {
> @@ -519,6 +522,11 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
>   			   &qcom_socinfo->info.fmt);
>   
>   	switch (qcom_socinfo->info.fmt) {
> +	case SOCINFO_VERSION(0, 17):
> +		qcom_socinfo->info.oem_variant = __le32_to_cpu(info->oem_variant);
> +		debugfs_create_u32("oem_variant", 0444, qcom_socinfo->dbg_root,
> +				   &qcom_socinfo->info.oem_variant);
> +		fallthrough;
>   	case SOCINFO_VERSION(0, 16):
>   		qcom_socinfo->info.feature_code = __le32_to_cpu(info->feature_code);
>   		qcom_socinfo->info.pcode = __le32_to_cpu(info->pcode);

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FBF666711
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjAKXTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjAKXTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:19:30 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C973C0C2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 15:19:28 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id g14so17583215ljh.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 15:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mC5m0TUcxUCYj+K6Vrt74XfJKXwtL5Pl6atowem6kR0=;
        b=kRJjWVWd8ykMNyErYET8dVGwXEu36d1MZDo272nyRNqA4NJAfEBj9je4s/wsADbu0E
         mx+gZL4bIfrxz3wcM2G26wusBuYhCHZEL8n9FJYSVSWFaw7lb9SMAeyDeI1y75nfpn4G
         ePSdXBrbQJu5EmIdbocTt6CutE94UMbdajPsxh4kBJOQ52FtcoYmwUTi+3NC84MJYD9h
         AH0N9+dV3b1DRaNgdtC1g6di+xY70D5TBDHFKKG20WQzWBAvZkfWXJcgsEWxFcCR17xv
         TkIzLcA3tOLraPPY8srk5ZfmTnEP6jMDCcPKzOyBQGFp71aj3+XBvC1PDy275HjUNL/4
         ghQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mC5m0TUcxUCYj+K6Vrt74XfJKXwtL5Pl6atowem6kR0=;
        b=j3xNd8to6sSnVLfZTgd7AtVGtizMymaAkKeKQjcU+mnInuOYoWDebNDGUpN9Jzkhli
         WEGBFJDtDhet8O5ktevO1FRuYjDqmmFXikzwuych+xSHbPOLVc5FvSWpFCWTLA2JpvHq
         3e2DCeRntQ8bECoRDo7PkXFMQjlqy5okzFG8LoM42LIURfaTj5Q2xHLXvuhlzB46J3YX
         G1iL5HU9l7i2NVghoScZEXeOtR+ZXFCPpADUcgbVn8NMZG/Qxpe3PueX4KWlRaNp5whV
         3fApJYwahE40h8ZIFB/gmt571s2Mw/gKP+QnE48mj5t5RM8Kw8TKA8mMXfV2S9gKv2F3
         At6g==
X-Gm-Message-State: AFqh2ko8PIOsz5wprzVMbY58LxokGmtv3yJdihF3Nlv/vD8Sv/ODtv9A
        +LhLknic6B7s1r+JXjupWi0h/g==
X-Google-Smtp-Source: AMrXdXsfsyzEhotBfXDjDajSkYz7NBRWL2/mFEKY5xBt/06pWM8e+wO07fI8DN43jQGZ3eK1xi6LfQ==
X-Received: by 2002:a2e:9b92:0:b0:27f:ed3e:8c80 with SMTP id z18-20020a2e9b92000000b0027fed3e8c80mr9189878lji.52.1673479166984;
        Wed, 11 Jan 2023 15:19:26 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u6-20020a05651220c600b004cc865fdfdfsm1543437lfr.89.2023.01.11.15.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 15:19:26 -0800 (PST)
Message-ID: <08ffedc3-3104-18fc-4813-287eccd1fdca@linaro.org>
Date:   Thu, 12 Jan 2023 01:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] soc: qcom: socinfo: Add sysfs attributes for fields
 in v2-v6
Content-Language: en-GB
To:     Naman Jain <quic_namajain@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com
References: <20230111082141.18109-1-quic_namajain@quicinc.com>
 <20230111082141.18109-3-quic_namajain@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230111082141.18109-3-quic_namajain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 10:21, Naman Jain wrote:
> Add support in sysfs custom attributes for fields in socinfo version
> v2-v6. This is to support SoC based operations in userland scripts
> and test scripts. Also, add name mappings for hw-platform type to
> make the sysfs information more descriptive.

Please include a patch documenting your additions to 
Documentation/ABI/testing/sysfs-devices-soc. Please describe usecases 
for new attributes and their applicability to non-Qualcomm boards.

Note, that testing scripts can access debugfs entries without any issues.

> 
> Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
> ---
>   drivers/soc/qcom/socinfo.c | 181 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 181 insertions(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 251c0fd94962..ff92064c2246 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -41,6 +41,52 @@
>    */
>   #define SMEM_HW_SW_BUILD_ID            137
>   
> +enum {
> +	HW_PLATFORM_UNKNOWN = 0,
> +	HW_PLATFORM_SURF = 1,
> +	HW_PLATFORM_FFA = 2,
> +	HW_PLATFORM_FLUID = 3,
> +	HW_PLATFORM_SVLTE_FFA = 4,
> +	HW_PLATFORM_SVLTE_SURF = 5,
> +	HW_PLATFORM_MTP_MDM = 7,
> +	HW_PLATFORM_MTP = 8,
> +	HW_PLATFORM_LIQUID = 9,
> +	HW_PLATFORM_DRAGON = 10,
> +	HW_PLATFORM_QRD = 11,
> +	HW_PLATFORM_HRD = 13,
> +	HW_PLATFORM_DTV = 14,
> +	HW_PLATFORM_RCM = 21,
> +	HW_PLATFORM_STP = 23,
> +	HW_PLATFORM_SBC = 24,
> +	HW_PLATFORM_HDK = 31,
> +	HW_PLATFORM_ATP = 33,
> +	HW_PLATFORM_IDP = 34,
> +	HW_PLATFORM_INVALID
> +};
> +
> +static const char * const hw_platform[] = {
> +	[HW_PLATFORM_UNKNOWN] = "Unknown",
> +	[HW_PLATFORM_SURF] = "Surf",
> +	[HW_PLATFORM_FFA] = "FFA",
> +	[HW_PLATFORM_FLUID] = "Fluid",
> +	[HW_PLATFORM_SVLTE_FFA] = "SVLTE_FFA",
> +	[HW_PLATFORM_SVLTE_SURF] = "SLVTE_SURF",
> +	[HW_PLATFORM_MTP_MDM] = "MDM_MTP_NO_DISPLAY",
> +	[HW_PLATFORM_MTP] = "MTP",
> +	[HW_PLATFORM_RCM] = "RCM",
> +	[HW_PLATFORM_LIQUID] = "Liquid",
> +	[HW_PLATFORM_DRAGON] = "Dragon",
> +	[HW_PLATFORM_QRD] = "QRD",
> +	[HW_PLATFORM_HRD] = "HRD",
> +	[HW_PLATFORM_DTV] = "DTV",
> +	[HW_PLATFORM_STP] = "STP",
> +	[HW_PLATFORM_SBC] = "SBC",
> +	[HW_PLATFORM_HDK] = "HDK",
> +	[HW_PLATFORM_ATP] = "ATP",
> +	[HW_PLATFORM_IDP] = "IDP",
> +	[HW_PLATFORM_INVALID] = "Invalid",
> +};

This is not a property of the SoC. It is a property of the device. As 
such it should not be part of /sys/bus/soc devices.

You can find board description in /sys/firmware/devicetree/base/model

> +
>   #ifdef CONFIG_DEBUG_FS
>   #define SMEM_IMAGE_VERSION_BLOCKS_COUNT        32
>   #define SMEM_IMAGE_VERSION_SIZE                4096
> @@ -368,6 +414,140 @@ static const struct soc_id soc_id[] = {
>   	{ qcom_board_id(QRU1062) },
>   };
>   
> +/* sysfs attributes */
> +#define ATTR_DEFINE(param) \
> +	static DEVICE_ATTR(param, 0644, qcom_get_##param, NULL)
> +
> +/* Version 2 */
> +static ssize_t
> +qcom_get_raw_id(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			 le32_to_cpu(soc_info->raw_id));
> +}
> +ATTR_DEFINE(raw_id);
> +
> +static ssize_t
> +qcom_get_raw_version(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			 le32_to_cpu(soc_info->raw_ver));
> +}
> +ATTR_DEFINE(raw_version);

Why are they raw? can you unraw them?

Whose version and id are these attributes referring to?

> +
> +/* Version 3 */
> +static ssize_t
> +qcom_get_hw_platform(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	uint32_t hw_plat = le32_to_cpu(soc_info->hw_plat);
> +
> +	hw_plat = (hw_plat >= HW_PLATFORM_INVALID) ? HW_PLATFORM_INVALID : hw_plat;
> +	return scnprintf(buf, PAGE_SIZE, "%-.32s\n",
> +			hw_platform[hw_plat]);
> +}
> +ATTR_DEFINE(hw_platform);
> +
> +/* Version 4 */
> +static ssize_t
> +qcom_get_platform_version(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			 le32_to_cpu(soc_info->plat_ver));
> +}
> +ATTR_DEFINE(platform_version);
> +
> +/* Version 5 */
> +static ssize_t
> +qcom_get_accessory_chip(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			le32_to_cpu(soc_info->accessory_chip));
> +}
> +ATTR_DEFINE(accessory_chip);

If this an _accessory_ chip, there should be a separate soc device 
describing it, rather than stuffing information into the soc0.

> +
> +/* Version 6 */
> +static ssize_t
> +qcom_get_platform_subtype_id(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +			 le32_to_cpu(soc_info->hw_plat_subtype));
> +}
> +ATTR_DEFINE(platform_subtype_id);

Again, this is the board property, not an SoC one.

> +
> +static struct attribute *qcom_custom_socinfo_attrs[7];
> +
> +static const struct attribute_group custom_soc_attr_group = {
> +	.attrs = qcom_custom_socinfo_attrs,
> +};
> +
> +static void qcom_socinfo_populate_sysfs(struct qcom_socinfo *qcom_socinfo)
> +{
> +	int i = 0, socinfo_format = le32_to_cpu(soc_info->fmt);
> +
> +	/* Note: qcom_custom_socinfo_attrs[] size needs to be in sync with attributes added here. */
> +	switch (socinfo_format) {
> +	case SOCINFO_VERSION(0, 16):
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 15):
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 14):
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 13):
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 12):
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 11):
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 10):
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 9):
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 8):
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 7):
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 6):
> +		qcom_custom_socinfo_attrs[i++] =
> +			&dev_attr_platform_subtype_id.attr;
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 5):
> +		qcom_custom_socinfo_attrs[i++] = &dev_attr_accessory_chip.attr;
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 4):
> +		qcom_custom_socinfo_attrs[i++] = &dev_attr_platform_version.attr;
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 3):
> +		qcom_custom_socinfo_attrs[i++] = &dev_attr_hw_platform.attr;
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 2):
> +		qcom_custom_socinfo_attrs[i++] = &dev_attr_raw_id.attr;
> +		qcom_custom_socinfo_attrs[i++] = &dev_attr_raw_version.attr;
> +		fallthrough;
> +	case SOCINFO_VERSION(0, 1):
> +		break;
> +	default:
> +		pr_err("Unknown socinfo format: v%u.%u\n",
> +				SOCINFO_MAJOR(socinfo_format),
> +				SOCINFO_MINOR(socinfo_format));
> +		break;
> +	}
> +
> +	qcom_custom_socinfo_attrs[i] = NULL;
> +	qcom_socinfo->attr.custom_attr_group = &custom_soc_attr_group;
> +}
> +
>   static const char *socinfo_machine(struct device *dev, unsigned int id)
>   {
>   	int idx;
> @@ -696,6 +876,7 @@ static int qcom_socinfo_probe(struct platform_device *pdev)
>   							"%u",
>   							le32_to_cpu(soc_info->serial_num));
>   
> +	qcom_socinfo_populate_sysfs(qs);
>   	qs->soc_dev = soc_device_register(&qs->attr);
>   	if (IS_ERR(qs->soc_dev))
>   		return PTR_ERR(qs->soc_dev);

-- 
With best wishes
Dmitry


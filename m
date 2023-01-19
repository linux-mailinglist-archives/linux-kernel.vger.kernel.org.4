Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E50F673496
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjASJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjASJji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:39:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A23D5D93F;
        Thu, 19 Jan 2023 01:39:30 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J7iHnI014270;
        Thu, 19 Jan 2023 09:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6BDPe1O5q0Or0stDsxL2U2nOzoBcM5eRR5V1Mpp772k=;
 b=UlMNRsITk0jxhfF/OfXrNmvJxfnlPi8+YON+vHiYrmWihBPwrioo5NQS5Y62DgjjkMQC
 MinPVTy1pLm+hKJjT5V+/tIMgsUUpvVBWUw1/62ViXweE7CiV3i74MgxSUB+RyJSGxRc
 YDzGQJPD+/EVYllyx9LLBomdPYxoj4wvg0GyuIcHMSxqf4kUvl2h10hm8SLeAxnhSVap
 Bh+ELXGNSYW5VgUV1czekVfqLgHOQstFN4wX2Z5z/u3bOOg01HzKwLrIwEKUnmymsSeQ
 X60JevmI1GEqxxp7Bam99FfFNasObfMajPGdeoP6pH2YwKn0wQRUrqoXhNeqsg4UBQif QA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6xktgunt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 09:39:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J9dN8w030328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 09:39:23 GMT
Received: from [10.214.82.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 01:39:19 -0800
Message-ID: <b623e046-8dbc-3a07-7e16-d22b762c4122@quicinc.com>
Date:   Thu, 19 Jan 2023 15:09:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] soc: qcom: socinfo: Add sysfs attributes for fields
 in v2-v6
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>,
        "Shiraz Hashim" <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>
References: <20230111082141.18109-1-quic_namajain@quicinc.com>
 <20230111082141.18109-3-quic_namajain@quicinc.com>
 <08ffedc3-3104-18fc-4813-287eccd1fdca@linaro.org>
From:   Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <08ffedc3-3104-18fc-4813-287eccd1fdca@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xwv8j4nuP67nbJ1Tm4ewZWfkUVVsVpEE
X-Proofpoint-GUID: xwv8j4nuP67nbJ1Tm4ewZWfkUVVsVpEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_07,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1011 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190077
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dmitry for reviewing the patches. Sorry, for replying late on 
your email, I wanted to collect all the information, before I do it.

On 1/12/2023 4:49 AM, Dmitry Baryshkov wrote:
> On 11/01/2023 10:21, Naman Jain wrote:
>> Add support in sysfs custom attributes for fields in socinfo version
>> v2-v6. This is to support SoC based operations in userland scripts
>> and test scripts. Also, add name mappings for hw-platform type to
>> make the sysfs information more descriptive.
>
> Please include a patch documenting your additions to 
> Documentation/ABI/testing/sysfs-devices-soc. Please describe usecases 
> for new attributes and their applicability to non-Qualcomm boards.
>

The fields added here, are applicable to Qualcomm boards only. I can 
include in the same file sysfs-devices-soc, mentioning the same that it 
is Qcom specific, or I can create a new file for this, 
sysfs-devices-soc-qcom, however you suggest. Mentioning the use cases, 
later in the mail.


> Note, that testing scripts can access debugfs entries without any issues.


Yes, that is right. Thanks.


>
>>
>> Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
>> ---
>>   drivers/soc/qcom/socinfo.c | 181 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 181 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
>> index 251c0fd94962..ff92064c2246 100644
>> --- a/drivers/soc/qcom/socinfo.c
>> +++ b/drivers/soc/qcom/socinfo.c
>> @@ -41,6 +41,52 @@
>>    */
>>   #define SMEM_HW_SW_BUILD_ID            137
>>   +enum {
>> +    HW_PLATFORM_UNKNOWN = 0,
>> +    HW_PLATFORM_SURF = 1,
>> +    HW_PLATFORM_FFA = 2,
>> +    HW_PLATFORM_FLUID = 3,
>> +    HW_PLATFORM_SVLTE_FFA = 4,
>> +    HW_PLATFORM_SVLTE_SURF = 5,
>> +    HW_PLATFORM_MTP_MDM = 7,
>> +    HW_PLATFORM_MTP = 8,
>> +    HW_PLATFORM_LIQUID = 9,
>> +    HW_PLATFORM_DRAGON = 10,
>> +    HW_PLATFORM_QRD = 11,
>> +    HW_PLATFORM_HRD = 13,
>> +    HW_PLATFORM_DTV = 14,
>> +    HW_PLATFORM_RCM = 21,
>> +    HW_PLATFORM_STP = 23,
>> +    HW_PLATFORM_SBC = 24,
>> +    HW_PLATFORM_HDK = 31,
>> +    HW_PLATFORM_ATP = 33,
>> +    HW_PLATFORM_IDP = 34,
>> +    HW_PLATFORM_INVALID
>> +};
>> +
>> +static const char * const hw_platform[] = {
>> +    [HW_PLATFORM_UNKNOWN] = "Unknown",
>> +    [HW_PLATFORM_SURF] = "Surf",
>> +    [HW_PLATFORM_FFA] = "FFA",
>> +    [HW_PLATFORM_FLUID] = "Fluid",
>> +    [HW_PLATFORM_SVLTE_FFA] = "SVLTE_FFA",
>> +    [HW_PLATFORM_SVLTE_SURF] = "SLVTE_SURF",
>> +    [HW_PLATFORM_MTP_MDM] = "MDM_MTP_NO_DISPLAY",
>> +    [HW_PLATFORM_MTP] = "MTP",
>> +    [HW_PLATFORM_RCM] = "RCM",
>> +    [HW_PLATFORM_LIQUID] = "Liquid",
>> +    [HW_PLATFORM_DRAGON] = "Dragon",
>> +    [HW_PLATFORM_QRD] = "QRD",
>> +    [HW_PLATFORM_HRD] = "HRD",
>> +    [HW_PLATFORM_DTV] = "DTV",
>> +    [HW_PLATFORM_STP] = "STP",
>> +    [HW_PLATFORM_SBC] = "SBC",
>> +    [HW_PLATFORM_HDK] = "HDK",
>> +    [HW_PLATFORM_ATP] = "ATP",
>> +    [HW_PLATFORM_IDP] = "IDP",
>> +    [HW_PLATFORM_INVALID] = "Invalid",
>> +};
>
> This is not a property of the SoC. It is a property of the device. As 
> such it should not be part of /sys/bus/soc devices.


I understand your point. The Socinfo structure as such on Qualcomm SoC 
gives not just SoC related information but also many other info like 
serial number, platform subtype etc. Now in order to support the 
usecases below, we are proposing sysfs interface extension, as we can't 
use debugfs interface in production/end user devices due to debugfs 
access restrictions.

Use cases:

1. In post-boot shell scripts, for various chip specific operations, 
that are relevant to that particular chip/board only:

     a. Setting kernel parameters using sysfs interfaces etc.

     b. Enabling particular traces, logs

     c. Changing permissions to certain paths

     d. Start a userspace service, and pass custom parameters to it on 
the fly

     e. Set certain device properties using setprop

     f. Miscellaneous things like DCC (Data Capture and Compare Engine) etc.

2. In userspace services, that depend on SoC information, for its 
configuration. Eg: Audio, Connectivity services use these.

3. adb needs device serial number, sensors need SoC information to 
decide its configuration.


>
> You can find board description in /sys/firmware/devicetree/base/model


Thanks for pointing this out. This is giving useful information on the 
chip and hw_platform, but the problem is that we need other fields as 
well, which we may want to use. Hence the ask.

model = "Qualcomm Technologies, Inc. Kalama MTP";


>
>> +
>>   #ifdef CONFIG_DEBUG_FS
>>   #define SMEM_IMAGE_VERSION_BLOCKS_COUNT        32
>>   #define SMEM_IMAGE_VERSION_SIZE                4096
>> @@ -368,6 +414,140 @@ static const struct soc_id soc_id[] = {
>>       { qcom_board_id(QRU1062) },
>>   };
>>   +/* sysfs attributes */
>> +#define ATTR_DEFINE(param) \
>> +    static DEVICE_ATTR(param, 0644, qcom_get_##param, NULL)
>> +
>> +/* Version 2 */
>> +static ssize_t
>> +qcom_get_raw_id(struct device *dev,
>> +        struct device_attribute *attr,
>> +        char *buf)
>> +{
>> +    return scnprintf(buf, PAGE_SIZE, "%u\n",
>> +             le32_to_cpu(soc_info->raw_id));
>> +}
>> +ATTR_DEFINE(raw_id);
>> +
>> +static ssize_t
>> +qcom_get_raw_version(struct device *dev,
>> +        struct device_attribute *attr,
>> +        char *buf)
>> +{
>> +    return scnprintf(buf, PAGE_SIZE, "%u\n",
>> +             le32_to_cpu(soc_info->raw_ver));
>> +}
>> +ATTR_DEFINE(raw_version);
>
> Why are they raw? can you unraw them?
>
> Whose version and id are these attributes referring to?


So basically, when we call them raw, it essentially means that it is not 
parsed as such (different bits may be giving different information, and 
the whole value may mean nothing).

*version* refers to the chip version, which can be like v1, v2, v1.1 etc 
in real terms. Its raw value is used to map it to one of these versions. 
*id* is used as chip ID for QC SoCs for using JTAG. It is different than 
the soc_id that we have.


>
>> +
>> +/* Version 3 */
>> +static ssize_t
>> +qcom_get_hw_platform(struct device *dev,
>> +        struct device_attribute *attr,
>> +        char *buf)
>> +{
>> +    uint32_t hw_plat = le32_to_cpu(soc_info->hw_plat);
>> +
>> +    hw_plat = (hw_plat >= HW_PLATFORM_INVALID) ? HW_PLATFORM_INVALID 
>> : hw_plat;
>> +    return scnprintf(buf, PAGE_SIZE, "%-.32s\n",
>> +            hw_platform[hw_plat]);
>> +}
>> +ATTR_DEFINE(hw_platform);
>> +
>> +/* Version 4 */
>> +static ssize_t
>> +qcom_get_platform_version(struct device *dev,
>> +        struct device_attribute *attr,
>> +        char *buf)
>> +{
>> +    return scnprintf(buf, PAGE_SIZE, "%u\n",
>> +             le32_to_cpu(soc_info->plat_ver));
>> +}
>> +ATTR_DEFINE(platform_version);
>> +
>> +/* Version 5 */
>> +static ssize_t
>> +qcom_get_accessory_chip(struct device *dev,
>> +        struct device_attribute *attr,
>> +        char *buf)
>> +{
>> +    return scnprintf(buf, PAGE_SIZE, "%u\n",
>> +            le32_to_cpu(soc_info->accessory_chip));
>> +}
>> +ATTR_DEFINE(accessory_chip);
>
> If this an _accessory_ chip, there should be a separate soc device 
> describing it, rather than stuffing information into the soc0.
>

This is used as a boolean currently to tell us whether SoC has an 
accessory chip or not.


>> +
>> +/* Version 6 */
>> +static ssize_t
>> +qcom_get_platform_subtype_id(struct device *dev,
>> +        struct device_attribute *attr,
>> +        char *buf)
>> +{
>> +    return scnprintf(buf, PAGE_SIZE, "%u\n",
>> +             le32_to_cpu(soc_info->hw_plat_subtype));
>> +}
>> +ATTR_DEFINE(platform_subtype_id);
>
> Again, this is the board property, not an SoC one.


Same justification as one of my previous comments.


>
>> +
>> +static struct attribute *qcom_custom_socinfo_attrs[7];
>> +
>> +static const struct attribute_group custom_soc_attr_group = {
>> +    .attrs = qcom_custom_socinfo_attrs,
>> +};
>> +
>> +static void qcom_socinfo_populate_sysfs(struct qcom_socinfo 
>> *qcom_socinfo)
>> +{
>> +    int i = 0, socinfo_format = le32_to_cpu(soc_info->fmt);
>> +
>> +    /* Note: qcom_custom_socinfo_attrs[] size needs to be in sync 
>> with attributes added here. */
>> +    switch (socinfo_format) {
>> +    case SOCINFO_VERSION(0, 16):
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 15):
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 14):
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 13):
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 12):
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 11):
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 10):
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 9):
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 8):
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 7):
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 6):
>> +        qcom_custom_socinfo_attrs[i++] =
>> +            &dev_attr_platform_subtype_id.attr;
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 5):
>> +        qcom_custom_socinfo_attrs[i++] = &dev_attr_accessory_chip.attr;
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 4):
>> +        qcom_custom_socinfo_attrs[i++] = 
>> &dev_attr_platform_version.attr;
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 3):
>> +        qcom_custom_socinfo_attrs[i++] = &dev_attr_hw_platform.attr;
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 2):
>> +        qcom_custom_socinfo_attrs[i++] = &dev_attr_raw_id.attr;
>> +        qcom_custom_socinfo_attrs[i++] = &dev_attr_raw_version.attr;
>> +        fallthrough;
>> +    case SOCINFO_VERSION(0, 1):
>> +        break;
>> +    default:
>> +        pr_err("Unknown socinfo format: v%u.%u\n",
>> +                SOCINFO_MAJOR(socinfo_format),
>> +                SOCINFO_MINOR(socinfo_format));
>> +        break;
>> +    }
>> +
>> +    qcom_custom_socinfo_attrs[i] = NULL;
>> +    qcom_socinfo->attr.custom_attr_group = &custom_soc_attr_group;
>> +}
>> +
>>   static const char *socinfo_machine(struct device *dev, unsigned int 
>> id)
>>   {
>>       int idx;
>> @@ -696,6 +876,7 @@ static int qcom_socinfo_probe(struct 
>> platform_device *pdev)
>>                               "%u",
>> le32_to_cpu(soc_info->serial_num));
>>   +    qcom_socinfo_populate_sysfs(qs);
>>       qs->soc_dev = soc_device_register(&qs->attr);
>>       if (IS_ERR(qs->soc_dev))
>>           return PTR_ERR(qs->soc_dev);
>

Thanks,

Naman Jain


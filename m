Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6964074395E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjF3K34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjF3K3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:29:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D68EE;
        Fri, 30 Jun 2023 03:29:43 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U8iUll014085;
        Fri, 30 Jun 2023 10:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GOMTvJmdffmDWCrvI3yojasKJx81ctdw/UTK3c7X3mU=;
 b=nH2boVJI3ijBC+UJ04cVwtzf4bvWoNMJ2dHz9CkQYH1qynrs4uoOvqDfoxRXZ68JUYqu
 X8nJ6FAnZlsF8Y/M7T8ef1gwNWX8dNu3lz1iJZZ6Pcuj+UAvE2uGu3U6quvZXj9fjSKi
 LWWj5OhWGi/F2PnRwZR4I+2WQ+JaR0oN36dQQmW7VvPTnThJmnsbxm7LK1JxPkUbMpcj
 Uw8P5n0vesUXI1GkggNrdKGIxprJIE8EPyoDGDQ2nR7Dga8TiVbq/wLutOs4e3myLubr
 pvbNUGc2JkShkV5Y34B1HtfI6Xthfl7eKIj1b9Q4A8Bb7pVF/1U2DTXPAA9/1Uej1QWP gA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh7s2tqad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 10:29:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35UATTqJ009321
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 10:29:29 GMT
Received: from [10.216.51.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Fri, 30 Jun
 2023 03:29:20 -0700
Message-ID: <8cf34ab3-fa8b-90f4-215e-bbfb0c41fade@quicinc.com>
Date:   Fri, 30 Jun 2023 15:59:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 10/13] remoteproc: qcom: Add Hexagon based multipd
 rproc driver
Content-Language: en-US
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-11-quic_mmanikan@quicinc.com>
 <2061a641-4b97-1aa6-27cd-99f01a785033@linaro.org>
 <54f06704-a849-7049-5956-31cb4765a1eb@quicinc.com>
In-Reply-To: <54f06704-a849-7049-5956-31cb4765a1eb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RHSaYhF1DKGxWm3pQ6oyiaPd62UwHcFO
X-Proofpoint-ORIG-GUID: RHSaYhF1DKGxWm3pQ6oyiaPd62UwHcFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300089
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2023 6:09 PM, Manikanta Mylavarapu wrote:
> 
> 
> On 6/24/2023 12:58 PM, Krzysztof Kozlowski wrote:
>> On 22/05/2023 00:28, Manikanta Mylavarapu wrote:
>>> It adds support to bring up remoteproc's on multipd model.
>>> Pd means protection domain. It's similar to process in Linux.
>>> Here QDSP6 processor runs each wifi radio functionality on a
>>> separate process. One process can't access other process
>>> resources, so this is termed as PD i.e protection domain.
>>>
>>> Here we have two pd's called root and user pd. We can correlate
>>> Root pd as root and user pd as user in linux. Root pd has more
>>> privileges than user pd. Root will provide services to user pd.
>>>
>>>  From remoteproc driver perspective, root pd corresponds to QDSP6
>>> processor bring up and user pd corresponds to Wifi radio (WCSS)
>>> bring up.
>>>
>>> Here WCSS(user) PD is dependent on Q6(root) PD, so first
>>> q6 pd should be up before wcss pd. After wcss pd goes down,
>>> q6 pd should be turned off.
>>>
>>> IPQ5018, IPQ9574 supports multipd remoteproc driver.
>>>
>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>> ---
>>> Changes in V2:
>>>     - Common functionalities moved to seperate patches
>>>     - qcom_get_pd_asid() moved to mpd driver
>>>     - Last DMA block alone memset to zero
>>>     - Added diagram to show how userpd data is organized and sent to
>>>       trustzone
>>>     - Rewritten commit message since most of the content available
>>>       in cover page
>>>     - Removed 'remote_id' becuase it's not required for bring up.
>>>
>>>   drivers/remoteproc/Kconfig          |  20 +
>>>   drivers/remoteproc/Makefile         |   1 +
>>>   drivers/remoteproc/qcom_common.h    |   9 +
>>>   drivers/remoteproc/qcom_q6v5_mpd.c  | 677 ++++++++++++++++++++++++++++
>>>   drivers/soc/qcom/mdt_loader.c       | 332 ++++++++++++++
>>>   include/linux/soc/qcom/mdt_loader.h |  19 +
>>>   6 files changed, 1058 insertions(+)
>>>   create mode 100644 drivers/remoteproc/qcom_q6v5_mpd.c
>>>
>>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>> index a850e9f486dd..44af5c36f67e 100644
>>> --- a/drivers/remoteproc/Kconfig
>>> +++ b/drivers/remoteproc/Kconfig
>>> @@ -234,6 +234,26 @@ config QCOM_Q6V5_PAS
>>>         CDSP (Compute DSP), MPSS (Modem Peripheral SubSystem), and
>>>         SLPI (Sensor Low Power Island).
>>>
>>> +config QCOM_Q6V5_MPD
>>> +    tristate "Qualcomm Hexagon based MPD model Peripheral Image Loader"
>>> +    depends on OF && ARCH_QCOM
>>> +    depends on QCOM_SMEM
>>> +    depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n
>>> +    depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>>> +    depends on QCOM_SYSMON || QCOM_SYSMON=n
>>> +    depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
>>> +    depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>>> +    select MFD_SYSCON
>>
>> Do you really need this?
>>
	It's not required. I will remove. Thanks for catching.

>>> +    select QCOM_MDT_LOADER
>>> +    select QCOM_PIL_INFO
>>> +    select QCOM_Q6V5_COMMON
>>> +    select QCOM_RPROC_COMMON
>>> +    select QCOM_SCM
>>> +    help
>>> +      Say y here to support the Qualcomm Secure Peripheral Image Loader
>>> +      for the Hexagon based MultiPD model remote processors on e.g. 
>>> IPQ5018.
>>> +      This is trustZone wireless subsystem.
>>> +
>>
>> ...
>>
	I didn't understand. Can you please elaborate your comment?

>>> +    int (*powerup_scm)(u32 peripheral);
>>> +    int (*powerdown_scm)(u32 peripheral);
>>> +};
>>> +
>>> +/**
>>> + * qcom_get_pd_asid() - get the pd asid number from DT node
>>
>>  From node name? NAK. It does not work like that. Node names can change
>> and you did not define this number as part of ABI.
>>
>> Probably you wanted unit address.
>>

	Yeah i got your point. Each of the WCSS PD's are internally
	represented in Q6 with their corresponding "spawn" bit numbers.
	I will use same and remove the "PD-" hardcodings.

	Is this fine ?

>>> + * @node:    device tree node
>>> + *
>>> + * Returns asid if node name has 'pd' string
>>> + */
>>> +s8 qcom_get_pd_asid(struct device_node *node)
>>> +{
>>> +    char *str;
>>> +    s8 pd_asid;
>>> +
>>> +    if (!node)
>>> +        return -EINVAL;
>>> +
>>> +    str = strstr(node->name, "pd");
>>> +    if (!str)
>>> +        return 0;
>>> +
>>> +    str += strlen("pd") + 1;
>>> +    return kstrtos8(str, 10, &pd_asid) ? -EINVAL : pd_asid;
>>> +}
>>> +EXPORT_SYMBOL(qcom_get_pd_asid);
>>> +
>>
>> ...
>>
	
	I didn't understand. Can you please elaborate your comment?

>>> +
>>> +static int q6_wcss_spawn_pd(struct rproc *rproc)
>>> +{
>>> +    int ret;
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +
>>> +    ret = qcom_q6v5_request_spawn(&wcss->q6);
>>> +    if (ret == -ETIMEDOUT) {
>>> +        pr_err("%s spawn timedout\n", rproc->name);
>>
>> dev_err
>>

	Sure, I will change to dev_err.

>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = qcom_q6v5_wait_for_start(&wcss->q6, msecs_to_jiffies(10000));
>>> +    if (ret == -ETIMEDOUT) {
>>> +        pr_err("%s start timedout\n", rproc->name);
>>
>> dev_err
>>

	Sure, I will change to dev_err.

>>> +        wcss->q6.running = false;
>>> +        return ret;
>>> +    }
>>> +    wcss->q6.running = true;
>>> +    return ret;
>>> +}
>>> +
>>> +static int wcss_ahb_pcie_pd_start(struct rproc *rproc)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +    const struct wcss_data *desc = wcss->desc;
>>> +    int ret;
>>> +
>>> +    if (!desc->reset_seq)
>>> +        return 0;
>>> +
>>> +    if (desc->powerup_scm) {
>>> +        ret = desc->powerup_scm(desc->pasid);
>>> +        if (ret) {
>>> +            dev_err(wcss->dev, "failed to power up pd\n");
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    ret = q6_wcss_spawn_pd(rproc);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    wcss->state = WCSS_NORMAL;
>>> +    return ret;
>>> +}
>>> +
>>> +static int q6_wcss_stop(struct rproc *rproc)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +    const struct wcss_data *desc = wcss->desc;
>>> +    int ret;
>>> +
>>> +    ret = qcom_scm_pas_shutdown(desc->pasid);
>>> +    if (ret) {
>>> +        dev_err(wcss->dev, "not able to shutdown\n");
>>> +        return ret;
>>> +    }
>>> +    qcom_q6v5_unprepare(&wcss->q6);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int wcss_ahb_pcie_pd_stop(struct rproc *rproc)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +    struct rproc *rpd_rproc = dev_get_drvdata(wcss->dev->parent);
>>> +    const struct wcss_data *desc = wcss->desc;
>>> +    int ret;
>>> +
>>> +    if (!desc->reset_seq)
>>> +        goto shut_down_rpd;
>>> +
>>> +    if (rproc->state != RPROC_CRASHED && wcss->q6.stop_bit) {
>>> +        ret = qcom_q6v5_request_stop(&wcss->q6, NULL);
>>> +        if (ret) {
>>> +            dev_err(&rproc->dev, "pd not stopped\n");
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    if (desc->powerdown_scm) {
>>> +        ret = desc->powerdown_scm(desc->pasid);
>>> +        if (ret) {
>>> +            dev_err(wcss->dev, "failed to power down pd\n");
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +shut_down_rpd:
>>> +    rproc_shutdown(rpd_rproc);
>>> +
>>> +    wcss->state = WCSS_SHUTDOWN;
>>> +    return 0;
>>> +}
>>> +
>>> +static void *q6_wcss_da_to_va(struct rproc *rproc, u64 da, size_t len,
>>> +                  bool *is_iomem)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +    int offset;
>>> +
>>> +    offset = da - wcss->mem_reloc;
>>> +    if (offset < 0 || offset + len > wcss->mem_size)
>>> +        return NULL;
>>> +
>>> +    return wcss->mem_region + offset;
>>> +}
>>> +
>>> +static int q6_wcss_load(struct rproc *rproc, const struct firmware *fw)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +    const struct firmware *fw_hdl;
>>> +    int ret;
>>> +    const struct wcss_data *desc = wcss->desc;
>>> +    int loop;
>>> +
>>> +    ret = qcom_mdt_load(wcss->dev, fw, rproc->firmware,
>>> +                desc->pasid, wcss->mem_region,
>>> +                wcss->mem_phys, wcss->mem_size,
>>> +                &wcss->mem_reloc);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    for (loop = 1; loop < MAX_FIRMWARE; loop++) {
>>> +        if (!wcss->firmware[loop])
>>> +            continue;
>>> +
>>> +        ret = request_firmware(&fw_hdl, wcss->firmware[loop],
>>> +                       wcss->dev);
>>> +        if (ret)
>>> +            continue;
>>> +
>>> +        ret = qcom_mdt_load_no_init(wcss->dev, fw_hdl,
>>> +                        wcss->firmware[loop], 0,
>>> +                        wcss->mem_region,
>>> +                        wcss->mem_phys,
>>> +                        wcss->mem_size,
>>> +                        &wcss->mem_reloc);
>>> +
>>> +        release_firmware(fw_hdl);
>>> +
>>> +        if (ret) {
>>> +            dev_err(wcss->dev,
>>> +                "can't load %s ret:%d\n", wcss->firmware[loop], ret);
>>> +            return ret;
>>> +        }
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +/* This function load's userpd firmware. Since Userpd depends on rootpd
>>
>> Use Linux coding style comments.
>>

	Sure, I will update.

>>> + * first bring up root pd and then load. User pd firmware load is 
>>> required
>>> + * only during user pd restart because root pd loads user pd FW pil 
>>> segments
>>> + * during it's bringup.
>>> + */
>>> +static int wcss_ahb_pcie_pd_load(struct rproc *rproc, const struct 
>>> firmware *fw)
>>> +{
>>> +    struct q6_wcss *wcss = rproc->priv, *wcss_rpd;
>>> +    struct rproc *rpd_rproc = dev_get_drvdata(wcss->dev->parent);
>>> +    const struct wcss_data *desc = wcss->desc;
>>> +    int ret;
>>> +
>>> +    wcss_rpd = rpd_rproc->priv;
>>> +
>>> +    /* Boot rootpd rproc */
>>
>> That's not helpful - i tcopies the function name.
>>

	sure, i will remove comment.

>>> +    ret = rproc_boot(rpd_rproc);
>>> +    if (ret || wcss->state == WCSS_NORMAL)
>>> +        return ret;
>>> +
>>> +    return desc->mdt_load_sec(wcss->dev, fw, rproc->firmware,
>>> +                  desc->pasid, wcss->mem_region,
>>> +                  wcss->mem_phys, wcss->mem_size,
>>> +                  &wcss->mem_reloc);
>>> +}
>>> +

...

	I didn't understand. Can you please elaborate your comment?

>>> +static int q6_get_inbound_irq(struct qcom_q6v5 *q6,
>>> +                  struct platform_device *pdev,
>>> +                  const char *int_name,
>>> +                  irqreturn_t (*handler)(int irq, void *data))
>>> +{
>>> +    int ret, irq;
>>> +    char *interrupt, *tmp = (char *)int_name;
>>> +    struct q6_wcss *wcss = q6->rproc->priv;
>>> +
>>> +    irq = platform_get_irq_byname(pdev, int_name);
>>> +    if (irq < 0) {
>>> +        if (irq != -EPROBE_DEFER)
>>> +            dev_err(&pdev->dev,
>>> +                "failed to retrieve %s IRQ: %d\n",
>>> +                    int_name, irq);
>>
>> return dev_err_probe
>>

	I will use dev_err_probe.

>>> +        return irq;
>>> +    }
>>> +
>>> +    if (!strcmp(int_name, "fatal")) {
>>> +        q6->fatal_irq = irq;
>>> +    } else if (!strcmp(int_name, "stop-ack")) {
>>> +        q6->stop_irq = irq;
>>> +        tmp = "stop_ack";
>>> +    } else if (!strcmp(int_name, "ready")) {
>>> +        q6->ready_irq = irq;
>>> +    } else if (!strcmp(int_name, "handover")) {
>>> +        q6->handover_irq  = irq;
>>> +    } else if (!strcmp(int_name, "spawn-ack")) {
>>> +        q6->spawn_irq = irq;
>>> +        tmp = "spawn_ack";
>>> +    } else {
>>> +        dev_err(&pdev->dev, "unknown interrupt\n");
>>> +        return -EINVAL;
>>> +    }
>>
>> This is over complicated method of getting interrupts. First, you can
>> pass here address of variable with interrupt to assign (*irq_field =
>> irq). Second, drop the names and get by index. Entries are fixed, not
>> flexible.
>>
	Sure, I will do it.

>>> +
>>> +    interrupt = devm_kzalloc(&pdev->dev, BUF_SIZE, GFP_KERNEL);
>>> +    if (!interrupt)
>>> +        return -ENOMEM;
>>> +
>>> +    snprintf(interrupt, BUF_SIZE, "q6v5_wcss_userpd%d_%s", 
>>> wcss->pd_asid, tmp);
>>> +
>>> +    ret = devm_request_threaded_irq(&pdev->dev, irq,
>>> +                    NULL, handler,
>>> +                    IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>>> +                    interrupt, q6);
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to acquire %s irq\n", interrupt);
>>> +        return ret;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static int q6_get_outbound_irq(struct qcom_q6v5 *q6,
>>> +                   struct platform_device *pdev,
>>> +                   const char *int_name)
>>> +{
>>> +    struct qcom_smem_state *tmp_state;
>>> +    unsigned  bit;
>>> +
>>> +    tmp_state = qcom_smem_state_get(&pdev->dev, int_name, &bit);
>>> +    if (IS_ERR(tmp_state)) {
>>> +        dev_err(&pdev->dev, "failed to acquire %s state\n", int_name);
>>> +        return PTR_ERR(tmp_state);
>>> +    }
>>> +
>>> +    if (!strcmp(int_name, "stop")) {
>>> +        q6->state = tmp_state;
>>> +        q6->stop_bit = bit;
>>> +    } else if (!strcmp(int_name, "spawn")) {
>>> +        q6->spawn_state = tmp_state;
>>> +        q6->spawn_bit = bit;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int init_irq(struct qcom_q6v5 *q6,
>>> +            struct platform_device *pdev, struct rproc *rproc,
>>> +            int crash_reason, const char *load_state,
>>> +            void (*handover)(struct qcom_q6v5 *q6))
>>> +{
>>> +    int ret;
>>> +
>>> +    q6->rproc = rproc;
>>> +    q6->dev = &pdev->dev;
>>> +    q6->crash_reason = crash_reason;
>>> +    q6->handover = handover;
>>> +
>>> +    init_completion(&q6->start_done);
>>> +    init_completion(&q6->stop_done);
>>> +    init_completion(&q6->spawn_done);
>>> +
>>> +    ret = q6_get_inbound_irq(q6, pdev, "fatal",
>>> +                 q6v5_fatal_interrupt);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = q6_get_inbound_irq(q6, pdev, "ready",
>>> +                 q6v5_ready_interrupt);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = q6_get_inbound_irq(q6, pdev, "stop-ack",
>>> +                 q6v5_stop_interrupt);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = q6_get_inbound_irq(q6, pdev, "spawn-ack",
>>> +                 q6v5_spawn_interrupt);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = q6_get_outbound_irq(q6, pdev, "stop");
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = q6_get_outbound_irq(q6, pdev, "spawn");
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int q6_wcss_probe(struct platform_device *pdev)
>>> +{
>>> +    const struct wcss_data *desc;
>>> +    struct q6_wcss *wcss;
>>> +    struct rproc *rproc;
>>> +    int ret;
>>> +    char *subdev_name;
>>> +    const char **firmware;
>>> +
>>> +    desc = of_device_get_match_data(&pdev->dev);
>>> +    if (!desc)
>>> +        return -EINVAL;
>>> +
>>> +    firmware = devm_kcalloc(&pdev->dev, MAX_FIRMWARE,
>>> +                sizeof(*firmware), GFP_KERNEL);
>>> +    if (!firmware)
>>> +        return -ENOMEM;
>>> +
>>> +    ret = of_property_read_string_array(pdev->dev.of_node, 
>>> "firmware-name",
>>> +                        firmware, MAX_FIRMWARE);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    rproc = rproc_alloc(&pdev->dev, pdev->name, desc->ops,
>>> +                firmware[0], sizeof(*wcss));
>>> +    if (!rproc) {
>>> +        dev_err(&pdev->dev, "failed to allocate rproc\n");
>>
>> ENOMEM do not print errors. Why do you have to print something here?
>>

	Yeah, I will remove print.

>>> +        return -ENOMEM;
>>> +    }
>>> +    wcss = rproc->priv;
>>> +    wcss->dev = &pdev->dev;
>>> +    wcss->desc = desc;
>>> +    wcss->firmware = firmware;
>>> +
>>> +    ret = q6_alloc_memory_region(wcss);
>>> +    if (ret)
>>> +        goto free_rproc;
>>> +
>>> +    wcss->pd_asid = qcom_get_pd_asid(wcss->dev->of_node);
>>> +    if (wcss->pd_asid < 0)
>>> +        goto free_rproc;
>>> +
>>> +    if (desc->init_irq) {
>>> +        ret = desc->init_irq(&wcss->q6, pdev, rproc,
>>> +                     desc->crash_reason_smem, NULL, NULL);
>>> +        if (ret)
>>> +            goto free_rproc;
>>> +    }
>>> +
>>> +    if (desc->glink_subdev_required)
>>> +        qcom_add_glink_subdev(rproc, &wcss->glink_subdev, 
>>> desc->ssr_name);
>>> +
>>> +    subdev_name = (char *)(desc->ssr_name ? desc->ssr_name : 
>>> pdev->name);
>>> +    qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, subdev_name);
>>> +
>>> +    rproc->auto_boot = false;
>>> +    ret = rproc_add(rproc);
>>> +    if (ret)
>>> +        goto free_rproc;
>>> +
>>> +    platform_set_drvdata(pdev, rproc);
>>> +
>>> +    ret = of_platform_populate(wcss->dev->of_node, NULL,
>>> +                   NULL, wcss->dev);
>>
>> It is the same probe used for the children, right? So whom do they 
>> populate?
>>

	I will add match table in 2nd param, so that childs, whose
	compatible matches with match table will be populated.

	Is this fine ?
>>> +    if (ret) {
>>> +        dev_err(&pdev->dev, "failed to populate wcss pd nodes\n");
>>
>> dev_err_probe
>>
	 Sure, i will use dev_err_probe

>>> +        goto free_rproc;
>>> +    }
>>> +    return 0;
>>> +
>>> +free_rproc:
>>> +    rproc_free(rproc);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int q6_wcss_remove(struct platform_device *pdev)
>>> +{
>>> +    struct rproc *rproc = platform_get_drvdata(pdev);
>>> +    struct q6_wcss *wcss = rproc->priv;
>>> +
>>> +    qcom_q6v5_deinit(&wcss->q6);
>>> +
>>> +    rproc_del(rproc);
>>> +    rproc_free(rproc);
>>> +
>>> +    return 0;
>>> +}
>>
>>
>>

Thanks & Regards,
Manikanta.

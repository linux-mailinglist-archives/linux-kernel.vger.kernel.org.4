Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC164B700
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiLMOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiLMOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:11:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8512D21837;
        Tue, 13 Dec 2022 06:10:39 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDA2NwR028557;
        Tue, 13 Dec 2022 14:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FwrwvFMWgt+E6HS54fIVrXxLq1pccb2k7dMl7mUyU2Y=;
 b=mQMkTtTCNaWwPuLVwJ0dqID9dX0Ili9ictmRprclqEyJE93+5RB1kOsbxyc/gZeowYsA
 dqqY5bSCbsp+oODrJc9FF3+xelXNV0GMnbtp80kMuVuu/4k52CX8mCU7V43kPwEKp2bY
 97cDT5KRlw+kIE8P21byekGWPKRY88+sRRNTpDOsHeuPsfIGRYn+NJCFfNze62GgqG3X
 3uJ+aPJhTXqhP/xYfEL0RIZoJWIj/zJdAK560sQK8Y/ilVSXUwlpy6g6H7bWG4AZLCM6
 zFP9KwjJCa/0qBdmA8gI/dqCY2KX1lwDBboWpzAHUYanZoQjM5/6MH1zS2Ips101I9AO Pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3meh7u9n48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:10:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDEA2QX013742
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:10:02 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 06:09:57 -0800
Message-ID: <03f12771-7c90-e0f7-66f4-9ebe04d63fc1@quicinc.com>
Date:   Tue, 13 Dec 2022 19:39:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] mailbox: Add support for QTI CPUCP mailbox controller
Content-Language: en-US
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <konrad.dybcio@somainline.org>,
        <amit.pundir@linaro.org>, <regressions@leemhuis.info>,
        <sumit.semwal@linaro.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <robin.murphy@arm.com>,
        Gaurav Kohli <gkohli@codeaurora.org>
References: <20221213140409.772-1-quic_sibis@quicinc.com>
 <20221213140409.772-3-quic_sibis@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221213140409.772-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ug_V2OCafGJmhgvtm_ruic6XmMsg59cy
X-Proofpoint-ORIG-GUID: Ug_V2OCafGJmhgvtm_ruic6XmMsg59cy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional patches got tagged along. Please ignore.


On 12/13/22 19:34, Sibi Sankar wrote:
> Add support for CPUSS Control Processor (CPUCP) mailbox controller,
> this driver enables communication between AP and CPUCP by acting as
> a doorbell between them.
> 
> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
> [sibis: moved to mailbox and misc. cleanups]
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>   drivers/mailbox/Kconfig           |   9 ++
>   drivers/mailbox/Makefile          |   2 +
>   drivers/mailbox/qcom-cpucp-mbox.c | 176 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 187 insertions(+)
>   create mode 100644 drivers/mailbox/qcom-cpucp-mbox.c
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 05d6fae800e3..7766e0ad2f12 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -284,6 +284,15 @@ config SPRD_MBOX
>   	  to send message between application processors and MCU. Say Y here if
>   	  you want to build the Spreatrum mailbox controller driver.
>   
> +config QCOM_CPUCP_MBOX
> +	tristate "Qualcomm Technologies, Inc. CPUCP mailbox driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  Qualcomm Technologies, Inc. CPUSS Control Processor (CPUCP) mailbox
> +	  controller driver enables communication between AP and CPUCP by
> +	  acting as a doorbell between them. Say Y here if you want to build
> +	  this driver.
> +
>   config QCOM_IPCC
>   	tristate "Qualcomm Technologies, Inc. IPCC driver"
>   	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index fc9376117111..195b7e40541f 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -59,6 +59,8 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
>   
>   obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
>   
> +obj-$(CONFIG_QCOM_CPUCP_MBOX)	+= qcom-cpucp-mbox.o
> +
>   obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
>   
>   obj-$(CONFIG_APPLE_MAILBOX)	+= apple-mailbox.o
> diff --git a/drivers/mailbox/qcom-cpucp-mbox.c b/drivers/mailbox/qcom-cpucp-mbox.c
> new file mode 100644
> index 000000000000..063bb2d80f3e
> --- /dev/null
> +++ b/drivers/mailbox/qcom-cpucp-mbox.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +/* CPUCP Register offsets */
> +#define CPUCP_INTR_CLEAR_REG		0x8
> +#define CPUCP_INTR_STATUS_REG		0xC
> +#define CPUCP_SEND_IRQ_REG		0xC
> +
> +#define CPUCP_IRQ_CLEAR			BIT(3)
> +#define CPUCP_IRQ_STATUS_ASSERTED	BIT(3)
> +#define CPUCP_SEND_IRQ			BIT(28)
> +
> +/**
> + * struct qcom_cpucp_mbox - Holder for the mailbox driver
> + * @mbox:			The mailbox controller
> + * @chan:			The mailbox channel
> + * @tx_base:			Base address of the CPUCP tx registers
> + * @rx_base:			Base address of the CPUCP rx registers
> + * @dev:			Device associated with this instance
> + * @lock:			Lock protecting private
> + * @irq:			CPUCP to AP irq
> + */
> +struct qcom_cpucp_mbox {
> +	struct mbox_controller mbox;
> +	struct mbox_chan chan;
> +	void __iomem *tx_base;
> +	void __iomem *rx_base;
> +	struct device *dev;
> +	int irq;
> +
> +	/* control access to the chan private data */
> +	spinlock_t lock;
> +};
> +
> +static inline struct qcom_cpucp_mbox *to_qcom_cpucp_mbox(struct mbox_controller *mbox)
> +{
> +	return container_of(mbox, struct qcom_cpucp_mbox, mbox);
> +}
> +
> +static irqreturn_t qcom_cpucp_mbox_irq_fn(int irq, void *data)
> +{
> +	struct qcom_cpucp_mbox *cpucp = data;
> +	unsigned long flags;
> +	u32 val;
> +
> +	val = readl(cpucp->rx_base + CPUCP_INTR_STATUS_REG);
> +	if (val & CPUCP_IRQ_STATUS_ASSERTED) {
> +		writel(CPUCP_IRQ_CLEAR, cpucp->rx_base + CPUCP_INTR_CLEAR_REG);
> +
> +		spin_lock_irqsave(&cpucp->lock, flags);
> +		if (cpucp->chan.con_priv)
> +			mbox_chan_received_data(&cpucp->chan, NULL);
> +		spin_unlock_irqrestore(&cpucp->lock, flags);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int qcom_cpucp_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct qcom_cpucp_mbox *cpucp = to_qcom_cpucp_mbox(chan->mbox);
> +
> +	writel(CPUCP_SEND_IRQ, cpucp->tx_base + CPUCP_SEND_IRQ_REG);
> +
> +	return 0;
> +}
> +
> +static void qcom_cpucp_mbox_shutdown(struct mbox_chan *chan)
> +{
> +	struct qcom_cpucp_mbox *cpucp = to_qcom_cpucp_mbox(chan->mbox);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cpucp->lock, flags);
> +	chan->con_priv = NULL;
> +	spin_unlock_irqrestore(&cpucp->lock, flags);
> +}
> +
> +static const struct mbox_chan_ops cpucp_mbox_chan_ops = {
> +	.send_data = qcom_cpucp_mbox_send_data,
> +	.shutdown = qcom_cpucp_mbox_shutdown
> +};
> +
> +static struct mbox_chan *qcom_cpucp_mbox_xlate(struct mbox_controller *mbox,
> +					       const struct of_phandle_args *ph)
> +{
> +	struct qcom_cpucp_mbox *cpucp = to_qcom_cpucp_mbox(mbox);
> +
> +	if (ph->args_count != 0)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (mbox->chans[0].con_priv)
> +		return ERR_PTR(-EBUSY);
> +
> +	mbox->chans[0].con_priv = cpucp;
> +
> +	return &mbox->chans[0];
> +}
> +
> +static int qcom_cpucp_mbox_probe(struct platform_device *pdev)
> +{
> +	struct qcom_cpucp_mbox *cpucp;
> +	struct mbox_controller *mbox;
> +	int ret;
> +
> +	cpucp = devm_kzalloc(&pdev->dev, sizeof(*cpucp), GFP_KERNEL);
> +	if (!cpucp)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&cpucp->lock);
> +	cpucp->dev = &pdev->dev;
> +
> +	cpucp->tx_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(cpucp->tx_base))
> +		return PTR_ERR(cpucp->tx_base);
> +
> +	cpucp->rx_base = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(cpucp->rx_base))
> +		return PTR_ERR(cpucp->rx_base);
> +
> +	cpucp->irq = platform_get_irq(pdev, 0);
> +	if (cpucp->irq < 0)
> +		return cpucp->irq;
> +
> +	mbox = &cpucp->mbox;
> +	mbox->dev = cpucp->dev;
> +	mbox->num_chans = 1;
> +	mbox->chans = &cpucp->chan;
> +	mbox->ops = &cpucp_mbox_chan_ops;
> +	mbox->of_xlate = qcom_cpucp_mbox_xlate;
> +	mbox->txdone_irq = false;
> +	mbox->txdone_poll = false;
> +
> +	ret = devm_mbox_controller_register(&pdev->dev, mbox);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_irq(&pdev->dev, cpucp->irq, qcom_cpucp_mbox_irq_fn,
> +			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND, "qcom_cpucp_mbox", cpucp);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to register the irq: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, cpucp);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_cpucp_mbox_of_match[] = {
> +	{ .compatible = "qcom,cpucp-mbox"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_cpucp_mbox_of_match);
> +
> +static struct platform_driver qcom_cpucp_mbox_driver = {
> +	.probe = qcom_cpucp_mbox_probe,
> +	.driver = {
> +		.name = "qcom_cpucp_mbox",
> +		.of_match_table = qcom_cpucp_mbox_of_match,
> +	},
> +};
> +module_platform_driver(qcom_cpucp_mbox_driver);
> +
> +MODULE_AUTHOR("Gaurav Kohli <gkohli@codeaurora.org>");
> +MODULE_AUTHOR("Sibi Sankar <quic_sibis@qti.qualcomm.com>");
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. CPUSS Control Processor Mailbox driver");
> +MODULE_LICENSE("GPL");

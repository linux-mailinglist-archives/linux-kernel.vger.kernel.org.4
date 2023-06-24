Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5873C757
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjFXH2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 03:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjFXH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 03:28:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381B62733
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 00:28:15 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9887ebe16d0so161989966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 00:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687591693; x=1690183693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0d9ka9qXrT8bIH/PefHROeo/N45KfGB6MKK5OqaRnM=;
        b=LKtnuqdjpHEo+jp85EapT8pw3v/EECkwGHgK/L6Xzfvv5m7s2KqIYc7klBebFsifbm
         IXv3zFHMUGSr6SlKIGYYNBv+H91z+Q4FOe4WeyI2zH9Jqo1J93ovCfXeAzQEBTRbSK6E
         jnCaPtSq/ESLgtR9fkjwXpBovjikmSTIXvXhbVvjr65HCOhUt41qOL6calvPECZMzBNw
         52V00Bc/fcQgQ/5o7yLUH9QA4E3hmhNCroFwmbVtv1LlP8aGDPk80+x08qvG/dFozPJ5
         gbl1VPe5/es+AtPj+J+zfa/fh1k9c6hBL+TmpkadninTYvn6pIF0ClDWmQ2ARJr256pG
         /NjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687591693; x=1690183693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0d9ka9qXrT8bIH/PefHROeo/N45KfGB6MKK5OqaRnM=;
        b=hL5bfEfTgCCSRHow73YkzLk2BJbKCP7Rjq57hVi+kyagYMdmPfkn9znzFwsGWv3POk
         Qr9XasBE+PZfzQuFHhFVbNRwp3vJyseYT8pul5KYThj/My5aoI/h2pvZegUlVe8EbKnX
         JF86202QWENJxPsvwcbjOybcPyuvgrGMzO2IyUNRCxcEnzuTZgT+taLY0+LAXzGlU4xj
         rtP7F/kCfD0q/v1Vfa9bwfinEVs2OZ0ON8mzVvpZrXvO5iOmtXzzUFWA42jcTm4TgwsF
         w/dJXlhYFUw6t5TT1dpVcdK5twmo+KZ1YX+IIOhD+Z1cPvPaIh4v7UGedTaEDg3rZgIg
         Y/zA==
X-Gm-Message-State: AC+VfDxY0Zw1/rtwqexa9KVHl+W3BYke7ZNpLL9eyfbzwXPlDDyoBzNU
        eIw3chxPdFhfEAGTDyyfc6ivdg==
X-Google-Smtp-Source: ACHHUZ5PJCKogs55RBIbcnabcf2e0CYuLz8z97UtAeEl9sPxG4v63qpxRs0LdQqEKLw1yfxUAWGdlw==
X-Received: by 2002:a17:906:7312:b0:98d:3ae:b693 with SMTP id di18-20020a170906731200b0098d03aeb693mr6692863ejc.7.1687591693362;
        Sat, 24 Jun 2023 00:28:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z18-20020a1709067e5200b00989257be620sm552582ejr.200.2023.06.24.00.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 00:28:12 -0700 (PDT)
Message-ID: <2061a641-4b97-1aa6-27cd-99f01a785033@linaro.org>
Date:   Sat, 24 Jun 2023 09:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 10/13] remoteproc: qcom: Add Hexagon based multipd
 rproc driver
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jassisinghbrar@gmail.com,
        mathieu.poirier@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_eberman@quicinc.com, quic_mojha@quicinc.com,
        kvalo@kernel.org, loic.poulain@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com, quic_varada@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-11-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230521222852.5740-11-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 00:28, Manikanta Mylavarapu wrote:
> It adds support to bring up remoteproc's on multipd model.
> Pd means protection domain. It's similar to process in Linux.
> Here QDSP6 processor runs each wifi radio functionality on a
> separate process. One process can't access other process
> resources, so this is termed as PD i.e protection domain.
> 
> Here we have two pd's called root and user pd. We can correlate
> Root pd as root and user pd as user in linux. Root pd has more
> privileges than user pd. Root will provide services to user pd.
> 
> From remoteproc driver perspective, root pd corresponds to QDSP6
> processor bring up and user pd corresponds to Wifi radio (WCSS)
> bring up.
> 
> Here WCSS(user) PD is dependent on Q6(root) PD, so first
> q6 pd should be up before wcss pd. After wcss pd goes down,
> q6 pd should be turned off.
> 
> IPQ5018, IPQ9574 supports multipd remoteproc driver.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V2:
> 	- Common functionalities moved to seperate patches
> 	- qcom_get_pd_asid() moved to mpd driver
> 	- Last DMA block alone memset to zero
> 	- Added diagram to show how userpd data is organized and sent to
> 	  trustzone
> 	- Rewritten commit message since most of the content available
> 	  in cover page
> 	- Removed 'remote_id' becuase it's not required for bring up.
> 
>  drivers/remoteproc/Kconfig          |  20 +
>  drivers/remoteproc/Makefile         |   1 +
>  drivers/remoteproc/qcom_common.h    |   9 +
>  drivers/remoteproc/qcom_q6v5_mpd.c  | 677 ++++++++++++++++++++++++++++
>  drivers/soc/qcom/mdt_loader.c       | 332 ++++++++++++++
>  include/linux/soc/qcom/mdt_loader.h |  19 +
>  6 files changed, 1058 insertions(+)
>  create mode 100644 drivers/remoteproc/qcom_q6v5_mpd.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index a850e9f486dd..44af5c36f67e 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -234,6 +234,26 @@ config QCOM_Q6V5_PAS
>  	  CDSP (Compute DSP), MPSS (Modem Peripheral SubSystem), and
>  	  SLPI (Sensor Low Power Island).
> 
> +config QCOM_Q6V5_MPD
> +	tristate "Qualcomm Hexagon based MPD model Peripheral Image Loader"
> +	depends on OF && ARCH_QCOM
> +	depends on QCOM_SMEM
> +	depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n
> +	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
> +	depends on QCOM_SYSMON || QCOM_SYSMON=n
> +	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
> +	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
> +	select MFD_SYSCON

Do you really need this?

> +	select QCOM_MDT_LOADER
> +	select QCOM_PIL_INFO
> +	select QCOM_Q6V5_COMMON
> +	select QCOM_RPROC_COMMON
> +	select QCOM_SCM
> +	help
> +	  Say y here to support the Qualcomm Secure Peripheral Image Loader
> +	  for the Hexagon based MultiPD model remote processors on e.g. IPQ5018.
> +	  This is trustZone wireless subsystem.
> +

...

> +	int (*powerup_scm)(u32 peripheral);
> +	int (*powerdown_scm)(u32 peripheral);
> +};
> +
> +/**
> + * qcom_get_pd_asid() - get the pd asid number from DT node

From node name? NAK. It does not work like that. Node names can change
and you did not define this number as part of ABI.

Probably you wanted unit address.

> + * @node:	device tree node
> + *
> + * Returns asid if node name has 'pd' string
> + */
> +s8 qcom_get_pd_asid(struct device_node *node)
> +{
> +	char *str;
> +	s8 pd_asid;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	str = strstr(node->name, "pd");
> +	if (!str)
> +		return 0;
> +
> +	str += strlen("pd") + 1;
> +	return kstrtos8(str, 10, &pd_asid) ? -EINVAL : pd_asid;
> +}
> +EXPORT_SYMBOL(qcom_get_pd_asid);
> +

...

> +
> +static int q6_wcss_spawn_pd(struct rproc *rproc)
> +{
> +	int ret;
> +	struct q6_wcss *wcss = rproc->priv;
> +
> +	ret = qcom_q6v5_request_spawn(&wcss->q6);
> +	if (ret == -ETIMEDOUT) {
> +		pr_err("%s spawn timedout\n", rproc->name);

dev_err

> +		return ret;
> +	}
> +
> +	ret = qcom_q6v5_wait_for_start(&wcss->q6, msecs_to_jiffies(10000));
> +	if (ret == -ETIMEDOUT) {
> +		pr_err("%s start timedout\n", rproc->name);

dev_err

> +		wcss->q6.running = false;
> +		return ret;
> +	}
> +	wcss->q6.running = true;
> +	return ret;
> +}
> +
> +static int wcss_ahb_pcie_pd_start(struct rproc *rproc)
> +{
> +	struct q6_wcss *wcss = rproc->priv;
> +	const struct wcss_data *desc = wcss->desc;
> +	int ret;
> +
> +	if (!desc->reset_seq)
> +		return 0;
> +
> +	if (desc->powerup_scm) {
> +		ret = desc->powerup_scm(desc->pasid);
> +		if (ret) {
> +			dev_err(wcss->dev, "failed to power up pd\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = q6_wcss_spawn_pd(rproc);
> +	if (ret)
> +		return ret;
> +
> +	wcss->state = WCSS_NORMAL;
> +	return ret;
> +}
> +
> +static int q6_wcss_stop(struct rproc *rproc)
> +{
> +	struct q6_wcss *wcss = rproc->priv;
> +	const struct wcss_data *desc = wcss->desc;
> +	int ret;
> +
> +	ret = qcom_scm_pas_shutdown(desc->pasid);
> +	if (ret) {
> +		dev_err(wcss->dev, "not able to shutdown\n");
> +		return ret;
> +	}
> +	qcom_q6v5_unprepare(&wcss->q6);
> +
> +	return 0;
> +}
> +
> +static int wcss_ahb_pcie_pd_stop(struct rproc *rproc)
> +{
> +	struct q6_wcss *wcss = rproc->priv;
> +	struct rproc *rpd_rproc = dev_get_drvdata(wcss->dev->parent);
> +	const struct wcss_data *desc = wcss->desc;
> +	int ret;
> +
> +	if (!desc->reset_seq)
> +		goto shut_down_rpd;
> +
> +	if (rproc->state != RPROC_CRASHED && wcss->q6.stop_bit) {
> +		ret = qcom_q6v5_request_stop(&wcss->q6, NULL);
> +		if (ret) {
> +			dev_err(&rproc->dev, "pd not stopped\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (desc->powerdown_scm) {
> +		ret = desc->powerdown_scm(desc->pasid);
> +		if (ret) {
> +			dev_err(wcss->dev, "failed to power down pd\n");
> +			return ret;
> +		}
> +	}
> +
> +shut_down_rpd:
> +	rproc_shutdown(rpd_rproc);
> +
> +	wcss->state = WCSS_SHUTDOWN;
> +	return 0;
> +}
> +
> +static void *q6_wcss_da_to_va(struct rproc *rproc, u64 da, size_t len,
> +			      bool *is_iomem)
> +{
> +	struct q6_wcss *wcss = rproc->priv;
> +	int offset;
> +
> +	offset = da - wcss->mem_reloc;
> +	if (offset < 0 || offset + len > wcss->mem_size)
> +		return NULL;
> +
> +	return wcss->mem_region + offset;
> +}
> +
> +static int q6_wcss_load(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct q6_wcss *wcss = rproc->priv;
> +	const struct firmware *fw_hdl;
> +	int ret;
> +	const struct wcss_data *desc = wcss->desc;
> +	int loop;
> +
> +	ret = qcom_mdt_load(wcss->dev, fw, rproc->firmware,
> +			    desc->pasid, wcss->mem_region,
> +			    wcss->mem_phys, wcss->mem_size,
> +			    &wcss->mem_reloc);
> +	if (ret)
> +		return ret;
> +
> +	for (loop = 1; loop < MAX_FIRMWARE; loop++) {
> +		if (!wcss->firmware[loop])
> +			continue;
> +
> +		ret = request_firmware(&fw_hdl, wcss->firmware[loop],
> +				       wcss->dev);
> +		if (ret)
> +			continue;
> +
> +		ret = qcom_mdt_load_no_init(wcss->dev, fw_hdl,
> +					    wcss->firmware[loop], 0,
> +					    wcss->mem_region,
> +					    wcss->mem_phys,
> +					    wcss->mem_size,
> +					    &wcss->mem_reloc);
> +
> +		release_firmware(fw_hdl);
> +
> +		if (ret) {
> +			dev_err(wcss->dev,
> +				"can't load %s ret:%d\n", wcss->firmware[loop], ret);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/* This function load's userpd firmware. Since Userpd depends on rootpd

Use Linux coding style comments.

> + * first bring up root pd and then load. User pd firmware load is required
> + * only during user pd restart because root pd loads user pd FW pil segments
> + * during it's bringup.
> + */
> +static int wcss_ahb_pcie_pd_load(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct q6_wcss *wcss = rproc->priv, *wcss_rpd;
> +	struct rproc *rpd_rproc = dev_get_drvdata(wcss->dev->parent);
> +	const struct wcss_data *desc = wcss->desc;
> +	int ret;
> +
> +	wcss_rpd = rpd_rproc->priv;
> +
> +	/* Boot rootpd rproc */

That's not helpful - i tcopies the function name.

> +	ret = rproc_boot(rpd_rproc);
> +	if (ret || wcss->state == WCSS_NORMAL)
> +		return ret;
> +
> +	return desc->mdt_load_sec(wcss->dev, fw, rproc->firmware,
> +				  desc->pasid, wcss->mem_region,
> +				  wcss->mem_phys, wcss->mem_size,
> +				  &wcss->mem_reloc);
> +}
> +

...

> +
> +static int q6_get_inbound_irq(struct qcom_q6v5 *q6,
> +			      struct platform_device *pdev,
> +			      const char *int_name,
> +			      irqreturn_t (*handler)(int irq, void *data))
> +{
> +	int ret, irq;
> +	char *interrupt, *tmp = (char *)int_name;
> +	struct q6_wcss *wcss = q6->rproc->priv;
> +
> +	irq = platform_get_irq_byname(pdev, int_name);
> +	if (irq < 0) {
> +		if (irq != -EPROBE_DEFER)
> +			dev_err(&pdev->dev,
> +				"failed to retrieve %s IRQ: %d\n",
> +					int_name, irq);

return dev_err_probe

> +		return irq;
> +	}
> +
> +	if (!strcmp(int_name, "fatal")) {
> +		q6->fatal_irq = irq;
> +	} else if (!strcmp(int_name, "stop-ack")) {
> +		q6->stop_irq = irq;
> +		tmp = "stop_ack";
> +	} else if (!strcmp(int_name, "ready")) {
> +		q6->ready_irq = irq;
> +	} else if (!strcmp(int_name, "handover")) {
> +		q6->handover_irq  = irq;
> +	} else if (!strcmp(int_name, "spawn-ack")) {
> +		q6->spawn_irq = irq;
> +		tmp = "spawn_ack";
> +	} else {
> +		dev_err(&pdev->dev, "unknown interrupt\n");
> +		return -EINVAL;
> +	}

This is over complicated method of getting interrupts. First, you can
pass here address of variable with interrupt to assign (*irq_field =
irq). Second, drop the names and get by index. Entries are fixed, not
flexible.

> +
> +	interrupt = devm_kzalloc(&pdev->dev, BUF_SIZE, GFP_KERNEL);
> +	if (!interrupt)
> +		return -ENOMEM;
> +
> +	snprintf(interrupt, BUF_SIZE, "q6v5_wcss_userpd%d_%s", wcss->pd_asid, tmp);
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq,
> +					NULL, handler,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					interrupt, q6);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to acquire %s irq\n", interrupt);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int q6_get_outbound_irq(struct qcom_q6v5 *q6,
> +			       struct platform_device *pdev,
> +			       const char *int_name)
> +{
> +	struct qcom_smem_state *tmp_state;
> +	unsigned  bit;
> +
> +	tmp_state = qcom_smem_state_get(&pdev->dev, int_name, &bit);
> +	if (IS_ERR(tmp_state)) {
> +		dev_err(&pdev->dev, "failed to acquire %s state\n", int_name);
> +		return PTR_ERR(tmp_state);
> +	}
> +
> +	if (!strcmp(int_name, "stop")) {
> +		q6->state = tmp_state;
> +		q6->stop_bit = bit;
> +	} else if (!strcmp(int_name, "spawn")) {
> +		q6->spawn_state = tmp_state;
> +		q6->spawn_bit = bit;
> +	}
> +
> +	return 0;
> +}
> +
> +static int init_irq(struct qcom_q6v5 *q6,
> +		    struct platform_device *pdev, struct rproc *rproc,
> +		    int crash_reason, const char *load_state,
> +		    void (*handover)(struct qcom_q6v5 *q6))
> +{
> +	int ret;
> +
> +	q6->rproc = rproc;
> +	q6->dev = &pdev->dev;
> +	q6->crash_reason = crash_reason;
> +	q6->handover = handover;
> +
> +	init_completion(&q6->start_done);
> +	init_completion(&q6->stop_done);
> +	init_completion(&q6->spawn_done);
> +
> +	ret = q6_get_inbound_irq(q6, pdev, "fatal",
> +				 q6v5_fatal_interrupt);
> +	if (ret)
> +		return ret;
> +
> +	ret = q6_get_inbound_irq(q6, pdev, "ready",
> +				 q6v5_ready_interrupt);
> +	if (ret)
> +		return ret;
> +
> +	ret = q6_get_inbound_irq(q6, pdev, "stop-ack",
> +				 q6v5_stop_interrupt);
> +	if (ret)
> +		return ret;
> +
> +	ret = q6_get_inbound_irq(q6, pdev, "spawn-ack",
> +				 q6v5_spawn_interrupt);
> +	if (ret)
> +		return ret;
> +
> +	ret = q6_get_outbound_irq(q6, pdev, "stop");
> +	if (ret)
> +		return ret;
> +
> +	ret = q6_get_outbound_irq(q6, pdev, "spawn");
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int q6_wcss_probe(struct platform_device *pdev)
> +{
> +	const struct wcss_data *desc;
> +	struct q6_wcss *wcss;
> +	struct rproc *rproc;
> +	int ret;
> +	char *subdev_name;
> +	const char **firmware;
> +
> +	desc = of_device_get_match_data(&pdev->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	firmware = devm_kcalloc(&pdev->dev, MAX_FIRMWARE,
> +				sizeof(*firmware), GFP_KERNEL);
> +	if (!firmware)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_string_array(pdev->dev.of_node, "firmware-name",
> +					    firmware, MAX_FIRMWARE);
> +	if (ret < 0)
> +		return ret;
> +
> +	rproc = rproc_alloc(&pdev->dev, pdev->name, desc->ops,
> +			    firmware[0], sizeof(*wcss));
> +	if (!rproc) {
> +		dev_err(&pdev->dev, "failed to allocate rproc\n");

ENOMEM do not print errors. Why do you have to print something here?

> +		return -ENOMEM;
> +	}
> +	wcss = rproc->priv;
> +	wcss->dev = &pdev->dev;
> +	wcss->desc = desc;
> +	wcss->firmware = firmware;
> +
> +	ret = q6_alloc_memory_region(wcss);
> +	if (ret)
> +		goto free_rproc;
> +
> +	wcss->pd_asid = qcom_get_pd_asid(wcss->dev->of_node);
> +	if (wcss->pd_asid < 0)
> +		goto free_rproc;
> +
> +	if (desc->init_irq) {
> +		ret = desc->init_irq(&wcss->q6, pdev, rproc,
> +				     desc->crash_reason_smem, NULL, NULL);
> +		if (ret)
> +			goto free_rproc;
> +	}
> +
> +	if (desc->glink_subdev_required)
> +		qcom_add_glink_subdev(rproc, &wcss->glink_subdev, desc->ssr_name);
> +
> +	subdev_name = (char *)(desc->ssr_name ? desc->ssr_name : pdev->name);
> +	qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, subdev_name);
> +
> +	rproc->auto_boot = false;
> +	ret = rproc_add(rproc);
> +	if (ret)
> +		goto free_rproc;
> +
> +	platform_set_drvdata(pdev, rproc);
> +
> +	ret = of_platform_populate(wcss->dev->of_node, NULL,
> +				   NULL, wcss->dev);

It is the same probe used for the children, right? So whom do they populate?

> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to populate wcss pd nodes\n");

dev_err_probe

> +		goto free_rproc;
> +	}
> +	return 0;
> +
> +free_rproc:
> +	rproc_free(rproc);
> +
> +	return ret;
> +}
> +
> +static int q6_wcss_remove(struct platform_device *pdev)
> +{
> +	struct rproc *rproc = platform_get_drvdata(pdev);
> +	struct q6_wcss *wcss = rproc->priv;
> +
> +	qcom_q6v5_deinit(&wcss->q6);
> +
> +	rproc_del(rproc);
> +	rproc_free(rproc);
> +
> +	return 0;
> +}



Best regards,
Krzysztof


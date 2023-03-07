Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963226AE510
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjCGPkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjCGPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:40:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FAB85341
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:39:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cy23so53803305edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678203560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBP4yZy0AVeC0MnD40cQqAFe/SHBra0LCgpXTLIauoo=;
        b=trVxxTQOYz0Su1ie3bNBkqYpGwqjWhQup5lfaC+uL+kNNLkqAoe/KeoPJFPCGyPIfd
         jX/zWg+L607/6JPCXz1CQVGTdn9fKQLAtHibGn3kJ0YztKcQM6Ip8C0rwx2IjY1q7Usv
         s6Y0uKaFjsLsJEl/ON1yT9Blsx6DUZd6w3N7MUosPdD1fUwdNtvkGomlDRbf1QrRXho6
         zPAB/ABqBcVJhXLvfyixBVRdaF9PoRuarLMXDr0AYcYKd2Q2Ut+Glc4KUEgnT+xYkxAR
         eK5ph8+8dXw2wM5aNE0KaqMTX60pUYrZXHGKRt0p/ktrX4NKKNRnnMBRISz8DMQKmLQs
         JLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBP4yZy0AVeC0MnD40cQqAFe/SHBra0LCgpXTLIauoo=;
        b=GQMv8l0XfQDqAT1D0JPPx+AfQB19ZEFBGxvWryiiNu0oRQSkgcyClDBh+DEVKOQx0s
         3xqd5AoBcILVKrSBrL3YPH4sVnF+O4MY4hSQSvZ7F/cwGQX8at9x8HthkEPf1gzJn2oW
         jJBTKVfG9pdKtusjzIid3Pp2MyD2jvAGS8bKMporHR2mAN0g7NpveoTgsciy40vIiV06
         yDT3FGedx6CqaDm8KNo2h5l8+PyCO9tZ7x9/YLrnP+k6620zMMqQX8y5VsbPxaCbaiPJ
         GKWHR/j2JHMPR3EOUpJQ7YTfwLTkA8ZrIphNYLXXEi/t+FroTMOSvutotTcCHl2SmFHN
         Veyg==
X-Gm-Message-State: AO0yUKV2qLiogVg9+ssgmtwluKVcUinEE7DT63JqQNxYzPyJS28tFsot
        cYB28YO+FUlBegsLlrXvVfrtNA==
X-Google-Smtp-Source: AK7set+xTuAJzQc0uULFQeqTwUTCoMklSzXAufpbBVloRdxCMVGokbPwteSaL1f1+7dcXUf7gQLZDA==
X-Received: by 2002:a17:907:9713:b0:861:7a02:1046 with SMTP id jg19-20020a170907971300b008617a021046mr20673191ejc.37.1678203559630;
        Tue, 07 Mar 2023 07:39:19 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:a60f:e604:c252:1f3d? ([2a02:810d:15c0:828:a60f:e604:c252:1f3d])
        by smtp.gmail.com with ESMTPSA id q10-20020a50c34a000000b004bda465da32sm6965274edb.1.2023.03.07.07.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 07:39:19 -0800 (PST)
Message-ID: <059bec3f-0c77-fc16-83a3-d78cf82d543f@linaro.org>
Date:   Tue, 7 Mar 2023 16:39:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/11] remoteproc: qcom: Add Hexagon based multipd rproc
 driver
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, mathieu.poirier@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_gurus@quicinc.com,
        loic.poulain@linaro.org, quic_eberman@quicinc.com,
        robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-9-git-send-email-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678164097-13247-9-git-send-email-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 05:41, Manikanta Mylavarapu wrote:
> APSS brings Q6 out of reset and then Q6 brings
> WCSS block (wifi radio's) out of reset.
> 
> 				   ---------------
> 			      -->  |WiFi 2G radio|
> 			      |	   --------------
> 			      |
> --------	-------	      |
> | APSS | --->   |QDSP6|  -----|
> ---------	-------       |
>                               |
>       			      |
> 			      |   --------------
> 			      --> |WiFi 5G radio|
> 				  --------------
> 
> Problem here is if any radio crashes, subsequently other
> radio also should crash because Q6 crashed. Let's say
> 2G radio crashed, Q6 should pass this info to APSS. Only
> Q6 processor interrupts registered with APSS. Obviously
> Q6 should crash and raise fatal interrupt to APSS. Due
> to this 5G radio also crashed. But no issue in 5G radio,
> because of 2G radio crash 5G radio also impacted.
> 


Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> In multi pd model, this problem is resolved. Here WCSS
> functionality (WiFi radio's) moved out from Q6 root pd
> to a separate user pd. Due to this, radio's independently
> pass their status info to APPS with out crashing Q6. So
> other radio's won't be impacted.
> 
> 						---------
> 					    	|WiFi    |
> 					    --> |2G radio|
> 					    | 	---------
> ------	Start Q6     		-------     |
> |    |	------------------>     |     |     |
> |    |  Start WCSS PD1 (2G)   	|     |	    |
> |APSS|	----------------------->|QDSP6|-----|
> |    |	Start WCSS PD1 (5G)	|     |
> |    |	----------------------->|     |-----|
> ------		     		-------     |
> 					    |
> 					    |	-----------
> 					    |-->|WiFi	  |
> 						|5G radio |
> 						-----------
> According to linux terminology, here consider Q6 as root
> i.e it provide all services, WCSS (wifi radio's) as user
> i.e it uses services provided by root.
> 
> Since Q6 root & WCSS user pd's able to communicate with
> APSS individually, multipd remoteproc driver registers
> each PD with rproc framework. Here clients (Wifi host drivers)
> intrested on WCSS PD rproc, so multipd driver start's root
> pd in the context of WCSS user pd rproc start. Similarly
> on down path, root pd will be stopped after wcss user pd
> stopped.
> 
> Here WCSS(user) PD is dependent on Q6(root) PD, so first
> q6 pd should be up before wcss pd. After wcss pd goes down,
> q6 pd should be turned off.
> 
> rproc->ops->start(userpd_rproc) {
> 	/* Boot root pd rproc */
> 	rproc_boot(upd_dev->parent);
> 	---
> 	/* user pd rproc start sequence */
> 	---
> 	---
> }
> With this way we ensure that root pd brought up before userpd.
> 
> rproc->ops->stop(userpd_rproc) {
> 	---
> 	---
> 	/* user pd rproc stop sequence */
> 	---
> 	---
> 	/* Shutdown root pd rproc */
> 	rproc_shutdown(upd_dev->parent);
> }
> After userpd rproc stops, root pd rproc will be stopped.
> IPQ5018, IPQ9574 supports multipd remoteproc driver.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  drivers/firmware/qcom_scm.c            | 114 +++++
>  drivers/firmware/qcom_scm.h            |   6 +
>  drivers/remoteproc/Kconfig             |  20 +
>  drivers/remoteproc/Makefile            |   1 +
>  drivers/remoteproc/qcom_common.c       |  23 +
>  drivers/remoteproc/qcom_common.h       |   1 +
>  drivers/remoteproc/qcom_q6v5.c         |  41 +-
>  drivers/remoteproc/qcom_q6v5.h         |  15 +-
>  drivers/remoteproc/qcom_q6v5_adsp.c    |   5 +-
>  drivers/remoteproc/qcom_q6v5_mpd.c     | 668 +++++++++++++++++++++++++

Why exactly do you need a new driver for this instead of extending
existing PIL? I feel all this is growing because no one wants to touch
existing code and merge with it...


>  drivers/remoteproc/qcom_q6v5_mss.c     |   4 +-
>  drivers/remoteproc/qcom_q6v5_pas.c     |   3 +-
>  drivers/soc/qcom/mdt_loader.c          | 314 ++++++++++++
>  include/linux/firmware/qcom/qcom_scm.h |   3 +
>  include/linux/soc/qcom/mdt_loader.h    |  19 +
>  15 files changed, 1228 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/remoteproc/qcom_q6v5_mpd.c
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index d88c5f14bd54..d69560963353 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -654,6 +654,120 @@ int qcom_scm_pas_shutdown(u32 peripheral)
>  }
>  EXPORT_SYMBOL(qcom_scm_pas_shutdown);
>  
> +/**
> + * qti_scm_int_radio_powerup - Bring up internal radio userpd
> + *
> + * @peripheral:	peripheral id
> + *
> + * Return 0 on success.
> + */

...

> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 91314a9b43ce..b64051080ec1 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_QCOM_PIL_INFO)		+= qcom_pil_info.o
>  obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
>  obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
>  obj-$(CONFIG_QCOM_Q6V5_ADSP)		+= qcom_q6v5_adsp.o
> +obj-$(CONFIG_QCOM_Q6V5_MPD)		+= qcom_q6v5_mpd.o
>  obj-$(CONFIG_QCOM_Q6V5_MSS)		+= qcom_q6v5_mss.o
>  obj-$(CONFIG_QCOM_Q6V5_PAS)		+= qcom_q6v5_pas.o
>  obj-$(CONFIG_QCOM_Q6V5_WCSS)		+= qcom_q6v5_wcss.o
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index a0d4238492e9..b72fbda02242 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -510,5 +510,28 @@ void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr)
>  }
>  EXPORT_SYMBOL_GPL(qcom_remove_ssr_subdev);
>  
> +/**
> + * qcom_get_pd_asid() - get the pd asid number from DT node
> + * @node:	device tree node
> + *
> + * Returns asid if node name has 'pd' string
> + */
> +s8 qcom_get_pd_asid(struct device_node *node)
> +{
> +	char *str;
> +	u8 pd_asid;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	str = strstr(node->name, "pd");
> +	if (!str)
> +		return 0;
> +
> +	str += strlen("pd");
> +	return kstrtos8(str, 10, &pd_asid) ? -EINVAL : pd_asid;
> +}
> +EXPORT_SYMBOL(qcom_get_pd_asid);

Why do you need it in shared file?

> +
>  MODULE_DESCRIPTION("Qualcomm Remoteproc helper driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
> index 9ef4449052a9..9f3fb11224aa 100644
> --- a/drivers/remoteproc/qcom_common.h
> +++ b/drivers/remoteproc/qcom_common.h
> @@ -75,5 +75,6 @@ static inline bool qcom_sysmon_shutdown_acked(struct qcom_sysmon *sysmon)
>  	return false;
>  }
>  #endif
> +s8 qcom_get_pd_asid(struct device_node *node);
>  
>  #endif
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index 192c7aa0e39e..b88bf3a8e53b 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -118,7 +118,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
> +irqreturn_t q6v5_fatal_interrupt(int irq, void *data)

The amount of changes you are doing to other interfaces is worrying...
Actually it points to the fact that you are duplicating a lot instead of
merging the code.

Also this patch is doing so many things at the same time.

>  {
>  	struct qcom_q6v5 *q6v5 = data;
>  	size_t len;
> @@ -139,7 +139,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t q6v5_ready_interrupt(int irq, void *data)
> +irqreturn_t q6v5_ready_interrupt(int irq, void *data)
>  {
>  	struct qcom_q6v5 *q6v5 = data;
>  
> @@ -183,7 +183,16 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t q6v5_stop_interrupt(int irq, void *data)
> +irqreturn_t q6v5_spawn_interrupt(int irq, void *data)

> +{
> +	struct qcom_q6v5 *q6v5 = data;
> +
> +	complete(&q6v5->spawn_done);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t q6v5_stop_interrupt(int irq, void *data)
>  {
>  	struct qcom_q6v5 *q6v5 = data;
>  
> @@ -220,6 +229,28 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon)
>  }
>  EXPORT_SYMBOL_GPL(qcom_q6v5_request_stop);
>  
> +/**
> + * qcom_q6v5_request_spawn() - request the remote processor to spawn
> + * @q6v5:      reference to qcom_q6v5 context
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int qcom_q6v5_request_spawn(struct qcom_q6v5 *q6v5)
> +{
> +	int ret;
> +
> +	ret = qcom_smem_state_update_bits(q6v5->spawn_state,
> +					  BIT(q6v5->spawn_bit), BIT(q6v5->spawn_bit));
> +
> +	ret = wait_for_completion_timeout(&q6v5->spawn_done, 5 * HZ);
> +
> +	qcom_smem_state_update_bits(q6v5->spawn_state,
> +				    BIT(q6v5->spawn_bit), 0);
> +
> +	return ret == 0 ? -ETIMEDOUT : 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_q6v5_request_spawn);
> +
>  /**
>   * qcom_q6v5_panic() - panic handler to invoke a stop on the remote
>   * @q6v5:	reference to qcom_q6v5 context
> @@ -250,7 +281,8 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
>   * Return: 0 on success, negative errno on failure
>   */
>  int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
> -		   struct rproc *rproc, int crash_reason, const char *load_state,
> +		   struct rproc *rproc, int remote_id, int crash_reason,
> +		   const char *load_state,
>  		   void (*handover)(struct qcom_q6v5 *q6v5))
>  {
>  	int ret;
> @@ -258,6 +290,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>  	q6v5->rproc = rproc;
>  	q6v5->dev = &pdev->dev;
>  	q6v5->crash_reason = crash_reason;
> +	q6v5->remote_id = remote_id;
>  	q6v5->handover = handover;
>  
>  	init_completion(&q6v5->start_done);
> diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
> index 5a859c41896e..d00568339d46 100644
> --- a/drivers/remoteproc/qcom_q6v5.h
> +++ b/drivers/remoteproc/qcom_q6v5.h
> @@ -18,22 +18,29 @@ struct qcom_q6v5 {
>  
>  	struct qcom_smem_state *state;
>  	struct qmp *qmp;
> +	struct qcom_smem_state *shutdown_state;
> +	struct qcom_smem_state *spawn_state;
>  
>  	struct icc_path *path;
>  
>  	unsigned stop_bit;
> +	unsigned shutdown_bit;
> +	unsigned spawn_bit;
>  
>  	int wdog_irq;
>  	int fatal_irq;
>  	int ready_irq;
>  	int handover_irq;
>  	int stop_irq;
> +	int spawn_irq;
>  
>  	bool handover_issued;
>  
>  	struct completion start_done;
>  	struct completion stop_done;
> +	struct completion spawn_done;
>  
> +	int remote_id;
>  	int crash_reason;
>  
>  	bool running;
> @@ -43,14 +50,20 @@ struct qcom_q6v5 {
>  };
>  
>  int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
> -		   struct rproc *rproc, int crash_reason, const char *load_state,
> +		   struct rproc *rproc, int remote_id, int crash_reason,
> +		   const char *load_state,
>  		   void (*handover)(struct qcom_q6v5 *q6v5));
>  void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5);
>  
>  int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5);
>  int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5);
>  int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon);
> +int qcom_q6v5_request_spawn(struct qcom_q6v5 *q6v5);
>  int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout);
>  unsigned long qcom_q6v5_panic(struct qcom_q6v5 *q6v5);
> +irqreturn_t q6v5_fatal_interrupt(int irq, void *data);
> +irqreturn_t q6v5_ready_interrupt(int irq, void *data);
> +irqreturn_t q6v5_spawn_interrupt(int irq, void *data);
> +irqreturn_t q6v5_stop_interrupt(int irq, void *data);
>  
>  #endif
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 08d8dad22ca7..bf8909ad5ff5 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -733,8 +733,9 @@ static int adsp_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto disable_pm;
>  
> -	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
> -			     desc->load_state, qcom_adsp_pil_handover);
> +	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
> +			     desc->crash_reason_smem, desc->load_state,
> +			     qcom_adsp_pil_handover);
>  	if (ret)
>  		goto disable_pm;
>  
> diff --git a/drivers/remoteproc/qcom_q6v5_mpd.c b/drivers/remoteproc/qcom_q6v5_mpd.c
> new file mode 100644
> index 000000000000..853aa3bc5859
> --- /dev/null
> +++ b/drivers/remoteproc/qcom_q6v5_mpd.c
> @@ -0,0 +1,668 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016-2018 Linaro Ltd.
> + * Copyright (C) 2014 Sony Mobile Communications AB
> + * Copyright (c) 2012-2018, 2021 The Linux Foundation. All rights reserved.
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/soc/qcom/mdt_loader.h>
> +#include <linux/soc/qcom/smem.h>
> +#include <linux/soc/qcom/smem_state.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/interrupt.h>
> +#include "qcom_common.h"
> +#include "qcom_q6v5.h"
> +
> +#include "remoteproc_internal.h"
> +
> +#define WCSS_CRASH_REASON		421
> +#define WCSS_SMEM_HOST			1
> +
> +#define WCNSS_PAS_ID			6
> +#define MPD_WCNSS_PAS_ID        0xD
> +
> +#define BUF_SIZE			35
> +
> +/**
> + * enum state - state of a wcss (private)
> + * @WCSS_NORMAL: subsystem is operating normally
> + * @WCSS_CRASHED: subsystem has crashed and hasn't been shutdown
> + * @WCSS_RESTARTING: subsystem has been shutdown and is now restarting
> + * @WCSS_SHUTDOWN: subsystem has been shutdown
> + *
> + */
> +enum q6_wcss_state {
> +	WCSS_NORMAL,
> +	WCSS_CRASHED,
> +	WCSS_RESTARTING,
> +	WCSS_SHUTDOWN,
> +};
> +
> +enum {
> +	Q6_IPQ,
> +	WCSS_AHB_IPQ,
> +	WCSS_PCIE_IPQ,
> +};
> +
> +struct q6_wcss {
> +	struct device *dev;
> +	struct qcom_rproc_glink glink_subdev;
> +	struct qcom_rproc_ssr ssr_subdev;
> +	struct qcom_q6v5 q6;
> +	phys_addr_t mem_phys;
> +	phys_addr_t mem_reloc;
> +	void *mem_region;
> +	size_t mem_size;
> +	int crash_reason_smem;
> +	u32 version;
> +	s8 pd_asid;
> +	enum q6_wcss_state state;
> +};
> +
> +struct wcss_data {
> +	int (*init_irq)(struct qcom_q6v5 *q6, struct platform_device *pdev,
> +			struct rproc *rproc, int remote_id,
> +			int crash_reason, const char *load_state,
> +			void (*handover)(struct qcom_q6v5 *q6));
> +	const char *q6_firmware_name;
> +	int crash_reason_smem;
> +	int remote_id;
> +	u32 version;
> +	const char *ssr_name;
> +	const struct rproc_ops *ops;
> +	bool need_auto_boot;
> +	bool glink_subdev_required;
> +	s8 pd_asid;
> +	bool reset_seq;
> +	u32 pasid;
> +	int (*mdt_load_sec)(struct device *dev, const struct firmware *fw,
> +			    const char *fw_name, int pas_id, void *mem_region,
> +			    phys_addr_t mem_phys, size_t mem_size,
> +			    phys_addr_t *reloc_base);
> +};
> +
> +static int q6_wcss_start(struct rproc *rproc)
> +{
> +	struct q6_wcss *wcss = rproc->priv;
> +	int ret;
> +	struct device_node *upd_np;
> +	struct platform_device *upd_pdev;
> +	struct rproc *upd_rproc;
> +	struct q6_wcss *upd_wcss;
> +	const struct wcss_data *desc;
> +
> +	desc = of_device_get_match_data(wcss->dev);

Why do you match in start callback, not in probe?

> +	if (!desc)
> +		return -EINVAL;
> +
> +	qcom_q6v5_prepare(&wcss->q6);
> +
> +	ret = qcom_scm_pas_auth_and_reset(desc->pasid);
> +	if (ret) {
> +		dev_err(wcss->dev, "wcss_reset failed\n");
> +		return ret;
> +	}
> +
> +	ret = qcom_q6v5_wait_for_start(&wcss->q6, 5 * HZ);
> +	if (ret == -ETIMEDOUT)
> +		dev_err(wcss->dev, "start timed out\n");
> +
> +	/* Bring userpd wcss state to default value */
> +	for_each_available_child_of_node(wcss->dev->of_node, upd_np) {
> +		if (!strstr(upd_np->name, "pd"))

Device node names are not an ABI. Don't try to make them, NAK.

> +			continue;
> +		upd_pdev = of_find_device_by_node(upd_np);
> +		upd_rproc = platform_get_drvdata(upd_pdev);
> +		upd_wcss = upd_rproc->priv;
> +		upd_wcss->state = WCSS_NORMAL;
> +	}
> +	return ret;

So all this looks pretty standard and simialr to other wcss/pils...

> +}
> +
> +static int q6_wcss_spawn_pd(struct rproc *rproc)
> +{
> +	int ret;
> +	struct q6_wcss *wcss = rproc->priv;
> +
> +	ret = qcom_q6v5_request_spawn(&wcss->q6);
> +	if (ret == -ETIMEDOUT) {
> +		pr_err("%s spawn timedout\n", rproc->name);
> +		return ret;
> +	}
> +
> +	ret = qcom_q6v5_wait_for_start(&wcss->q6, msecs_to_jiffies(10000));
> +	if (ret == -ETIMEDOUT) {
> +		pr_err("%s start timedout\n", rproc->name);
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
> +	const struct wcss_data *desc = of_device_get_match_data(wcss->dev);
> +	int ret;
> +
> +	if (desc->reset_seq) {
> +		ret = qti_scm_int_radio_powerup(desc->pasid);
> +		if (ret) {
> +			dev_err(wcss->dev, "failed to power up ahb pd\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (wcss->q6.spawn_bit) {
> +		ret = q6_wcss_spawn_pd(rproc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	wcss->state = WCSS_NORMAL;
> +	return 0;
> +}
> +
> +static int q6_wcss_stop(struct rproc *rproc)
> +{
> +	struct q6_wcss *wcss = rproc->priv;
> +	int ret;
> +	const struct wcss_data *desc =
> +			of_device_get_match_data(wcss->dev);
> +
> +	if (!desc)
> +		return -EINVAL;
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
> +	const struct wcss_data *desc = of_device_get_match_data(wcss->dev);
> +	int ret;
> +
> +	if (rproc->state != RPROC_CRASHED && wcss->q6.stop_bit) {
> +		ret = qcom_q6v5_request_stop(&wcss->q6, NULL);
> +		if (ret) {
> +			dev_err(&rproc->dev, "pd not stopped\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (desc->reset_seq) {
> +		ret = qti_scm_int_radio_powerdown(desc->pasid);
> +		if (ret) {
> +			dev_err(wcss->dev, "failed to power down pd\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (rproc->state != RPROC_CRASHED)
> +		rproc_shutdown(rpd_rproc);
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
> +	const struct firmware *m3_fw;
> +	int ret;
> +	const char *m3_fw_name;
> +	struct device_node *upd_np;
> +	struct platform_device *upd_pdev;
> +	const struct wcss_data *desc =
> +				of_device_get_match_data(wcss->dev);
> +
> +	if (!desc)
> +		return -EINVAL;
> +
> +	/* load m3 firmware */
> +	for_each_available_child_of_node(wcss->dev->of_node, upd_np) {
> +		if (!strstr(upd_np->name, "pd"))
> +			continue;
> +		upd_pdev = of_find_device_by_node(upd_np);
> +
> +		ret = of_property_read_string(upd_np, "m3_firmware",
> +					      &m3_fw_name);

Undocumented property. Drop.

> +		if (!ret && m3_fw_name) {
> +			ret = request_firmware(&m3_fw, m3_fw_name,
> +					       &upd_pdev->dev);
> +			if (ret)
> +				continue;
> +
> +			ret = qcom_mdt_load_no_init(wcss->dev, m3_fw,
> +						    m3_fw_name, 0,
> +						    wcss->mem_region,
> +						    wcss->mem_phys,
> +						    wcss->mem_size,
> +						    &wcss->mem_reloc);
> +
> +			release_firmware(m3_fw);
> +
> +			if (ret) {
> +				dev_err(wcss->dev,
> +					"can't load m3_fw.bXX ret:%d\n", ret);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return qcom_mdt_load(wcss->dev, fw, rproc->firmware,
> +				desc->pasid, wcss->mem_region,
> +				wcss->mem_phys, wcss->mem_size,
> +				&wcss->mem_reloc);
> +}
> +
> +static int wcss_ahb_pcie_pd_load(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct q6_wcss *wcss = rproc->priv, *wcss_rpd;
> +	struct rproc *rpd_rproc = dev_get_drvdata(wcss->dev->parent);
> +	int ret;
> +	const struct wcss_data *desc =
> +				of_device_get_match_data(wcss->dev);

Actually now I see you match devices in all over the place. Don't do it,
there is no need. Match it once and use the result.

This really should not introduce its own patterns and coding style.

> +
> +	if (!desc)
> +		return -EINVAL;
> +
> +	wcss_rpd = rpd_rproc->priv;
> +
> +	/* Boot rootpd rproc */
> +	ret = rproc_boot(rpd_rproc);
> +	if (ret || wcss->state == WCSS_NORMAL)
> +		return ret;
> +
> +	return desc->mdt_load_sec(wcss->dev, fw, rproc->firmware,
> +				desc->pasid, wcss->mem_region,
> +				wcss->mem_phys, wcss->mem_size,
> +				&wcss->mem_reloc);
> +}

(...)

> +MODULE_DESCRIPTION("Hexagon WCSS Multipd Peripheral Image Loader");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index ab053084f7a2..48685bb85718 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -28,6 +28,7 @@
>  #include <linux/soc/qcom/mdt_loader.h>
>  #include <linux/iopoll.h>
>  #include <linux/slab.h>
> +#include <linux/soc/qcom/smem.h>
>  
>  #include "remoteproc_internal.h"
>  #include "qcom_common.h"
> @@ -2070,7 +2071,8 @@ static int q6v5_probe(struct platform_device *pdev)
>  	qproc->need_mem_protection = desc->need_mem_protection;
>  	qproc->has_mba_logs = desc->has_mba_logs;
>  
> -	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM, "modem",
> +	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,

Not obvious... aren't you doing multiple things in one patch?


Best regards,
Krzysztof


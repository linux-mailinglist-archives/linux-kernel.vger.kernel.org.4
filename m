Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F12603A15
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJSGtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJSGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:49:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8881D74B86
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:49:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so13874247wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EHEfbD5vjmeOcpHWoErGZrblUmEAMtTtw+iah1+Okec=;
        b=vkdXLC+CfEqDYB+MG92p+/3r4s/n2BElmI9rdXfDI6BXbzRkUVkyOJD+gVoAYn4jFS
         UzLtrQFvlfBWjFM47+5+YdldvqZh2TyvFuWDBdSqpVhqUC80WtmuBR/xMmYCJqIDKpAL
         VG38qFSyJA3tdUozgFvVyrVK7lhpqiGDm0g+gR+mMh631eW/PaFwzJszvIW5PlKqnnid
         H1Ew70aCzWO8tu+jM1SZ+zUulO5/TCn0WKKwpgsu+yjzcTezHcJqVGgXEFGwawi7fU4R
         Fh29ga68Vp6domIauYLHAdMwBcyjnMZs9fhGtAPm7vw0VBxpriUkzVZA88GkUJ9Srh9A
         1Mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHEfbD5vjmeOcpHWoErGZrblUmEAMtTtw+iah1+Okec=;
        b=mHzN7XpLw9FHD1Gdx+qALjrcMQ+vVEAu5yZeI3b4gBP685mkhuCc7/hThwiRSTD6tv
         l7mbllYGjBQkYpbPiMgMII8Y5aB4qsjKzAs8jhbKMBV8icrBaQa1eS21S2WoWeC8QU/I
         RY2FX4ufMC/53dD2J1wU1pbMU97vK1j3CJbnwDDV3zka36ibpVcwspwqlU/AqfaSmGAn
         WxRJ6QYwXMxm7uGAi+fCSEh3BMBzE5yQ2PV5WdsURVV/JXhVROwP8HF0/YdUBpJwKC7g
         nHv1f8F4BFCdKml4foPUveztFLSXACwMUp8Yk7mAtVfnnMDj20fgJxdzFRElq+s6b+cg
         jf/w==
X-Gm-Message-State: ACrzQf13Zs7G0VCoam806CbKjC8M46m567umkoGZNFPCq41VH4gn2GHf
        QJi4z5gwCDxzOiwp0JFHeqXz/w==
X-Google-Smtp-Source: AMsMyM42nUY5dDESTRMIUp3phXVtozgM6j7UcbWX9Pe0oMKDz8gvs9oh7Yh+mHuNtFgFV0PQMChBZA==
X-Received: by 2002:a05:600c:4587:b0:3c6:f645:dbc2 with SMTP id r7-20020a05600c458700b003c6f645dbc2mr10322939wmo.83.1666162145922;
        Tue, 18 Oct 2022 23:49:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b15b:4b56:592a:c397? ([2a01:e0a:982:cbb0:b15b:4b56:592a:c397])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b003a682354f63sm5268601wmo.11.2022.10.18.23.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 23:49:05 -0700 (PDT)
Message-ID: <9c2b2e78-73ea-ebac-b91a-a8766bd60d27@linaro.org>
Date:   Wed, 19 Oct 2022 08:49:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 1/1] drivers: remoteproc: Add bus scaling capability
 during bootup
Content-Language: en-US
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
References: <35eb4ce2bb8f3bb78a616c071a012f1f49d8b593.1666127246.git.quic_gokukris@quicinc.com>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <35eb4ce2bb8f3bb78a616c071a012f1f49d8b593.1666127246.git.quic_gokukris@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gokul,

On 18/10/2022 23:10, Gokul krishna Krishnakumar wrote:
> During bootup since remote processors cannot request for
> additional bus bandwidth from the interconect framework,
> platform driver should provide the proxy resources. Make
> a proxy vote for maximizing the bus bandwidth during bootup
> for a remote processor and remove it once processor is up.

A similar change has been upstreamed in
- [0] 65b7ebda5028 ("firmware: qcom_scm: Add bw voting support to the SCM interface")
- [1] 8d9be5c6bdcd ("remoteproc: qcom: q6v5: Add interconnect path proxy vote")

The main difference with this patch are:
- [0] only votes for each scm calls, not across multiple calls, is that a problem ?
- [0] & [1] votes (0, UINT_MAX) but you change votes (UINT_MAX, UINT_MAX), does this make a difference ?

[0] https://github.com/torvalds/linux/commit/65b7ebda5028
[1] https://github.com/torvalds/linux/commit/8d9be5c6bdcd

> 
> Change-Id: I798b3b000aef4761a7ff8cb6390b7ecd98f925b7
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 106 ++++++++++++++++++++++++++++++++++---
>   1 file changed, 100 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 6afd094..b02a1dc 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -21,6 +21,7 @@
>   #include <linux/qcom_scm.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/remoteproc.h>
> +#include <linux/interconnect.h>
>   #include <linux/soc/qcom/mdt_loader.h>
>   #include <linux/soc/qcom/smem.h>
>   #include <linux/soc/qcom/smem_state.h>
> @@ -30,8 +31,14 @@
>   #include "qcom_q6v5.h"
>   #include "remoteproc_internal.h"
>   
> +#define PIL_TZ_AVG_BW	UINT_MAX
> +#define PIL_TZ_PEAK_BW	UINT_MAX
>   #define ADSP_DECRYPT_SHUTDOWN_DELAY_MS	100
>   
> +static struct icc_path *scm_perf_client;
> +static int scm_pas_bw_count;
> +static DEFINE_MUTEX(scm_pas_bw_mutex);
> +
>   struct adsp_data {
>   	int crash_reason_smem;
>   	const char *firmware_name;
> @@ -67,6 +74,7 @@ struct qcom_adsp {
>   
>   	int pas_id;
>   	unsigned int minidump_id;
> +	struct icc_path *bus_client;
>   	int crash_reason_smem;
>   	bool has_aggre2_clk;
>   	bool decrypt_shutdown;
> @@ -136,6 +144,44 @@ static void adsp_pds_disable(struct qcom_adsp *adsp, struct device **pds,
>   	}
>   }
>   
> +static int scm_pas_enable_bw(void)
> +{
> +	int ret = 0;
> +
> +	if (IS_ERR(scm_perf_client))
> +		return -EINVAL;
> +
> +	mutex_lock(&scm_pas_bw_mutex);
> +	if (!scm_pas_bw_count) {
> +		ret = icc_set_bw(scm_perf_client, PIL_TZ_AVG_BW,
> +						PIL_TZ_PEAK_BW);
> +		if (ret)
> +			goto err_bus;
> +	}
> +
> +	scm_pas_bw_count++;
> +	mutex_unlock(&scm_pas_bw_mutex);
> +	return ret;
> +
> +err_bus:
> +	pr_err("scm-pas: Bandwidth request failed (%d)\n", ret);
> +	icc_set_bw(scm_perf_client, 0, 0);
> +
> +	mutex_unlock(&scm_pas_bw_mutex);
> +	return ret;
> +}
> +
> +static void scm_pas_disable_bw(void)
> +{
> +	if (IS_ERR(scm_perf_client))
> +		return;
> +
> +	mutex_lock(&scm_pas_bw_mutex);
> +	if (scm_pas_bw_count-- == 1)
> +		icc_set_bw(scm_perf_client, 0, 0);
> +	mutex_unlock(&scm_pas_bw_mutex);
> +}
> +
>   static int adsp_shutdown_poll_decrypt(struct qcom_adsp *adsp)
>   {
>   	unsigned int retry_num = 50;
> @@ -174,15 +220,35 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>   	if (ret)
>   		return ret;
>   
> +	scm_pas_enable_bw();
>   	ret = qcom_mdt_load_no_init(adsp->dev, fw, rproc->firmware, adsp->pas_id,
>   				    adsp->mem_region, adsp->mem_phys, adsp->mem_size,
>   				    &adsp->mem_reloc);
>   	if (ret)
> -		return ret;
> +		goto exit;
>   
>   	qcom_pil_info_store(adsp->info_name, adsp->mem_phys, adsp->mem_size);
> +exit:
> +	scm_pas_disable_bw();
> +	return ret;
> +}
>   
> -	return 0;
> +static int do_bus_scaling(struct qcom_adsp *adsp, bool enable)
> +{
> +	int rc = 0;
> +	u32 avg_bw = enable ? PIL_TZ_AVG_BW : 0;
> +	u32 peak_bw = enable ? PIL_TZ_PEAK_BW : 0;
> +
> +	if (IS_ERR(adsp->bus_client))
> +		dev_err(adsp->dev, "Bus scaling not setup for %s\n",
> +			adsp->rproc->name);
> +	else
> +		rc = icc_set_bw(adsp->bus_client, avg_bw, peak_bw);
> +
> +	if (rc)
> +		dev_err(adsp->dev, "bandwidth request failed(rc:%d)\n", rc);
> +
> +	return rc;
>   }
>   
>   static int adsp_start(struct rproc *rproc)
> @@ -194,10 +260,14 @@ static int adsp_start(struct rproc *rproc)
>   	if (ret)
>   		return ret;
>   
> -	ret = adsp_pds_enable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
> +	ret = do_bus_scaling(adsp, true);
>   	if (ret < 0)
>   		goto disable_irqs;
>   
> +	ret = adsp_pds_enable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
> +	if (ret < 0)
> +		goto unscale_bus;
> +
>   	ret = clk_prepare_enable(adsp->xo);
>   	if (ret)
>   		goto disable_proxy_pds;
> @@ -218,6 +288,8 @@ static int adsp_start(struct rproc *rproc)
>   			goto disable_cx_supply;
>   	}
>   
> +	scm_pas_enable_bw();
> +
>   	ret = qcom_scm_pas_auth_and_reset(adsp->pas_id);
>   	if (ret) {
>   		dev_err(adsp->dev,
> @@ -234,9 +306,10 @@ static int adsp_start(struct rproc *rproc)
>   
>   	qcom_scm_pas_metadata_release(&adsp->pas_metadata);
>   
> -	return 0;
> -
>   disable_px_supply:
> +	scm_pas_disable_bw();
> +	if(!ret)
> +		goto exit;
>   	if (adsp->px_supply)
>   		regulator_disable(adsp->px_supply);
>   disable_cx_supply:
> @@ -248,9 +321,11 @@ static int adsp_start(struct rproc *rproc)
>   	clk_disable_unprepare(adsp->xo);
>   disable_proxy_pds:
>   	adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
> +unscale_bus:
> +	do_bus_scaling(adsp, false);
>   disable_irqs:
>   	qcom_q6v5_unprepare(&adsp->q6v5);
> -
> +exit:
>   	return ret;
>   }
>   
> @@ -265,6 +340,7 @@ static void qcom_pas_handover(struct qcom_q6v5 *q6v5)
>   	clk_disable_unprepare(adsp->aggre2_clk);
>   	clk_disable_unprepare(adsp->xo);
>   	adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
> +	do_bus_scaling(adsp, false);
>   }
>   
>   static int adsp_stop(struct rproc *rproc)
> @@ -383,6 +459,22 @@ static int adsp_init_regulator(struct qcom_adsp *adsp)
>   	return 0;
>   }
>   
> +static void adsp_init_bus_scaling(struct qcom_adsp *adsp)
> +{
> +	if (scm_perf_client)
> +		goto get_rproc_client;
> +
> +	scm_perf_client = of_icc_get(adsp->dev, "crypto_ddr");
> +	if (IS_ERR(scm_perf_client))
> +		dev_warn(adsp->dev, "Crypto scaling not setup\n");
> +
> +get_rproc_client:
> +	adsp->bus_client = of_icc_get(adsp->dev, "rproc_ddr");
> +	if (IS_ERR(adsp->bus_client))
> +		dev_warn(adsp->dev, "%s: No bus client\n", __func__);
> +
> +}
> +
>   static int adsp_pds_attach(struct device *dev, struct device **devs,
>   			   char **pd_names)
>   {
> @@ -525,6 +617,8 @@ static int adsp_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto free_rproc;
>   
> +	adsp_init_bus_scaling(adsp);
> +
>   	ret = adsp_pds_attach(&pdev->dev, adsp->proxy_pds,
>   			      desc->proxy_pd_names);
>   	if (ret < 0)


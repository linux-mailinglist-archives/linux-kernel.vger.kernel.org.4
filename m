Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A38717A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjEaIsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjEaIsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:48:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5502010CA;
        Wed, 31 May 2023 01:47:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so546656f8f.1;
        Wed, 31 May 2023 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685522873; x=1688114873;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=op3yDZuhLildiEClG3ofYGddByOEYT8YVnfVcFniJM4=;
        b=P2cYuxP9Bq8/926b/sL6/xaVlK+ftTA5gn6K3qSNfN0To9H8ZbM1nXg1NwtPSnGuPm
         2GKuvm4Nfpsqfmmh/HeQLwS1c30o3RXb8ljqv2cHgFwxusDYZg6muNyoV5oNZiZKORI1
         6HSmPVfg1Y9AwIh9w6njbol98QSSSG4JbhcVfsojVm3dpt2i7qyfBp9BQvmqQwQFh3zF
         PjJQM3nN8r/4+feWXZECAu+R6eUOjZiAvleH1EGfq8xcczjnyY7oqjl9XhlsvapJv9/I
         Lq9pX3AAUE67mWJAzm97Me7oOfZklN5FIwliA6r/tvL+9gHmOWxsHMwSi2oSjtEa8+3N
         70tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685522873; x=1688114873;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op3yDZuhLildiEClG3ofYGddByOEYT8YVnfVcFniJM4=;
        b=gAubauXRFAoc3fbYmOjJ9wF5AZAflZgYM2m50X1QimRqYU4uNTk4iZuxL31MygVZCa
         TJt1pS+/3lSwcmQ7x2ddaDF5221SsLtBXPo6eoQjsKii3iJsc8zZbUTUR0NQvmP3I93u
         0ZHWapjxGVowDI4+zGSTL4KbtOH9rKEoY3BGqi0UUKN5KtdmRL7qcZBeqyNe5SIMCCwB
         w6zRAtD+7vhAXkDvIZWRKnrdMaiSuD6xMgezSv1bf1tZdrnpsdNWZpmC2m9G+924SYlm
         5gMmvcGQjrBtaUZ1wyTq2xswr1QVtyNFOwg4IOlLlVJW7pSip6tvlcPLcmO+nHgxsdf/
         m43w==
X-Gm-Message-State: AC+VfDxUgJyZknFtUiAIBEr3rXta6ehtuuABdQGQErq8ncGj65vxpzuS
        t5eNH2BUWsS6QXycvWZJWmJV8vravBk=
X-Google-Smtp-Source: ACHHUZ5a7fMycdAntwUgVUjIdNV7lWwpMhgxxjEJBS/4OwVmZiM52mYWFiQDD2lM6ssyWL+IHExDTQ==
X-Received: by 2002:a5d:490b:0:b0:306:2ff1:5227 with SMTP id x11-20020a5d490b000000b003062ff15227mr4283365wrq.23.1685522872506;
        Wed, 31 May 2023 01:47:52 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id i2-20020adfdec2000000b002e61e002943sm5845850wrn.116.2023.05.31.01.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 01:47:52 -0700 (PDT)
Message-ID: <647709b8.df0a0220.28e58.6a42@mx.google.com>
X-Google-Original-Message-ID: <ZHalcEN06Ka4vGFp@Ansuel-xps.>
Date:   Wed, 31 May 2023 03:40:00 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, andersson@kernel.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/2] cpufreq: qcom-nvmem: add support for
 IPQ8064
References: <20230530165807.642084-1-robimarko@gmail.com>
 <20230530165807.642084-2-robimarko@gmail.com>
 <507831fd-326a-a5f7-cdc1-5584ad1aa11b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <507831fd-326a-a5f7-cdc1-5584ad1aa11b@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:40:54AM +0200, Konrad Dybcio wrote:
> 
> 
> On 30.05.2023 18:58, Robert Marko wrote:
> > From: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > IPQ8064 comes in 3 families:
> > * IPQ8062 up to 1.0GHz
> > * IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
> > * IPQ8065/IPQ8069 up to 1.7Ghz
> > 
> > So, in order to be able to share one OPP table, add support for
> > IPQ8064 family based of SMEM SoC ID-s as speedbin fuse is always 0 on
> > IPQ8064.
> > 
> > Bit are set with the following logic:
> > * IPQ8062 BIT 0
> > * IPQ8064/IPQ8066/IPQ8068 BIT 1
> > * IPQ8065/IPQ8069 BIT 2
> > 
> > speed is never fused, only psv values are fused.
> > Set speed to the versions to permit a unified opp table following
> > this named opp:
> > 
> > opp-microvolt-speed<SPEED_VALUE>-pvs<PSV_VALUE>-v0
> > 
> > Example:
> > - for ipq8062 psv2
> >   opp-microvolt-speed0-pvs2-v0 = < 925000 878750 971250>
> > - for ipq8064 psv2
> >   opp-microvolt-speed2-pvs2-v0 = <925000 878750 971250>;
> > - for ipq8065 psv2
> >   opp-microvolt-speed4-pvs2-v0 = <950000 902500 997500>;
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 +++++++++++++++++++++++++++-
> >  1 file changed, 72 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > index ce444b5962f2..c644138680ba 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > @@ -34,6 +34,10 @@
> >  #define IPQ8074_HAWKEYE_VERSION		BIT(0)
> >  #define IPQ8074_ACORN_VERSION		BIT(1)
> >  
> > +#define IPQ8062_VERSION		BIT(0)
> > +#define IPQ8064_VERSION		BIT(1)
> > +#define IPQ8065_VERSION		BIT(2)
> > +
> >  struct qcom_cpufreq_drv;
> >  
> >  struct qcom_cpufreq_match_data {
> > @@ -207,6 +211,69 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> >  	return ret;
> >  }
> >  
> > +static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
> > +					     struct nvmem_cell *speedbin_nvmem,
> > +					     char **pvs_name,
> > +					     struct qcom_cpufreq_drv *drv)
> > +{
> > +	int speed = 0, pvs = 0, pvs_ver = 0;
> > +	int msm_id, ret = 0;
> > +	u8 *speedbin;
> > +	size_t len;
> > +
> > +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> > +
> > +	if (IS_ERR(speedbin))
> > +		return PTR_ERR(speedbin);
> > +
> > +	switch (len) {
> Do we expect more variety here? Otherwise a switch statement sounds a
> bit too heavy for the job, imo.
>

Well no, considering ipq8064 is effectively EOL i guess format 4 is the
only one present. But if you check the driver this is like a pattern so
the idea was too keep that. I can totally change that to a simple
if (len != 4) if we really want.

> > +	case 4:
> > +		get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
> > +				       speedbin);
> > +		break;
> > +	default:
> > +		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
> > +		ret = -ENODEV;
> > +		goto len_error;
> > +	}
> > +
> > +	ret = qcom_smem_get_soc_id(&msm_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (msm_id) {
> > +	case QCOM_ID_IPQ8062:
> > +		drv->versions = IPQ8062_VERSION;
> > +		break;
> > +	case QCOM_ID_IPQ8064:
> > +	case QCOM_ID_IPQ8066:
> > +	case QCOM_ID_IPQ8068:
> > +		drv->versions = IPQ8064_VERSION;
> > +		break;
> > +	case QCOM_ID_IPQ8065:
> > +	case QCOM_ID_IPQ8069:
> > +		drv->versions = IPQ8065_VERSION;
> > +		break;
> > +	default:
> > +		dev_err(cpu_dev,
> > +			"SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
> > +			msm_id);
> > +		drv->versions = IPQ8062_VERSION;
> > +		break;
> > +	}
> > +
> > +	/*
> > +	 * IPQ8064 speed is never fused. Only psv values are fused.
> > +	 * Set speed to the versions to permit a unified opp table.
> > +	 */
> > +	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
> > +		 drv->versions, pvs, pvs_ver);
> > +
> > +len_error:
> > +	kfree(speedbin);
> Perhaps we should switch to devres-managed nvmem soon..
> 

devres nvmem would be very good, maybe an idea would be search for the
actualy use of nvmem_cell_read and see if it's worth to introduce these
new API.

> > +	return ret;
> > +}
> > +
> >  static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
> >  					     struct nvmem_cell *speedbin_nvmem,
> >  					     char **pvs_name,
> > @@ -256,6 +323,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
> >  	.genpd_names = qcs404_genpd_names,
> >  };
> >  
> > +static const struct qcom_cpufreq_match_data match_data_ipq8064 = {
> > +	.get_version = qcom_cpufreq_ipq8064_name_version,
> > +};
> > +
> >  static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
> >  	.get_version = qcom_cpufreq_ipq8074_name_version,
> >  };
> > @@ -404,7 +475,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
> >  	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
> >  	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
> >  	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
> > -	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
> > +	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
> >  	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
> >  	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
> >  	{ .compatible = "qcom,msm8974", .data = &match_data_krait },

-- 
	Ansuel

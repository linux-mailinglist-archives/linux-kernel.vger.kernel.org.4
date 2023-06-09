Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C75C729CA7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbjFIOVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbjFIOVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:21:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C86C3AA9;
        Fri,  9 Jun 2023 07:21:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso14141145e9.1;
        Fri, 09 Jun 2023 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686320467; x=1688912467;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w7Qv6hACTBN/Qh28fLD3Zn+5GxRPvrAynQbIs4fTdU4=;
        b=mmACuuAeo1VJcR9dcCycCpkPZczk0gRqX/n4qMCUVLVmh6UaTfkN/SXhXu8bXGUiGz
         epM1Juduc2uAnT/009llsMNmOhjc6edjZkNZrk9eQJzZXL4QoITB6X/MUmiIes4giH/W
         Dy//kFL8O/oBuqWovgJPxHMffj17rJAkniXnayyblfh+KQ3u3mBaEKoP4fHB7v8/oZLC
         ruSNuYDa7vEAiOlbgHfsJMBVYXhFtpx5IBUn/xkgqahIvonMZC762v5i2xFVPiWYRSRf
         yFd61QlE50t7ggp8b1u35FyIAmIcy7pqGgWZyZgIY/wGBAdGNA9BB1+MrZqRQfkCOZcd
         HyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686320467; x=1688912467;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7Qv6hACTBN/Qh28fLD3Zn+5GxRPvrAynQbIs4fTdU4=;
        b=QnyK9mQ4lyt5L0CUapN2nw3DM0dQCGxhoQ5Hr+4x9ESZuIbGoLiQ9sb9EaTBozAP/N
         gzU49sZUEFGQPEBALbycxqaZHgUy9MV5yzfAmZyoJf8ZqhaxGXdI88vnyP4EqO5thkeE
         M1JRsr9satjVzPlpAElTbxXR6V1No3WJQMxDvsdfKqn2gBPMvk/pS861VeUD6wJmzjTa
         gkzEbuwKL47uqrFyQd+B9S6uZat8gFek/rumtFiczLI4zzAfyoHtHucL/huH49Z6EaW5
         YPrpiZwZqcErriyLYQteMYGk438HRveUE9QICRZNCdAyRVCmKcEwm3y77W/ydQM0zIkA
         eLIw==
X-Gm-Message-State: AC+VfDwVYMeQxUdrBXc/evQSaQXR20Jr+FxFkXByqku+Ku6RZM1PYv93
        MPMTp6M1lpSmkno8ekU2xP6h9yN71sc=
X-Google-Smtp-Source: ACHHUZ5BRlM6f6J+0jzoXTAvqUEGJq7FjBFJcm+lzTx8XwsexwOFjfmk0Aj0KQKRz7yso4x679DJVA==
X-Received: by 2002:a7b:cd8a:0:b0:3f7:e605:287c with SMTP id y10-20020a7bcd8a000000b003f7e605287cmr974320wmj.40.1686320446408;
        Fri, 09 Jun 2023 07:20:46 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003f7f36896f9sm2788877wmi.42.2023.06.09.07.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:20:46 -0700 (PDT)
Message-ID: <6483353e.7b0a0220.65698.0e15@mx.google.com>
X-Google-Original-Message-ID: <ZIM1PNjRhTnV+wLa@Ansuel-xps.>
Date:   Fri, 9 Jun 2023 16:20:44 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ilia.lin@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/2] cpufreq: qcom-nvmem: add support for
 IPQ8064
References: <20230530165807.642084-1-robimarko@gmail.com>
 <20230530165807.642084-2-robimarko@gmail.com>
 <3f1bfaf9-35ff-59ae-6756-84fc8900ed92@linaro.org>
 <647708e2.050a0220.514c7.feab@mx.google.com>
 <517f8b82-1230-985a-811a-2100f0dd339e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <517f8b82-1230-985a-811a-2100f0dd339e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:07:17PM +0300, Dmitry Baryshkov wrote:
> On 31/05/2023 04:36, Christian Marangi wrote:
> > On Wed, May 31, 2023 at 05:03:01AM +0300, Dmitry Baryshkov wrote:
> > > On 30/05/2023 19:58, Robert Marko wrote:
> > > > From: Christian Marangi <ansuelsmth@gmail.com>
> > > > 
> > > > IPQ8064 comes in 3 families:
> > > > * IPQ8062 up to 1.0GHz
> > > > * IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
> > > > * IPQ8065/IPQ8069 up to 1.7Ghz
> > > > 
> > > > So, in order to be able to share one OPP table, add support for
> > > > IPQ8064 family based of SMEM SoC ID-s as speedbin fuse is always 0 on
> > > > IPQ8064.
> > > > 
> > > > Bit are set with the following logic:
> > > > * IPQ8062 BIT 0
> > > > * IPQ8064/IPQ8066/IPQ8068 BIT 1
> > > > * IPQ8065/IPQ8069 BIT 2
> > > > 
> > > > speed is never fused, only psv values are fused.
> > > > Set speed to the versions to permit a unified opp table following
> > > > this named opp:
> > > > 
> > > > opp-microvolt-speed<SPEED_VALUE>-pvs<PSV_VALUE>-v0
> > > > 
> > > > Example:
> > > > - for ipq8062 psv2
> > > >     opp-microvolt-speed0-pvs2-v0 = < 925000 878750 971250>
> > > > - for ipq8064 psv2
> > > >     opp-microvolt-speed2-pvs2-v0 = <925000 878750 971250>;
> > > > - for ipq8065 psv2
> > > >     opp-microvolt-speed4-pvs2-v0 = <950000 902500 997500>;
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > ---
> > > >    drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 +++++++++++++++++++++++++++-
> > > >    1 file changed, 72 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > index ce444b5962f2..c644138680ba 100644
> > > > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > @@ -34,6 +34,10 @@
> > > >    #define IPQ8074_HAWKEYE_VERSION		BIT(0)
> > > >    #define IPQ8074_ACORN_VERSION		BIT(1)
> > > > +#define IPQ8062_VERSION		BIT(0)
> > > > +#define IPQ8064_VERSION		BIT(1)
> > > > +#define IPQ8065_VERSION		BIT(2)
> > > 
> > > I think it would be more logical to change these defines to consecutive enum
> > > instead of BIT(n) values. Another (and better in my opinion) option is to
> > > drop versions completely (and remove speedN from the opp names) and to have
> > > per-SoC tables in per-SoC dtsi files. There are already separate
> > > ipq8064.dtsi, ipq8062.dtsi and ipq8065.dtsi files. It makes little sense to
> > > overcomplicate the OPP tables.
> > > 
> > 
> > That is what was used downstream but it was also wrong and against the
> > normal implementation of this driver itself.
> > 
> > OPP have opp-supported-hw just for the task with the principle of
> > declaring a single table in dtsi and automatically select the right one.
> > 
> > Using the implementation downstream (opp table in each dtsi) is actually
> > worse as ipq8065 have 1.4ghz and not 1.2ghz and that can correctly be
> > handled with opp-supported-hw (and this change) or using delete-property
> > in dtsi (that I don't really like and it's ugly)
> > 
> > Also this implementation would match what is currently secribed for the
> > use of OPP in the documentation.
> > 
> > Hope you can understand the reason of this change, the intention is to
> > clear and trying to use standard OPP stuff instead of hacks in the DTS.
> 
> I'm fine with the opp-supported-hw part (I forgot that it is used by default
> with the help of drv->versions). I do not like the idea of encoding the same
> value into the -speedN part. If it is not needed, it's better be dropped
> than using a semi-dummy value there.
> 
> So, I'd suggest to define an enum, use BIT(enum_value) for drv->versions and
> drop the speed%d part.
> 
> Also, while we are at it, could you please define a schema for your opp
> extensions? An example would make it easier to understand the bindings (and
> will also provide a reference for possible other implementers).
>

Sorry for the delay in answering this.

The speed part is still needed... since the voltage for each voltage
change on the different SoC.

Let me give you an example for one freq.

		opp-384000000 {
			opp-hz = /bits/ 64 <384000000>;
			opp-microvolt-speed0-pvs0-v0 = <1000000 950000 1050000>;
			opp-microvolt-speed0-pvs1-v0 = <925000 878750 971250>;
			opp-microvolt-speed0-pvs2-v0 = <875000 831250 918750>;
			opp-microvolt-speed0-pvs3-v0 = <800000 760000 840000>;
			opp-microvolt-speed2-pvs0-v0 = <1000000 950000 1050000>;
			opp-microvolt-speed2-pvs1-v0 = <925000 878750 971250>;
			opp-microvolt-speed2-pvs2-v0 = <875000 831250 918750>;
			opp-microvolt-speed2-pvs3-v0 = <800000 760000 840000>;
			opp-microvolt-speed4-pvs0-v0 = <975000 926250 1023750>;
			opp-microvolt-speed4-pvs1-v0 = <950000 902500 997500>;
			opp-microvolt-speed4-pvs2-v0 = <925000 878750 971250>;
			opp-microvolt-speed4-pvs3-v0 = <900000 855000 945000>;
			opp-microvolt-speed4-pvs4-v0 = <875000 831250 918750>;
			opp-microvolt-speed4-pvs5-v0 = <825000 783750 866250>;
			opp-microvolt-speed4-pvs6-v0 = <775000 736250 813750>;
			opp-supported-hw = <0x7>;
			clock-latency-ns = <100000>;
		};

As you can see we use the speed value to match the different SoC and
apply the correct voltage.

Yes I will add the missing info in the schema.

> > 
> > > > +
> > > >    struct qcom_cpufreq_drv;
> > > >    struct qcom_cpufreq_match_data {
> > > > @@ -207,6 +211,69 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> > > >    	return ret;
> > > >    }
> > > > +static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
> > > > +					     struct nvmem_cell *speedbin_nvmem,
> > > > +					     char **pvs_name,
> > > > +					     struct qcom_cpufreq_drv *drv)
> > > > +{
> > > > +	int speed = 0, pvs = 0, pvs_ver = 0;
> > > > +	int msm_id, ret = 0;
> > > > +	u8 *speedbin;
> > > > +	size_t len;
> > > > +
> > > > +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> > > > +
> > > > +	if (IS_ERR(speedbin))
> > > > +		return PTR_ERR(speedbin);
> > > > +
> > > > +	switch (len) {
> > > > +	case 4:
> > > > +		get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
> > > > +				       speedbin);
> > > > +		break;
> > > > +	default:
> > > > +		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
> > > > +		ret = -ENODEV;
> > > > +		goto len_error;
> > > > +	}
> > > > +
> > > > +	ret = qcom_smem_get_soc_id(&msm_id);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	switch (msm_id) {
> > > > +	case QCOM_ID_IPQ8062:
> > > > +		drv->versions = IPQ8062_VERSION;
> > > > +		break;
> > > > +	case QCOM_ID_IPQ8064:
> > > > +	case QCOM_ID_IPQ8066:
> > > > +	case QCOM_ID_IPQ8068:
> > > > +		drv->versions = IPQ8064_VERSION;
> > > > +		break;
> > > > +	case QCOM_ID_IPQ8065:
> > > > +	case QCOM_ID_IPQ8069:
> > > > +		drv->versions = IPQ8065_VERSION;
> > > > +		break;
> > > > +	default:
> > > > +		dev_err(cpu_dev,
> > > > +			"SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
> > > > +			msm_id);
> > > > +		drv->versions = IPQ8062_VERSION;
> > > > +		break;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * IPQ8064 speed is never fused. Only psv values are fused.
> > > > +	 * Set speed to the versions to permit a unified opp table.
> > > > +	 */
> > > > +	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
> > > > +		 drv->versions, pvs, pvs_ver);
> > > > +
> > > > +len_error:
> > > > +	kfree(speedbin);
> > > > +	return ret;
> > > > +}
> > > > +
> > > >    static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
> > > >    					     struct nvmem_cell *speedbin_nvmem,
> > > >    					     char **pvs_name,
> > > > @@ -256,6 +323,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
> > > >    	.genpd_names = qcs404_genpd_names,
> > > >    };
> > > > +static const struct qcom_cpufreq_match_data match_data_ipq8064 = {
> > > > +	.get_version = qcom_cpufreq_ipq8064_name_version,
> > > > +};
> > > > +
> > > >    static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
> > > >    	.get_version = qcom_cpufreq_ipq8074_name_version,
> > > >    };
> > > > @@ -404,7 +475,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
> > > >    	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
> > > >    	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
> > > >    	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
> > > > -	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
> > > > +	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
> > > >    	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
> > > >    	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
> > > >    	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
> > > 
> > > -- 
> > > With best wishes
> > > Dmitry
> > > 
> > 
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
	Ansuel

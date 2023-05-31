Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0A9717A77
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjEaIpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjEaIoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:44:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F3F18D;
        Wed, 31 May 2023 01:44:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f60e730bf2so56410325e9.1;
        Wed, 31 May 2023 01:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685522659; x=1688114659;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aeVfaAvN/B9zS94GU8YhP7iOFMrKyMVlofzW5NQKF4A=;
        b=gFZO3TTbIYGXcXPHsduiJ2W/hO8gv5YNITmYvb7Uw41gi2KdddU9t2thx5kzJM5Xn/
         k+qywmWrKYx9lMQ64W55vspmMOy7IDercyDUNaK4KJhYnF0weiah1D5iu53vPrvt1/P4
         02yMQnVqGr2LyHHf4bSHlUl9dd6fV7XgUntFmIDU66exMXurtxsIPTUhpY3azS5baBEw
         Dum3ewEOHk6ah9cuh/1lrfLSuCNo6FYddq59AcLfDP7VnIkz6aIkscqIDw23ZRoz7IoR
         vxlmjhWGwCV7OFJ832npN2CCDBPm+N61A7Pka3hTIcE4fecdri5iwAnAGLMDkhn6nlft
         MsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685522659; x=1688114659;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeVfaAvN/B9zS94GU8YhP7iOFMrKyMVlofzW5NQKF4A=;
        b=QyA6SD5tSJWpdjbSdN71axR56yFK7WDOuQYJ2ywzrXehxhnMCpOSXh4oEwGs2Jst+S
         3ORyX+3N5EEQahG6rzZkI4O3vGCtW8wJc6bgQP3mq77YS/HxmUlVOU6Wk+Shb0sQItbL
         1mtEHlibQZ9Vvkg48ZSK5QYohzefnCNpWcY28f0idlBpNmYRddlVP6ze25wULxdEGHUh
         aSSfiJ7D93XoFfx1ofhH0bFiZhg6qjLmv25YdH9PwuJQ/gF7qnXYmIj9xM8WfABF5/1p
         5V0wNYSLFH26xP7Ez9wZxYJ0+mTiB1VHf1YxY9nIQpeEu6jYOrnWXGubQbNQK4VzOKVE
         EizA==
X-Gm-Message-State: AC+VfDzpOyUbcd2wrVjmWMVUYnADA0cJTeguHVa59EjpMjkG3WCPg7k9
        0km+oA0UqHqYFfc3tN4qjG4=
X-Google-Smtp-Source: ACHHUZ53Z+Sn2Djn7GYxfUVn//FwC1aRKygDp8t/ieSm+R60GxfFr7MaVra8pB45vRo5D7E1NROj6w==
X-Received: by 2002:a7b:c8d9:0:b0:3f6:105:8d87 with SMTP id f25-20020a7bc8d9000000b003f601058d87mr4306025wml.14.1685522658986;
        Wed, 31 May 2023 01:44:18 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id x4-20020a05600c21c400b003f0aefcc457sm23697609wmj.45.2023.05.31.01.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 01:44:18 -0700 (PDT)
Message-ID: <647708e2.050a0220.514c7.feab@mx.google.com>
X-Google-Original-Message-ID: <ZHakiet1ZyoKr0/o@Ansuel-xps.>
Date:   Wed, 31 May 2023 03:36:09 +0200
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f1bfaf9-35ff-59ae-6756-84fc8900ed92@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 05:03:01AM +0300, Dmitry Baryshkov wrote:
> On 30/05/2023 19:58, Robert Marko wrote:
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
> >    opp-microvolt-speed0-pvs2-v0 = < 925000 878750 971250>
> > - for ipq8064 psv2
> >    opp-microvolt-speed2-pvs2-v0 = <925000 878750 971250>;
> > - for ipq8065 psv2
> >    opp-microvolt-speed4-pvs2-v0 = <950000 902500 997500>;
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >   drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 +++++++++++++++++++++++++++-
> >   1 file changed, 72 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > index ce444b5962f2..c644138680ba 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > @@ -34,6 +34,10 @@
> >   #define IPQ8074_HAWKEYE_VERSION		BIT(0)
> >   #define IPQ8074_ACORN_VERSION		BIT(1)
> > +#define IPQ8062_VERSION		BIT(0)
> > +#define IPQ8064_VERSION		BIT(1)
> > +#define IPQ8065_VERSION		BIT(2)
> 
> I think it would be more logical to change these defines to consecutive enum
> instead of BIT(n) values. Another (and better in my opinion) option is to
> drop versions completely (and remove speedN from the opp names) and to have
> per-SoC tables in per-SoC dtsi files. There are already separate
> ipq8064.dtsi, ipq8062.dtsi and ipq8065.dtsi files. It makes little sense to
> overcomplicate the OPP tables.
>

That is what was used downstream but it was also wrong and against the
normal implementation of this driver itself.

OPP have opp-supported-hw just for the task with the principle of
declaring a single table in dtsi and automatically select the right one.

Using the implementation downstream (opp table in each dtsi) is actually
worse as ipq8065 have 1.4ghz and not 1.2ghz and that can correctly be
handled with opp-supported-hw (and this change) or using delete-property
in dtsi (that I don't really like and it's ugly)

Also this implementation would match what is currently secribed for the
use of OPP in the documentation.

Hope you can understand the reason of this change, the intention is to
clear and trying to use standard OPP stuff instead of hacks in the DTS.

> > +
> >   struct qcom_cpufreq_drv;
> >   struct qcom_cpufreq_match_data {
> > @@ -207,6 +211,69 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> >   	return ret;
> >   }
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
> > +	return ret;
> > +}
> > +
> >   static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
> >   					     struct nvmem_cell *speedbin_nvmem,
> >   					     char **pvs_name,
> > @@ -256,6 +323,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
> >   	.genpd_names = qcs404_genpd_names,
> >   };
> > +static const struct qcom_cpufreq_match_data match_data_ipq8064 = {
> > +	.get_version = qcom_cpufreq_ipq8064_name_version,
> > +};
> > +
> >   static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
> >   	.get_version = qcom_cpufreq_ipq8074_name_version,
> >   };
> > @@ -404,7 +475,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
> >   	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
> >   	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
> >   	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
> > -	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
> > +	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
> >   	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
> >   	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
> >   	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
	Ansuel

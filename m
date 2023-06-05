Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4744B722F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjFETHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjFETHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:07:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B362F1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:06:58 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so2069854e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685992016; x=1688584016;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guzm7P5lkblMk/Vrn4ZKD+mnzHB554/CDVbb05+Zx+A=;
        b=Lsgk4k6zNNXLcu4CiQcLCUBCzb6yzWBNzHg32aYrkUzxC7IGbcwzeaqUf9YVXudD1+
         pzeuRUoV2crOxS4+TA1/sF0uG3BDYY2UfPy6Smv/1AYzOrEfJszOi/YoNSTPYrGZiErK
         OFtFWuEMN1CklpjenHLrgjduX5lztJvVrhNeUFoaTlpZSRKW9dCtCJSazQTDyf/fn730
         7R3YJstLSu2AfCx0q0aX6EkIAj8YaYGTgsNK/AfvmyuaUrgse49JPAuOIsuxegYwurLJ
         9hSlijfkzKxR+P9QFqWiSTTm2B/CiJzHE1c/YeENILw1SVuJeTCN1N3qxTPkMhiiNo36
         ql7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685992016; x=1688584016;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guzm7P5lkblMk/Vrn4ZKD+mnzHB554/CDVbb05+Zx+A=;
        b=R6DCAgtvXQIoSV2MuHcupV/UhjrJIxPGxzrF/A53S0rsbYZGOnmzZN/GrBGurNQCxJ
         0PAmQ+lQmxqvKHvaiL11YR07cL6VsyfhFHp53IzVIrmmNsmF1U4qu1uyoCOEsftkmISj
         Nu15cEBh9z5wHWroK3eEpjBMOhL0wLW4qohpNtXoxtR4ErdlxZ9a81Sr0BJ1NE9AkFJz
         /BbbxA+HKTzGt5UZ5iBUDxFS/187daP+utUhIsn9bvI4MtiBFzjkBfxPy/aarii1xjcn
         qzSjWp1YG0w6RrU28Ri2dTzHUica+CBFsJIL3UpYl8oTKaFKh9e4kEz0fq/V6Jg6LHru
         QgKQ==
X-Gm-Message-State: AC+VfDzUL/yQOar8mauGef/+tDv6WhyGu/HBnKd84f4yX5inanzRBgXg
        8hYOM5Js/LRfoX9steZIJ037Ew==
X-Google-Smtp-Source: ACHHUZ7eSq/8s+ospor02JxiF2DUCAATiBEohkdIovg2kbWUthInvEBpG7L5wjhJaBPO1zO5cYx3fw==
X-Received: by 2002:ac2:548d:0:b0:4a4:6af4:43b7 with SMTP id t13-20020ac2548d000000b004a46af443b7mr5012518lfk.69.1685992016410;
        Mon, 05 Jun 2023 12:06:56 -0700 (PDT)
Received: from [192.168.1.101] (abyj96.neoplus.adsl.tpnet.pl. [83.9.29.96])
        by smtp.gmail.com with ESMTPSA id v15-20020a19740f000000b004eed8de597csm1217000lfe.32.2023.06.05.12.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:06:55 -0700 (PDT)
Message-ID: <04745990-d270-b37c-7ac8-dff24b03e02b@linaro.org>
Date:   Mon, 5 Jun 2023 21:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-10-e0a3b6de1f14@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 10/14] soc: qcom: Add RPM processor/subsystem driver
In-Reply-To: <20230531-rpm-rproc-v1-10-e0a3b6de1f14@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.06.2023 09:08, Stephan Gerhold wrote:
> Add a simple driver for the qcom,rpm-proc compatible that registers the
> "smd-edge" and populates other children defined in the device tree.
> 
> Note that the DT schema belongs to the remoteproc subsystem while this
> driver is added inside soc/qcom. I argue that the RPM *is* a remoteproc,
> but as an implementation detail in Linux it can currently not benefit
> from anything provided by the remoteproc subsystem. The RPM firmware is
> usually already loaded and started by earlier components in the boot
> chain and is not meant to be ever restarted.
> 
> To avoid breaking existing kernel configurations the driver is always
> built when smd-rpm.c is also built. They belong closely together anyway.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/soc/qcom/Makefile   |  2 +-
>  drivers/soc/qcom/rpm-proc.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 99114c71092b..113b9ff2ad43 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -18,7 +18,7 @@ obj-$(CONFIG_QCOM_RPM_MASTER_STATS)	+= rpm_master_stats.o
>  obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
>  qcom_rpmh-y			+= rpmh-rsc.o
>  qcom_rpmh-y			+= rpmh.o
> -obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
> +obj-$(CONFIG_QCOM_SMD_RPM)	+= rpm-proc.o smd-rpm.o
>  obj-$(CONFIG_QCOM_SMEM) +=	smem.o
>  obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
>  obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
> diff --git a/drivers/soc/qcom/rpm-proc.c b/drivers/soc/qcom/rpm-proc.c
> new file mode 100644
> index 000000000000..0652be7f7895
> --- /dev/null
> +++ b/drivers/soc/qcom/rpm-proc.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2021-2023, Stephan Gerhold <stephan@gerhold.net> */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/rpmsg/qcom_smd.h>
> +
> +static int rpm_proc_probe(struct platform_device *pdev)
> +{
> +	struct qcom_smd_edge *edge = NULL;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *edge_node;
> +	int ret;
> +
> +	edge_node = of_get_child_by_name(dev->of_node, "smd-edge");
> +	if (edge_node) {
> +		edge = qcom_smd_register_edge(dev, edge_node);
> +		if (IS_ERR(edge))
> +			return dev_err_probe(dev, PTR_ERR(edge),
> +					     "Failed to register smd-edge\n");
Need of_node_put in both success and IS_ERR paths

> +	}
> +
> +	ret = devm_of_platform_populate(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to populate children devices: %d\n", ret);
I may be having a brain lag moment but I think it should be "child"
singular, otherwise it sounds like they're devices for children!

> +		goto err;
> +	}
> +
> +	platform_set_drvdata(pdev, edge);
> +	return 0;
> +err:
> +	if (edge)
> +		qcom_smd_unregister_edge(edge);
> +	return ret;
> +}
> +
> +static void rpm_proc_remove(struct platform_device *pdev)
> +{
> +	struct qcom_smd_edge *edge = platform_get_drvdata(pdev);
> +
> +	if (edge)
> +		qcom_smd_unregister_edge(edge);
> +}
> +
> +static const struct of_device_id rpm_proc_of_match[] = {
> +	{ .compatible = "qcom,rpm-proc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rpm_proc_of_match);
> +
> +static struct platform_driver rpm_proc_driver = {
> +	.probe = rpm_proc_probe,
> +	.remove_new = rpm_proc_remove,
> +	.driver = {
> +		.name = "qcom-rpm-proc",
> +		.of_match_table = rpm_proc_of_match,
> +	},
> +};
> +
> +static int __init rpm_proc_init(void)
> +{
> +	return platform_driver_register(&rpm_proc_driver);
> +}
> +arch_initcall(rpm_proc_init);
Maybe we can go as early as core...

Konrad
> +
> +static void __exit rpm_proc_exit(void)
> +{
> +	platform_driver_unregister(&rpm_proc_driver);
> +}
> +module_exit(rpm_proc_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm RPM processor/subsystem driver");
> +MODULE_AUTHOR("Stephan Gerhold <stephan@gerhold.net>");
> +MODULE_LICENSE("GPL");
> 

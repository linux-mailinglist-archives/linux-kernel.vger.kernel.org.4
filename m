Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95D56EA7C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjDUKCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjDUKCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:02:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3329D93EF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:02:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f178da219bso15596685e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20221208.gappssmtp.com; s=20221208; t=1682071346; x=1684663346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+cGK3fatl1Bm5tT0CtRHdACfz5IxHb/Sssw2zc8S/ZM=;
        b=OmsXGYsBZD07lO5F+Xt9on01iO6wI3UjF+vP5hMBJUy/Rto+cnCMDT6ekOehjzMr2J
         2ZiCvh5UwEglzxCa7UeMZLsUnBb9jyQwWK6pJfYGDaoAr3/78qZEOrPhV8IpWIqG+YSJ
         qq72npCB6JU5YL+7ytuVt8B/RXwfn5WoSL5UiFyHd3kTK3aOhmO72RaQP97Jcqi07Rt+
         WIHJ7cCXZagIFn3xtT2YHTEcWYxlq02JohWFpFCbgQGfF+IowIYMXlT+v3AS4k7+FELc
         ce59voW9axw0EebSmCwFmqefVQcj2xdqiF5pV7ZOV4sT80akb/tzPFxQfuT27NHGRltR
         ndUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682071346; x=1684663346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cGK3fatl1Bm5tT0CtRHdACfz5IxHb/Sssw2zc8S/ZM=;
        b=awyPVqG+8LczpEfEnABGzHoe/5bofucd3CB1UY/d5pz823l6ixw0ytTck36bi+9l9V
         ZM6wDt6+STnpU/Oy01d5THTYqsiFCUu+N2Q1Kv775nNrcdPg85redS0tBG0udv9Rt0Az
         fTpb+XR++lcjR5+X/IrGxdMpSDqy0V7TEr9rlsNWqAWxe6F6HEzbrnM2M79LMoCA0TcV
         CuETnAz1+FYBnOzHxYrq4CUPe99GN47g0mS/cm+Cs0jdpB9UvhWOkT14lmZ9V3h2/B3j
         5fU9Ku+aKWCXUzCbZ8ClEUBHzpK2Jq5qrDUiYyf7JNCjR8CD4ipzYdPBOAwSAuW2HYcM
         gRhQ==
X-Gm-Message-State: AAQBX9f0N0NR0wJmkHlp9po2/khlh03L5LBynfVx4Vz49W7lWaD96fBR
        VC0sfb3xSVSngH6klZ8fNmkyaQ==
X-Google-Smtp-Source: AKy350auFHB9I3KfGQwNRfIZaleQI1+V9R5fF91Ly6PhHuMv0rZrc8Slpp7mD7rlh4zdoueoBbn5Wg==
X-Received: by 2002:a1c:7211:0:b0:3da:1f6a:7b36 with SMTP id n17-20020a1c7211000000b003da1f6a7b36mr1622555wmc.0.1682071346475;
        Fri, 21 Apr 2023 03:02:26 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c45c800b003f18992079dsm4819834wmo.42.2023.04.21.03.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 03:02:26 -0700 (PDT)
Message-ID: <b66290c6-5c1b-70a4-84e3-d65b139d1460@nexus-software.ie>
Date:   Fri, 21 Apr 2023 11:02:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V5 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681799201.git.quic_schowdhu@quicinc.com>
 <142bfd034c12c245cda9f1dee20a05188b63494d.1681799201.git.quic_schowdhu@quicinc.com>
Content-Language: en-US
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <142bfd034c12c245cda9f1dee20a05188b63494d.1681799201.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 07:46, Souradeep Chowdhury wrote:
> All of Qualcomm's proprietary Android boot-loaders capture boot time
> stats, like the time when the bootloader started execution and at what
> point the bootloader handed over control to the kernel etc. in the IMEM
> region. This information is captured in a specific format by this driver
> by mapping a structure to the IMEM memory region and then accessing the
> members of the structure to show the information within debugfs file.
> This information is useful in verifying if the existing boot KPIs have
> regressed or not. The information is shown in milliseconds, a sample
> log from sm8450(waipio) device is as follows:-
> 
> /sys/kernel/debug/146aa6b0.boot_stats # cat abl_time
> 17898 ms
> /sys/kernel/debug/146aa6b0.boot_stats # cat pre_abl_time
> 2879 ms
> 
> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
> stage and the timestamp generated by the sleep counter is logged by
> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
> starts execution which is logged here as "pre_abl_time" and the second
> when it is about to load the kernel logged as "abl_time". Documentation
> details are also added in Documentation/ABI/testing/debugfs-driver-bootstat
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>   Documentation/ABI/testing/debugfs-driver-bootstat |  17 ++++
>   drivers/soc/qcom/Kconfig                          |   9 ++
>   drivers/soc/qcom/Makefile                         |   1 +
>   drivers/soc/qcom/boot_stats.c                     | 101 ++++++++++++++++++++++
>   4 files changed, 128 insertions(+)
>   create mode 100644 Documentation/ABI/testing/debugfs-driver-bootstat
>   create mode 100644 drivers/soc/qcom/boot_stats.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-driver-bootstat b/Documentation/ABI/testing/debugfs-driver-bootstat
> new file mode 100644
> index 0000000..2543029
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-driver-bootstat
> @@ -0,0 +1,17 @@
> +What:		/sys/kernel/debug/...stats/pre_abl_time
> +Date:           April 2023
> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This file is used to read the KPI value pre abl time.
> +		It shows the time in milliseconds from the starting
> +		point of PBL to the point when the control shifted
> +		to ABL(Qualcomm proprietary bootloader).
> +
> +What:           /sys/kernel/debug/...stats/abl_time
> +Date:           April 2023
> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This file is used to read the KPI value abl time.
> +		It show the duration in milliseconds from the
> +		time control switched to ABL to the point when
> +		the linux kernel started getting loaded.
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a8f2830..0d2cbd3 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -16,6 +16,15 @@ config QCOM_AOSS_QMP
>   	  subsystems as well as controlling the debug clocks exposed by the Always On
>   	  Subsystem (AOSS) using Qualcomm Messaging Protocol (QMP).
>   
> +config QCOM_BOOTSTAT
> +	tristate "Qualcomm Technologies, Boot Stat driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  This option enables driver support for boot stats. Boot stat driver logs
> +	  the kernel bootloader information by accessing the imem region. These
> +	  information are exposed in the form of debugfs files. This is used to
> +	  determine if there is any regression in boot timings.
> +
>   config QCOM_COMMAND_DB
>   	tristate "Qualcomm Command DB"
>   	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 6e88da8..bdaa41a 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   CFLAGS_rpmh-rsc.o := -I$(src)
>   obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
> +obj-$(CONFIG_QCOM_BOOTSTAT) += boot_stats.o
>   obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>   obj-$(CONFIG_QCOM_CPR)		+= cpr.o
> diff --git a/drivers/soc/qcom/boot_stats.c b/drivers/soc/qcom/boot_stats.c
> new file mode 100644
> index 0000000..7ae002b
> --- /dev/null
> +++ b/drivers/soc/qcom/boot_stats.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2013-2019, 2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +#define TO_MS(timestamp) ((timestamp * 1000) / 32768)

Is this related to the sleep_clk, if not, what is the refrence clock ?

Is this value constant across different SoCs i.e. will this run and 
produce meaningful results on an msm8916 ?

---
bod

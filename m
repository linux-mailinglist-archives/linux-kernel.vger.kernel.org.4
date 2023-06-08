Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746EC7280A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjFHMyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbjFHMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:54:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88EC3594
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:54:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f7fc9014fdso3428955e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 05:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686228831; x=1688820831;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=InHp6AifXEpwXcgGbkL/ZV2RrHkvo9FL6i2UTJDIYB0=;
        b=ZDjW0Q9l7x0hBg8+IHtZmugU5k8Uhxr0Z9a1ve4J80evELnmIGFQaDnNTpcJ5LE646
         6pbpXJBkG3cBIAArHd3A/B6DMypdAlO2PN7LS2gj4wFM8sHjKiMEnlUUcjRCqdOQSnhJ
         4zGEOroi5yZoza7oi/5wQ/5aZQGMl4SYWTMMwDy3HW5tsCXKLAeVuf3tYURFOu5NGEkQ
         aA401kfru6nO4tuPIQg8GWuuMPlgd2SAO5ncTbb+fxRXUPNpWhHnIJyuZvlQf+cqR3Mt
         2yjuXzd4mWaNOTbs7uC8WbK63VkzZHyNnuTZBouRXe6WQPeuCAE0Qe0SXqVlWzuLxiy3
         9abQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686228831; x=1688820831;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InHp6AifXEpwXcgGbkL/ZV2RrHkvo9FL6i2UTJDIYB0=;
        b=Ine3BkZznlHkluWC82yvkEIfoRoxaN4afOJyihYruexueJ8wJ3u8HAzgqJrz1zoosZ
         hHIGR8HJJLUP+QVxmLLPrwu/FjO+0c0NRAe/vrs5/ZO8tu2tCbr0KMi4O3uHrYlXu0lS
         0GiIIENxKlfCOm3QgFizkeqQBsWQLjyiF9tm2lSMIqSNCdwgiQfGsps8+5ehnmzKLoG3
         dRcIQqjygr+8JtOdPSRRR34d50LZPzobAmSXU+aaxMnFgUazDHmE0/RfDfrmx73M3He0
         pmb+/3Z4NybuvkPmVgQbPAXrct6Zuwu1QOErbLrJkNRjrpCB8q2FYX0wWuGej4P2MRHM
         V5hQ==
X-Gm-Message-State: AC+VfDx9qyuU/XwYGdSCJUSXiJnrv03cq7lIZVu+sHfoN0fVyRMBMtJX
        Ws7GkgKAYTZbGJK7fYEPLFRU5w==
X-Google-Smtp-Source: ACHHUZ4oTgD6qat4+DrFYAq8xQnBw9gvkPPJOGVWwaYbnjBxuMA8auBmgKC3Rag8MC3HsFQv4HIigw==
X-Received: by 2002:a5d:590e:0:b0:30a:e81f:ef32 with SMTP id v14-20020a5d590e000000b0030ae81fef32mr7200688wrd.13.1686228831681;
        Thu, 08 Jun 2023 05:53:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1b90:b83e:29ce:beb6? ([2a01:e0a:982:cbb0:1b90:b83e:29ce:beb6])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003f7cb42fa20sm1906181wmg.42.2023.06.08.05.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 05:53:51 -0700 (PDT)
Message-ID: <638206ba-e2da-bb8e-a2e4-138af84648b4@linaro.org>
Date:   Thu, 8 Jun 2023 14:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 03/18] clk: meson: migrate a1 clock drivers out of
 hw_onecell_data to drop NR_CLKS
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
 <20230607-topic-amlogic-upstream-clkid-public-migration-v1-3-9676afa6b22c@linaro.org>
 <1jlegu9l5d.fsf@starbuckisacylon.baylibre.com>
Organization: Linaro Developer Services
In-Reply-To: <1jlegu9l5d.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 14:45, Jerome Brunet wrote:
>>   
>> +struct meson_a1_pll_clks {
>> +	struct clk_hw **hw_clks;
>> +	unsigned int hw_clk_num;
>> +};
>> +
>> +static struct meson_a1_pll_clks a1_pll_clks = {
>> +	.hw_clks = a1_pll_hw_clks,
>> +	.hw_clk_num = ARRAY_SIZE(a1_pll_hw_clks),
>> +};
>> +
>> +static struct clk_hw *meson_a1_pll_hw_get(struct of_phandle_args *clkspec, void *clk_data)
>> +{
>> +	const struct meson_a1_pll_clks *data = clk_data;
>> +	unsigned int idx = clkspec->args[0];
>> +
>> +	if (idx >= data->hw_clk_num) {
>> +		pr_err("%s: invalid index %u\n", __func__, idx);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	return data->hw_clks[idx];
>> +}
> 
> I'd prefer to have a single struct type and and single custom
> callback for the different SoC please.

Sure, I've written a common code for that, but I have a hard time finding
a proper naming for it... so I choosed meson-clkc since it could have
more common helper code for duplicated code over the clk driver:

===================================><============================================================================
diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 8ce846fdbe43..9070dcfd9e71 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -30,6 +30,9 @@ config COMMON_CLK_MESON_VID_PLL_DIV
  	tristate
  	select COMMON_CLK_MESON_REGMAP

+config COMMON_CLK_MESON_CLKC
+	tristate
+
  config COMMON_CLK_MESON_AO_CLKC
  	tristate
  	select COMMON_CLK_MESON_REGMAP
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index d5288662881d..13c6db466986 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -1,6 +1,7 @@
  # SPDX-License-Identifier: GPL-2.0-only
  # Amlogic clock drivers

+obj-$(CONFIG_COMMON_CLK_MESON_CLKC) += meson-clkc.o
  obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
  obj-$(CONFIG_COMMON_CLK_MESON_CPU_DYNDIV) += clk-cpu-dyndiv.o
  obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
diff --git a/drivers/clk/meson/meson-clkc.c b/drivers/clk/meson/meson-clkc.c
new file mode 100644
index 000000000000..fa98b9d09011
--- /dev/null
+++ b/drivers/clk/meson/meson-clkc.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#include <linux/of_device.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include "meson-clkc.h"
+
+struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_data)
+{
+	const struct meson_clk_hw_data *data = clk_hw_data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= data->num) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return data->hws[idx];
+}
+EXPORT_SYMBOL_GPL(meson_clk_hw_get);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/meson-clkc.h b/drivers/clk/meson/meson-clkc.h
new file mode 100644
index 000000000000..e3bad2aa17eb
--- /dev/null
+++ b/drivers/clk/meson/meson-clkc.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#ifndef __MESON_HW_CLKC_H__
+#define __MESON_HW_CLKC_H__
+
+#include <linux/of_device.h>
+#include <linux/clk-provider.h>
+
+struct meson_clk_hw_data {
+	struct clk_hw	**hws;
+	unsigned int	num;
+};
+
+struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_data);
+
+#endif
===================================><============================================================================

If it's ok I'll send a v2 using this.

Thanks,
Neil

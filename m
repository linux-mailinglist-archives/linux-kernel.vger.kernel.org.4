Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C517A5FF71C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 01:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJNXxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 19:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJNXxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:53:40 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4786374;
        Fri, 14 Oct 2022 16:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665791618; x=1697327618;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rbflSGtIpPJO6C65/fJEG2ZGnDtsLTlgBQPQCuKjCoM=;
  b=ZTJwN2IrGuyL287wDDpMJC7ncJW5uA3g1AKIC3uZTtmVt8wIoqHpHeMF
   lpOErIvq1ghpbpyjmMrCUWaYwWmYQ8kqVL4TBvCTyhlPRSHT+tCj4/Vid
   TjoDwZFi531MIfhRoEpNvt0VZIzWbxFO3CIJrb07yaI6NwuZp/Eex0G/N
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Oct 2022 16:53:38 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:53:37 -0700
Received: from [10.110.77.177] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 14 Oct
 2022 16:53:37 -0700
Message-ID: <eec2e9f5-5980-6a2e-53e5-71cc9a76f0a7@quicinc.com>
Date:   Fri, 14 Oct 2022 16:53:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/6] clk: qcom: Add clocks for the QDU1000 and QRU1000
 SoCs
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221014221011.7360-1-quic_molvera@quicinc.com>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221014221011.7360-1-quic_molvera@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2022 3:10 PM, Melody Olvera wrote:
> This series adds the GCC, RPMh, and PDC clock support required for the
> QDU1000 and QRU1000 SoCs along with the devicetree bindings for them.
>
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
>
> This patchset is based on the YAML conversion patch [1] submitted already.
>
> [1] https://lore.kernel.org/r/20220103074348.6039-1-luca.weiss@fairphone.com
Changes from V1:
- fixed alphabetic sorting
- moved clk-branch changes to a separate commit
- revised bindings
> Imran Shaik (1):
>   clk: qcom: branch: Add BRANCH_HALT_INVERT flag support for branch
>     clocks
>
> Melody Olvera (4):
>   dt-bindings: clock: Add QDU1000 and QRU1000 GCC clock bindings
>   dt-bindings: clock: Add RPMHCC bindings for QDU1000 and QRU1000
>   clk: qcom: Add support for QDU1000 and QRU1000 RPMh clocks
>   dt-bindings: qcom,pdc: Introduce pdc bindings for QDU1000 and QRU1000
>
> Taniya Das (1):
>   clk: qcom: Add QDU1000 and QRU1000 GCC support
>
>  .../bindings/clock/qcom,gcc-qdu1000.yaml      |   70 +
>  .../bindings/clock/qcom,rpmhcc.yaml           |    2 +
>  .../interrupt-controller/qcom,pdc.yaml        |    2 +
>  drivers/clk/qcom/Kconfig                      |    8 +
>  drivers/clk/qcom/Makefile                     |    1 +
>  drivers/clk/qcom/clk-branch.c                 |    5 +
>  drivers/clk/qcom/clk-branch.h                 |    2 +
>  drivers/clk/qcom/clk-rpmh.c                   |   14 +
>  drivers/clk/qcom/gcc-qdu1000.c                | 2644 +++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-qdu1000.h  |  170 ++
>  10 files changed, 2918 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
>  create mode 100644 drivers/clk/qcom/gcc-qdu1000.c
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-qdu1000.h
>
>
> base-commit: dca0a0385a4963145593ba417e1417af88a7c18d


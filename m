Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B585FF72A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 01:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJNXzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 19:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJNXzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:55:38 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509349B66;
        Fri, 14 Oct 2022 16:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665791737; x=1697327737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7YM7bqF1aXR2ufiew1CcFKjinjmgcp/o4CP9Z5CEV7E=;
  b=Fn5cJ/IX0foNIfImRzoi8k5NXxpCfdvuW/WtkROrVi2ut0qtC5oulif8
   HK9Z9sI6TKsBxBFLB32SAYY4qmKETc0l95QSkXWXQZzY/IPnUtQ2hoNJj
   ZZbwleR6KD3vDIMYwDxvPPlAn/vFAzWYjDeOowWk4XOd9znLibOe714cw
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Oct 2022 16:55:36 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:55:20 -0700
Received: from [10.110.77.177] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 14 Oct
 2022 16:55:19 -0700
Message-ID: <0c790f8e-2dc1-6023-6cc6-d1e3c9c916a4@quicinc.com>
Date:   Fri, 14 Oct 2022 16:55:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/2] Add interconnect support for QDU1000/QRU1000 SoCs
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221014221038.7423-1-quic_molvera@quicinc.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221014221038.7423-1-quic_molvera@quicinc.com>
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
> Add dt bindings and driver support for the Qualcomm QDU1000 and QRU1000
> SoCs.
>
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
Changes from v1:
- fixed ordering and licenses
>
> Melody Olvera (2):
>   dt-bindings: interconnect: Add QDU1000/QRU1000 dt bindings
>   interconnect: qcom: Add QDU1000/QRU1000 interconnect driver
>
>  .../bindings/interconnect/qcom,rpmh.yaml      |    8 +
>  drivers/interconnect/qcom/Kconfig             |    9 +
>  drivers/interconnect/qcom/Makefile            |    2 +
>  drivers/interconnect/qcom/qdu1000.c           | 1091 +++++++++++++++++
>  drivers/interconnect/qcom/qdu1000.h           |   95 ++
>  .../dt-bindings/interconnect/qcom,qdu1000.h   |   98 ++
>  6 files changed, 1303 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/qdu1000.c
>  create mode 100644 drivers/interconnect/qcom/qdu1000.h
>  create mode 100644 include/dt-bindings/interconnect/qcom,qdu1000.h
>
>
> base-commit: dca0a0385a4963145593ba417e1417af88a7c18d


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4E774D952
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGJOuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGJOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:50:02 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A13B106;
        Mon, 10 Jul 2023 07:50:00 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ACrLXs015879;
        Mon, 10 Jul 2023 16:49:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=VI5BUgJKKnKd81L1yWTc/ee+ko738S4C9F8jfybX2Fo=;
 b=Oytith9HRt/VQTLW1jj7BPwyCTMarM5sJXs/+TBddf+wFYTUJc7PCMHu3/9vNQOQ08UO
 QyCJGxEldx30p9C0l/W513Arbmdv6qvTYyJ806Y0ZNwEG/y4wJYYVOx49Jln5ElHeN6I
 7gVav+ee+MtrmO0VcrDrlrHbO376iRPJa8VXDsg6aX+V6yFXq90osOGjZBJvMrvhkQW/
 O/T2UjZ5IYovB14QHw8VfHG5aiUSB4b4vls/2JZce/H2mVqcAxPRj3IlhaJwLL8YKLrW
 2nNd4CmIpvolCRGUWjQeQbwtYOX9tlGtmyXR6UH9Kzd0qkG1ZMHZLsLwvX+w6/bhmmzd yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rrjcygtfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 16:49:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC66910005D;
        Mon, 10 Jul 2023 16:49:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D816C25E537;
        Mon, 10 Jul 2023 16:49:36 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 10 Jul
 2023 16:49:36 +0200
Message-ID: <a53e130e-8968-7e69-8b5a-ac37b8e01770@foss.st.com>
Date:   Mon, 10 Jul 2023 16:49:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] ARM: dts: sm32mp: remove shmem for scmi-optee
Content-Language: en-US
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     Christophe PRIOUZEAU <christophe.priouzeau@st.com>,
        Etienne CARRIERE <etienne.carriere@foss.st.com>,
        Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230705154459.1194895-1-patrick.delaunay@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230705154459.1194895-1-patrick.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 17:44, Patrick Delaunay wrote:
> 
> Remove the optional shared memory in SYSRAM and
> use the OP-TEE native shared memory for SCMI-OPTEE to
> - avoid boot issue with the latest OP-TEE version 3.22.0 for STM32MP15 SoC,
>    when CFG_STM32MP1_SCMI_SHM_SYSRAM is disabled
> - prepare migration with the same configuration for STM32MP13 SoC
> 
> 
> 
> Patrick Delaunay (2):
>    ARM: dts: sm32mp: remove shmem for scmi-optee on stm32mp15
>    ARM: dts: sm32mp: remove shmem for scmi-optee on stm32mp13
> 
>   arch/arm/boot/dts/st/stm32mp131.dtsi     | 14 --------------
>   arch/arm/boot/dts/st/stm32mp15-scmi.dtsi | 16 ----------------
>   2 files changed, 30 deletions(-)
> 

Applied to stm32-next. Will be send for fixes in this v6.5 cycle.

Thanks
Alex

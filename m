Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566D0731F62
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjFORjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFORi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:38:58 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF01BDB;
        Thu, 15 Jun 2023 10:38:56 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FG4DjV001861;
        Thu, 15 Jun 2023 19:38:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=WVSwhybmAV6yFwYl/ec10wt/7sRPE+inDDJ2qyzeYXc=;
 b=nsI0QSd5WUAwiTuWEhNhY8uAWQ/fKWLBh7qIDb3yv2fUCkhUko0Cc1q/3Ib/NA+LwXvO
 +65mzkcEfl0JaRrk7LYcL1MKdWf5X0bk4ju1E22mKB7lTIhZ01Kg/v2+faPmP3ekdRAP
 M2a34y53SdwJvXpY5jTlgqbvZulEDJ7HiToGkO6exBIpGSAJMbsJw8gB5Faop6bs7GdP
 uY78p/WmJbWIlpbItsT9JWY4kg0XPAlaRKNefoR7NXvGtUTmw6HgWOLM40Nps0cgk9cH
 iCGUi6Gh7wopoK1OPHgxvKIxigxWS8s2B+dq8a2RhcbDmlaezqYd9H7a3vv47NbfPvnN Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r82fy9sm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 19:38:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 95AE110002A;
        Thu, 15 Jun 2023 19:38:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DDAF245525;
        Thu, 15 Jun 2023 19:38:38 +0200 (CEST)
Received: from [10.252.8.64] (10.252.8.64) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 19:38:37 +0200
Message-ID: <b25d30de-8a22-b5ea-e58c-78b3d55b3cac@foss.st.com>
Date:   Thu, 15 Jun 2023 19:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/4] dt-bindings: spi: stm32: disable spi-slave
 property for stm32f4-f7
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230615075815.310261-1-valentin.caron@foss.st.com>
 <20230615075815.310261-4-valentin.caron@foss.st.com>
 <479bf05e-342d-f94b-87f3-4cc0a95fb01a@linaro.org>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <479bf05e-342d-f94b-87f3-4cc0a95fb01a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.8.64]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_13,2023-06-15_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 6/15/23 15:36, Krzysztof Kozlowski wrote:
> On 15/06/2023 09:58, Valentin Caron wrote:
>> From: Alain Volmat <alain.volmat@foss.st.com>
>>
>> STM32F4 and STM32F7 can't switch to spi device mode.
>> Forbid this property with compatible "st,stm32f4-spi".
> Just to clarify - driver cannot switch or hardware does not support it?

Driver can't support it right now but hardware can.

> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. (spi: dt-bindings:)
Sorry, I missed that.
> Best regards,
> Krzysztof

Regards,
Valentin


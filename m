Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DB36D3EB2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjDCIMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjDCIMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:12:17 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C93D10D5;
        Mon,  3 Apr 2023 01:12:15 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33365u7x006137;
        Mon, 3 Apr 2023 10:11:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=fwYoHtk4uBEjNDRfcBSbMb8Oh9eWXuhyTYHse6pcGEs=;
 b=ffDmcWm24qyCFRt36xfw/hKtTjyV1MkGXpj9dTTxXZkA0SZ4gcffZfv++/AXa+cSnLzj
 XKMCB0sokvw9uJk7cUG4iUW/KWq5I8mr0YNDEchzLCb9TdtnyVpl5DbEeav7NBr9jrDm
 U5tK+r0PtrVuTSLroqo4EObBKuF0WGm7GlRlsk54gQohtmxkZqGIdn4Iqu6N9sEKjZ3z
 Lf7ic/4xD0JMdxzYTtnP5wTfISSpArtmli3WHM45p1or91FJKmf3FXjd67aGDnjcL0fJ
 WqzH4Pbdgdq5wg1U8CLumI9fRbkygjhzmxVjfYJPihrVWvwT9oI6kTplSk85ETYiX2PN eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ppby3rh36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 10:11:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 95C1D100034;
        Mon,  3 Apr 2023 10:11:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 879682128C2;
        Mon,  3 Apr 2023 10:11:47 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 3 Apr
 2023 10:11:46 +0200
Message-ID: <c2a80960-f92f-0919-bf82-d5cec74fda09@foss.st.com>
Date:   Mon, 3 Apr 2023 10:11:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/3] YAML validation fixes
Content-Language: en-US
To:     Pierre Yves MORDRET <frq08952@lmecxl1060.lme.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
References: <20230119144030.1805-1-pierre-yves.mordret@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230119144030.1805-1-pierre-yves.mordret@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_05,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-3.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 1/19/23 15:40, Pierre Yves MORDRET wrote:
> Attention: Sender not authenticated
> --------------------------------------------------
> 
> Patches to get rid from DT check errors for STM32MPU Boards but also for Argon and Odyssey.
> 
> ---
>    Version history:
>      v1:
>          * Initial
>      v2:
>          * Update send addresses
> 
> Pierre-Yves MORDRET (3):
>    ARM: dts: stm32: YAML validation fails for STM32MPU Boards
>    ARM: dts: stm32: YAML validation fails for Odyssey Boards
>    ARM: dts: stm32: YAML validation fails for Argon Boards
> 
>   arch/arm/boot/dts/stm32mp157c-ed1.dts            |  9 ---------
>   arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi |  9 ---------
>   arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi   | 10 ----------
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi           |  9 ---------
>   4 files changed, 37 deletions(-)
> 
> --
> 2.17.1
> 

Series applied on stm32-next.

Regards
Alex

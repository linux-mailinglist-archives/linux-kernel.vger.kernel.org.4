Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF1662BAC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbjAIQu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjAIQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:50:09 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E8139F94;
        Mon,  9 Jan 2023 08:48:21 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309CcS0M004755;
        Mon, 9 Jan 2023 17:48:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=HpjiDxO7BGUdjKg/xPiZJGtQIB3/nFTNQ+hhSfVtEHI=;
 b=Xf4ggyfezBBZz5tGahk6Ry/CmwDoWSua995vphfp4I9FRscTEcEZHSkdHTmccbFDrIzV
 DDyZSCiHKpn4xfm+mx4d2r1/Qi/ua0KrbDy8B1amN3LNzgO7loZIVblEShE3zgyKo7Dz
 vfUQ6goV7a+AO8V+I975A6bwr5U7e9T2deAA3lGxv8yAr8CTVVP5BiWpVKQwvmp8IW+N
 ml/aKP7TOmyGNBewcSJWtRNs5GfuenWVhRAWYX2wjAXRMm6rjUFNKQqjaElFBlvDkTMI
 +2R+ybQn/aBQQiW0l2aKclXIEwQRN0yDNar9XzAFfIWKG8uB7iHt+4Jaz+bFtsblW3Ab Bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3my0y6ugtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 17:48:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 05F9010002A;
        Mon,  9 Jan 2023 17:48:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E8399226FD2;
        Mon,  9 Jan 2023 17:48:12 +0100 (CET)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 9 Jan
 2023 17:48:12 +0100
Message-ID: <6219844a-47d9-5edd-ff9f-6e5df0602d0c@foss.st.com>
Date:   Mon, 9 Jan 2023 17:48:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/3] ARM: dts: stm32: Remove the pins-are-numbered
 property
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <mcoquelin.stm32@gmail.com>, <krzysztof.kozlowski@linaro.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <khilman@baylibre.com>,
        <linux-gpio@vger.kernel.org>
References: <20221205135158.1842465-1-bero@baylibre.com>
 <20221205135158.1842465-4-bero@baylibre.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20221205135158.1842465-4-bero@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_10,2023-01-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernhard

On 12/5/22 14:51, Bernhard Rosenkränzer wrote:
> Remove the pins-are-numbered property from STM32 DeviceTrees
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Applied on stm32-next.

Cheers
Alex


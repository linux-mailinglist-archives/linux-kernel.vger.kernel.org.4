Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7696F6582
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjEDHKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjEDHKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:10:11 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20088E;
        Thu,  4 May 2023 00:10:09 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3445knZ4015912;
        Thu, 4 May 2023 09:09:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=BdevYqMi76NwKC3zRXAgy5PN3WHuWUsGRFi5mAmNrPU=;
 b=diBkdS5cAS1F6aGRwKb+ZnpjXcLvvpzZASwgoOP/4T8WkojTtCRd77G8y0wSpK265DFf
 5SRXoIc/CY5v7rG7eBolJXEjxs5ZNy928g9ffgPPkIG0/TUSRBSkZ69nPsngOZ/qKR6R
 Dc+Duyu4G38L9DAJuDKUVJ6ZFi6zwRDwUa2XBGJ9YcUUsZ7jKuPAExnDi3F2gWKNlaiV
 lGX9W7eGu6apovH/vVztA94SREXjCBuLXZ1Ef+IcSl/mQmGRz5U83sXo5yh+4sPvoItI
 nXSuhuHXKRPRxWD3ghAGp+VdxBVGEfJFlyDZ2TPVqtOzUXuqFoZcaBR526anQtwoamsn 5g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qc6uw8hjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 09:09:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DCD5210002A;
        Thu,  4 May 2023 09:09:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F0066210F61;
        Thu,  4 May 2023 09:09:15 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 4 May
 2023 09:09:15 +0200
Message-ID: <95076d3b-5667-8cb3-c09a-e0b7dc2b03c3@foss.st.com>
Date:   Thu, 4 May 2023 09:09:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Linux-stm32] [RFC PATCH 0/1] Categorize ARM dts directory
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-aspeed@lists.ozlabs.org>,
        <linux-realtek-soc@lists.infradead.org>,
        <linux-arm-kernel@axis.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <chrome-platform@lists.linux.dev>,
        <linux-samsung-soc@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-sunxi@lists.linux.dev>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-actions@lists.infradead.org>,
        <linux-unisoc@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        <kernel@dh-electronics.com>, Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <99b49e6b-e963-415a-a2c9-72505087833c@app.fastmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <99b49e6b-e963-415a-a2c9-72505087833c@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_04,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/23 13:02, Arnd Bergmann wrote:
> On Tue, May 2, 2023, at 21:40, Rob Herring wrote:
>> On Tue, May 2, 2023 at 3:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
> 

...

> 
>>      'stm' : 'stm32',
>>      'sti' : 'sti',
>>      'st-pin' : 'sti',
>>      'ste' : 'st-ericsson',
>>      'spear' : 'spear',
> 
> I would put all five of these into 'st'. The ux500 was developed
> in st-ericsson, but last sold by st, and the other ones are all
> original st products.

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

thanks
Alex

> 
>        Arnd
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32


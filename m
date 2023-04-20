Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311156E8D23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjDTItU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjDTIsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:48:24 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A12468A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:48:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33K8lbDT097439;
        Thu, 20 Apr 2023 03:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681980457;
        bh=4JXCnX7/6ZI1mB75DWzDR8k021aCvnf/x0gwmwCaIzo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=xQxGzwzZQXzuHcrJoKhGCCO4R3EP7I08FTCTfs9H/XVv9UiPbu6mf0t5lTX5npEhV
         4IdoY6+ZhXatryNqvIaDNX6jwqLdSMv6RU5PO5z2Mea8sndo0VSKe5FOb5wxWft0uH
         gIfvF5jcU+O+KDblsa3SHt7eJ50zeqxCbI2+0s80=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33K8lbNb000678
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Apr 2023 03:47:37 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 20
 Apr 2023 03:47:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 20 Apr 2023 03:47:36 -0500
Received: from [10.249.48.175] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33K8laas013782;
        Thu, 20 Apr 2023 03:47:36 -0500
Message-ID: <f4514baa-d92d-c421-b13a-b30c7023108e@ti.com>
Date:   Thu, 20 Apr 2023 03:47:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] arm64: defconfig: enable TI K3 R5 and DSP remote proc
 drivers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <arnd@arndb.de>, <treding@nvidia.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>
References: <20230419113958.17141-1-hnagalla@ti.com>
 <20230419113958.17141-3-hnagalla@ti.com>
 <70b6f997-d420-0e59-0be5-6ae9db7aed66@linaro.org>
 <ae49267f-4534-e489-4bb7-946944a9a04c@ti.com>
 <9a2ed4b6-13b7-9e65-263c-d2b08e11da00@linaro.org>
Content-Language: en-US
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <9a2ed4b6-13b7-9e65-263c-d2b08e11da00@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/23 07:46, Krzysztof Kozlowski wrote:
> Yeah, but why? This is simple defconfig change, just enabling drivers
> for same platform. With such arguments are we going to enable all
> drivers everywhere one-by-one?
Ok. will coalesce both patches and resubmit.

Thanks

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0025866B516
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 01:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjAPAy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 19:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjAPAy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 19:54:26 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9F96A7B;
        Sun, 15 Jan 2023 16:54:25 -0800 (PST)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NwD5L0nNVznVSn;
        Mon, 16 Jan 2023 08:52:38 +0800 (CST)
Received: from [10.67.103.39] (10.67.103.39) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 08:54:19 +0800
Message-ID: <63C4A03A.70701@hisilicon.com>
Date:   Mon, 16 Jan 2023 08:54:18 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: hisilicon: align LED node names with dtschema
References: <20221125144140.477225-1-krzysztof.kozlowski@linaro.org> <167360709873.32944.9243558336647166949.b4-ty@linaro.org>
In-Reply-To: <167360709873.32944.9243558336647166949.b4-ty@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.39]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof，

On 2023/1/13 18:51, Krzysztof Kozlowski wrote:
> On Fri, 25 Nov 2022 15:41:39 +0100, Krzysztof Kozlowski wrote:
>> The node names should be generic and DT schema expects certain pattern:
>>
>>   hisilicon/hi3660-hikey960.dtb: leds: wlan_active_led: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
>>
>>
> 
> Applied, thanks!
> 
> [1/1] arm64: dts: hisilicon: align LED node names with dtschema
>       https://git.kernel.org/krzk/linux-dt/c/d0931f1d5e9c1655cfa8128edd14e813b4044801
> 
> Best regards,
> 

Thanks!

Best Regards,
Wei

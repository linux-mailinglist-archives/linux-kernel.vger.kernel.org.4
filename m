Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948946B6D05
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 02:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCMBU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 21:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCMBUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 21:20:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F12229425;
        Sun, 12 Mar 2023 18:20:24 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PZf2W0LXXzrSPZ;
        Mon, 13 Mar 2023 09:19:31 +0800 (CST)
Received: from [10.67.103.39] (10.67.103.39) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 13 Mar
 2023 08:59:26 +0800
Message-ID: <640E756E.7050001@hisilicon.com>
Date:   Mon, 13 Mar 2023 08:59:26 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: hisilicon: use "okay" for status
References: <20230127101834.93818-1-krzysztof.kozlowski@linaro.org> <167864162129.395859.5462304450333936857.b4-ty@linaro.org>
In-Reply-To: <167864162129.395859.5462304450333936857.b4-ty@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

Hi Krzysztof,

On 2023/3/13 1:21, Krzysztof Kozlowski wrote:
> On Fri, 27 Jan 2023 11:18:34 +0100, Krzysztof Kozlowski wrote:
>> "okay" over "ok" is preferred for status property.
>>
>>
> 
> Applied, thanks!
> (Patch was waiting for quite a long on the lists, let me know if anyone wants
> to pick it up instead)
> 
> [1/1] ARM: dts: hisilicon: use "okay" for status
>       https://git.kernel.org/krzk/linux-dt/c/aff750faa5ac699df7ade5a31b6ba52ab1072d8a
> 
> Best regards,
> 

Thanks!

Best Regards,
Wei

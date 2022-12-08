Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3726468EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLHGLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLHGLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:11:02 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51FA99F17
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 22:11:00 -0800 (PST)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NSNzg4g81zmWLC;
        Thu,  8 Dec 2022 14:10:07 +0800 (CST)
Received: from [10.174.176.131] (10.174.176.131) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Dec 2022 14:10:57 +0800
Message-ID: <803c31e1-5e33-2a96-835c-420815a6e7a5@huawei.com>
Date:   Thu, 8 Dec 2022 14:10:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ASoC: rockchip: spdif: Add missing
 clk_disable_unprepare() in rockchip_pdm_runtime_resume()
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <heiko@sntech.de>, <sugar.zhang@rock-chips.com>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221205024317.2422223-1-wangjingjin1@huawei.com>
 <Y5Cb/1kRQVOrOT0Q@sirena.org.uk>
From:   "Wangjingjin(KERNEL)" <wangjingjin1@huawei.com>
In-Reply-To: <Y5Cb/1kRQVOrOT0Q@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.131]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right，will fix in v2
Thanks for review.

在 2022/12/7 21:58, Mark Brown 写道:
> On Mon, Dec 05, 2022 at 10:43:17AM +0800, Wang Jingjin wrote:
>> The clk_disable_unprepare() should be called in the error handling of
>> rockchip_pdm_runtime_resume().
>>
>> Fixes: fc05a5b22253 ("ASoC: rockchip: add support for pdm controller")
>> Signed-off-by: Wang Jingjin <wangjingjin1@huawei.com>
>> ---
>>   sound/soc/rockchip/rockchip_pdm.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> The subject line says this is a fix for the S/PDIF driver but the patch
> is for the PDM driver and I see you sent a separate fix for the PDM
> driver.

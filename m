Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38EB68B79F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBFInz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBFInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:43:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC304495
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:42:45 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P9KTz41dKzJsJP;
        Mon,  6 Feb 2023 16:40:55 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Feb 2023 16:42:34 +0800
Subject: Re: [PATCH] ASoC: codecs: es8326: Fix DTS properties reading
To:     Alexey Firago <a.firago@yadro.com>, <linux-kernel@vger.kernel.org>
CC:     <alsa-devel@alsa-project.org>, <zhuning0077@gmail.com>,
        <yangxiaohua@everest-semi.com>, <broonie@kernel.org>,
        <tiwai@suse.com>
References: <20230204195106.46539-1-a.firago@yadro.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <96c99731-a5e9-778d-24f5-cb42a5c2d840@huawei.com>
Date:   Mon, 6 Feb 2023 16:42:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230204195106.46539-1-a.firago@yadro.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/2/5 3:51, Alexey Firago wrote:
> Seems like properties parsing and reading was copy-pasted,
> so "everest,interrupt-src" and "everest,interrupt-clk" are saved into
> the es8326->jack_pol variable. This might lead to wrong settings
> being saved into the reg 57 (ES8326_HP_DET).
>
> Fix this by using proper variables while reading properties.
>
> Signed-off-by: Alexey Firago <a.firago@yadro.com>

Fix tag is needed, it should be 5c439937775d ("ASoC: codecs: add support 
for ES8326")

Reviewed-by: Yang Yingliang <yangyingliang@huawei.com


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7B613859
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJaNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiJaNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:48:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A8FAEE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:48:02 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1DxW0LX4zmVZv;
        Mon, 31 Oct 2022 21:47:59 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 21:48:00 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 21:48:00 +0800
Message-ID: <4712b4ec-1e76-862c-4383-9496233a262a@huawei.com>
Date:   Mon, 31 Oct 2022 21:47:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] ASoC: core: Fix use-after-free in snd_soc_exit()
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <tiwai@suse.com>, <perex@perex.cz>, <lgirdwood@gmail.com>
References: <20221028031603.59416-1-chenzhongjin@huawei.com>
 <166697367874.746166.7503879951900455151.b4-ty@kernel.org>
 <b30fa009-9174-da95-5799-149837e199e6@huawei.com>
 <Y1/IC1DWcKzvSDb5@sirena.org.uk>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <Y1/IC1DWcKzvSDb5@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/31 21:05, Mark Brown wrote:
> On Sat, Oct 29, 2022 at 12:34:19PM +0800, Chen Zhongjin wrote:
>
>> Since snd_soc_util_exit is only used in snd_soc_init() and snd_soc_exit(),
>> could you please add this fix to the patch and delete _exit for
>> snd_soc_util_exit()?
>> Or should I send a v2 version to replace current one?
> As the mail you got when the patch was applied said:
>
> | If any updates are required or you are submitting further changes they
> | should be sent as incremental updates against current git, existing
> | patches will not be replaced.
>
> so please submit another patch on top of what's there currently as
> normal.

Thanks for answer! Will remember for the next time.

Have send the fix up patch:

ASoC: soc-utils: Remove __exit for snd_soc_util_exit()


Best,

Chen


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BC76A14D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBXCP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBXCP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:15:56 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD2455E865
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:15:54 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.133])
        by gateway (Coremail) with SMTP id _____8Cxf9vZHfhj4WwEAA--.3175S3;
        Fri, 24 Feb 2023 10:15:53 +0800 (CST)
Received: from [10.20.42.133] (unknown [10.20.42.133])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axvr7WHfhjfCY6AA--.45207S3;
        Fri, 24 Feb 2023 10:15:52 +0800 (CST)
Message-ID: <d0640075-289a-e5ac-132a-c4fb8e151ad2@loongson.cn>
Date:   Fri, 24 Feb 2023 10:15:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] drm: add kms driver for loongson display controller
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        suijingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Li Yi <liyi@loongson.cn>
References: <20230220165130.6297-1-15330273260@189.cn>
 <ce854840-17d3-9ba1-5cf9-79a5fd2888c6@suse.de>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <ce854840-17d3-9ba1-5cf9-79a5fd2888c6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axvr7WHfhjfCY6AA--.45207S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvdXoW7Gr48Xr1rtw4kXw1DAw47Jwb_yoWkuFb_uw
        4DGrs3Zw1jyFs7trWktr45ZryDGrZYqrykAF42vFZIqFnrJF98Arn5JF97Za43u3ySy39x
        Krn8JFn7ua1q9jkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO
        n7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/2/23 22:07, Thomas Zimmermann wrote:
>
> It's the same story all over: you rather want to remove all these 
> lookup helpers and do a single test before you create the modesetting 
> pipeline:
>
>  if (chip == LS7A2000 && index == 0)
>     lscd_create_output_ls7a2000_0();
>  else if (chip == LS7A2000 && index == 1)
>     lscd_create_output_ls7a2000_1();
>  else if (chip == LS7A1000 && index == 0)
>     lscd_create_output_ls7a1000_0();
>  else if (chip == LS7A1000 && index == 1)
>     lscd_create_output_ls7a1000_1();
>  else if (...)
>     ...
>
> There you create the data structures for each pair of chip and index. 
> If you have functions that can be used by multiple pairs, sharing 
> those is fine. You might end up with duplicated code, but the overall 
> design is sound.
>
> Your current design will become unmaintainable pretty soon. We already 
> have several of such drivers.


Yes, your are right.

I'm fear of the duplicated code in the past.

I did not put my attention to the maintainable of the software.

a quick skim through radeon, I find that there also seems have 
"duplicated" code, this is  a design.

I didn't get it before, now I get it.


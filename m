Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC85E9A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiIZHie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiIZHic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:38:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F58D28E34
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:38:31 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MbZJS1cYszlWrH;
        Mon, 26 Sep 2022 15:34:16 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 15:38:29 +0800
Message-ID: <b237cfe9-7a8c-e884-2ec6-fbe1c6603f95@huawei.com>
Date:   Mon, 26 Sep 2022 15:38:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] drm/ast: make ast_modeset static
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, <airlied@redhat.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20220926023253.739699-1-ruanjinjie@huawei.com>
 <c6d0fb6f-6fc3-3123-ee7c-7edac211dbf3@suse.de>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <c6d0fb6f-6fc3-3123-ee7c-7edac211dbf3@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much!

On 2022/9/26 15:16, Thomas Zimmermann wrote:
> Hi
> 
> Am 26.09.22 um 04:32 schrieb ruanjinjie:
>> The symbol is not used outside of the file, so mark it static.
>>
>> Fixes the following warning:
>>
>> drivers/gpu/drm/ast/ast_drv.c:42:5: warning: symbol 'ast_modeset'
>> was not declared. Should it be static?
>>
>> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> 
> Thank you. Added to drm-misc-next.
> 
> Best regards
> Thomas
> 
>> ---
>>   drivers/gpu/drm/ast/ast_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/ast/ast_drv.c
>> b/drivers/gpu/drm/ast/ast_drv.c
>> index 760b27971557..b9392f31e629 100644
>> --- a/drivers/gpu/drm/ast/ast_drv.c
>> +++ b/drivers/gpu/drm/ast/ast_drv.c
>> @@ -39,7 +39,7 @@
>>     #include "ast_drv.h"
>>   -int ast_modeset = -1;
>> +static int ast_modeset = -1;
>>     MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
>>   module_param_named(modeset, ast_modeset, int, 0400);
> 

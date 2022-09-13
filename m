Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CABC5B6545
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIMBx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIMBxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:53:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2314F6BE;
        Mon, 12 Sep 2022 18:53:49 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MRRKH1G0kzHnsX;
        Tue, 13 Sep 2022 09:51:47 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 09:53:47 +0800
Subject: Re: [PATCH] security/keys: remove request_key_conswq and
 keyring_search_instkey() declarations
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dhowells@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220909060452.1121620-1-cuigaosheng1@huawei.com>
 <Yx8adIc2FC0jdJuM@kernel.org>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <169ff0aa-b59f-99d2-942b-01cb2fe47795@huawei.com>
Date:   Tue, 13 Sep 2022 09:53:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <Yx8adIc2FC0jdJuM@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking the time to review this patch, I have made a patch V2 and submitted it.

link: https://patchwork.kernel.org/project/linux-security-module/patch/20220913014613.524253-1-cuigaosheng1@huawei.com/

ÔÚ 2022/9/12 19:39, Jarkko Sakkinen Ð´µÀ:
> "KEYS: Remove orphan declarations from security/keys/internal.h"
>
> On Fri, Sep 09, 2022 at 02:04:52PM +0800, Gaosheng Cui wrote:
>> request_key_conswq has been removed since
>> commit 76181c134f87 ("KEYS: Make request_key() and co fundamentally
>> asynchronous").
>>
>> keyring_search_instkey() has been removed since
>> commit b5f545c880a2 ("[PATCH] keys: Permit running process to
>> instantiate keys").
>>
>> so remove the declare for them from header file.
>>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> "
> Remove the following orphan declarations from security/keys/internal.h:
>
> 1. request_key_conswq()
> 2. keyring_search_instkey()
> "
>
> Then add two fixes tags after that.
>
> BR, Jarkko
>
> .

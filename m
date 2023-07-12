Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCEB74FD56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjGLC6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjGLC6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:58:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CF4E6F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 19:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GZqFOmuLSJRAIAl3ElgJNozu6CdF+cuRdHQxRHRCEvg=; b=yD1ZqQTnVxnUblrCBQqg35IIPz
        YGSeokSUodn4iLkRQ2HhhEk+yJCQzOZQSVm7hvhwW1Zr0GH5GDwj360mEIaIbvjYV4OH4WC06G+n5
        kRTwdij+tCShkga3AnScMxp8wuYWUEhJ0WThy7gKlbH5DRgkdfvMe7UlyYmqvWvf4Yj5ZPtAJ8pyg
        /E0dwNvnCC+XxqLC6QlrgCDJUVZPWGW3r2NzrXJBWVgFMbnEMDJAvYxH65YL34sR5iK9xFVb4cvQi
        xfmKlLUam8XY9BMKudL80U37K/tljF14upTfiRzWb17DgzIxxMsdgqYZiu9D5udfpIp7xZrbyouVS
        gXxb3R5A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJQ3L-00GKqw-1s;
        Wed, 12 Jul 2023 02:58:07 +0000
Message-ID: <7871b526-3cd4-9c78-298c-b03c95277b2d@infradead.org>
Date:   Tue, 11 Jul 2023 19:58:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBsaWI6Rml4IG1vcmUgZXJyb3Ig?=
 =?UTF-8?Q?checking_for_debugfs=5fcreate=5fdir=28=29?=
Content-Language: en-US
To:     =?UTF-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>, LKML <linux-kernel@vger.kernel.org>
Cc:     "opensource.kernel" <opensource.kernel@vivo.com>
References: <20230711111727.2672-1-machel@vivo.com>
 <5469d33c-8b23-79b0-3815-163908cffb40@infradead.org>
 <SG2PR06MB3743963CD8DA3A48FC6C2122BD36A@SG2PR06MB3743.apcprd06.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <SG2PR06MB3743963CD8DA3A48FC6C2122BD36A@SG2PR06MB3743.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/23 18:20, 王明-软件底层技术部 wrote:
> Hi Randy.
> The only maintainers I obtained using get_maintainer.pl were LKML, and there seems to be no other maintainers
> Do you have any good suggestions?: )
> 

Use 'git log lib/test_fpu.c' to see who merges patches to it.

> ~Ming
> -----邮件原件-----
> 发件人: Randy Dunlap <rdunlap@infradead.org> 
> 发送时间: 2023年7月12日 3:33
> 收件人: 王明-软件底层技术部 <machel@vivo.com>; linux-kernel@vger.kernel.org
> 抄送: opensource.kernel <opensource.kernel@vivo.com>
> 主题: Re: [PATCH v2] lib:Fix more error checking for debugfs_create_dir()
> 
> [Some people who received this message don't often get email from rdunlap@infradead.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi--
> 
> On 7/11/23 04:16, Wang Ming wrote:
>> In case of failure, debugfs_create_dir() does not return NULL, but an 
>> error pointer.  Most incorrect error checks were fixed, but the one in 
>> test_fpu_init() was forgotten.
>>
>> Fix the remaining error check.
>>
>> Signed-off-by: Wang Ming <machel@vivo.com>
> 
> You need to send this to some maintainer who can merge it, so please an appropriate maintainer to send it to.
> 
> Thanks.
> 
>> ---
>>  lib/test_fpu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/test_fpu.c b/lib/test_fpu.c index 
>> e82db19fed84..5d6aa4691b4a 100644
>> --- a/lib/test_fpu.c
>> +++ b/lib/test_fpu.c
>> @@ -69,7 +69,7 @@ static struct dentry *selftest_dir;  static int 
>> __init test_fpu_init(void)  {
>>       selftest_dir = debugfs_create_dir("selftest_helpers", NULL);
>> -     if (!selftest_dir)
>> +     if (IS_ERR(selftest_dir))
>>               return -ENOMEM;
>>
>>       debugfs_create_file_unsafe("test_fpu", 0444, selftest_dir, NULL,
> 
> --
> ~Randy

-- 
~Randy

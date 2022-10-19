Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71939604580
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJSMit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiJSMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:38:14 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEF115201E;
        Wed, 19 Oct 2022 05:19:12 -0700 (PDT)
Message-ID: <410b2536-5cb3-ca1e-17cb-49e9e0324edf@lirui.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666181747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJZwIzOf40cWqYWDcV6d9EHXjGN4IFX3s7oxhx8/EWU=;
        b=mNpOq7qweHHX6EbM/tFKjzj+f/NS2vm+equnnXnunmGgcdh98I6m+zOolXG0AYw+LRU0XQ
        4BcKbF4kdzS8zb8xOBgVNQbAAkra7uoQ1bVSGE91JMu8lxrELr/efLlBL1IAGkiieVM3So
        TPztnbnlKtxriW1LqKJm9SlLw5VewHL426/kRvccLNoCqIQB/M/a4UCFjoJZxG6J/JKA4Q
        gea7j9uDDxG+P4KFZOPGOL7OcaQOCEpu5AEIhZMcDC0DNKahlTxK96N0SqFGitrgBFAKCT
        G5Yc5v99a/L2rFoI0tSlZ7LrQk5b2xUeJWEYfF4V8r1Hj8DrB7cNfp7Iq0tV7A==
Date:   Wed, 19 Oct 2022 20:15:39 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] docs/zh_CN: Add staging/index Chinese translation
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <cover.1666067195.git.me@lirui.org>
 <4ef47cfc6c85ad9c778af1f13761e8dd8e410ee8.1666067195.git.me@lirui.org>
 <ceb6193f-8cd6-15c0-8965-f8496e7732cd@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Rui Li <me@lirui.org>
In-Reply-To: <ceb6193f-8cd6-15c0-8965-f8496e7732cd@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/19 19:25, Yanteng Si wrote:
>
> On 10/18/22 12:31, Rui Li wrote:
>> Translate the following files into Chinese:
>>
>> - Documentation/staging/index.rst
>>
>> Add it into the menu of zh_CN/index. Also fix one translation
>> in the zh_CN/index file.
>>
>> Signed-off-by: Rui Li <me@lirui.org>
>> ---
>>   Documentation/translations/zh_CN/index.rst    |  8 +++---
>>   .../translations/zh_CN/staging/index.rst      | 27 +++++++++++++++++++
>>   2 files changed, 31 insertions(+), 4 deletions(-)
>>   create mode 100644 Documentation/translations/zh_CN/staging/index.rst
>>
>> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
>> index ec99ef5fe990..3d07b3149afe 100644
>> --- a/Documentation/translations/zh_CN/index.rst
>> +++ b/Documentation/translations/zh_CN/index.rst
>> @@ -124,13 +124,13 @@ TODOList:
>>   其他文档
>>   --------
>>   -有几份未排序的文档似乎不适合放在文档的其他部分，或者可能需要进行一些调整和/或
>> +有几份未分类的文档似乎不适合放在文档的其他部分，或者可能需要进行一些调整和/或
>>   转换为reStructureText格式，也有可能太旧。
>>   -TODOList:
>> -
>> -* staging/index
>> +.. toctree::
>> +   :maxdepth: 2
>>   +   staging/index
>>     索引和表格
>>   ----------
>> diff --git a/Documentation/translations/zh_CN/staging/index.rst b/Documentation/translations/zh_CN/staging/index.rst
>> new file mode 100644
>> index 000000000000..7d074b34ac97
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/staging/index.rst
>> @@ -0,0 +1,27 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/staging/index.rst
>> +
>> +:翻译:
>> +
>> + 李睿 Rui Li <me@lirui.org>
>> +
>> +未分类文档
>> +======================
>> +
>> +.. toctree::
>> +   :maxdepth: 2
>> +
>> +   xz
>
> The thing of adding xz to the index should be put to patch 1, one patch to do one thing.
>
>
> Logically, this patch should be used as patch 1, otherwise xz will be homeless at some point.
>
>
> Thanks,
>
> Yanteng
>
>> +
>> +TODOList:
>> +
>> +* crc32
>> +* lzo
>> +* remoteproc
>> +* rpmsg
>> +* speculation
>> +* static-keys
>> +* tee
>> +* xz
>

Thanks a lot! I made changes in PATCH v2.

-- 
Rui Li


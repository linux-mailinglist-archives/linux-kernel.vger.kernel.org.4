Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C106E0D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDMMJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMMJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:09:33 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59E849EA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:09:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-517bd9b1589so957096a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20221208.gappssmtp.com; s=20221208; t=1681387770; x=1683979770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fC7swCqsGSVufMz0OK23aCUiXDDf/Z3zzgbfOWg5le8=;
        b=x3vx9Uo1rrzHddyhS+Ef+EuNqHBsOCAlNvJHJNluECyCUQuB4Vlvar1HUbh7xVFxW+
         f974NDZu+MrmT0zvzITq1/HTGIr1eXXlVjuI9fifbL0LWfa40Fd7WWd2bJILbG+Oah+n
         iHcNLw+hb29itvIl2rN/6DLkveIrEZfQ5KhIO0A+Ci7xUuw5UZE9eCpY6pQytFfh3mHY
         ptDqRa8kSKcUH2M7qxRrNwuZUMo8lljnvjoZA5RKh/yakL2Fx8cxDykXY6RtfLAWZ6gN
         HavOzWcCryPvT7PtDq2FDHT8qMUnVtm3SrKXPij4bKpeXTO4oEgdUkmd8NHBXIsLl1Nx
         0Zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387770; x=1683979770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fC7swCqsGSVufMz0OK23aCUiXDDf/Z3zzgbfOWg5le8=;
        b=lVZg2U8ZNUJBDOaITJVypHpimmHg016cFWpaQf8O6izw2OopuSvJCjtCaEnaHeP4Gb
         oZmvK3ILgdCc2UKyP2tE2CxFu86+lt40aIZDQG4nq0ASQTodwk13LZ/AyuPxYxJuaVSk
         Aw5u/ovuqv4xwP8EUviwRRcjDP7b/xpBL0AEUGo8x0rZK8M50UVcjzd4qcJ3hg4tBsFy
         4p064MtTRTlsdc7gklJgNEdkGyfCMfSRuqEJR/oWJ1Fn+49jIKBbTtozut6GXGXysXxc
         Ew4BuszQJNJxLS8QbQzLNy8FqiCpzcRgS+Yxe3NQjf3uhYJKEDHfObyYYZ9gE12To2VM
         +b2w==
X-Gm-Message-State: AAQBX9erqYBuZih8U+quX2E+RvgvvDtc/rT/m2/D7CMMEh9DGBv3l8R2
        /PPiuPvW2JRKwDZr+mm/nkqMMz9TgngwvLMX4sU=
X-Google-Smtp-Source: AKy350ZCF3nJLzyOo/4fodCdTblbeeVhBN/n9MvGBg3lmPySenM5YKV7BN2lNGhcody9LlFr4Vwenw==
X-Received: by 2002:a05:6a00:1a4d:b0:63b:1bc7:c703 with SMTP id h13-20020a056a001a4d00b0063b1bc7c703mr3290601pfv.10.1681387770184;
        Thu, 13 Apr 2023 05:09:30 -0700 (PDT)
Received: from [192.168.10.153] (ppp118-208-169-253.cbr-trn-nor-bras39.tpg.internode.on.net. [118.208.169.253])
        by smtp.gmail.com with ESMTPSA id t26-20020aa7939a000000b0063b54ccc123sm870148pfe.196.2023.04.13.05.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 05:09:29 -0700 (PDT)
Message-ID: <2a80cb20-0c9f-2d0c-e951-c4f005f3e4b3@ozlabs.ru>
Date:   Thu, 13 Apr 2023 22:09:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101
 Thunderbird/108.0
Subject: Re: Probing nvme disks fails on Upstream kernels on powerpc Maxconfig
To:     Michael Ellerman <mpe@ellerman.id.au>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sachinp@linux.vnet.ibm.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230323095333.GI1005120@linux.vnet.ibm.com>
 <906d4d0e-b487-00a5-9399-7d1edc5e20a4@leemhuis.info>
 <87bkk2khl0.fsf@mpe.ellerman.id.au>
Content-Language: en-US
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <87bkk2khl0.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2023 15:45, Michael Ellerman wrote:
> "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> writes:
>> [CCing the regression list, as it should be in the loop for regressions:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>
>> On 23.03.23 10:53, Srikar Dronamraju wrote:
>>>
>>> I am unable to boot upstream kernels from v5.16 to the latest upstream
>>> kernel on a maxconfig system. (Machine config details given below)
>>>
>>> At boot, we see a series of messages like the below.
>>>
>>> dracut-initqueue[13917]: Warning: dracut-initqueue: timeout, still waiting for following initqueue hooks:
>>> dracut-initqueue[13917]: Warning: /lib/dracut/hooks/initqueue/finished/devexists-\x2fdev\x2fdisk\x2fby-uuid\x2f93dc0767-18aa-467f-afa7-5b4e9c13108a.sh: "if ! grep -q After=remote-fs-pre.target /run/systemd/generator/systemd-cryptsetup@*.service 2>/dev/null; then
>>> dracut-initqueue[13917]:     [ -e "/dev/disk/by-uuid/93dc0767-18aa-467f-afa7-5b4e9c13108a" ]
>>> dracut-initqueue[13917]: fi"
>>
>> Alexey, did you look into this? This is apparently caused by a commit of
>> yours (see quoted part below) that Michael applied. Looks like it fell
>> through the cracks from here, but maybe I'm missing something.
> 
> Unfortunately Alexey is not working at IBM any more, so he won't have
> access to any hardware to debug/test this.
> 
> Srikar are you debugging this? If not we'll have to find someone else to
> look at it.

Has this been fixed and I missed cc:? Anyway, without the full log, I 
still see it is a huge guest so chances are the guest could not map all 
RAM so instead it uses the biggest possible DDW with 2M pages. If that's 
the case, this might help it:

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 614af78b3695..996acf245ae5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -906,7 +906,7 @@ void *iommu_alloc_coherent(struct device *dev, 
struct iommu_table *tbl,
         unsigned int nio_pages, io_order;
         struct page *page;

-       size = PAGE_ALIGN(size);
+       size = _ALIGN(size, IOMMU_PAGE_SIZE(tbl));
         order = get_order(size);

         /*
@@ -949,10 +949,9 @@ void iommu_free_coherent(struct iommu_table *tbl, 
size_t size,
         if (tbl) {
                 unsigned int nio_pages;

-               size = PAGE_ALIGN(size);
+               size = _ALIGN(size, IOMMU_PAGE_SIZE(tbl));
                 nio_pages = size >> tbl->it_page_shift;
                 iommu_free(tbl, dma_handle, nio_pages);
-               size = PAGE_ALIGN(size);
                 free_pages((unsigned long)vaddr, get_order(size));
         }


And there may be other places where PAGE_SIZE is used instead of 
IOMMU_PAGE_SIZE(tbl). Thanks,


-- 
Alexey

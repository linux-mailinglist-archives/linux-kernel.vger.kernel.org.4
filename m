Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7206025A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJRHYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJRHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:24:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF07AC498
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:23:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pq16so13207658pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBwuizpkCKbq1SvzVMTwyeKTeXU4LazpzWWzaVv1xBU=;
        b=aE7vPfO8sNeJjmd/6/cG+NJE5XS1hLqfbe0KMmeekFjfDWtjLVy53z9pfBfXOMzWuh
         eDT/imD4IeynJD2dWFql4p8zJY2WZs8QUXbQxyzFSF6EepBDqR9uuJgyuGUdlaMPPHWL
         RL9JuKT27kiWLLwEpO9Y52KYBELWN+ut62KpOnxhB/gj/M4Wmfivx7tx7vbYAKA4tBQ6
         NmG0/jv0u6rHohU8wJAn0cKYdVfouhHLXaEZqyVYceit5hsj6J/KkfFsMDv77yhtiBZ8
         hcR2raWRMmz2UjDXo3TOefvDKI9qGwT78EKy/cXIv3fLJf3TfoYH70G2C8TeGoD+4lIA
         utpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBwuizpkCKbq1SvzVMTwyeKTeXU4LazpzWWzaVv1xBU=;
        b=GhJHWWWlSkV8yH4nUS2HAVOb5Dx+KFmBr0MN+4pFGbBj4ZNKPa29hof+Ou4NBA43fS
         vkzwg0U1zhrjQh0Yv5tumJRso164emFsTfbU6PZ7kvgapLoFxDjJbOIB2UtJdD2OQkaw
         442VrHRokvJlPxLOFn+EGKu0llBksYTI3O7+rVN8XuTE64+WnlkxDmK6mmMNI1rxI90I
         5VJuiLzvBAzVveVojI5HK+10PZCUxW8RW4RQoWcVk+gGJ7SOn8UUvxvlkZJce36j5Xyu
         xzqSc5JQtkzihrGXxWv9fyhquPqfEkrCvyd/QPZIdbfUEqy2l06G5Pg06pueyks5sO+J
         2odA==
X-Gm-Message-State: ACrzQf0e2wjBPtDF9H/lu4d/MrG47zFfQCXxMc03Ubj+4IAb/C8/kloy
        y8fKAjger6GO5sxKkH2d3MQ=
X-Google-Smtp-Source: AMsMyM5rNrKDU+uoU480m4jpkMFZ7GXOSt2UncqLsHnNn74mJccwffNoJpUYBZUR6Tk0KShwwcpK1g==
X-Received: by 2002:a17:90a:2849:b0:20a:f3ff:c983 with SMTP id p9-20020a17090a284900b0020af3ffc983mr2106136pjf.198.1666077826587;
        Tue, 18 Oct 2022 00:23:46 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id y126-20020a623284000000b00560cdb3784bsm8353589pfy.60.2022.10.18.00.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 00:23:46 -0700 (PDT)
Message-ID: <2522e5d5-5f8a-c5e9-4864-a82f0e6d2512@gmail.com>
Date:   Tue, 18 Oct 2022 14:23:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
To:     Jintao Yin <nicememory@gmail.com>, phillip@squashfs.org.uk
Cc:     linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        mirsad.todorovac@alu.unizg.hr, regressions@leemhuis.info,
        regressions@lists.linux.dev, srw@sladewatkins.net
References: <20221015205936.5735-1-phillip@squashfs.org.uk>
 <20221018021507.612-1-nicememory@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221018021507.612-1-nicememory@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 09:15, Jintao Yin wrote:
> Hi Phillip,
>   There is a logical bug in commit 8fc78b6fe24c36b151ac98d7546591ed92083d4f
>   which is parent commit of commit b09a7a036d2035b14636cd4c4c69518d73770f65.
>   
>   In function squashfs_readahead(...),
>   file_end is initialized with i_size_read(inode) >> msblk->block_log,
>   which means the last block index of the file.
>   But later in the logic to check if the page is last one or not the
>   code is 
>     if (pages[nr_pages - 1]->index == file_end && bytes) {
>       ...
>     }
>   , use file_end as the last page index of file but actually is the last
>   block index, so for the common setup of page and block size, the first 
>   comparison is true only when pages[nr_pages - 1]->index is 0.
>   Otherwise, the trailing bytes of last page won't be zeroed.
> 
>   Maybe it's the real cause of the snap bug in some way.
> 

Hi Jintao, thanks for explaining the real culprit. However, I'd like to
see the fixup patch from you so that we can test.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


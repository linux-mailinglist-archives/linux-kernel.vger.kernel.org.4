Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72D695970
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjBNGto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjBNGtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:49:41 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16711C7D0;
        Mon, 13 Feb 2023 22:49:40 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-16cc1e43244so13674389fac.12;
        Mon, 13 Feb 2023 22:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rijdzKSfbK5ozVCDgevjXVzr4zgQ6Ett6421gYQjBjU=;
        b=gNLByVF7GA+0ujtTikXm5+Fcca8YkgCFBVUuv8X/YA7bpI1ZRU6IPPKtbZJlYRUWpw
         /MePF0CQTl8AnRVKMAdAAao6pyWwBtMNn1nwGCo4cxOf5cpfTZi46H59nzeSfT+WLW46
         zqMic8R1xlGD6D2g80oUKonOHxY4i1asrnDtUFnWcqOZLou/bp5+/Gf3PDepKM8FEWen
         Ic5D/hkpZ4PmSBcu7zvV2riF5tEK1jtyx3z/USuHuM+TZsb1I9rOoq5iDAPOPaRTcqQX
         juqmd/Gx6Nc5i6Tsg1I/YdijZticj1qluGeu/XedoBajQVKGwYw4h6wOIXAQekqu2B3C
         H/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rijdzKSfbK5ozVCDgevjXVzr4zgQ6Ett6421gYQjBjU=;
        b=AUDGhDm26AWk2lQEF/I00cLIG4LffQAuDdLfF8+SCsdifSr4s5I0V6iF492lt5LLZ9
         CJoMv4cTg7iHaaarnICHmEkbuH0awI3k1gVIJwvpI4BFmmFBKacVXSw2sfypSXGgxTtb
         wA5+o6RLTP9ttDk4QRVOdjq0mKdXepbaIYE7G8JI67D95m8VvtMxl1bGSNkUDLIxg5H7
         EexI4NvXb1ZP9wqSkObD3WSDTz8//31ivVkQxedLkcUc38obm7lDUWFcH89uy6vD0Tu0
         psIPuS9eDxIa6ut42fWzjoVe6L0imRb0p4D62hgW+G63C2YoGHqku1ZlWpGZp9MSD7v0
         fNLQ==
X-Gm-Message-State: AO0yUKXvRherOEQwboMFuaaKR7MRSzPBz6kLTlF7cNfRBSajIypNKt8T
        tdMLM8LtPegAP8uHWw9KUpKLhsiSa9s=
X-Google-Smtp-Source: AK7set+D6se+3HXzrTkHjLfiAh+EJonOXL1A3hahbqcy+RaRH5Onp3cZWFOegYMqLSY70kp6fnxs3A==
X-Received: by 2002:a05:6870:e750:b0:16e:9dd:f059 with SMTP id t16-20020a056870e75000b0016e09ddf059mr441585oak.14.1676357380183;
        Mon, 13 Feb 2023 22:49:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ds41-20020a0568705b2900b0016db8833b2dsm4153574oab.52.2023.02.13.22.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 22:49:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <07c870d3-5d98-ca51-5de8-034abc631673@roeck-us.net>
Date:   Mon, 13 Feb 2023 22:49:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-mm@kvack.org
References: <ed33b9ff-e6f2-dae8-ede6-59dc3c649ece@roeck-us.net>
 <20230213094754.397f86af6b2dea4aafd92344@linux-foundation.org>
 <a276d6ae-677d-e4cf-13d7-934c0a7639d2@gmail.com>
 <58fb32f8-ce1e-913b-3b85-c41b0630d4c6@roeck-us.net>
 <20230214172040.60657882@canb.auug.org.au>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: nvme boot problems after merge of mm-stable tree into linux-next
In-Reply-To: <20230214172040.60657882@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 22:20, Stephen Rothwell wrote:
> Hi Guenter,
> 
> On Mon, 13 Feb 2023 20:01:33 -0800 Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Overall, that suggests that there may have been a change somewhere
>> else in the kernel which is incompatible with a change in one of
>> the mm branches. It is interesting that the problem in next-20230210
>> was seen after the merge of mm-stable, and that it is now seen after
>> the merge of mm-everything.
> 
> That could be because I moved some merge resolution fix patches from
> the merge of mm-everything to the merge of mm-stable (they were all for
> conflicts involving commits that are now in mm-stable).  So one of my
> merge resolutions could be bad.  Or there could be some interaction of
> something in mm-everything (that is not in mm-stable or
> mm-nonmm-stable) that is interacting with some other change in the rest
> of -next.
> 

In next-20230210, the crash happened after the merge of mm-stable.
In next-20230213, the crash happens after the merge of mm-everything.
That means both the merge of mm-stable and mm-nonmm-stable are now fine.
So I would suspect that something in the merge of mm-everything
interacts with the rest of -next.

Guenter


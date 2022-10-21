Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1FE606F55
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJUFUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiJUFUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:20:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFD210451A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:20:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u21so2636807edi.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/tGCSPwUCul3MmHqm96jJCAhRvbCVXq9YYet3C7H4HE=;
        b=jqaR+ZJTr5oAL9cUPBdKhnvoP25WX4bk5wv1iYRf2lg7hD4kriRuwI3IY/Z0COXLUs
         f4DF5E/bUNxowkzYep5qtJSNKKBpp84Mitw3KA7KQuk2vQo/riL5rY/AEB+hdhPmXw9z
         TlAnrAqoBdXuybzZ6FnbCu98nrhc4/xeN53pg9I/g/hbkzqEwPZR064vlinBgwBkT3HG
         F5Ktnm5s8Klcs9l6KfFhubaSCI4IX/nQZYrJQvjij+6I7Tm+xvL9ilc1t/hNeuEwVACQ
         sZlnhCqfPDMDigru92D8bB+IQQ/PiexH0EBWe4EnJB9ABTn86O1agPKLCQM4IQ8hTWnR
         2UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/tGCSPwUCul3MmHqm96jJCAhRvbCVXq9YYet3C7H4HE=;
        b=Q8Zy7PNmL1DwR7mPBl/TlAx4eLv88L52A5Lp51gHk2Nr0sf9+U2E1dcPg09PUBWQg9
         /N7nFSXTonwoTz2mTfDeqQircEbiXEkDYAQmx6R+R6bQqnUE+vh6rIpWG8LGo48VJbC6
         dbDtbP7QA+FQQFBHpgmU01Ti24waN7jWrkLLHDItgSowfOYeElhO7BcmB0RXPP+pALRi
         ZFLIghS8verWwRk/GhD5cQj7DRa8XfmTBXpKHJEFy8eHZnF/vz0UR2KMqM+VQH4hn16V
         MwUniexeJld/Hqz1JAMAgF8teobu/y4e947S5ybObp0Hzc0adf5GwCmCSdc5YZYtlgU4
         uFyw==
X-Gm-Message-State: ACrzQf0g6g1ZpHLKGIwVaB9rXr8SoIbMyx9qXOXgkBLIUjF2QIZy32Tb
        Z7PgdnTEMIvmwh+JAb+x8SjozBNpamc=
X-Google-Smtp-Source: AMsMyM44MhLjOIKLQCOamIpRVGlwU3akY0H2Fm8QViu36fo5VwEX1W7zEYPSEKI8PNuhBrdDQZi6cQ==
X-Received: by 2002:a05:6402:3806:b0:450:bad8:8cd5 with SMTP id es6-20020a056402380600b00450bad88cd5mr16039806edb.305.1666329645313;
        Thu, 20 Oct 2022 22:20:45 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a49:651a:d082:a7de:14e2? (p200300c78f3e6a49651ad082a7de14e2.dip0.t-ipconnect.de. [2003:c7:8f3e:6a49:651a:d082:a7de:14e2])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906300f00b007415f8ffcbbsm11272939ejz.98.2022.10.20.22.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 22:20:44 -0700 (PDT)
Message-ID: <113aed11-de11-bf68-1ec1-1b420ff502da@gmail.com>
Date:   Fri, 21 Oct 2022 07:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 00/11] staging: r8188eu: trivial code cleanup patches
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
References: <cover.1666299151.git.drv@mailo.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1666299151.git.drv@mailo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 23:26, Deepak R Varma wrote:
> Address different kinds of checkpatch complains for the staging/r8188eu module.
> The patches are required to be applied in sequence.
> 
> Changes in v4:
>     1. Include patch 11 in the set for unused macro clean up. Suggested by julia.lawall@inria.fr
>     2. Update patch 1 per feedback from David.Laight@ACULAB.COM
>     3. Update patch 5 & 6 per feedback from dan.carpenter@oracle.com & julia.lawall@inria.fr
> 
> Changes in v3:
>     1. Patch 4: Extend the __constant_htons to htons change to other files of the driver.
>        This was suggested by philipp.g.hortmann@gmail.com
>     2. Patch 4: Spelling mistake corrected as pointed out by joe@perches.com
>     3. Patch 5 through 10: Included in this version. Additional clean up patches.
> 
> Changes in v2:
>     I incorrectly labeled the first revision as v1 instead of v2. So,
>     following change recorded under v1 is actually changes for v2. Feedback
>     provided by philipp.g.hortmann@gmail.com
>        1. Improve language / grammar for the patch descriptions
>        2. Further improve code reformatting
> 
> 
> Deepak R Varma (11):
>    staging: r8188eu: use Linux kernel variable naming convention
>    staging: r8188eu: reformat long computation lines
>    staging: r8188eu: remove {} for single statement blocks
>    staging: r8188eu: use htons macro instead of __constant_htons
>    staging: r8188eu: correct misspelled words in comments
>    staging: r8188eu: Add space between function & macro parameters
>    staging: r8188eu: Associate pointer symbol with parameter name
>    staging: r8188eu: replace leading spaces by tabs
>    staging: r8188eu: Put '{" on the symbol declaration line
>    staging: r8188eu: Correct missing or extra space in the statements
>    staging: r8188eu: Remove unused macros
> 
>   drivers/staging/r8188eu/core/rtw_br_ext.c     | 119 +++++++++---------
>   drivers/staging/r8188eu/core/rtw_ioctl_set.c  |   2 +-
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  36 +++---
>   drivers/staging/r8188eu/core/rtw_recv.c       |   8 +-
>   drivers/staging/r8188eu/core/rtw_xmit.c       |  14 +--
>   drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |   2 +-
>   drivers/staging/r8188eu/hal/odm_RTL8188E.c    |   2 +-
>   .../staging/r8188eu/hal/rtl8188e_hal_init.c   |   2 +-
>   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  16 +--
>   .../staging/r8188eu/include/Hal8188EPhyReg.h  |   4 +-
>   .../staging/r8188eu/include/osdep_service.h   |   4 +-
>   .../staging/r8188eu/include/rtl8188e_hal.h    |   6 +-
>   .../staging/r8188eu/include/rtl8188e_spec.h   |  18 +--
>   drivers/staging/r8188eu/include/rtw_cmd.h     |  62 +++++----
>   drivers/staging/r8188eu/include/rtw_io.h      |  16 +--
>   .../staging/r8188eu/include/rtw_ioctl_set.h   |   4 +-
>   drivers/staging/r8188eu/include/rtw_mlme.h    |  22 ++--
>   .../staging/r8188eu/include/rtw_mlme_ext.h    |  12 +-
>   drivers/staging/r8188eu/include/rtw_recv.h    |   4 +-
>   drivers/staging/r8188eu/include/rtw_xmit.h    |   2 +-
>   drivers/staging/r8188eu/include/wifi.h        |  12 +-
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c  |   6 +-
>   22 files changed, 176 insertions(+), 197 deletions(-)
> 
> --
> 2.30.2
> 
> 
> 
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150


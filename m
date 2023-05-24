Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74BD70F706
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjEXM60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjEXM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:58:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E4B6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:58:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so240622a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684933102; x=1687525102;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tBAr6nf6/jR5QGXzB4/+ToLJPUfTVA+N9gkbz/Hb2eQ=;
        b=VCLcvliaK4vDpHRRpgL3RsP9JKt/fLc2ZCTTdsegcVU1bEl0YVZeu0Bo5o+Az9hiHb
         x9MsCqoRBeEjSkWgvBTS6sMq8tZdhbcHi3CD9WsSCBDgfX2QmGF0DIMw5UAKFG+5U/P7
         3bdTFzPqPIUZKd3QBh+cNCR78euyscIMqDtgIpVfPeWuLPINwQaq/OLUP/A4r22c8TBz
         C7QkA7HlP8JHeYb/dmQbVZawNFkFmb15o0UjxwSrrRN08Dc6IWzAPlQRHRlQ/fZ3gTl1
         Xm0ido7BvtrpiFAS+60ZHOamXx/r5lgod/wwtFOdlJFY66q3Sk3oq/4RoRzdw4KJ8vdr
         qOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684933102; x=1687525102;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBAr6nf6/jR5QGXzB4/+ToLJPUfTVA+N9gkbz/Hb2eQ=;
        b=UBVvwxszMn3LvectFSBKGH42bBviviUsDscp5gnJYeJAWDxj8eN4zkIxgrGn0T2FZr
         TMimhpyd4/P2c8nL4pJ3Oa5RAQFpU+2oqU7JXNHt3BacBPljF/NZav7ziaCmPBMw+ssT
         lIKbH6MXUCX24cXfhammh2p2sdPPZfIGgjH1cinvWMLKkM9QsBIn4QaZR720Q1hSBOXW
         ZnYShp92lY3adOc+N7d1OWhs9IQShAH1PBAFjmZDCL/zkXh9ZqVXW1PVm4y7NrPQcYxg
         xe/+3lwzDjkb826nX35R/hzw172VFSkt1+WrgRqeVPY3VSeiuvL2UzMuy5jUXrcQdnNc
         NeiQ==
X-Gm-Message-State: AC+VfDzJHJixbsXF92b+AdPqjP/DGbgDzKt2N4+9ayD/aekg+F1JPQF0
        yN7OFnOj/ozd3LdAQLSN0vn5u9GHMAw=
X-Google-Smtp-Source: ACHHUZ5E6x244rmOMqqWNfxM+LDTWBnKBvIyGo1mwSh4eCdrHeqJOk1OgxQ/08oZRvsvO7uRH6PMxw==
X-Received: by 2002:a17:902:daca:b0:1ad:dbea:6e09 with SMTP id q10-20020a170902daca00b001addbea6e09mr20587943plx.66.1684933102342;
        Wed, 24 May 2023 05:58:22 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-11.three.co.id. [180.214.232.11])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001ac706dd98bsm8665957plg.35.2023.05.24.05.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 05:58:21 -0700 (PDT)
Message-ID: <5d22e1e9-0307-3664-8b4a-99caaaaa4315@gmail.com>
Date:   Wed, 24 May 2023 19:58:16 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Fwd: ./include/linux/mmzone.h:1735:2: error: #error Allocator
 MAX_ORDER exceeds SECTION_SIZE (v6.4-rc3 build regression)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        doru iorgulescu <doru.iorgulescu1@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
References: <2a1cd5e6-01f7-66f9-1f9d-c655cc3f919b@gmail.com>
Content-Language: en-US
In-Reply-To: <2a1cd5e6-01f7-66f9-1f9d-c655cc3f919b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 17:58, Bagas Sanjaya wrote:
> Anyway, I'm adding it to regzbot:
> 
> #regzbot introduced: 23baf831a32c04f https://bugzilla.kernel.org/show_bug.cgi?id=217477
> #regzbot title: Allocator MAX_ORDER exceeds SECTION_SIZE caused by MAX_ORDER redefinition
> 

From bugzilla [1], the reporter had successfully tried the proposed
kernel config fix, so:

#regzbot resolve: reducing CONFIG_ARCH_FORCE_MAX_ORDER to 8 resolves the regression

Thanks for all who participates in this regression report!

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217477#c8

-- 
An old man doll... just what I always wanted! - Clara


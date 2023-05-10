Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A65F6FDA2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbjEJI6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjEJI56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:57:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB27C7;
        Wed, 10 May 2023 01:57:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64115e652eeso48699281b3a.0;
        Wed, 10 May 2023 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683709077; x=1686301077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4LgiY91SCDw/qvHZBPA87wfua9PTLmx+fPMF0dnUHEU=;
        b=gxPv8nGZx9abnewODkwJuJeHbUhbTT30cPBXlyH6/krljpNRFKhy4Lkwjvv/4ZD1yH
         TB3l5btaSAOpWJ28+akCQo6kfF27ryGnUxYINQ/ABNYH4+0KuSAWf4awJ19OwOoZlqF/
         GNTf05mrHIvB8LRgooJjxEM1s1DqE+4hrAobSDDlhYgr0acZB/mg0F8N5m1x5DcutAuy
         VIdiWkBWxEuCuO09PiqIgj1/4DqXsF1M5tTYJdhnjSPd7jLYnDcqiU8bgfb+eKoDvjDl
         3L4fL08X1OOq8T5otzoboSro99YY9M7nV7UQtfAhk2AHMnYY3YUBbp7mTscOa2I+tP9X
         k+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683709077; x=1686301077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LgiY91SCDw/qvHZBPA87wfua9PTLmx+fPMF0dnUHEU=;
        b=f97z3e03s3e+GoUMCd/VvtQg0oOoLKkj7Ia/NCbvBPXQLnzL4Xl+hvy0sscgB+nWVx
         BFIT9r+t3GW+bYcsL5gG+f3gQ638hH9D7WJXlXCyo2MYRBG71Fs0yRzIMWUyjZZCLHby
         nTdWGKy1qbxsNETvew99sLk6c2N8Z1i/XUe7V92iBqKVgDQ8yW0QL5XwjKmvDupiKRTZ
         WBvNKLPTvpWjdH0ahOB5eagkY3vEHlRWZ7w3Zug47NI+CvwupHukp4wzXEP8Uv5hCsmX
         W1EzbAbjZ6ZJi7AKV6PR/eOvwlECqe7H3+dsNKBblWMIJoBMb1jy39BUgBJbtu/C29Pb
         aeGA==
X-Gm-Message-State: AC+VfDwzN+dUp+iq0/DOaqXG55rxYmy8AhOSdf1Akil0tWvFYc3Vy85i
        /bjada2ATho4DiTy0M/OLng=
X-Google-Smtp-Source: ACHHUZ7Ycs0i1IoirPPY7K0VFg5JBsZc1QYMtbKlTLB7E4Xn6WIzg1DvmT687DG5glzD9PgjjVP3jw==
X-Received: by 2002:a17:902:ec87:b0:19c:3d78:6a54 with SMTP id x7-20020a170902ec8700b0019c3d786a54mr19484051plg.14.1683709077168;
        Wed, 10 May 2023 01:57:57 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902bb9100b001aaef9d0102sm3180669pls.197.2023.05.10.01.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 01:57:56 -0700 (PDT)
Message-ID: <7e3e90f2-49bd-46f6-ce1e-bd3263e6eb32@gmail.com>
Date:   Wed, 10 May 2023 15:57:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] Documentation: scsi: dc395x: Remove reference to 2.4
 driver
Content-Language: en-US
To:     Oliver Neukum <oneukum@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20230505082704.16228-1-bagasdotme@gmail.com>
 <20230505082704.16228-4-bagasdotme@gmail.com>
 <d919a2e1-5749-13f8-7867-1f17277190f4@linux-m68k.org>
 <87pm7enbpo.fsf@meer.lwn.net> <8536273d-20a4-1993-1381-b50e44701835@suse.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <8536273d-20a4-1993-1381-b50e44701835@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 15:55, Oliver Neukum wrote:
> Hi,
> 
> the documentation of a kernel should document that kernel.
> 
> Now, we have a perfectly fine tool named "git" which allows
> for metadocumentation. May I suggest that you respin the patch
> and include a link to the old stuff, which somebody has been
> nice enough to find, in the change log?
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara


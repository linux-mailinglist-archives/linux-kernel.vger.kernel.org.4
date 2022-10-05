Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92B95F5342
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiJELTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJELTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:19:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDC1764D;
        Wed,  5 Oct 2022 04:19:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f11so22820383wrm.6;
        Wed, 05 Oct 2022 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOH0N862OH/9tiivSt3Zwjt1qR1oUocM3XEbjZOA5Xs=;
        b=p7hISEZxTLVrPFiIi0B0dRX9xAJv7UNvnE9chppraPoeFcDGnYgmBx7MsPASMikx7G
         wbA5/N24Zr1SDnUFS219VtWjVVzWI8ci9lLmJCa1uE+xWm7Ij8o23Uk+sVKMH0HOwhyq
         46wws/br7R6VdhUZST8gkDX94W8FD8Qaa0rk6paqpjPxiZB07oLDxHSMPMLAbs2cSUFX
         xnwBOniashRY//mCbHOF1K4jdWMy5nBtpIP34SevKDdZs6cw9HgxroWtTSZh7SIDZt3M
         GPgGr/fzo/bAdEeaVUXgAiCHCF7D2+4EP5K63Y/RDoC8YBfh3b5XZ5Nu2iDNFgICw3sr
         ny2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOH0N862OH/9tiivSt3Zwjt1qR1oUocM3XEbjZOA5Xs=;
        b=LzFiEr383GVzZpk25tYAQNEA3L3KPAM/dMJxHOByD9MDzNgC3ElG4D+agp7knKVYwT
         GcEkv9E20BUcZz0rqWBHK6jGd5z5dEfjcuGcIKR4Rk4ZtTC8NmVER9pz4rM5xKCKB6Qn
         zsvqFUjkqtTcs5z40I+dShjWWLJdD7/cVBqR2iRXnEADxVbNvguiQ6LqNWNv6FIVFnfu
         V37lKGkH6QKGFOkuRn8/+LDjMEn0+d8Miwkfpx9eVWkAYpVJ+Wc62gt8U3A/ADnqRcx2
         LjqXCdHM3JDn4oTcv77wJyswkmgE33LW77kbNQ6fuQnbV4uNnT+ubXUpHE6Uhkf3AsM3
         nGLw==
X-Gm-Message-State: ACrzQf3bukAgLOXWi1j8pwkrzaCUUXwgL0kJB0MGMCUZg7ih9+zG5Zyz
        46guc9mAGrBgxGaLKvMAeOSX6rYcw60=
X-Google-Smtp-Source: AMsMyM7MATMXyZeCGO0qZBzgn4wRxM30AAQNmiEGIHECsD8SmyDHKW1kRFhFnMcsDjUGC6TUcmdX6w==
X-Received: by 2002:adf:fdcf:0:b0:22e:3ef3:1d28 with SMTP id i15-20020adffdcf000000b0022e3ef31d28mr8765657wrs.331.1664968784078;
        Wed, 05 Oct 2022 04:19:44 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c19d300b003bf6da9d2cesm1138180wmq.28.2022.10.05.04.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:19:43 -0700 (PDT)
Date:   Wed, 5 Oct 2022 12:19:42 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-next@vger.kernel.org
Subject: build failure of next-20221005 due to a3a956c78efa ("fs/ntfs3: Add
 option "nocase"")
Message-ID: <Yz1oTvzDpCkOE+fr@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of x86_84 allmodconfig with clang have failed to build
next-20221005 with the error:

fs/ntfs3/namei.c:445:7: error: variable 'uni1' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
                if (toupper(c1) != toupper(c2)) {
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/ctype.h:64:20: note: expanded from macro 'toupper'
#define toupper(c) __toupper(c)
                   ^
fs/ntfs3/namei.c:487:12: note: uninitialized use occurs here
        __putname(uni1);
                  ^~~~
./include/linux/fs.h:2803:65: note: expanded from macro '__putname'
#define __putname(name)         kmem_cache_free(names_cachep, (void *)(name))
                                                                       ^~~~
fs/ntfs3/namei.c:445:3: note: remove the 'if' if its condition is always false
                if (toupper(c1) != toupper(c2)) {
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/ntfs3/namei.c:434:7: error: variable 'uni1' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
                if (!lm--) {
                    ^~~~~
fs/ntfs3/namei.c:487:12: note: uninitialized use occurs here
        __putname(uni1);
                  ^~~~
./include/linux/fs.h:2803:65: note: expanded from macro '__putname'
#define __putname(name)         kmem_cache_free(names_cachep, (void *)(name))
                                                                       ^~~~
fs/ntfs3/namei.c:434:3: note: remove the 'if' if its condition is always false
                if (!lm--) {
                ^~~~~~~~~~~~
fs/ntfs3/namei.c:430:22: note: initialize the variable 'uni1' to silence this warning
        struct cpu_str *uni1, *uni2;
                            ^
                             = NULL
2 errors generated.

git bisect pointed to a3a956c78efa ("fs/ntfs3: Add option "nocase"").

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip

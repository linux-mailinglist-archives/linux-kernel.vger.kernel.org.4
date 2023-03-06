Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF446ABDF0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCFLNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCFLNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:13:32 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44F41D936
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:13:13 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id f23so8699773vsa.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678101192;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m4mHnm6tKi9QUsR2VBQisXaqYs+QXsAPXswpr2JeOMw=;
        b=s945bFy3wxHRsThiokBxog7jblaBRypipXnIJcNW1NuZew9RmghR9Vid87kg/3+7FN
         wvJRCtNG43lBa7DF4MVp9YscyiD76EJ7iGNa3J8YXjdL35Spm1WIfYskt+/Voqy4DhFc
         lcIWO1wZvIHkOrZE5aBgOBNqd9MN/KrzPQcoaLrYew/iu02B5QjXdVbzdLaZm6NQAtSS
         kJg4+1DAUlPyMvP12K1pfeFFE0OeOzrn098bM5W7P4Vm+Tc1ACk/DfViP6lgNf34HUOO
         hzAgmxCv1KClBsbUqETgn0tRydK9M/5Of3oy3PV3OC4QPsD2ViOnF9bum//XHGLYctNV
         T18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678101192;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m4mHnm6tKi9QUsR2VBQisXaqYs+QXsAPXswpr2JeOMw=;
        b=pc+ZljSNaZTMqZYbRVVxpDtp38Kh+T+WBBeXl8p5NxseA7HGRn9sSNpY5DI+ERsB5+
         DYTRR4x3W1DBRqZQ3SYdpMu7RdLLX+VUTj1DZMZywHNDc1nGCyLCeXxcGBqKWdFjkNMH
         azic0FGKM+P8AoMUd4sNwiSnGyH/Vvfk84DcsyMc3E5MT1tUQf8wsA36/5jgluV45BsI
         ziBeMhs2XIWpfotM1UVZmzPeHmwb32lZo665kye/Gnl8lfUMKnhH5n+Dwl9SoD8o/LD2
         pXf4vTQhP/ukH7kCqzHSI5P4lqQzWhFLqxJ2gPCawaahJ6108MiNqwF/UvuFa2NcoxF1
         dCEw==
X-Gm-Message-State: AO0yUKXLSdx4qDeqPCKmQXu/ltSxjlqKPT9WIAgm70opy/8d3zzfmEB6
        8aqxHrWU7XR2iqUt0M+Lt1FU8JY4rd3rQwukZF1KalxdkeaZYJvU/rc=
X-Google-Smtp-Source: AK7set82NVO+VDrqJQfMtTWglBInb3q69D4Og0wpmm8DVBoIwB3MNcFYCGklbiRk1+4MrMxMpqyfS7/AB0hfgMV0/kQ=
X-Received: by 2002:a05:6102:80b:b0:421:7f84:f3d9 with SMTP id
 g11-20020a056102080b00b004217f84f3d9mr6560680vsb.3.1678101192299; Mon, 06 Mar
 2023 03:13:12 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 6 Mar 2023 16:43:01 +0530
Message-ID: <CA+G9fYtwqro9qaCmxOBAM1qt8L7k5ZwceaYBLY8RWoELDghhsw@mail.gmail.com>
Subject: next: mm/khugepaged.c:1702:30: error: implicit declaration of
 function 'vma_try_start_write'; did you mean 'vma_start_write'? [-Werror=implicit-function-declaration]
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build regression noticed on i386, mips and s390.

mm/khugepaged.c: In function 'retract_page_tables':
mm/khugepaged.c:1702:30: error: implicit declaration of function
'vma_try_start_write'; did you mean 'vma_start_write'?
[-Werror=implicit-function-declaration]
 1702 |                         if (!vma_try_start_write(vma))
      |                              ^~~~~~~~~~~~~~~~~~~
      |                              vma_start_write
cc1: all warnings being treated as errors

build details:
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230306/testrun/15286608/suite/build/test/gcc-11-lkftconfig-rcutorture/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230306/testrun/15286608/suite/build/test/gcc-11-lkftconfig-rcutorture/log

# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#

tuxmake --runtime podman \
         --target-arch i386 \
         --toolchain gcc-12 \
         --kconfig
https://storage.tuxsuite.com/public/linaro/lkft/builds/2McWOXP1OH5MiYficVNv8hJCR4F/config

Similar issues have been reported and discussed on the mailing list.
- https://lore.kernel.org/all/20230305191335.fee8e6aa285b0ca771cab9dd@linux-foundation.org/

--
Linaro LKFT
https://lkft.linaro.org

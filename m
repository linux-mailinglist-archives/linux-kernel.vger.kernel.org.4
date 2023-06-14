Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3463724CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbjFFTPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbjFFTOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:14:55 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CDB10D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:14:53 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b043b9ad2bso24408655ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078893; x=1688670893;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xFaVbO2q9K0Nb8KnZHHNp+vUFD3+kx6IMeKF20JouTE=;
        b=HmWP1hbDpiczLd4QaBTMw1741xOR9Zp3pzSU1+Z4xgBSgJ728TfrLWV875YbwUWrH7
         J4o5sa/SUMI/uH3lZfWwnpZUu3AbM958RJC45tbvukhrVYn2rnVDxhuzFSbVWmwddy59
         y3WOjMd8Md5w1wbE/4z5/a/83NTArYH3N5VYITETRVQ2TmcRMaNPLhjB5CBClGz4rSIr
         IvtKAwbcjlPTC+ainM4kZYGdcAdpss7OFCum6UkIo4BdyeyyvnV1PlNYOAI8QsQ5A5PX
         F48rArOE52HdnohOKGralnaoUhq8O4xobniKxwt2WVm3TSOXdncvXoPgVaACSrpGCWOq
         pL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078893; x=1688670893;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFaVbO2q9K0Nb8KnZHHNp+vUFD3+kx6IMeKF20JouTE=;
        b=SUCzNZXxZPDEdaQj3nbfuqozt65wf/tp7RNLPF32EB32T8UBz+4GwA2JjcweeJ/hjk
         zzzMFACQX+066k4Q3LHzJ3iTv55k5J3KPUqOq+C8+4VBezyaeNL3prhjrW6K7XrSVSc8
         fb9kfztBo0RzDhSIDtFEU04JI/paZmgyftD2fpeUdpguA5nXw0uMg+9axwd+GJcE39dY
         oNp3DJOQdKe1N/nB4ZCPoxzJX5tDVNw80IlFeTiR1i75lKjFpfauAPnvsCSyt1fyutB4
         l7oa0vtGTw0HvoAlILqBMtR9A/vXLIcUtjEhAqTaYSXAyjX9GV0itUrnVkgrrohnGi4t
         lYwA==
X-Gm-Message-State: AC+VfDz+8Ib7VWU1hWpZ4KTi7lpwAtQhBa4Vdy1bO1/QJ5n194qM5FIH
        IMx8msji/RDBuVmHViudyHJq2K2+1MiJEVnX8Q==
X-Google-Smtp-Source: ACHHUZ4r1p5pWFS42UqQZI9VR+0MjUz+zddsWgqDei7+oqdEO6H6FyaUj51+oucoa/1SLA2BFS6NpB3SavaP+BpHCw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:e744:b0:1af:fd3a:2b39 with
 SMTP id p4-20020a170902e74400b001affd3a2b39mr1014340plf.9.1686078893164; Tue,
 06 Jun 2023 12:14:53 -0700 (PDT)
Date:   Tue, 06 Jun 2023 19:14:51 +0000
In-Reply-To: <ZEM5Zq8oo+xnApW9@google.com> (message from Sean Christopherson
 on Fri, 21 Apr 2023 18:33:26 -0700)
Mime-Version: 1.0
Message-ID: <diqz8rcwjtck.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: Rename restrictedmem => guardedmem? (was: Re: [PATCH v10 0/9]
 KVM: mm: fd-based approach for supporting KVM)
From:   Ackerley Tng <ackerleytng@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     david@redhat.com, chao.p.peng@linux.intel.com, pbonzini@redhat.com,
        vkuznets@redhat.com, jmattson@google.com, joro@8bytes.org,
        mail@maciej.szmigiero.name, vbabka@suse.cz, vannapurve@google.com,
        yu.c.zhang@linux.intel.com, kirill.shutemov@linux.intel.com,
        dhildenb@redhat.com, qperret@google.com, tabba@google.com,
        michael.roth@amd.com, wei.w.wang@intel.com, rppt@kernel.org,
        liam.merwick@oracle.com, isaku.yamahata@gmail.com,
        jarkko@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hughd@google.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I've ported selftests from Chao and I [1] while working on hugetlb support  
for
guest_mem [2].

In the process, I found some bugs and have some suggestions for guest_mem.
Please see separate commits at [3].

Here are some highlights/questions:

+ "KVM: guest_mem: Explain the use of the uptodate flag for gmem"
     + Generally, uptodate flags means that the contents of this page match  
the
       backing store. Since gmem is memory-backed, does "uptodate" for gmem  
mean
       "zeroed"?
+ "KVM: guest_mem: Don't re-mark accessed after getting a folio" and "KVM:
   guest_mem: Don't set dirty flag for folio"
     + Do we need to folio_mark_accessed(), when it was created with
       FGP_ACCESSED?
     + What is the significance of these LRU flags when gmem doesn't support
       swapping/eviction?
+ "KVM: guest_mem: Align so that at least 1 page is allocated"
     + Bug in current implementation: without this alignment, fallocate() of  
a
       size less than the gmem page size will result in no allocation at all
     + Both shmem and hugetlbfs perform this alignment
+ "KVM: guest_mem: Add alignment checks"
     + Implemented the alignment checks for guest_mem because hugetlb on gmem
       would hit a BUG_ON without this check
+ "KVM: guest_mem: Prevent overflows in kvm_gmem_invalidate_begin()"
     + Sean fixed a bug in the offset-to-gfn conversion in
       kvm_gmem_invalidate_begin() earlier, adding a WARN_ON_ONCE()
     + Code will always hit WARN_ON_ONCE() when the entire file is closed  
and all
       offsets are invalidated, so WARN_ON_ONCE() should be removed
     + Vishal noticed that the conversion might result in an overflow, so I  
fixed
       that
+ And of course, hugetlb support! Please let me know what you think of the
   approach proposed at [2].

[1]  
https://lore.kernel.org/all/cover.1678926164.git.ackerleytng@google.com/T/
[2]  
https://lore.kernel.org/lkml/cover.1686077275.git.ackerleytng@google.com/T/
[3] https://github.com/googleprodkernel/linux-cc/tree/gmem-hugetlb-rfc-v1

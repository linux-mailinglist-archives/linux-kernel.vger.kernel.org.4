Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC31660700
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbjAFTSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjAFTSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:18:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD201BC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:18:15 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d3so2613328plr.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 11:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1g+D6GKRsTiQykQO9KE60w2GEfBj+ZoVYOVS89fqaM=;
        b=lForBUT+xfCxFfejzmI48nWa304S9hs7+UtxKzsuGf+nKyNipgoBWpzJ3oOllc+BLy
         fLDlp8q4SaVr26D/cDF6oKbi7FnAMwtfV4yARvo4vxo/iax71v8smWoTzF/n1QraNary
         oqQVOZQeoGzYVFn3of8qosgGmmGcsI+Wup5HINc3+dtX1yQqnSXsHe+P2XXwvQ4WNLxG
         1mZ+JIzOAaVv46hpmEMSoVcfUbbegViVzXj5QjdFOi1yRs7ritmPEDewD1MPVwBi3fsf
         oMSiGOMJt4u0HEfrZYT3EG5kMiF4K9BabXmQPhxyvFFOrdAgjceyG36wgZzmDEnzlOkJ
         ebXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1g+D6GKRsTiQykQO9KE60w2GEfBj+ZoVYOVS89fqaM=;
        b=gZGztC2fnl55hcgGFJDBAH3HmNVe0qTUOXjmWOVTuV4nS5IJn22FkoprpsGG/c71y9
         pFZKrPt32zqtdF+f8kmpN0irVQtrwzrrytIvqHw/ES8czMAtjO/+qzLNzSLclUFF0fQJ
         IGFzFHGn6kg6DmwuvyXuoZPMIJuxfiKuqxVEtU7cAx04urOiJQSG2bOyg3mcAmc1V23Y
         C1KIZ7Pefc6dfldVxetg+Huo/G+FAkjYUL3YzL+bUhVxghnLP9GFOxRBNqedQ15bjXM8
         6iwccojA7E3x/ctXgdqhAOS2O5O4OZoKZPXLGxp+omQhJ/y1Rb6IISIfInWG66OvolYD
         juCQ==
X-Gm-Message-State: AFqh2koWA489LOWy5CfrrXMj4aHfvVVuwObkf5s8nW6EXue8YOBr1Yoz
        /SWT2hOKDDIN/LipGOc6Z7cDng==
X-Google-Smtp-Source: AMrXdXuynn2Ya06o13mJ6u/LbnfcEx4D+cI/xzrrDy+wPkCxomKjTBCmiUXC9ZkytIb46+gz7PMTEg==
X-Received: by 2002:a05:6a20:8362:b0:ac:7a44:db55 with SMTP id z34-20020a056a20836200b000ac7a44db55mr56135144pzc.39.1673032694737;
        Fri, 06 Jan 2023 11:18:14 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id e14-20020a170902ed8e00b00192850277fcsm1291714plj.146.2023.01.06.11.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 11:18:14 -0800 (PST)
Date:   Fri, 6 Jan 2023 11:18:10 -0800
From:   David Matlack <dmatlack@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Nagareddy Reddy <nspreddy@google.com>
Subject: Re: [RFC 00/14] KVM: x86/MMU: Formalize the Shadow MMU
Message-ID: <Y7hz8geAGgysptY5@google.com>
References: <20221221222418.3307832-1-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221222418.3307832-1-bgardon@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 10:24:04PM +0000, Ben Gardon wrote:
> This series makes the Shadow MMU a distinct part of the KVM x86 MMU,
> implemented in separate files, with a defined interface to common code.

Overall I really like the end result.

While looking through I found a few more bits of code that should
probably be moved into shadow_mmu.c:

 - kvm_mmu_zap_all(): Move the shadow MMU zapping to shadow_mmu.c (the
   active_mmu_pages loop + commit_zap_page).

 - need_topup(), need_topup_split_caches_or_resched()
   topup_split_caches() should be static functions in shadow_mmu.c.

 - Split out kvm_mmu_init/uninit_vm() functions for the shadow MMU.
   Notably, the split caches, active_mmu_pages, zapped_obsolete_pages,
   and other Shadow MMU-specific stuff can go in shadow_mmu.c.

 - The Shadow MMU parts of walk_shadow_page_lockless_begin/end() should
   go in shadow_mmu.c. e.g. kvm_shadow_mmu_walk_lockless_begin/end().

> Patch 3 is an enormous change, and doing it all at once in a single
> commit all but guarantees merge conflicts and makes it hard to review. I
> don't have a good answer to this problem as there's no easy way to move
> 3.5K lines between files. I tried moving the code bit-by-bit but the
> intermediate steps added complexity and ultimately the 50+ patches it
> created didn't seem any easier to review.
> Doing the big move all at once at least makes it easier to get past when
> doing Git archeology, and doing it at the beggining of the series allows the
> rest of the commits to still show up in Git blame.

An alternative would be to rename mmu.c to shadow_mmu.c first and then
move code in the opposite direction. That would preserve the git-blame
history for shadow_mmu.c. But by the end of the series mmu.c and
shadow_mmu.c are both ~3K LOC, so I don't think doing this is really any
better. Either way, you have to move ~3K LOC.

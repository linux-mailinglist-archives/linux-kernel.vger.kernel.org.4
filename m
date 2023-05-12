Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357D66FFCEA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbjEKXDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbjEKXDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:03:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502310CC
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:03:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaf702c3ccso421865ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683846183; x=1686438183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uB2iqlK11OQsKPd9Pr1QSGgzqWB2tqFxHS68iHnGQns=;
        b=RWmON4VeXRg726Drr60jlakRmM+cWHoNancE+z69c2c9PPzUWq+Qkucb/Jc3iMoo/Z
         DaR5eV+kEPLKbHzvrcFcJhZdU9QKFDvtyZ1M/bwRqxLLvL8q9Nyu/quyJmHdLogNVshe
         Bs4CxefhMIP+sVOa5ez2hraCriFiQFp7MtFz+ALzBQ5wERl0qSqON5DPizJx/XvJDmeH
         YelRz/mtLw3VwB5G4mBCX23meLfPO2miiJVrgziyJfWO4fyftyI+aku9cQU932UjDQAE
         HfylxX05aegejIT6AzxnWB7MwnTHVLKXWDhETWB5bSjMoCtfhe3NGwqxdzUDEfKvhBR1
         /WyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683846183; x=1686438183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uB2iqlK11OQsKPd9Pr1QSGgzqWB2tqFxHS68iHnGQns=;
        b=T6yRoMTT5tzXaO0JH3wI0/3wHfk35uwNjj4kMrRHbCKpCtWQOE28JzeqGtlkaw210M
         OzIj//dccFeJSkXhK6AQyxjJEBGq/zesoMvr1yM98fjZS6FCqVQJYNFM04tb2w80plq5
         /fqGpsKKlAtCxcDrucXFDJXQ2pXyhSRF31q4bE1/bUr77hK7Hnd9KF9ilXqs5wzkf+eE
         MBS7Hp/LHewoZLU9xdGIUyxYk2uex9aso7874Q6fbK694gnpDH5ErnXb0c3s8hiOAjcp
         jmkZL8CV0gX2kwgYK0WFEfFz1DnFWnZ+09/LevC4VwJfWaDsfIv2YipH4jcTQqUs0WSd
         TFLA==
X-Gm-Message-State: AC+VfDxS4BmZsZOSIUlFdaIxBapsZgd9HKhsMCVyS0iwBMZyCW6pW4e7
        WX7VXhwJAxCTIUr1Wi0du/xZewbs+U8vq83Xj2B5QQ==
X-Google-Smtp-Source: ACHHUZ64VnYmS71+rD9l4jUC2YQ3gX3wsLmYkLHhKgjyoMKx1yuh1vMc6oYGJskGIumQz6tzdZGDUjW/uKNeU+fF+Cc=
X-Received: by 2002:a17:902:ce8d:b0:1a9:343c:76e5 with SMTP id
 f13-20020a170902ce8d00b001a9343c76e5mr89434plg.18.1683846183027; Thu, 11 May
 2023 16:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221214194056.161492-1-michael.roth@amd.com> <20221214194056.161492-53-michael.roth@amd.com>
 <aab7ed11-870e-579d-9328-4c32d9936392@amd.com> <66039193-14ca-5edb-d8d4-ca732d8c13a6@amd.com>
 <119075dd-5f3e-a393-f543-6cdfd34cd337@amd.com> <385016f9-e948-4f7f-8db3-24a0c0543b3d@amd.com>
 <55e5f02f-4c1f-e6b0-59ba-07abc4d3408f@amd.com> <81037a58-6b5c-cde4-79fe-3686d9b8a551@amd.com>
 <b0baa6ee-ea6d-3a30-d5fb-3ec395896750@amd.com> <dbcb6666-270a-4867-6de7-73812d32fd8c@amd.com>
 <7fb25176-3752-1be3-66d4-a7f5a0e1617a@amd.com> <682c0bf9-ccf7-9660-21fe-925ef63c5fbb@amd.com>
 <4c642bd1-5f1c-292e-398f-eed699db590d@amd.com> <65cb8f0f-7e8b-6df6-6bb1-a9f1add027bb@amd.com>
In-Reply-To: <65cb8f0f-7e8b-6df6-6bb1-a9f1add027bb@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 11 May 2023 16:02:50 -0700
Message-ID: <CAAH4kHYDUGnUnZt2HUVcGqOYyzsyUhBXUqW+iDyvKCtQW9XuEQ@mail.gmail.com>
Subject: Re: [PATCH RFC v7 52/64] KVM: SVM: Provide support for
 SNP_GUEST_REQUEST NAE event
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Alexey Kardashevskiy <aik@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, hpa@zytor.com, ardb@kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, luto@kernel.org,
        dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com,
        peterz@infradead.org, srinivas.pandruvada@linux.intel.com,
        rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com,
        bp@alien8.de, vbabka@suse.cz, kirill@shutemov.name,
        ak@linux.intel.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        dgilbert@redhat.com, jarkko@kernel.org, harald@profian.com,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be okay to request that we add a KVM stat for how often there
are GUEST_REQUEST_NAE exits? I think it'd be good for service
operators to get a better idea how valued the feature is.

-- 
-Dionna Glaze, PhD (she/her)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F81E67B8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbjAYRtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYRtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:49:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D834C1A942
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:49:01 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso2837921pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WE/U1ZXqu25zbDj7iRUFyb4DIUvk2g6lrNzCgYjyvo=;
        b=UeeMeZ6w/bvQ79EXE/pdDBDC6JyCE3GqB/O2SaXf5EQfFxF9p+jfNceiqm6iaBt0C1
         kNf1NaOcnxJMu5SCPMp22NV8P697O2wgelY1FDG5HVWsyYn0xTiNhLnDmxPGdrsrZWDc
         t3gxhN+CuIAGkBkfE9MCrHvTzYEvnLg6P5dF6teQcgxUk3BD8sUIsHtSZXqV0sOfUKYt
         +Rq8Z7LkLEneJthAMD1WZICS0yR1SnHr0i51u6OHkR/bykBesj6859vuS7uKz6Tjs7W7
         rujRX9RGF5mWqJzkmB5X6zf9EJ/P+otvG5GkOf6DvqNJhxgq553gEP63SV1HBemzzUnP
         m+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WE/U1ZXqu25zbDj7iRUFyb4DIUvk2g6lrNzCgYjyvo=;
        b=cMeO6oVi+hTzJy+SBFj+RaDXtieSFg7jZJsdfgvQPhTODfuDK1xP19nQVKBmrglhzZ
         LeHWnfvKCV8E17EsM2meQhKr0nJnLrUgRsHP61uYyDYmiHJHaPYVNchEFRrtIRf0sPjC
         bqwRySsI89Pu99H+aDaLWLZ17TAb/pws1qynfBNtXIsILTeuE6isK4zepfbhLM6iXRqK
         RSXtR/3PzY2MDAbRRITNEusaRJP8g7i7KO1hcSsN20S+IrbJUbXZggE2RujIaG2Qptwa
         EF5+4WIepPZOsqirqRVYl5TUHizgTKmjbsbnzkCGvvcZJNfr/fBF+nIDMcmeB5Jz1ZUq
         HYfA==
X-Gm-Message-State: AFqh2koYZcGkVPe75buPJmsg1AbaISlCRJG7Nk1mbCyu3YDXnOR4ulaX
        z0tn71hGZYbzzuy3jczblEQHNh0ofpZGg4KQPygQX9ni+oQJCJ9K
X-Google-Smtp-Source: AMrXdXtC/84bGsfOU9w7Jm+bYG7MdwFlwuZIWlU9XHONJbWLLRObtW41xi4WOv5y6f1TxF71X9+K1KXd21b+ACbTLWI=
X-Received: by 2002:a17:90a:7d14:b0:229:efae:388e with SMTP id
 g20-20020a17090a7d1400b00229efae388emr3836394pjl.46.1674668940976; Wed, 25
 Jan 2023 09:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20230124211455.2563674-1-dionnaglaze@google.com>
 <20230124211455.2563674-2-dionnaglaze@google.com> <724f03d8-91e9-e870-f063-65c2e98b6ee5@amd.com>
In-Reply-To: <724f03d8-91e9-e870-f063-65c2e98b6ee5@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 25 Jan 2023 09:48:49 -0800
Message-ID: <CAAH4kHbdLe5-hY5raoSyqhXru9Rz4050_RMDsq8EAEBnWZcKRQ@mail.gmail.com>
Subject: Re: [PATCH v13 1/4] virt/coco/sev-guest: Add throttling awareness
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> So these should really be:
>
> #define SNP_GUEST_REQ_INVALID_LEN       (1ULL << 32)
> #define SNP_GUEST_REQ_ERR_BUSY          (2ULL << 32)
>
> Thanks,
> Tom
>

Patch 3/4 cleans them up with just such a shift. They also move from
arch/x86/include/asm/sev-common.h to include/uapi/linux/sev-guest.h.
Is it okay to delay that cleanup until after the fix patch?


--
-Dionna Glaze, PhD (she/her)

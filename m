Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9825668F80F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjBHTar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBHTap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:30:45 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FD05279
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:30:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gj9-20020a17090b108900b0023114156d36so3172681pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 11:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zz4zdn34dZ4Re3527S2wyDgD0R8P1aL/OaCQ3uWJm2Q=;
        b=R2qFbi51sOAateWGze6fWvLDw6nGcxX8WnnB+DyI62C0a7bLgjpf9vFspzXIhAm0Yq
         ZQZPmFfCRA9/ABOE64CpodA4vYmG36WJomQWehj7zZlyjsqG5cL6RjskLJEXXU8HvHnZ
         yvxr4kzzvJZCoCbmxBaAjHTf5MiN2Vco0tnD6LBuQV2oij/68GyeWGO+zuhFvS6YrkK1
         01dMavwpVef5/KLOt/HH3XlKwZ1vZW0T9YDY3vqo50BKlh/iFzL+fneUQYZ/JxFiKjQG
         dT7M42yMiQTvmd3TZylSub/EduabnZAsELScZp0JlpPGw/HWffYc9p75M+JcRmBUhFx5
         7Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zz4zdn34dZ4Re3527S2wyDgD0R8P1aL/OaCQ3uWJm2Q=;
        b=g8/3yVc3gMKWhonpPplX3WV6x5ouipc+LlYX6OW6ZxdSt5IuKN62EYYhSOrnozv1Cn
         EhDdL7JBKAsjK21G9pCDTJYbNRCr+ixkPOikHlMCTpzQsP1t5nXTKnJi/xJ3oEo5ITeI
         mWNPHCBQUSTktMYxNwD92Q7E2sNp4Ob8+tNFwEZVvsmPZjo0j/t7AXhoL0nakh/r8FLa
         MVBUtKRTFV5D3jkd5xW+FTbA6S4Vdh6IiXof+ncVw1O3WLLxwB45FO0idl26ad2u0oAG
         uO0o6Jq158DkVVYuuhGLBqPAHYswTNbPPmoIDR80lTHVdI71BN6YyLSzFqIyDHjd4xV6
         nSCQ==
X-Gm-Message-State: AO0yUKXTbkIqxYc9QbY5BJKckJJVQWhdjpg8aaK8X+7RTGYcGJuUZ5EN
        Mb9qpX2gFV4lvRJBZLIWzn+6/DKcey8HiEU272l+UA==
X-Google-Smtp-Source: AK7set9vyaH1EntzZUoATbzvHaBwpoZBFsKvEm8nm3nwx9SjpW/xV4UxICbghSJHJu17Q+wP871vCdBX9E/P3GMboxM=
X-Received: by 2002:a17:90a:cc01:b0:231:1a27:80ea with SMTP id
 b1-20020a17090acc0100b002311a2780eamr795812pju.43.1675884644374; Wed, 08 Feb
 2023 11:30:44 -0800 (PST)
MIME-Version: 1.0
References: <20230124211455.2563674-1-dionnaglaze@google.com>
 <20230124211455.2563674-2-dionnaglaze@google.com> <Y9emVjoTBrM2+Y5P@zn.tnic>
 <e0d52194-d478-b33e-851b-d5067f4a7669@amd.com> <CAAH4kHbXKnWyO5hS19q74jDQjvAvj6rUw_Q06Of1+Fmng50-7Q@mail.gmail.com>
 <Y+P4C4jtMWu2PanS@zn.tnic>
In-Reply-To: <Y+P4C4jtMWu2PanS@zn.tnic>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 8 Feb 2023 11:30:32 -0800
Message-ID: <CAAH4kHYJCMbEaQ=7Nf-3CbmgomLt7AyvJQcX8DvnCU2cG6iYJA@mail.gmail.com>
Subject: Re: [PATCH v13 1/4] virt/coco/sev-guest: Add throttling awareness
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
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

> Not really - I'm waiting for you to remove the potential endless loop:
>
> https://lore.kernel.org/r/Y9emVjoTBrM2%2BY5P@zn.tnic
>
> Thx.
>

Ah that slipped my attention. Thanks, I'll update that.

-- 
-Dionna Glaze, PhD (she/her)

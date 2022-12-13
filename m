Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2330964BBC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiLMSR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiLMSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:17:00 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE6124F05
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:16:02 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id m4so671087pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mbj0itUaH2iI2Sp/W9k9+6g0jhIxKWmgtOweAbYRTUI=;
        b=sC+ng59I3Fq379InLul02c4vIKRtojDOmCdA3u1aPrX/Secw1WbygvzSnQtrcXYLRv
         8VKvHC8/RMQeZSCGG/jWyFsHnoDakOTxmUStaD+UQ8VqsYKOHrI84HA18XL1CVHS8J9h
         HhulPQMxoeQ5eGoAEvisjEzqhhcynKVfGGNoCr63YtiyGQHXmKY96OaKEomb08NNn78O
         amnA22Drjb0CZ9McvmqXAFu+94KT/O2XAGO6jzMnzDHE6X30XS5Wm/xpxnd0IeOqdqss
         oJZHunF1x1iV3VJHnI5ndOfeRV3QYopm0EUclP+FrLqT9kFY93zPSesA2dWEiSOvtQZp
         hFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbj0itUaH2iI2Sp/W9k9+6g0jhIxKWmgtOweAbYRTUI=;
        b=Ep8yy4UtVF31BsvyRft2ZXktBzu5yWnNEB1SKfnk1oui1etVVjmmc3KWBhl4zcFnpC
         WHgzAxBCSWYVx9lqtXdw0B6D645mdZewA6bpGHh+5uyuCBPiuWXQIlYaSdF2KRdbq7H6
         43ppMjfybUffMp/Q7epVAtoxcd64jRQHXBZv1MAn9qHv0f8mcIzSs5C21APX/oesGMHm
         bqphHYsVRAu/vnGqP2sWGmWOir9M4grw7c+lp4jRjnG7Qaij5NrKd9InXuvKk4lwvv4l
         vuLdiH0S8sDgr8wHbPk6YCJdK613pl8pODEqSFQ7big4mvqiE8fIZTdwoBd6dFaB7oK5
         rJsg==
X-Gm-Message-State: ANoB5pkbs0xLDexRrsEejfwsA87HvBtf0or0j7koCwU1Mfuaz57Dm0hh
        AkuM3bh/SXe9WzHrBuLdH5D1ag==
X-Google-Smtp-Source: AA0mqf5O9wC1on6FlXqUebgt4MLj8U3d2+Rhe7oCe8bSoF5oGoKdWjb5P1acJ9cSewPVoNCoOpq7EQ==
X-Received: by 2002:a17:902:da8d:b0:189:3a04:4466 with SMTP id j13-20020a170902da8d00b001893a044466mr431766plx.2.1670955362013;
        Tue, 13 Dec 2022 10:16:02 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b00189c26719cdsm157289plg.272.2022.12.13.10.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:16:00 -0800 (PST)
Date:   Tue, 13 Dec 2022 18:15:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Hoo <robert.hu@linux.intel.com>,
        Greg Thelen <gthelen@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 4/5] KVM: x86/mmu: Don't install TDP MMU SPTE if SP has
 unexpected level
Message-ID: <Y5jBXIF26odk6jWC@google.com>
References: <20221213033030.83345-1-seanjc@google.com>
 <20221213033030.83345-5-seanjc@google.com>
 <CALzav=d-9G6SSBCB=TbVWi9Szprm1wD3AqqgZzoCq26_LF_ySw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=d-9G6SSBCB=TbVWi9Szprm1wD3AqqgZzoCq26_LF_ySw@mail.gmail.com>
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

On Tue, Dec 13, 2022, David Matlack wrote:
> On Mon, Dec 12, 2022 at 7:30 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > Don't install a leaf TDP MMU SPTE if the parent page's level doesn't
> > match the target level of the fault, and instead have the vCPU retry the
> > faulting instruction after warning.  Continuing on is completely
> > unnecessary as the absolute worst case scenario of retrying is DoSing
> > the vCPU, whereas continuing on all but guarantees bigger explosions, e.g.
> 
> Would it make sense to kill the VM instead via KVM_BUG()?

No, because if bug that hits this escapes to a release, odds are quite high that
retrying will succeed.  E.g. the fix earlier in this series is for a rare corner
case that I was able to hit consistently only by hacking KVM to effectively
synchronize the page fault and zap.  Other than an extra page fault, no harm has
been done to the guest, e.g. there's no need to kill the VM to protect it from
data corruption.

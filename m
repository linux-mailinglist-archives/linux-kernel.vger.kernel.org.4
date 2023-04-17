Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F277F6E5514
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjDQXSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDQXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:17:58 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D3140FA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 16:17:57 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54c0c86a436so555951327b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 16:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681773477; x=1684365477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7sqT2MMNV6p6hOax3PoPR+0asBKqco8uuNCkq2LhVM=;
        b=XFhs4lbTpFBkCbCXvQgW2oHC5DWbyjcxDrzxy6sUo++VgawktEiOJALIBFGSjXar1u
         dIP4YXahmH0tn11zBHVHQ49Gp5gjfovqSQ/Sz1gsKEM7ENStkLmat84xQhyzk0E88z50
         0G24fj2YYeJlDbHkj7M5Omk8UDuV1lh1rjciHXC7oCkk7DuhQSXgoQ4z8lwa0B5zUixJ
         jggcH6zEHhkXFQeV3F2WvY8OTOqzB5LmfqR9ziz8WoltWMPovWPFQ9mFxaSQW1r4ERtN
         JuWxZtlaxKp4zLLDCTFB4zcF4pDUnhcLmVMwck67DGOsH0gdPGuUQ+eu/ljmq6Q9hB+7
         9LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681773477; x=1684365477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7sqT2MMNV6p6hOax3PoPR+0asBKqco8uuNCkq2LhVM=;
        b=D0MlhrfGoaecrASx9Zued3XjsKTKQTosGQjMtILMdGqm/G9lFUDteP9nIg7scQlitP
         O4KJT+VokDLhGrbEPSASe2EzPyf6X2fWEJ1UpHECzeVPESNzpheNw6CezKKSEsBTd2mS
         FI02WsHLsXWteJlSjFTbjmRlphPxfO6HoxJq5wLAqNLwnMNdpDI9hTYFMd90eFcYFqcA
         S0ms6F5GU2jgninbMJG9ZyItoGdK0+Rf6YIxAKvelcW1vNhsD1kPzEOrQl5nAHe2TkbA
         VNxMXRz/+/IN2juOzDqrwFktD0sMVTdRFzWgQCdPx/7Sod7O+LsKBo5neQeSMhCv5Am5
         z4yQ==
X-Gm-Message-State: AAQBX9duwyohMKvMu4/N3gwWejdM5deEqOQqfXQhxLdvXXS3fljeFmU3
        CjFT3bK4Tle+WXtPzY80NFjez1dvyUZlEwXaPeaO5Q==
X-Google-Smtp-Source: AKy350Ys7h+H3UG23FGfVDvHzrLubQ22gurK633DoVg7WxBxFbRZVhPMVLAweNPk4OvxDfUC5hTQxjRgEPRMzBJNeQw=
X-Received: by 2002:a81:4415:0:b0:54f:9e1b:971c with SMTP id
 r21-20020a814415000000b0054f9e1b971cmr10701230ywa.1.1681773476678; Mon, 17
 Apr 2023 16:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230415000818.1955007-1-surenb@google.com> <ZD2gsbN2K66oXT69@x1n>
 <ZD3Nk0u+nxOT4snZ@casper.infradead.org>
In-Reply-To: <ZD3Nk0u+nxOT4snZ@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 Apr 2023 16:17:45 -0700
Message-ID: <CAJuCfpFPziNK65qpzd5dEYSnoE-94UHAsM-CX080VTTJC5ZZKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page fault
 handler retries
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 3:52=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Apr 17, 2023 at 03:40:33PM -0400, Peter Xu wrote:
> > >     /*
> > > -    * We don't do accounting for some specific faults:
> > > -    *
> > > -    * - Unsuccessful faults (e.g. when the address wasn't valid).  T=
hat
> > > -    *   includes arch_vma_access_permitted() failing before reaching=
 here.
> > > -    *   So this is not a "this many hardware page faults" counter.  =
We
> > > -    *   should use the hw profiling for that.
> > > -    *
> > > -    * - Incomplete faults (VM_FAULT_RETRY).  They will only be count=
ed
> > > -    *   once they're completed.
> > > +    * Do not account for incomplete faults (VM_FAULT_RETRY). They wi=
ll be
> > > +    * counted upon completion.
> > >      */
> > > -   if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > > +   if (ret & VM_FAULT_RETRY)
> > > +           return;
> > > +
> > > +   /* Register both successful and failed faults in PGFAULT counters=
. */
> > > +   count_vm_event(PGFAULT);
> > > +   count_memcg_event_mm(mm, PGFAULT);
> >
> > Is there reason on why vm events accountings need to be explicitly
> > different from perf events right below on handling ERROR?
>
> I think so.  ERROR is quite different from RETRY.  If we are, for
> example, handling a SIGSEGV (perhaps a GC language?) that should be
> accounted.  If we can't handle a page fault right now, and need to
> retry within the kernel, that should not be accounted.

IIUC, the question was about the differences in vm vs perf accounting
for errors, not the difference between ERROR and RETRY cases. Matthew,
are you answering the right question or did I misunderstand your
answer?

>

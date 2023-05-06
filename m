Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237E76F8D6F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjEFBSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjEFBSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:18:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393026EAF
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:18:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so4669959a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683335885; x=1685927885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xWunwBjreINeCb0tO4bVmW1S3dLtRxVeicO2rC/ju8=;
        b=6gF+SduOYgncFnt7ZoiU1yx51SAGT7MsKJ8qMRLCFbcZLolcmF75btB31W65qIZKqG
         RcwwpNxWFCNe6YCvsTUo5bO8745sK8NoXqJLZQYb1yL9bWX6xxNGHV/8cAtsND72KXUT
         +R5EXLe7k15qKVOt9ir0LkDHmRWKDxRZ4IiinvbaIAwrS3+7iZZsXhpsj41lajkfxaGx
         OmPjbVrffr7ffl54AIh2BBVarNlhvD0ZNVDStiGuh8fb8EV9+kNsdliptmErMyCjQWF0
         YI081B68yYJtReicH84crcE1AYrOaCc6CtpHxDf+oTFdQuckCpxwLrpZ73i5EeHCf77N
         tXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683335885; x=1685927885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xWunwBjreINeCb0tO4bVmW1S3dLtRxVeicO2rC/ju8=;
        b=cpE89A9038Gh2G8Tqt6eWmS1xPf5FyCvfWGGUI03zhRCkDot24laFjKVJWagwNwg3Y
         8JMzbx2r8odbl8pc+fnt8r/J7iGxP19AkxPb5zRuk6mzmqbEXhBNtEOB22tLTBPMNW5T
         6QjcOFkdvCR7f2ccL3vyJQbs22Saa1/TP2CCiykyEos45ute5C92MD+g+hN7tsoEycy7
         kAyia3RIw4MtQ2pTcUpoRGfwg3d1h4VRR6CoOTt5rmsjcAUVhH33lLov+MsObChryzZa
         P+B656pY5p+UkYIGfm/NSBRVjpy4jPs8JpIEbCYZjhCDO6k3ZdI2K8lCyTez7Spo8pOv
         ugfQ==
X-Gm-Message-State: AC+VfDyUUYZgVo1sx/Tt32PLIQSU/yR+926z1rByjDjHLdrd047DR2Lz
        fjzeJCS370g7/XlMdxhyI2dY0pfd0j6ndFDr0U9NUQ==
X-Google-Smtp-Source: ACHHUZ7u4889MI8XKPWoYqh+hmmV7kq1hmv0/5hgbUWSzYNJEMPiTmCrxeOzedFVKJlWbn8rSBaDbniD+gAkIxH/I1E=
X-Received: by 2002:aa7:c0d7:0:b0:50b:d53d:7ceb with SMTP id
 j23-20020aa7c0d7000000b0050bd53d7cebmr2386748edp.40.1683335885503; Fri, 05
 May 2023 18:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <ZEM5Zq8oo+xnApW9@google.com> <diqz8re2ftzb.fsf@ackerleytng-ctop.c.googlers.com>
 <ZFWli2/H5M8MZRiY@google.com>
In-Reply-To: <ZFWli2/H5M8MZRiY@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Fri, 5 May 2023 18:17:54 -0700
Message-ID: <CAGtprH9UTL5_3F4Zad38vasTWse43GEP3HHdCHtYyWkCTwu_gA@mail.gmail.com>
Subject: Re: Rename restrictedmem => guardedmem? (was: Re: [PATCH v10 0/9]
 KVM: mm: fd-based approach for supporting KVM)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ackerley Tng <ackerleytng@google.com>, david@redhat.com,
        chao.p.peng@linux.intel.com, pbonzini@redhat.com,
        vkuznets@redhat.com, jmattson@google.com, joro@8bytes.org,
        mail@maciej.szmigiero.name, vbabka@suse.cz,
        yu.c.zhang@linux.intel.com, kirill.shutemov@linux.intel.com,
        dhildenb@redhat.com, qperret@google.com, tabba@google.com,
        michael.roth@amd.com, wei.w.wang@intel.com, rppt@kernel.org,
        liam.merwick@oracle.com, isaku.yamahata@gmail.com,
        jarkko@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hughd@google.com, brauner@kernel.org
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

On Fri, May 5, 2023 at 5:55=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> ...
> My preference is to make it a VM-scoped ioctl(), if it ends up being a KV=
M ioctl()
> and not a common syscall.  If the file isn't tightly coupled to a single =
VM, then
> punching a hole is further complicated by needing to deal with invalidati=
ng multiple
> regions that are bound to different @kvm instances.  It's not super compl=
ex, but
> AFAICT having the ioctl() be system-scoped doesn't add value, e.g. I don'=
t think
> having one VM own the memory will complicate even if/when we get to the p=
oint where
> VMs can share "private" memory, and the gmem code would still need to dea=
l with
> grabbing a module reference.

Copyless migration would be a scenario where "private" memory may need
to be shared between source and target VMs depending on how migration
support is implemented.

Regards,
Vishal

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF09170342C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbjEOQp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242926AbjEOQpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:45:24 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B104ED1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:45:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f38824a025so1515621cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684169122; x=1686761122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRf1suCxpp2xw9xVtC6+jBhjPv+ukUhidKZm42V6ybU=;
        b=EDIK7Pc/86wryFh04RCHc696LTO8e7WBVjartdOINZOy20P8SDN8FxNtn6AilVWdDJ
         qplWuDdd5lGpudBSOsNa6OtkgIfzsB1eE3m9Lz9jwt0A7SGm1KHD+bVxe7ba8YJCzgix
         pDK/Y1fX6/d0Z/3gceRYPDj/4YsT9gpdTuFL0i7mGT/AQWNw+0YAxKOVMGp/HP7RNbyE
         ldupBjv3mNrUNl76wZi15yBT8Nk2Yw9AXWOL2I6CLO4jQTn+MQkw2agqf0aQXHYl9Pp9
         74JixFrx7e9SWXEAs+6xBUIsPOEuCLml3za3UZTShdbIxXM5CzjTNNDOcPyjcbYEoerk
         iR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169122; x=1686761122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRf1suCxpp2xw9xVtC6+jBhjPv+ukUhidKZm42V6ybU=;
        b=ZAgMVmssEfVyH1sya2tg243lcXg2p4q9VlJp8ARt6epXYXB8Yz77Ww5ogserYX9eGZ
         BQ3wx7yYW0DBT+A8dZ/xZdySeIIA9dxspraoMqdbTZ9YzSdtiD91UBIGQxc4Yuv4E17c
         EGscnPAGs8Kn6IBh1BNkQ/YUFydbt3sEbIV/b1dRtiz6IiTdqKtl+Jem4nioetHclwrc
         ZDlx72evhmVWKt6Ls0NRrwwm8tx34XBfDHCKuM+mUgc76enFzCqXDb51SlKA6G9R7ebR
         +14s3HZKV3qMh/UV7yAszGw5eY3fI0dBBq6Man+Knu5unBFzTKuNfzLrzlscmkffYOn5
         sP9Q==
X-Gm-Message-State: AC+VfDxKV4TMdvbX6o1Kq2ifpNRe0zfcOL8MuCo1OS5dfKL9F+QXOywR
        +h9EajN4s4xASF5IKOAad9fxclklxi8XGe46XfhDZA==
X-Google-Smtp-Source: ACHHUZ6WL2yHBGGSTjCR/zNcMyHw7JQQk7RuXqLGbndgXVi0BaKjhZ4zIXUc8BriMv7vS24UmRRZQDqx5sUvWOA/tBw=
X-Received: by 2002:a05:622a:1456:b0:3ed:6bde:9681 with SMTP id
 v22-20020a05622a145600b003ed6bde9681mr1323105qtx.0.1684169121825; Mon, 15 May
 2023 09:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <385016f9-e948-4f7f-8db3-24a0c0543b3d@amd.com> <55e5f02f-4c1f-e6b0-59ba-07abc4d3408f@amd.com>
 <81037a58-6b5c-cde4-79fe-3686d9b8a551@amd.com> <b0baa6ee-ea6d-3a30-d5fb-3ec395896750@amd.com>
 <dbcb6666-270a-4867-6de7-73812d32fd8c@amd.com> <7fb25176-3752-1be3-66d4-a7f5a0e1617a@amd.com>
 <682c0bf9-ccf7-9660-21fe-925ef63c5fbb@amd.com> <4c642bd1-5f1c-292e-398f-eed699db590d@amd.com>
 <65cb8f0f-7e8b-6df6-6bb1-a9f1add027bb@amd.com> <CAAH4kHYDUGnUnZt2HUVcGqOYyzsyUhBXUqW+iDyvKCtQW9XuEQ@mail.gmail.com>
 <ZF17KuHV5VIpT8DG@google.com>
In-Reply-To: <ZF17KuHV5VIpT8DG@google.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 15 May 2023 09:45:10 -0700
Message-ID: <CAAH4kHbLrZZ6xvXYc-TLEyN4pAd=-PL4d2T2yUF318yuh+=_pw@mail.gmail.com>
Subject: Re: [PATCH RFC v7 52/64] KVM: SVM: Provide support for
 SNP_GUEST_REQUEST NAE event
To:     Sean Christopherson <seanjc@google.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, hpa@zytor.com, ardb@kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, luto@kernel.org, dave.hansen@linux.intel.com,
        slp@redhat.com, pgonda@google.com, peterz@infradead.org,
        srinivas.pandruvada@linux.intel.com, rientjes@google.com,
        dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de,
        vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        dgilbert@redhat.com, jarkko@kernel.org, harald@profian.com,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 11, 2023 at 4:33=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, May 11, 2023, Dionna Amalie Glaze wrote:
> > Would it be okay to request that we add a KVM stat for how often there
> > are GUEST_REQUEST_NAE exits? I think it'd be good for service
> > operators to get a better idea how valued the feature is.
>
> Heh, it's always ok to request something, but sometimes the answer will b=
e no.
>
> And in the case, the answer is likely "no stat for you".  A year or so ag=
o, in the
> context of us (Google) trying to upstream a pile of stats, we (KVM folks)=
 came to
> a rough consensus that KVM should only add upstream stats if they are rel=
atively
> generic and (almost) universally useful[*].  IMO, a one-off stat for a sp=
ecific exit
> reason is too narrowly focused, e.g. collecting information on all exit r=
easons is
> superior.  And no, that won't be accepted upstream either, because for so=
me environments
> gathering detailed information on all exits is too much overhead (also co=
vered in
> the link).
>
> FWIW, we (GCE) plan on carrying stats like this in out-of-tree patches, i=
.e. your
> request for stats is likely something that would get accepted internally =
(if it
> isn't already captured through our generic stats collection).
>
> [*] https://lore.kernel.org/all/87czp0voqg.wl-maz@kernel.org

Thanks Sean, noted :)

--=20
-Dionna Glaze, PhD (she/her)

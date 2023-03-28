Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05C6CC949
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjC1Rb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjC1Rb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:31:56 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283BEC651
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:31:55 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r187so16091177ybr.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680024714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DY7YgCh1iZeJKq9EsheOBiDYaF9Q7m8O4sVVQRTEOtQ=;
        b=r86BZXlKh2IQx67G5OPEubqsNljPE7UW5dQk3KKfx0taW0k2gLEGJ0KskGNsNmSvO5
         49z49W6/HN+WNnhR5uyF48EEh7C7W8ub/+SpF9yZH0T+dJHYF7nWJ8BjIQ7nCQ8cEqcP
         FjxmTw+W06HCkU6L7A+QeVwwX+kk9XFZfDJFVbPdomeL4zw4VXErylakiGdBTlvwQdCC
         cZUC6upH5mIciQ7/JCHmGyFCoQSyQ8pUC4GRXKkEGipvNn/qkiS+PBwTmnuFJPmHpQaG
         uHLgDfWcJx2honDZ9BMj8fCdDxqYMlirsqd6jrQ+hg+RmCYNdqx2SHYQGbAPSWfxRXzA
         PmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DY7YgCh1iZeJKq9EsheOBiDYaF9Q7m8O4sVVQRTEOtQ=;
        b=Pw+wwQ/wniKLz7GyCRakQ4aj2VtTGm3mYjRI8SGN+tXr+Sv6WZNWcypnmHxGkctbZK
         4ceaPszwWx94qC+7g/OIRpTjhrJSIuw1OYQeR25oxeVSzqsELn0c0rqowAONvdzNPVQp
         VVSTLuVsHbNmcegwt3O8DDEFaF22pKy0DuGez0Ez2DB95MC5SjWYw4/sYCdf8WJaEwSV
         s8vKfqWQOLAbiEhP5zZDkvcQSHGfPE959iPSxOYz+n4xIAztxtQJKV6GkszMKgKFHuMu
         XCRY3SV6MEwt373JG4/29ZSsNZUgG4g5/axtg+qoSUSDy2wMrzwP0LgHCUP2X7Wt4lkb
         fFzA==
X-Gm-Message-State: AAQBX9fMfJ4BpYRGPCXtiqGZGMi5pxEMR0S1ZFMyX5rbjmYIipwLQJX1
        Zb+CbS7nbzsnShlkl+oAXiiQlnx4UgVcT3WeZDS6MQ==
X-Google-Smtp-Source: AKy350Z+jFy6i2s7WBj3hhG5uYYtFfJtpmAkGMeuxT4IHufp3T7blFtifyFS90kbxP4x7v2utE2351pqleUHO1aGuLQ=
X-Received: by 2002:a05:6902:1009:b0:b6b:e967:920d with SMTP id
 w9-20020a056902100900b00b6be967920dmr8469098ybt.13.1680024714097; Tue, 28 Mar
 2023 10:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com> <20230306224127.1689967-15-vipinsh@google.com>
 <ZBzSgI2mkpl3QTNt@google.com>
In-Reply-To: <ZBzSgI2mkpl3QTNt@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 28 Mar 2023 10:31:18 -0700
Message-ID: <CAHVum0dSh-=VsiR+dC6MC3FO_ev4CqNZ6PrVuZoQ+uRd5qn-0g@mail.gmail.com>
Subject: Re: [Patch v4 14/18] KVM: mmu: Initialize kvm_mmu_memory_cache.gfp_zero
 to __GFP_ZERO by default
To:     David Matlack <dmatlack@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 3:28=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Mon, Mar 06, 2023 at 02:41:23PM -0800, Vipin Sharma wrote:
> > Set __GFP_ZERO to gfp_zero in default initizliation of struct
> > kvm_mmu_memory_cache{}
> >
> > All of the users of default initialization code of struct
> > kvm_mmu_memory_cache{} explicitly sets gfp_zero to __GFP_ZERO. This can
> > be moved to common initialization logic.
>
> If that were true we could get rid of gfp_zero entirely and hard-code
> __GFP_ZERO in the memory allocator! mmu_shadowed_info_cache is the one
> that does not set __GFP_ZERO.
>

Can we use __GFP_ZERO for mmu_shadowed_info_cache? Also, MIPS doesn't
use __GFP_ZERO, I think it might be a missed thing in MIPS rather than
intentional.

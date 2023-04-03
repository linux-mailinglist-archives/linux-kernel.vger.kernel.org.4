Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B936D5511
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 01:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjDCXD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 19:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjDCXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 19:03:26 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9A71716
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:03:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id d3so8832359ybu.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 16:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680563003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UqlrjHaq21iiGBIQ42uRCqTTkgo3ssXPeC+pvC2mpk=;
        b=YXF6ct2am7WoKSfbts4DI3hdBCAldklbdhzonbI2heK3aoEG7hZhdcI/bAD4GMwf/l
         2vGdgZlpR3lkJjX6ulynKiH4aUoUyKl3MUNn9IYYdlO05Ad2q4S4IL4ihCUlS6XxpP/A
         tMTFJC67oxjeOxfQJ5bZSC4kGZvRJ2tRIPeKUBXHz0VoZVVvjENsfUE93yNQWhXTzZRp
         XAkf0u+p4+4me7LrRLHTrUOqzlscXY8yBbBKcA5PnfJM+lih6UkmNUXQfDWyf4Nu9VMd
         1G6gE+qVJ7GioYqH1Wf9ardZ/QvbVpN03mcWYRfgPpaMFWG39USSqctJ/E1YhMwUjERs
         bPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680563003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UqlrjHaq21iiGBIQ42uRCqTTkgo3ssXPeC+pvC2mpk=;
        b=7rI04+ejfc/6Cwq7oaP7D8jru801J9goLErdhOKqhcluGyxZp29PJCqIHEdxMOJr2I
         HT9RaGjk1mevkm1O85TH3yTjFxX/RD2EpBaQAWM3RIZOxZLuF1ihu3G4J6fSafo/iIEU
         vLt+bPa7hkQiqDBQ/NSc+0aDxc3dZLVufG/+bQSALUp0QpuTcOrLd+dnt/OVmZhf8ApA
         2o6zPsek3rTN/+IiKBVU8L6jCGvLpAmmHxSqxM9r1t6WLSIIsAOj0fAIOCnMmrDhATOV
         /hWcyzQjW1bNLoK7yACiLmH95tMJMoaVWk70o9VA+sCELK0On3Su5bbA2q/7TxfrVtP5
         8AnA==
X-Gm-Message-State: AAQBX9f2Qw+bl0fg8hU1mD1aDeYMi1lancvjyZRrtL63qkJS0HmtXuw5
        Pi8oX7D0sGbL7qU+GniKIgxHHSPyicz+o1UwIJnTRA==
X-Google-Smtp-Source: AKy350a7+WUqYPzL1iHQeB+Smx71zLrW8+QcNi7UEx8a0U3oM1Svz9j/afNcWg6iaFDuEy2ZVeRiNGzDM5hig/fQlvo=
X-Received: by 2002:a25:e00a:0:b0:b6c:48c3:3c1c with SMTP id
 x10-20020a25e00a000000b00b6c48c33c1cmr561444ybg.13.1680563003401; Mon, 03 Apr
 2023 16:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com> <20230306224127.1689967-9-vipinsh@google.com>
 <ecd28c71-6f3d-d5bb-cd39-ab80edc549ab@intel.com>
In-Reply-To: <ecd28c71-6f3d-d5bb-cd39-ab80edc549ab@intel.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 3 Apr 2023 16:02:47 -0700
Message-ID: <CAHVum0cOG62gstGK_W9r1vgjJ5P7_Eswek9SCmEA=E_hexaysw@mail.gmail.com>
Subject: Re: [Patch v4 08/18] KVM: x86/mmu: Track unused mmu_shadowed_info_cache
 pages count via global counter
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanjc@google.com,
        pbonzini@redhat.com, bgardon@google.com, dmatlack@google.com
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

On Wed, Mar 29, 2023 at 9:53=E2=80=AFPM Yang, Weijiang <weijiang.yang@intel=
.com> wrote:
>
>
> On 3/7/2023 6:41 AM, Vipin Sharma wrote:
> > Add unused pages in mmu_shadowed_info_cache to global MMU unused page
> > cache counter i.e. kvm_total_unused_cached_pages. These pages will be
> > freed by MMU shrinker in future commit.
>
> This patch mainly renames some functions,  but the commit log doesn't
> reflect what
>
> this patch does. Please change the commit log or squash the patch.
>
>

This is not just function renaming, it is using a function which does
page accounting. I will expand the commit log to capture more details
instead of squashing.

Thanks

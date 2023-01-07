Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82022660C5F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 05:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbjAGECN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 23:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAGECK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 23:02:10 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36206338C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 20:02:09 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-476e643d1d5so47257807b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 20:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJk5uhm1gW8UxQ71cUt1sIIi1A36+CzRZlAwgpuglyw=;
        b=cYMfdlHdJIBCalXHzFMH2+G+v5rJhDtASbYLXZVih48uZErXNRywmNGvp8EVOXfGxQ
         vK6QxxJfQ0L40+jUvKIfKYEIrlQ+ZUxaAWSxGHJ4gATE6QvZgANgCtzMwBheCYcW5160
         TTURYlTAbC5IcQBTU27mnJ99HmKvA3h39K+TVc2y0AalI2TNBnbRYThdmMv8RnrTL4xU
         VC1KAYvy7IW6HUgqe4xBu1ZB5cnd0rfEd2CFzm8w0QESmTioOB/JXlR3tvcHQrfKFzrC
         1hufHOzaM6XgqQVJ7cD7b3WgytLeWwD3C9QySwYkmJH8q5Ks+7hVWiYmHppvH/1hvHE+
         6+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJk5uhm1gW8UxQ71cUt1sIIi1A36+CzRZlAwgpuglyw=;
        b=o9qPHANHx9XHPR3vjeqYlPF6OuJisNKvL5c3cfAvqGHe7MjCOKwIYtOhLRydI6bJ+t
         CFSa4ht5pBuk5Hrh9czqXw2SHcAW0EtkgKR7+DEH1agFwyVQSn7cgLnjB3gmXT47TQJK
         BvYIUmnyPngWLux/UCpVZ43VQA+HvHJKyLKt60l3vNpo2PsSWXTa6I+3xIuc7U4O8aYW
         0hA8IiQTY4IeZ75NP0fY4EH4C1yW9xLWDxW/2E+4ixBsF4fSY92TFRUE6R76mVp7Y+Ll
         69vor5rTkCRtnbf0ixl8WH2rsVe1FNXBSUNiUVflZXHwAEf/aIAAXdsjqpcjyq8VT8zB
         hmvA==
X-Gm-Message-State: AFqh2kpoui0huI2TLM2EMV2vHm62a1sIwgYa1vyxfMgsmIhTjfFn6sDQ
        qfbhIJGzj+EeiMEITiZ/FrrBdZADtlsa4GnB4u4qEw==
X-Google-Smtp-Source: AMrXdXt2vfXGKIUsfuJk0JqxeWZVs/uJSWWTD71sEeh8BThFYyAludbnusJK8KcjzJ/QtLplPI1pDUZkijDPZRR8JjQ=
X-Received: by 2002:a0d:c385:0:b0:3df:21db:24f3 with SMTP id
 f127-20020a0dc385000000b003df21db24f3mr5364132ywd.25.1673064128772; Fri, 06
 Jan 2023 20:02:08 -0800 (PST)
MIME-Version: 1.0
References: <CAL715W+k6HWJed8niOK4RWta+viLXBnLT6sZPmqdTi09FEep5w@mail.gmail.com>
 <fc142051-c5a9-8e45-02cd-58b556d04b49@intel.com>
In-Reply-To: <fc142051-c5a9-8e45-02cd-58b556d04b49@intel.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Fri, 6 Jan 2023 20:01:57 -0800
Message-ID: <CAL715WJ9gR3Z-xxv1YM9ekFkxXbmeZYL4MNnTmTMPHKzuWK5NA@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86/fpu: Improve the init_fpstate setup code
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        "Baker, Thomas" <thomas.baker@intel.com>,
        Neel Natu <neelnatu@google.com>
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

On Fri, Jan 6, 2023 at 5:03 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> On 1/6/2023 3:08 PM, Mingwei Zhang wrote:
> >
> > Is there any update for this code? I haven't seen any updates since
> > this version.
> Hi Mingwei,
>
> Oh, this series was merged. So did the followup fix [1].
>
> They are included in v6.1 [2,3].
>
> Thanks,
> Chang
>
> [1]
> https://lore.kernel.org/lkml/20221021185844.13472-1-chang.seok.bae@intel.com/
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a401f45e38754953c9d402f8b3bc965707eecc91
> [3]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=471f0aa7fa64e23766a1473b32d9ec3f0718895a

Thank you very much for the update!

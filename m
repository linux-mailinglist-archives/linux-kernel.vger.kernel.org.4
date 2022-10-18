Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807836036A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJRX0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJRX0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:26:49 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7780E1F639
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:26:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b18so19995412ljr.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MNDee1pbx2mi61goTN2Rwf6hjEyLLZkQkM6iSEb1JP4=;
        b=lZfB8i092E89/JR+0/tlU0LF229bQTh3LK1w304jAl3XpGb5wUEnCDHfKSO5A5S0fg
         zOLXJ5ermV7HAG6AzbsL/cO9vsrb4pKGskjy93JqQM91fWIfX3qQbxOiEKvo4drlSmvO
         8FjkgF23WfEmYwkVJtBpzvd1VuCdjuY1O9I5mrH1yf0KYBc4kCbEl6kRlEH9NpMZkqbx
         5iDtGa7uV29rjGKfh7l4hQ4Heu3v6Evumx12yIdhNJ931tyFtk/DdwBDdlXkFUYYc0GT
         +Kja7bVgGpcA/kIwia4jNcO0qb1sJPqStKYReHlAJEpfjDuk0sOSSIsw/lOlxsUR8jZy
         0k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNDee1pbx2mi61goTN2Rwf6hjEyLLZkQkM6iSEb1JP4=;
        b=vILwRti6vjUlSBHy46pNaFdgn8ZkNz/ce7qr6sCqK2ADDq3RgpMZFH4XwpLdmdYQQ+
         AESr4Vu1xxKnusqmYJsj+XIQaTWY3iyNwgAcbWutYfxX8qU83eo2gPYrItXE1jBC4Mtf
         5VAPGRWhrEGNDMZaOwiEIkOGZrLe5pTorjCMhFmGZkmff1AieXCFZGE6E30UjQFroJCg
         woYQqnU0jjaYv31Vsp/e2fHG7kKgVZrOHem9CJlEbLKIrbVmvoHYmFz5O1b5mlx8zOcE
         ApRUrJ9kd48EGywH1RGfDllPLZFHHaPqqx2kij/3QNJ1HHz4Q8v3gi4Au5pw8hnYXXtY
         JVDA==
X-Gm-Message-State: ACrzQf3M2f/QytUx72QnFtqLjzkUNoGXZyQhlJ6QIKWNgDZGtnq8l01Q
        slQtmglIKejSV1BOAz0jQYHrvIhT3C4x0UTxihcNhg==
X-Google-Smtp-Source: AMsMyM6VTAPhKtp/uyFFJejWpmlSMOhfcr17DbvRhUmeNfNp9PjTORQRlNxxDhDHmCDJm0pwN/iMTxmTGMVck1PypIs=
X-Received: by 2002:a2e:8719:0:b0:26e:b9:31a9 with SMTP id m25-20020a2e8719000000b0026e00b931a9mr1960773lji.111.1666135606729;
 Tue, 18 Oct 2022 16:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com> <CANiq72nU-eDOT94q26dTVgCFA_Hs1cGiLpDCmQ5n-cCVKAcsqQ@mail.gmail.com>
 <CAGS_qxqVUmjxULZ_Kt-gWRJb=+EYpG2_K89sQTq0BYbUighn5w@mail.gmail.com> <CANiq72m5nk4zvcYozFKjO=9gOXG2wx2MG1EYsgAZwB_PnHUSJA@mail.gmail.com>
In-Reply-To: <CANiq72m5nk4zvcYozFKjO=9gOXG2wx2MG1EYsgAZwB_PnHUSJA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 18 Oct 2022 16:26:35 -0700
Message-ID: <CAGS_qxpi+93JPaKiowVM65WJJ0Nipd6EN6HYHe0ZO_McWy2woQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] kunit: more assertion reworking
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
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

On Tue, Oct 18, 2022 at 4:20 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Oct 1, 2022 at 8:00 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > While I have you here, any thoughts on how to coordinate the change?
>
> My bad, I forgot to reply to this, sorry. I noticed it again when
> merging 6.1-rc1 into our branch.

No worries.
You've had a very busy couple of weeks, I imagine.

>
> Normally I fix the issues when I merge back from Linus. Since we
> intend to keep the CI green on every PR, I added the fix for this in
> the merge itself.

Thanks!


Daniel

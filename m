Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B266D09C6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjC3Pfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjC3Pfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:35:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A209CDCA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:35:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o2so18434990plg.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680190509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J5Dz0I/J07O36CXqE0BRQW45IGKi4sdZ6anPBoj71I=;
        b=EAl1AhmF75rYCLH5Q2vZtyt7h5YQjV6yPyx8moPuHclV7yeuRCAzkRDD7F2j341P9n
         YA8/XGuqFn9dKR+A4VEiA1rYPHy24yN3RG4Wm/YJkXMtoUXuyx2jY8s14FpT34Zd1GD8
         L07QTzxvU/AqKb62ZBKabLzqx3uaUvYHWDcY0HoWZ8x+DNeAFd7yqmqR0Tvku7NIkiU8
         WG5LOOf8II2uEEZjDVy/AZMLvDzdsGdKAlnduD2YzCH1Wk7T0sAVXkpeyGIpnGXJPVFS
         VnfsYAHXWqM4GIn8j+O/EUmETfFqRZg7LR81x1yzS49w7C7FH19BTm/O3B7uGa3uh5Dc
         C1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J5Dz0I/J07O36CXqE0BRQW45IGKi4sdZ6anPBoj71I=;
        b=uep5pvBR091AmObodBGrJltBTjJ6I96g25YeyE35mEWG6NJmmVvs2nFamsWgEQEH0x
         FNgZa5XIzzeixIUHu2TwHfmpZVPreJ5wM3GxPZwPEhIy31VJ/W8S9G6pifbq23hAQFww
         BE2B441QE+0jdOCU+jPu8zRJS2Q3x2pGjYmblSFSxfUkVvNNiLL4tTm2+GsHoLRBMO0l
         F3AZlitIcSWmOa0aH4a6k93BU6sRuc4DN9GBA25N4OO4gIiD7TcfAE+jkcYZWD2QohE5
         A24lzFZL0XfcmcxkCJ+bPZnYFcDSmngY4codo0C7gZfa64tOSZK4xGmOlz08vxAlZG8I
         AmZA==
X-Gm-Message-State: AAQBX9dsPL1l5LzgXq5zvR6fPTgumuyIHpOyjHqdmOObjuvCqnnvVFnm
        PCWRPAxp+0d7KY08PD4LLQbk58tA6RB/2jMyx5nLuw==
X-Google-Smtp-Source: AKy350YNQ6FECTA9ROsjSO3DYIpGj7n6B0divEu9JE+0CLFvLjKtYxt1YutcyQDZ0/lroePvmXBB7C0NdX8bl0paJF0=
X-Received: by 2002:a17:90a:da01:b0:23f:695a:1355 with SMTP id
 e1-20020a17090ada0100b0023f695a1355mr7327830pjv.5.1680190508548; Thu, 30 Mar
 2023 08:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230330112743.2331141-1-javierm@redhat.com>
In-Reply-To: <20230330112743.2331141-1-javierm@redhat.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 30 Mar 2023 08:34:57 -0700
Message-ID: <CAGS_qxptBcUQByWAd6JHAxWb08czOiGnx0_uSvMKdhzTVwv=6w@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: Exclude KUnit config dot-files
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
        linux-kselftest@vger.kernel.org, David Gow <davidgow@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Andrew Davis <afd@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

On Thu, Mar 30, 2023 at 4:27=E2=80=AFAM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> There's a rule to ignore all the dot-files (.*) but we want to exclude th=
e
> config files used by KUnit (.kunitconfig) since those are usually added t=
o
> allow executing test suites without having to enable custom config symbol=
s.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

FYI, Andy has a version of this patch from back in Jan here,
https://lore.kernel.org/linux-kselftest/20230127145708.12915-1-andriy.shevc=
henko@linux.intel.com/

I don't think anyone was adamantly opposed to it, but it's just been
sitting on the list waiting.

Daniel

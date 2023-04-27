Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975D96F0228
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbjD0HyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbjD0HyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:54:16 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0E1FC9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:54:16 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54fe25c2765so117532887b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682582055; x=1685174055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jo/lJ36HW0xRXLqbNyH+Zyjc3PHXczxmtp0i8KDLC+A=;
        b=atH59CRPSAmnTNsD1+f3T30VavsuOKNtLQxlqO/nJeGOQeCWksUCSTA7RoYTsRbv0a
         h4jynm12pn07UttkPYr7/2/kMYZQVXWioiJJFzJTN0CfhvfdanecEBU0cZA86SyxXbMY
         n4BRzhLBwLtKvKJlAhNmF6JVwlU2Zn/nwkuGLZ135ZlUqS41QfYDR/CRa9hFOfHpFW1L
         BvWFRiWwixzlTkKsXxDPYBwoVczdjOMlZOrtgb4RAw+NavSZZGIb5PYTfNfgk1qtq5Cn
         B4OKBhrnYBIca7YCvP6zkAwmnnmeoW1z85TVVcfzCaI04U52Tq9JSXvauJZozJKQW5DW
         yUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682582055; x=1685174055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jo/lJ36HW0xRXLqbNyH+Zyjc3PHXczxmtp0i8KDLC+A=;
        b=j+t2j8uMjLWU5ZUzywOJYjbzCXrFZuEM3S5t+YUfsemIWMYVGHxIhF+tbvPfcj9SP8
         99S6YRQqacpYpTF2qAQu+nhprHXPJfur4ZhuUYZT3lx9bo9DULAO3a24AW6c8P+IMbMh
         K3gPnq2Ze3q6tJXOQ5GjB6W3at3jSMPrIigToBOYLzvN65Wy6TXPwLBewYk/jHsSVvT/
         4LUgNzWMDgYmmpTbTrtjHSmZU9ieb0skqxAZ1TEY/u+1l7Ms/kpfuUPUdft0Tb1PIg4x
         C3FL+bAFP+xY1Ik7YmudYcbwtLX2jgzXf7+ZYhYk0VkWpwVqJK8qcsavBiS0H6bot+qs
         SG7w==
X-Gm-Message-State: AC+VfDy2Uhx0EUDDNBrl8DdlvrMpyRCWV6IzF1G7tla66vOHXEWWP/T9
        7z6RUeEQWmUv/rsAkq36HGH+FbTf5KAO1Pse9W4=
X-Google-Smtp-Source: ACHHUZ5lfyxAQtGHMxrPP4fTz36cviRIaXt0bs2yvbr2uc22wnJiX4kUvuMjpVNwZKF7BUXD+Pc2HZUf9JYB2RKD6cI=
X-Received: by 2002:a0d:ee81:0:b0:54f:b615:ab5d with SMTP id
 x123-20020a0dee81000000b0054fb615ab5dmr700116ywe.14.1682582055319; Thu, 27
 Apr 2023 00:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230427023345.1369433-1-brpol@chromium.org>
In-Reply-To: <20230427023345.1369433-1-brpol@chromium.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 27 Apr 2023 09:54:04 +0200
Message-ID: <CANiq72nxNtLvx1J-50F8D05QQjx4FBPkrhg6pysc25RL6--Zhw@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: ignore smatch generated files
To:     Brandon Pollack <brpol@chromium.org>,
        Dan Carpenter <error27@gmail.com>
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, keescook@chromium.org,
        nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brandon,

On Thu, Apr 27, 2023 at 4:33=E2=80=AFAM Brandon Pollack <brpol@chromium.org=
> wrote:
>
> ignore smatch generated files.

Cc'ing Dan who is the `smatch` author.

Also, when sending a v2 of a series, please mark it as such --
`git-format-patch` can do it for you with e.g. `-v2`.

Cheers,
Miguel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E07224B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjFELhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjFELhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:37:03 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A8E9;
        Mon,  5 Jun 2023 04:37:00 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9e6ec482b3so5335270276.3;
        Mon, 05 Jun 2023 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685965019; x=1688557019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTbdt8ORnl1B8sC3y3KbFpUIsRJM7YqW2sLcDSkmXLA=;
        b=RSRSthOlt6PQelpdb653+u9BcwAhAKhp0/+nPIUgfOkN1q9MGczP2bAid7XFUwr0bI
         qqKEExl1+wDF6xDqJ9D6mM6sPJF0wdyCgz9s5utLTl4RCivebhiN3reZKzqXImJYN5zk
         qWXTu4+gx4924dXVeZLS7gbEo+1EkJORAthSacDKR3SIq2RbPr6JJqsR6L3MEm4oxWed
         iHYVTTuBWrRo3TUUZ6Svt5lI5Im8UVAEFO/xgyUymvWkS9kzbbv7auZnFUwLRXCfFMsg
         2EA4g6tPmfgGds0wCDXATm/GXXN6Rx/28Ddk7UVpiDvTGlYSWObFwd+dQ3xfoZy4cJ4D
         DyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685965019; x=1688557019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTbdt8ORnl1B8sC3y3KbFpUIsRJM7YqW2sLcDSkmXLA=;
        b=f+k1yCt3A/DvSQ+FbahbMWM22y6sfFqJJREf5BB1wL84kRJntkCe5bvtvnegDdvgwH
         RTLk/yIgCxd16uSLpd7UqHU6fqhCu2OnVzcszDcPRfbNe+sOJt+pJJnQi4pDkF43ezGs
         IVFwoosg6tAFnXhhZdIi3LAm2dV3nWAcQZTnPk1yRlvmSdqGppDrD4uE53KXEgZ8C8Uy
         6JsX8W5jkxy+idbIvhLnEiassNyfIFrY8/reGgaa9zbDIjYp6lvDjiYSbZ/j5FGsoOGf
         6txNZyK8zeKRRC3xASO5Idl4XGBCLGPiBgKsJ63pVPVagGONPX4IJZde4pOYsp1Ua1rJ
         2mAw==
X-Gm-Message-State: AC+VfDyRYC77JAdAdV9QCfLY7BhJbRS6G6xcSkYbhiwNLb6OJTEmYzr4
        96sAF7wrTWPmBjfeclZjrrX97PR7VJ1WP+BJk4g=
X-Google-Smtp-Source: ACHHUZ5xPibmrkFS0SemXYrWTmceoht+d1JqfD+FxvGUN4R5p2/Q5Yc++3M4FkQsmc72rtjo2TvPFiIs7bXWUC0Y1As=
X-Received: by 2002:a25:74c2:0:b0:ba1:dfba:1d12 with SMTP id
 p185-20020a2574c2000000b00ba1dfba1d12mr13577515ybc.29.1685965019650; Mon, 05
 Jun 2023 04:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230602101819.2134194-1-changxian.cqs@antgroup.com>
 <20230602101819.2134194-2-changxian.cqs@antgroup.com> <5cbf5dcc-50e2-f6f6-262b-96ac1a8ebc52@gmail.com>
In-Reply-To: <5cbf5dcc-50e2-f6f6-262b-96ac1a8ebc52@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 5 Jun 2023 13:36:48 +0200
Message-ID: <CANiq72namC6dtnDfY-AQXU-UNwsRU1K3sS6HWY-jU9myLR3SoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: kernel: add ScatterList abstraction
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Qingsong Chen <changxian.cqs@antgroup.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org
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

On Fri, Jun 2, 2023 at 10:47=E2=80=AFPM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> This comment has some typos, but luckily there's the `typos` tool [1]
> out there to help us.

`scripts/checkpatch.pl` has `--codespell`, but the main dictionary
does not have it, so I sent:

    https://github.com/codespell-project/codespell/pull/2869
    https://github.com/codespell-project/codespell/pull/2870

Since `typos` appears to import `codespell` main dictionary, I guess
that will eventually help both tools.

Cheers,
Miguel

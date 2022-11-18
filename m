Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0825962FD54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbiKRSzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242869AbiKRSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:55:35 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB269A2894;
        Fri, 18 Nov 2022 10:53:27 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-368edbc2c18so57687207b3.13;
        Fri, 18 Nov 2022 10:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UxR9OpGoQxx9yjPAcwW/7PeO4mN55q5wxOodCyNKVa8=;
        b=iU9ThXBkqq8ayKDcs6HS4ecwuXdH+OMx+gSoNkDyXLNG1AAQ3jF4iExO4F6hPaf4UQ
         +i86KSRm92hqtZDlZ6hAhaFJt6om1QahZEZRN1dsaqoGNpi1Pk5x5ha4UMdpDHcdfMCl
         40Wg4SGQ/MCqnx76J4qxaW962YMLHdHPr7IPK9RP4JF09JOtK4V/NEisMsVR+UU92Pyh
         11i5hi2aRC9wfx/Mhz2Zs2H66JlT8/WttOgU4nddU7PEzMw2Abm80QieTZbMW0QPNHpu
         9AYVEjLgdkWxq0rFcOZ3G9td9bHHlbYAycrM6U0DBOscUzbDQ89aCwzCApSkkr7jZgvY
         R6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxR9OpGoQxx9yjPAcwW/7PeO4mN55q5wxOodCyNKVa8=;
        b=qVIv+W0iqkISz/+dl72eqit/3eT/G/KkNUhtVYluzGkZ2dXsOOeacFfjbAbNCdabLp
         KfYksOHQE8hRppyc4oNT7Z7HpyZ5dI12I+RSV1/V6+t9yUJX35IbspJNGVQWFeQIBRFR
         cirhZA4bbWiSvpVYLkoftoRK6kUy6sGJzLDXF0iyXY4wKN1u//xViphIt6gMaBHtg0ca
         OcS511ESY933OqhbA7GVS7HmrcjjDy0vYd4xx8yfQCzO4kbOAblE3FeaKUIfiaGqtLsR
         byzbAww8HTRz/qiuD6aplCQREYOH2zE//jChVs+PxBkoJZI8xwpisZpGQsv/FyN0GTKp
         PzJg==
X-Gm-Message-State: ANoB5pkvsoQaJl2icgY19l3xC9dYGJzSm0n9Y0Dk6dxuvoJw+5Zenh5P
        VMZyNjyVOJc20PWEtWT7tY/25ELbccLwVpDmONI=
X-Google-Smtp-Source: AA0mqf436iTUIdbNxYNL0kI0MCShiSQXnPw4sYZnkMf/dPBA5Z7OFdMpauzxWR1rB1uK4CY5kbvsJNlZ3q2yAbbFrec=
X-Received: by 2002:a81:6a88:0:b0:36a:fd2f:a935 with SMTP id
 f130-20020a816a88000000b0036afd2fa935mr7978610ywc.83.1668797603948; Fri, 18
 Nov 2022 10:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20221118170942.2588412-1-carlos.bilbao@amd.com>
 <20221118170942.2588412-2-carlos.bilbao@amd.com> <CANiq72nN7i4yXjnLftdKZ7zo8Qw8c=aM6L+D2SvzH47PVALJYQ@mail.gmail.com>
 <1ee66e1e-4ea0-1a6e-92fd-60831dd938b4@amd.com>
In-Reply-To: <1ee66e1e-4ea0-1a6e-92fd-60831dd938b4@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 18 Nov 2022 19:53:13 +0100
Message-ID: <CANiq72=d_khJg-LZqNXgiLnc-c1fBxdMfNhhWrg75pKQXP-quA@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: Update maintainer of kernel-docs.rst
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com, Dhaval.Giani@amd.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 7:27 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
> Ah, you are right, something like in:
>
> CODE OF CONDUCT
> M:      Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> S:      Supported
> F:      Documentation/process/code-of-conduct-interpretation.rst
> F:      Documentation/process/code-of-conduct.rst

Yeah, that way `get_maintainer.pl` would know about it.

Cheers,
Miguel

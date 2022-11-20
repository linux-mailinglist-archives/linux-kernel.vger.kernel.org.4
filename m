Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EA163146D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 14:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKTNpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 08:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTNpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 08:45:38 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15582098E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 05:45:37 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3691e040abaso91048027b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 05:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mBTdERcdgmnx8PvXKhzosAkVQsxzRJAGY7myiH2P1dc=;
        b=EK/D5hJRi/FEG1gMpWMJdLWbMPRhBGcPaWnBXGvK6LkpE2gtlLYz9TlLxQu6g5872G
         sYMgzj6TdGxHaYBXZX3wn2W//y22JCuvYKdh2FFmT1CV1WpBlW+VCO1JORJIY+y+sf03
         dcowyZSSTbyY63y64lpIvZ083EWfCWxi+Wphmab5TdSXiz/gVXKP7WSdvCBcvbq1qaCb
         8vlm2Z75iH8bct6G6Fw7Ny1NvHAbZWK3oi2EuPLILcG51MhvhoakUCjRWSFE4n7yWXQc
         ylOOdflGyGDH1dG7n6P5Gp+kkQkmOZB0+juxL4Mwu7Z/t6gIdYZ7HdmJDe3D1bD2yth1
         d7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBTdERcdgmnx8PvXKhzosAkVQsxzRJAGY7myiH2P1dc=;
        b=EdjaWwX7xlZ1Ti65kqyDMOyCPg/Y1sloAP59118u+9aUpmju+YbQ41TGkYpCzMMEQG
         ij5O5kNXWApzBqilpTBw+DkwvzKLaf66br9YX5t3BQNsF8wl5Gq+zYia64Rh0YxmHdGe
         1UAauFkDsUZ1nwTmyaHPzcNqeFDD1Tz9qvVqiATn1gIUNJafV5XQcaL49vmQiFn7gRCU
         X7wfZlqGaDilYYgpOu5Qw8m39hxzSSxWR3BY9MfBVA1cHSLkXSD5Ku8cr4ZpdsmTs1jZ
         6fYeTa5JQw/E60/S9CNSVlO2t/f+s5EzuuuJoKLnlc6HA5mhsGsUDRUGS7z0yCBf+Q3Y
         QDIg==
X-Gm-Message-State: ANoB5pm7NESJiJXx7GQwPLlypbpag72TF7x1mCIJnoNil48XxKdEIQbf
        Rw4lWoe7VufSOwZORpddgpnLIHz9AmgYyXwqagQ=
X-Google-Smtp-Source: AA0mqf6ldem3IX5OjEPbh3A/kSF+9OeCNrkzzl82eUNF7n1cY24rHRJKrTEqpH6eSnlTLEisvxopNqaG9RNj04dzeRw=
X-Received: by 2002:a81:7cd6:0:b0:385:136f:6e0b with SMTP id
 x205-20020a817cd6000000b00385136f6e0bmr13787490ywc.256.1668951937070; Sun, 20
 Nov 2022 05:45:37 -0800 (PST)
MIME-Version: 1.0
References: <20221118133631.4554-1-cyan@0x00a1e9.dev>
In-Reply-To: <20221118133631.4554-1-cyan@0x00a1e9.dev>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 20 Nov 2022 14:45:26 +0100
Message-ID: <CANiq72m2+_FXdUkEiL8_u=u1gTKob8bVcXQ5GpWiJkLwLeabug@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/kallsyms.c Make the comment up-to-date with
 current implementation
To:     Yuma Ueda <cyan@0x00a1e9.dev>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, ojeda@kernel.org, boqun.feng@gmail.com,
        masahiroy@kernel.org, samitolvanen@google.com, ytcoode@gmail.com
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

On Fri, Nov 18, 2022 at 2:36 PM Yuma Ueda <cyan@0x00a1e9.dev> wrote:
>
> The comment in scripts/kallsyms.c describing the usage of
> scripts/kallsyms does not reflect the latest implementation.
> Fix the comment to be equivalent to what the usage() function prints.

Not sure why you used that many leading spaces, but the content looks
fine to me!

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

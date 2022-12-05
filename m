Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3726429EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiLENyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiLENyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:54:05 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36127257;
        Mon,  5 Dec 2022 05:54:05 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3cbdd6c00adso118244167b3.11;
        Mon, 05 Dec 2022 05:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bc4/MjN/YjTPQ9EZGEra+4fgjSY8zygUtk0AgsersU0=;
        b=XuY48gARX1ENE547OqGANQPwOeRc2gRM3s9AirKaB5f7QPn2LgH6QY+/p5iN7FiaDR
         3CGX4FGzaQtIrLyvdndr7xdF/D9mtI9guwQWgJ7AS9Z0fnEYwZi4oCG9mtxDGGH40+vT
         R8ez7KsxFQtLHrKvTvhJZpskWdlNPMQFy0T5umLohosgOqmBqcHW7gkoRQBnv48EFiks
         OjzPsJWCMH/PoOktEwc9W5U4Ez6iElLwZTDVmFv8FV7MwlnXHv+h/Dze/3utINPe4Hoo
         6F7BeH/uSy/1K7myyxp7xfBcKLLyBOWpPBrMr7Gv3VgPkHR+Kg9eJImc6UHoB6fjru2U
         xCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bc4/MjN/YjTPQ9EZGEra+4fgjSY8zygUtk0AgsersU0=;
        b=usuFAR3bafzc05B7OGEGFU/PNjWIyPfFBHO/y4/gvMPudJwBh0wsEobIMu7Es4uDOK
         z7fLbxcj3z0hK8xbzTQFdpDjiOsvqGKgMwdS1GCEJZHmD0uEnHK0Q4mlDJuBqL7FHQE+
         rg9oo4XvTbUW8PZcay3cvZhBo6sm2eTaRiM27CNNlQBzxQruVCUAvMGPRVDc0wWbcovJ
         HRXD/79LtaHHslaEmWrKKYPnV2fFzf+vbPVJ/lA7lJULA97d9fl5IJlWVm3nJ0NBUzO7
         LzUuFdtTbLNnvH7015qBr33WiDJ82fkVjKolEt5MpFe8QiOcVrKRrND2q4YyVWOldEoI
         OSWw==
X-Gm-Message-State: ANoB5pkBvX6yOkdWXFUHE3NVANUl3B0YG3VEeNXwI77cfyB9mJ6nXs6l
        eQhB8mtfm1ueAhswJl4Na8h9op/HsfTHRg2cg2yTOOhnlqk=
X-Google-Smtp-Source: AA0mqf57yGmLoBnvvhGrWpWKkOSHlBQkM4Cadv4sz/Tocdkosl6Gp2yYDACuYMlP/LhWj7GpigOHueOZififfQBdTYE=
X-Received: by 2002:a05:690c:c9a:b0:3ed:90d2:2ab8 with SMTP id
 cm26-20020a05690c0c9a00b003ed90d22ab8mr3864513ywb.67.1670248444418; Mon, 05
 Dec 2022 05:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20221202161502.385525-1-ojeda@kernel.org> <20221202161502.385525-28-ojeda@kernel.org>
 <Y4qNR+Nn9utDftHq@localhost> <20221204103153.117675b1@GaryWorkstation> <CANeycqpNW0E5fQqD1Qzqr0p-3cgs5k5KgLusragaSWbrmcx2Nw@mail.gmail.com>
In-Reply-To: <CANeycqpNW0E5fQqD1Qzqr0p-3cgs5k5KgLusragaSWbrmcx2Nw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 5 Dec 2022 14:53:53 +0100
Message-ID: <CANiq72ns7U3mWxt=gZVPTHB49as5gaY7=kR5TmxGAoMQx3qgbA@mail.gmail.com>
Subject: Re: [PATCH v2 27/28] rust: types: add `Either` type
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Gary Guo <gary@garyguo.net>, Josh Triplett <josh@joshtriplett.org>,
        ojeda@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
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

On Sun, Dec 4, 2022 at 6:36 PM Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> It's also implemented in `std`, which the kernel doesn't include.
> (Which is actually good for us, since we can't really use it.)

We have it around in the kernel (the `std` one is a re-export), so one
"could" replace the `Either` with `Cow` in the case of the commit
message via ignoring the to-owned side of it (but I assume Josh didn't
mean to suggest that).

Anyway, it can be easily configured out from our `alloc`, so I will
send the patch.

Cheers,
Miguel

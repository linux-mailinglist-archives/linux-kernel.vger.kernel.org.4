Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44087660A3B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjAFXZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAFXZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:25:30 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6B185C82;
        Fri,  6 Jan 2023 15:25:29 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id l139so3415752ybl.12;
        Fri, 06 Jan 2023 15:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x/x9CY3CWPVOyJ/ylljcq1J8tB9E3uIzlqDARiQcJMg=;
        b=X+1VJHd81c6280pqJESzaGBW1CskNUbZxt1jFNNGMuyjS6EoKoFwnYR8uTu3XF/8Lo
         LgpQ6BYXhDDlmq7Cnkm2Cug+C9xqKQuQqRfWdtO9dQ0Hdwu5ak8Bgby9elo4VAMo1IWJ
         PzskCkS0V3S9tqV+ZV2TnCMaF4CFe/p3F3helCSq7EnNHXri/Xi16YjQEZl5C5mjt5d1
         DBWPKez87DqhHh/yFHezS7X8LRnw15vR68VjBvBUcRvBjO9Eu9irPRq2y1EbPxrf5VCf
         DCH3V+GSlHdeGdxtCs37wX0G5LVwmwhq4M3N8oZf/hrAAXjJewTVKGbgqRVVulN+brY5
         RZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/x9CY3CWPVOyJ/ylljcq1J8tB9E3uIzlqDARiQcJMg=;
        b=DJmfEKabniG2V1qFGTZnmH/p4mzKrY1oIQkClAHyAJGPRoJZs9e2x3KH6ioC52iqfq
         WJbEhcBG+8Fp26o6rtb6mpgyFFQ3SzOzgQH/BZKLZZSCL5NuGKPvbKg4yv2KfQFSZ/id
         1T7gSBTJPp7EUvVXc38caLl7YfkXa1a0TUHhCi2MkHu2NHNbzMEg2VUr6E79xHQQ4iUa
         5vZtgNSWaaoxvLkhfDYgk9zD4OXrRLdhL4FkQw4N5vRtBxdu6Wb3ShaE0tBowPIlr4B0
         TPCu5C0C6E232IpbJNIONw3TP4HGoLRnZMyKw39NDS1XXsPSRTSwbPsFNr1XSZJ+sznE
         YoSQ==
X-Gm-Message-State: AFqh2kr5uMWE7wVXaBnvbw246mD5WDCj+1sjiYSatFl8bA6LMzdltiyq
        06d2gE7vfsILWYNISQeCiMO4MygJEyuD9ddvpkioIoYPM3usbJZ+
X-Google-Smtp-Source: AMrXdXtzhvS4tKOzaKHTjdSB1dkfXPINULzU3DlwM8FZBtFz2W6f6snn7VcUhhvYSnkrphQdGhMUI9O5qAZ/i0Hcato=
X-Received: by 2002:a25:420b:0:b0:7b4:998f:196a with SMTP id
 p11-20020a25420b000000b007b4998f196amr956110yba.489.1673047528756; Fri, 06
 Jan 2023 15:25:28 -0800 (PST)
MIME-Version: 1.0
References: <202212272003.rgQDX8DQ-lkp@intel.com> <Y6r4mXz5NS0+HVXo@zn.tnic>
In-Reply-To: <Y6r4mXz5NS0+HVXo@zn.tnic>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 Jan 2023 00:25:17 +0100
Message-ID: <CANiq72kc60aPcx5LwFhOGL4AXOhZsZj32iOg75K5ZxLaaRaYkg@mail.gmail.com>
Subject: Re: [bp:tip-x86-alternatives 1/1] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, rust-for-linux@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
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

Hi Borislav,

On Tue, Dec 27, 2022 at 2:52 PM Borislav Petkov <bp@alien8.de> wrote:
>
> These reproduction instructions look insufficient to me. The env needs a
> rust compiler installed. Which I don't have:

Yeah, note the x86_64-rhel-8.3-rust config name. It is a config the
kernel test robot added for testing with Rust enabled (which explains
the version text you saw for `rustc`).

> ./scripts/rust_is_available.sh -v
> ***
> *** Rust compiler '' could not be found.
> ***

The script is meant to be called as a Make target, e.g. `make LLVM=1
rustavailable`. Perhaps we can put a message if the script was called
directly.

Cheers,
Miguel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951F86ACDD9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjCFTS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCFTSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:18:21 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1453F305DD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:18:08 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p20so11533563plw.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678130287;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlfUVnMpAeqg74Kjt8UEOETBGNFFbOVFaXPZinB2uzA=;
        b=t5crri0WcTaC4dbDeFT8B1Wf41RotuxLDoQ4au4TS14bhzVMaHsw9aHDiNZ/QgfigO
         pIri5VdgzvPiiJjI1Fi6ly7z7LM/WBF4IOflr++3YI+qk3fjdDueo9IiFarU45YM93jy
         InVglw2HcfH0SVosPwcOZVudDiaF8aEsAty9SKv60VRlOJ6dbXxRUnEfnuwuksQRL+oH
         MjCDHAW0mtGh5caILOuIvpWpotLpNMICgWII/CmspOGryPGZRcLIX7VDlhmcKqnho09M
         v3nqHeyXn7TJizhYBWel17Os2plRYUMcAagxx2fq7Xno7HV5B6AU7E+r1P+9n6NyddI7
         /lAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678130287;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlfUVnMpAeqg74Kjt8UEOETBGNFFbOVFaXPZinB2uzA=;
        b=J692aAjRU0FSGhK/iqcq1KT897OaDZw8w0kwwJ0FJskMD8/v4C8dcLkpnZmrcEZELt
         Vemx2xTZ4gMnJlk4O8EH6ZQcUTSRT+DL29Afkx1Pt/ZtJy5fN5lwdXj2f+Dmyz2Ct6RW
         Uj+6nCOlhoTEE35vNGMrJ7uZcnmoj1x4bzooNsBC2ZxVokU/J4eDlBplO/FsUMgedK8y
         pfR9bbh7xRVS/GhpKB+Jrq8GLUkIK8Ft/fkLQGwPZ90ccGOlP5axyPYr3Ef1iQ+GHu3h
         qINQ0m2lCxeG4zkCHhPTGQOwpM6N78g+wecb3LuMEWCkOcy9Zi2FmrigxGCXfI7nulNr
         IfRQ==
X-Gm-Message-State: AO0yUKXh/X0rNv1ZsqkSKBcY2JVAZDTm1RlNWT+6xV4HbhSZH2XQYz93
        XUzKL2Q/v+Ta5Y7vRoGN+TjauA==
X-Google-Smtp-Source: AK7set+iNoJZ2cxy5qRgIoHSJ0YdyIfw0jMkr21udOVpB5izRmx1RUdTQKZ9Owwbph8LjbeyohY5Ag==
X-Received: by 2002:a05:6a20:5483:b0:cc:50de:a2be with SMTP id i3-20020a056a20548300b000cc50dea2bemr13625900pzk.14.1678130287404;
        Mon, 06 Mar 2023 11:18:07 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d23-20020aa78697000000b005afda149679sm6782709pfo.179.2023.03.06.11.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 11:18:06 -0800 (PST)
Date:   Mon, 06 Mar 2023 11:18:06 -0800 (PST)
X-Google-Original-Date: Mon, 06 Mar 2023 11:17:18 PST (-0800)
Subject:     Re: [RFC 0/2] RISC-V: enable rust
In-Reply-To: <CANiq72ndkF0JM1kV=ewnO4uGirDowHDGLkhvjQgtLnuPEk_hTQ@mail.gmail.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     miguel.ojeda.sandonis@gmail.com
Message-ID: <mhng-a7ada57e-543c-434b-a4f3-4fbda9238eb0@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 00:37:29 PST (-0800), miguel.ojeda.sandonis@gmail.com wrote:
> On Sat, Feb 25, 2023 at 12:18 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> Works for me.
>>
>> I've got a few other things in the pipeline for this merge window so
>> this probably won't make it, but I'll dig in after that.  We've got a
>> bunch of Rust-types floating around Rivos as well, so with any luck
>> someone else will have some time to poke around.  Having a full cycle in
>> linux-next is probably the right way to go for this sort of thing
>> anyway, as it's likely to shake out some long-tail issues.
>
> Thanks a lot! That would be great.
>
> At least from our side, no rush. In fact, we are letting users (or
> arch maintainers) to request/submit the architectures themselves as
> they need/want them.

It's time for the next release.  IIUC there were some authorship issues 
here, did you guys want to re-spin this with those sorted out?  I can 
give it a shot if you want, but I'm probably as likely to screw it up as 
anyone else...

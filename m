Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5FF65A584
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 16:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiLaPZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 10:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiLaPZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:25:45 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14771E8;
        Sat, 31 Dec 2022 07:25:43 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3e45d25de97so333528577b3.6;
        Sat, 31 Dec 2022 07:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vTIkUhi2i57VDmwoitY7JCvY+QmJnIfSHOGksYjEkbA=;
        b=Wxutio96iEpSuzsprYxs6IHmn0oqq5J1twDr1+aDhNeWMa8G1wNSSFKAZ+NfqhV4xD
         49C2ygL/+2VW1SxaGbsz+qISSaSeeqK3I/h6Xmf2DpuzKNFnM+xUdJxr607Kv5Y2pGvd
         5FXZkH1X/33EAm5k/R0b5F9MrTpYwBjUL/1QgSGuM7QOyMkKiRoqBtEWYnGackGNkhcp
         UOUX/kgmSoVgRhl0XWE2KfsBnAyGaMEdjMy1ZfJJU+X46TPE0zH5WVEXvHN5H7Z1CzOQ
         t2kj9AXh9kyFroKHFPzA8N6hrWswDQbf0QIRPUl/U0clUCXJkPHbSPE+8iaDX4sgXYOc
         zn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTIkUhi2i57VDmwoitY7JCvY+QmJnIfSHOGksYjEkbA=;
        b=2T0zl0qd4I1NZULn02QYGuFxsIeUqJSobeot7BSWFcfoLzn//Lpk4YLmasFOm4n6fy
         hfz0l6DoIw94HHenRlPoIPQ6OPdIp57IO++FwYr1i4leUJDpxtZ4wx7WBJZyrY+ES+pO
         Vb1QeRexL3GhuDoRx+1KrTRc9YvqPSl95xCZ+12Jq/XTtDxKsmjloSj8DtjAwK/VaQc1
         zgEnR/X+JMiZEvUsQoxDiLUsZg/TjqRC4EFH8L6szXoxXgHNDjl+yl4WzQF39BGdCwr5
         9WF1CR5PYNL0ytHU9/GstwSMfgLNoIW5VHzKNOAGab0jSWjeWIe1RJzKmRlrhV2Q3nCr
         zPNg==
X-Gm-Message-State: AFqh2ko2deVEVcEIt6Gi2VTPH9SAQbTTUu3y9aII1kW2SVkO/5Ex5uhc
        K1/5/5xTyGLPkVJWBwGyc6skyT+CYNAD+wtVNS46393prt43XgFjQHU=
X-Google-Smtp-Source: AMrXdXuz6tWQhdwH3LFnVRkp0Z4hMEe45w1XsqKtayO3NmjA7lcsPsIu3ThMzTEuO3L1zUpDAC/cJ9LCOISwbELZGjw=
X-Received: by 2002:a81:7343:0:b0:484:a94f:210 with SMTP id
 o64-20020a817343000000b00484a94f0210mr1918307ywc.129.1672500343240; Sat, 31
 Dec 2022 07:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20221231064203.1623793-1-masahiroy@kernel.org> <20221231064203.1623793-3-masahiroy@kernel.org>
In-Reply-To: <20221231064203.1623793-3-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 31 Dec 2022 16:25:32 +0100
Message-ID: <CANiq72mbazF7b3sbH=9F=cHbTB_np=os+YzUPCzh=4HgEHsEKg@mail.gmail.com>
Subject: Re: [PATCH 2/6] fixdep: parse Makefile more correctly to handle
 comments etc.
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
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

On Sat, Dec 31, 2022 at 7:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> My main motivation is to drop comments. rustc may output comments
> (e.g. env-dep). Currentyly, rustc build rules invoke sed to remove
> comments, but it is more efficient to do it in fixdep.

Hmm... I couldn't apply this one, it turns out `#include <stdarg.h>`
is gone. Adding it and adjusting the patch fixes it.

Cheers,
Miguel

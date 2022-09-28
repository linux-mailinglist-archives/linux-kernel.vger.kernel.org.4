Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4BC5EE2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiI1RRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiI1RRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:17:02 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4582718E22;
        Wed, 28 Sep 2022 10:16:46 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n192so9500953iod.3;
        Wed, 28 Sep 2022 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nWT0dY8CH6ZDhZEwG3/zxXxVza72yOSFN78+9HivIx8=;
        b=o5lP24+OoGt0u1JvVmbs6pVe+VTt3V3io+TCieNxR4yRFDHB+h3mp762sRAFzfm8P2
         Zdi4+vfp0a4BKzFsNjQ9wy1FGmveqFoq4pRuSX/65InDVeGf8HNznCJ2eG7dGmT3uGKB
         Oc4UpQxSjJpNiFvsoYbbX2odnW9ctbHt0bZLFzgritGRvDaPF2kC76VJNVnj/y8s+m2/
         JurPbn1fL84T7lk+31WK1HGYzXg2vM0dhfJV2aTOy0wj/0zhtiptP/rfFYcZKuUIrXO6
         DvW4Z9I24dKz3DrOyy1tgNl1C3RS5dAIL3T+iFOuoEOt3M4sLzs/nZA/VWpSjJmFpLlU
         mTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nWT0dY8CH6ZDhZEwG3/zxXxVza72yOSFN78+9HivIx8=;
        b=POHFQW5Y9B7zarEvDPx2KNtJldA+mH5yj7pWNlTXBYI8/20Kj0RfMgg/ar9OffXs+O
         PvPg9qtMGPFu8LndyC3SJeXjeagDmBzDVcfWWKvhUaFPLsDN8LQnHkw5vo1MrM/yIdCq
         lv0z2zSth6fUfxor6BjoYr8NFbSOwuHHmc/2kCl++Lw2y8KiFGXsds2hOrnZiiihLcXM
         azn9L4h9lvcU/l9Yr6TwJtlOeuR8YS4hvo4t3wnHSTn7Y/f8G1h8s3OyHbdTud6lWZB6
         FbwfEoBPS12x8HqAN9lcW7jRp4NGMkhNP9wJuQzW5KzYbS0Ji4VXnFLm0APOJsKXXgLB
         XHIg==
X-Gm-Message-State: ACrzQf1SFZwpTooEIvMCooAC6niRbmEQ/xzfVNdi1hHnIi1P4pYGzlTm
        bhb/u8jKk+6gCAC4hQ8GVSTIp3tGMVonBweag7o=
X-Google-Smtp-Source: AMsMyM6a0LBYPMwSJMlznDm4+VAzXSEs+W4lpjj2ThGM0Q7tUeTU2/4r7NH0n+RWsv6q2iWYuipZAV7l8w4/Dd+64fk=
X-Received: by 2002:a05:6638:218f:b0:35a:7f20:6a57 with SMTP id
 s15-20020a056638218f00b0035a7f206a57mr17584932jaj.186.1664385405399; Wed, 28
 Sep 2022 10:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220927181647.487727-1-broonie@kernel.org>
In-Reply-To: <20220927181647.487727-1-broonie@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 28 Sep 2022 19:16:34 +0200
Message-ID: <CANiq72=9ns5DU0C6eacxLnMkNUqZXa_gP_x3KLBKof8dR3HNYw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the kbuild tree
To:     broonie@kernel.org
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
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

On Tue, Sep 27, 2022 at 8:16 PM <broonie@kernel.org> wrote:
>
> I fixed it up (see below) and can carry the fix as necessary. This

Build-tested it -- works, thanks!

Cheers,
Miguel

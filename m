Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984296ABA9B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCFKCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCFKCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:02:01 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1D323C48
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:01:58 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5384ff97993so174499987b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QD4rUPOwl3QwymfiFfudLxgF+k9sizGQtygZ6Xm8TaU=;
        b=En/KrIn6bNmZttBEZpgWZAjYMwbfb90TweOp8cecesdczbo2sLeXNl6Ju8cerTmrvu
         c1fVqDBfsFCMxq2fu9UrEY6qQMWMmzAB8jRd6ipdmCvWjnO5Gqt1ZValbHqzCgWoWLxr
         InCFNKXaVTgLVyN3iNaYH/IrMmVGvhXsRezr8EdfH+dEP/F0R95IrzSbdghn01qDuYi/
         4hzkC95K2bRJek78QyTcf4UnTTIiVwDdiiMxQ9mVHe1Zm0T0QEag0jr0cOYhzCuE3awk
         VCpeMfghlz5KXrFklJkdSHykKMLq5/94TBP2Vg+Kl2Sh2Uqs4/CtJ9/Y87njdc7oQKP4
         yemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QD4rUPOwl3QwymfiFfudLxgF+k9sizGQtygZ6Xm8TaU=;
        b=JTkEyTPcK09ZehWA2/9tmwW8K24yTGSQJLrrfpdkWj75+1Jy7Z9WRGhc/5etEGVL1c
         JAstG+Y6P5bAO4f4HopO8qyqFhzkcUJ2v8ILivRS8c8IupX5fDxE2fOXdjzp0DEtkLSP
         J5uBb5RrJRRjodtdHVPyJyfxDcbUesgj2/zVZPgNGEUVTX2ZNgecnJ9YJsUfRy2lgmMB
         Zt3SC9N1ClrTo9TOqP+4sHj9ZZVgeKvlOJjeRrH8oKIrn+90exYyZaoZGKzTrM6m8L4u
         Uh7ZdCucXA/6J8Aq9/Uza50IqH78dW+rFl6FeZuReeD4XnBmUFu9utOYmfk3CVOSdGuo
         baAw==
X-Gm-Message-State: AO0yUKVHCbM3MEQULiMpy9l+G60MnaO2+F7JKj9bLtoqp6OhthmV2RPY
        ybUYBMpT+egvFeadZHXk1iaSr6xbupiffhXbVZ6AnA==
X-Google-Smtp-Source: AK7set8yVm+4S3McVEwMVY5gRhLLC3IT/8pJgkJO55yRqGWg8PlD44jommdj8TfHnLckgPf3bx0xyH81bt2B2fGRuz0=
X-Received: by 2002:a81:a12:0:b0:533:9d13:a067 with SMTP id
 18-20020a810a12000000b005339d13a067mr8759239ywk.3.1678096918021; Mon, 06 Mar
 2023 02:01:58 -0800 (PST)
MIME-Version: 1.0
References: <ZAVu/XHbL9IR5D3h@gondor.apana.org.au> <E1pZ2fq-000e1q-0T@formenos.hmeau.com>
In-Reply-To: <E1pZ2fq-000e1q-0T@formenos.hmeau.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 11:01:46 +0100
Message-ID: <CACRpkdZrOW3c6QkUVdyZie52S1XmWbexG2K=Ttmoi1fuOD+Nng@mail.gmail.com>
Subject: Re: [v5 PATCH 6/7] crypto: stm32 - Remove unused HASH_FLAGS_ERRORS
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 5:42=E2=80=AFAM Herbert Xu <herbert@gondor.apana.org=
.au> wrote:

> The bit HASH_FLAGS_ERRORS was never used.  Remove it.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

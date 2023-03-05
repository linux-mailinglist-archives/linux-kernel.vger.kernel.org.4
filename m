Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695956AB2EB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCEWNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCEWMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:12:39 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3ED1ADF1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 14:11:59 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536bbef1c5eso150596767b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 14:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOAZ0bGuvBp/Aobr9qER3nHn+lNrIRRfqJCfBY1Kvv4=;
        b=gjMCt91aKj3KnGGeBKpADkPrRbbByh/HbyOao5EYCMmIKFQZuta8xQBBvACOMSXs3Y
         cdy3mk1yMMEY4hzjzOtxMLSBbgveLrpi9L1tJbEL8JQkHiiqPHRfVR/n2Buc/sbcWJLe
         3oAv4mL6NsCqcGl4kSrVqNctGFeGdYVj2uLPgWa2XWTwVha1qjwVRnLNXUOALM5aRL0S
         BrG+wTjwv9ZiHZo2JSTsQw6AArnp7by4I52AqvoB44V5yZpPY2R+xNWhaK3X3f43co+z
         BTmxWua/F2R0ZN9n+n9EfxjdQ795CaI7i0XteZt0mGqezR9OAVMah3l/8R8bjSNcC9AO
         3+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOAZ0bGuvBp/Aobr9qER3nHn+lNrIRRfqJCfBY1Kvv4=;
        b=qok8wKIoCFdFlos5WaXdme8K2I9VhgFYNKSvFWhkrqai4zBXqMQnE/o7ILr8ocRVK3
         5dRvUnIsm/jE7Hb9FY7f8ZNeyrH9zTrEjXfxdXNZaudKleAgrcJcUQ9/Vlxk3fYj0nWx
         ZIuj0cKH5nEY8FsM7hxsYA81G106/w3J94TdFC2dpsOxwZqN9jRwnSuyQVM7F93Zlfax
         RyFKuvBk2aOP+bL8SHMZEPkssWgXoD3rlgSQfT9l7pmajXHiMJt1T42D/84BOh3tmwnz
         CKipsfC4ulVEFONfkWoEZth36YnKng8rmysvB+duINJOeQ9C5c4C/Z6tJEa5VU5A5fac
         f4Cg==
X-Gm-Message-State: AO0yUKXGj+0tFaSOdFd12k45KnSDZbpIRgZAGBS7jmuYd/oxAr8ItrfF
        bODBlIGVRAvsZOsO2+dQDfMZxvLfcikl+QhU4u6PFg==
X-Google-Smtp-Source: AK7set+Q8NbS3q7qTFquSTzpie0bRNI7LjXs1EmcDoQ1MgyChDNmE71Qt9JWMzSp4ctpJWlHnEc+39tao4m9fEws64M=
X-Received: by 2002:a81:a783:0:b0:533:9b80:a30e with SMTP id
 e125-20020a81a783000000b005339b80a30emr5155244ywh.10.1678054317791; Sun, 05
 Mar 2023 14:11:57 -0800 (PST)
MIME-Version: 1.0
References: <ZAMQjOdi8GfqDUQI@gondor.apana.org.au> <E1pYOKJ-000GZ9-VW@formenos.hmeau.com>
In-Reply-To: <E1pYOKJ-000GZ9-VW@formenos.hmeau.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Mar 2023 23:11:46 +0100
Message-ID: <CACRpkdaqzdwzG4fuO9C4SUymP3i2F1RcfqGMVLHHkoFDABdBFw@mail.gmail.com>
Subject: Re: [v5 PATCH 4/7] crypto: stm32 - Remove unused hdev->err field
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

On Sat, Mar 4, 2023 at 10:37=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:

> The variable hdev->err is never read so it can be removed.
>
> Also remove a spurious inclusion of linux/crypto.h.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

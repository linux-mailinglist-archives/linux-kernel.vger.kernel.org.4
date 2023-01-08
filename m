Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468B7661A55
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 23:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjAHWH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 17:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjAHWHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 17:07:54 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7019BFAD1
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 14:07:53 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lc27so6570162ejc.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 14:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kIWT89hhIMpld/zeWPd7+BrMWFhTf5eLmGaqICxZdAY=;
        b=B+0o+U9S6yBB8lTCzXe0paj68/ya/QWt60z/QLt70o8YKolohtCD+7TLI9ny3C/B03
         Qb+juOdrlvrC31S2fmOJNup/PCgReSUXuSJDDxbt5RrSOjXjqRlSKuCzqCQ35Dek9wgw
         XG6rE3P2aj4KUCWF7fB3qsnuFqQEzj2FpUipiHEHVRvCWPJ2zqGU3qv0aYuENsskPJ5Y
         2KQybIKOMRSXXpMOLz9dWaB4FGGCl4aCvnkRwBjxNySEshmqVHS2+Osy5cuMBaZkOwpo
         EnhlgJlc/7YriOmYGo6qEXOFBiqPtnoZolDb+PxL3eiiCbjBuyDjLj8xyMJPcckXobQ4
         0IeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIWT89hhIMpld/zeWPd7+BrMWFhTf5eLmGaqICxZdAY=;
        b=TPJ39SX1KS26vB1iVlURtMXHwPJaLMgLhGavkI6vSgS7QttQmHt4ushueyVayijwSB
         DlLNx2tV1WeGpa2mmXQN/WrN1dnRaSmNrwOHH0PMy3ieONgN+GaSDMG5ln+uDDJaDmTU
         zSiEZL15dJRzvDKlqO0GJjjIf6/IETf/zrcOu0QvYZPOqjuCX6zA/9+UCxq7h1IoHgO+
         jy3qZzwmD4E9cNXops93aa8Bei//8OYIPuE/M6mJGjvEmmmCwPMEx9OI9Req2HN9P/ke
         qAEp+Isf5mY66iPv145lBL1w2Ks+PDKWXRl4v8sVkNuRx2LqeU5GHpdLqkIUmCqbxlgS
         7J7A==
X-Gm-Message-State: AFqh2kp9YWvYoV6jaLRUV8/4YtpJrNI3+WgUasSyCiKIUyQ0Ms8yPtqn
        dZaDt3yp0Bru/Dkx8bC0utN4B1dsy/17K1nemAQ=
X-Google-Smtp-Source: AMrXdXv1QWvQ0rkvovyAlYa5xGOhR3R2ydanqLBLkAgJruWrqOGcVxwWsvDKos39CPV2GwBUGHKJusHMFZRA2l5oHn0=
X-Received: by 2002:a17:906:2649:b0:84d:45cc:3247 with SMTP id
 i9-20020a170906264900b0084d45cc3247mr122622ejc.481.1673215672046; Sun, 08 Jan
 2023 14:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20230105141549.2252550-1-arnd@kernel.org>
In-Reply-To: <20230105141549.2252550-1-arnd@kernel.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 8 Jan 2023 22:07:16 +0000
Message-ID: <CADVatmNPCGVyrYhSU-v3VU4X-_=CeT1_eDuTGffBV-GXXdn=iw@mail.gmail.com>
Subject: Re: [PATCH] parport: remove ax88796 driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-parport@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-kernel@vger.kernel.org
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

On Thu, 5 Jan 2023 at 14:15, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The s3c24xx bast platform was removed, so this driver has no
> users any more and can be removed as well.
>
> Cc: linux-parport@lists.infradead.org
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I have a series for removing the s3c24xx platform to be queued for
> 6.3. This patch was missing when I originally posted it, and it can
> either go through the same branch, or get merged seperately through
> the parport tree, as there are no direct dependencies.

There is no separate parport tree. Please feel free to take it via the
same branch.
And, with that:

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


-- 
Regards
Sudip

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9905730903
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjFNUOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjFNUON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:14:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D451268C;
        Wed, 14 Jun 2023 13:14:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5186a157b85so4681152a12.0;
        Wed, 14 Jun 2023 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686773647; x=1689365647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3Rl7apYSnIbdty4J1LxmZb+9CZUYt38RK5u4EFXNuc=;
        b=sPIfg/bUnXtkfHGRWEXvqK+DryYeOgSATt05cmzm7c9lvbBZFAV8bvBcLt7oDOZr8B
         tHf1h6Od/EvSyU2rEWj6EnnZo1pOB38BR38wI804aJIYwneakuLnUr4m+x71X6omyP2o
         aJFXkdRoDCbFJmo0HPHqgjEw3nBz2O47vSeyDdXwFV9Jq89+H+RqJcKiFPuJXU09AF13
         G1u9MpXsn6LLbL7L0U4DPQXATZVsVQlubLScW3tgY2G4vymnhFdG3IK1UD+6RoKgj3tN
         v/UVtI+GurUgzPkV9LlSPsFFCD5iiovizyahmvHbOPxUNjuLsM9bOUrEM2QfZ9g4LaPC
         AUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686773647; x=1689365647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3Rl7apYSnIbdty4J1LxmZb+9CZUYt38RK5u4EFXNuc=;
        b=DmShBHjkK9mZVoHZNWiqzti+TWsrAHSDavEMWebcUoGLRhhlwXFU40lG+fB87/Ae+t
         TblPLdNSp0nmQ1zFUtQe361arWubLLIT/ocqa5X8ne5NKBNswlvSCXRwvs0EJ4mlF982
         y/rwqRaLkM+lkHt3ZdCStsKj4ro444HYfYHbroa+qi3go2GM2jvi/iCK8hAqIzWaFdOT
         AYkT4U7e4Y23cDUELvCT+gIVk0+OYYXwCHAVy7Z8Igv1r52SY2KC3DyaG0bb5uGbQvNV
         7OkA/g7EOyGWLUvJFY8hSTNJh9rrJNRxlxUE2jYOuGiWG64Q31evPYCFi3vgkbu7uilG
         eo0A==
X-Gm-Message-State: AC+VfDw+q0kxIUGQXflfo+GcTk6LPoxh0VbKOi3AT4pTeFGTxoUvNXAW
        EDOvg6JjZ7bR2Q5H3tpynusFna8OROrVJYwbw9I=
X-Google-Smtp-Source: ACHHUZ6fNzodgl60GiVPDhsGDmi6ZBnWEaM//Wso5VLBjQUMPVocF5eQv0G8fPbIWjaWGjrqtJONw2rblUU2J0bsUI4=
X-Received: by 2002:a17:907:748:b0:974:5ce6:f9f6 with SMTP id
 xc8-20020a170907074800b009745ce6f9f6mr17131237ejb.10.1686773646527; Wed, 14
 Jun 2023 13:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230614083943.85660-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230614083943.85660-1-yang.lee@linux.alibaba.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 14 Jun 2023 22:13:55 +0200
Message-ID: <CAFBinCCeGHqPw_8oUNj3q41KYOix9Tyczwn_=wVCZSEmuxk6bA@mail.gmail.com>
Subject: Re: [PATCH -next] clk: meson: Remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:40=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.co=
m> wrote:
>
> ./drivers/clk/meson/clk-pll.c:373:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5531
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
An identical patch was sent within minutes of this one: [0]
The other one has two Reviewed-by already. So I think this one should
be discarded.
Still, thanks for following up on this issue!


Best regards,
Martin


[0] https://lore.kernel.org/linux-amlogic/20230614084808.98819-1-jiapeng.ch=
ong@linux.alibaba.com/

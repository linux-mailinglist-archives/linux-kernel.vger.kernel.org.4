Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D46732287
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjFOWLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjFOWLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:11:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9230296C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:11:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9827bd8e0afso296685666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686867063; x=1689459063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMfpGXgXUiBhBplb6MiyxnSYCXqw3vciMv4l5IOtWhc=;
        b=IX1TO4+N7YXmYMplT4+BpNI2p6VYPbwFRQb/8kWMDHyTRq+g9mQdh/sKfod+wyMh1S
         3ymS3xt6SdZG2UjRUShUZk/JKH5m/eTwEe/eNsU0EsAVKwF7Tz/vlDqJ6upM9z0p8ml5
         rSpxIuaZyCjW8kvbBBwnQcpqorbf5mb2A3gPOhkMmOxVpe0Jz+KJzW0vipfDvPCb/U2u
         9oiDZ8ZOref4OExhQuxayEmKAU4HQ7gq6ghYOfjVYIlQSt/izHqm15tRLONdtUjLTlLa
         lmSbsAy6CE8S4r/lJxPjV86kZgZgpLlec0CYCbDjcKq2ynN41GDuz+p5lnA070wR+uDk
         nuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686867063; x=1689459063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMfpGXgXUiBhBplb6MiyxnSYCXqw3vciMv4l5IOtWhc=;
        b=jiDF1hbUpw+GS/8H9PV8YDTf3BYZbv5R195R06CuN3/WsdohH2G3VGvcu5osCodG1N
         HEsQ9fN+oEtBDuC6Igmga5kiURSVMWLiQQXb7l9eEmEWJKCHa6qQnbRNJKOLloysGMtj
         JQ35VSwtGNScmjWDrqyIyk0uTOn0E+NpJoD6jrTlgLApsvacE3xeC6OSPZ1vkErYi5t2
         jP85cqsLilyrps0bNx1TVJa3Pnhzo8PigP+U7XiHqdVe3KkWT1gGo/znTyPzogLFygkp
         u9aQlC4yKtH80U2z1+6TCl+UXlNpD7Qijy7IC6FOZQzi0Y3hKAQR8AJeRbi7qoSiKGwg
         yO5Q==
X-Gm-Message-State: AC+VfDzJkIGqwkqdxu9TuFqVp4N6HeDxUob+WxLsclC5r5bO96o7FjGk
        z7JIyTsMxvJcGgIviLMdG6aDiZoba8ZOeq14Wyc=
X-Google-Smtp-Source: ACHHUZ48SjOqD3+l7gehPO9gdGbzzRCAGLT76sqPbKxzQmwJCFloNdvtXR067KL2tfd5rNJYLE4jUmXqGnZi2MROPFg=
X-Received: by 2002:a17:906:dffc:b0:970:553:272c with SMTP id
 lc28-20020a170906dffc00b009700553272cmr214493ejc.27.1686867063160; Thu, 15
 Jun 2023 15:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230615164210.25515-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230615164210.25515-1-andriy.shevchenko@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 16 Jun 2023 00:10:52 +0200
Message-ID: <CAFBinCAJ5m+NTVry56=0AYMYr9xiM9KS7F837Hqb=ptOG_u54g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mtd: rawnand: Remove unused of_gpio.h inclusion
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 6:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The of_gpio.h is not and shouldn't be used in the drivers. Remove it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

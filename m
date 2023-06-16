Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D633E7331D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345154AbjFPNFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245134AbjFPNFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:05:08 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF7D2D77
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:05:07 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b29c972e00so649501a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686920706; x=1689512706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCWwAxyqGz0dxVXdN4x1E9m1cKBoRvQl+WOQKo4Ngkc=;
        b=bRIswQGjLCf4y769A4u1naT+GmdQ7J9gqc/qYPwOG9iZLIg8+p8+TFhbysRY4yLagf
         PCwjS/lmcpP3s6vbvMDu+sUUT2q/SCzff0NyY2je/HimhrKySASex85fx0+NaiDrNxS4
         45yfAbnr1AAciLpEzdK9il8dxT62VDZaOnk/ZKXq3Pyew9zWerTYfvxPravHnsYJHu0Z
         RSd3aDRCdMkm7QzOcd22Svqcr6N7tc/bcLO4vLYlFqUrOROKkPzEfMaCKnzqbJNupmjM
         eVn+ZAb4I6hPa8Hzj2/T924Kog+B9QPc6wqVApa9g9Y3Lqe1Q6lv+OYvx22LuMvt3YMh
         sA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686920706; x=1689512706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCWwAxyqGz0dxVXdN4x1E9m1cKBoRvQl+WOQKo4Ngkc=;
        b=Uim709ZmDkhsWB8Wz+oDIfqcifAtkZVF/Ej4NTfnY7fQzQ0CA9oozXjxokhr5JBIMm
         VOmYdabLEVnC0hdiVWL/SavXBgtsyuWqecMUnFx2qgS+EOcTuMwhOewC/+8AUIFMjrAR
         tKOLiQWZ4Q/smeqwzkerl5nn8NCIRtlW9JTS8psVKyu+AczK1LDzoiKEZClI97R9VDwm
         l0/DSHu0W/a8t7w6NnAhugaVeW0kDNGeL3J6t2IWalE9bcrQeekFP2gWbZr/j9GSLAWo
         FCZriKyW5I2LPfJlcCowQNZRzPAFLyUcqOHbWkG9yMxv5FZJl8Nd3soLIHz9QbcFY3t0
         xXOg==
X-Gm-Message-State: AC+VfDzz7VPek02egsxzbv/6A9+4ACXvsKmlQRZcXYy+Vtj/G4+FvJvV
        XXR/yrHWF7SkGGOfGPB9PCZldmyxVC5vER3LTfhJ2JA0Yf0BBUrb
X-Google-Smtp-Source: ACHHUZ5++cXvffXo4HJKBt1su21q2bNr/RxKNcZzN+Mrk92uq/9o7JMH+fwk3dYR3jVUGdS4GcAQ6LwWi1XJY7iQ3BE=
X-Received: by 2002:a9d:7410:0:b0:6ad:da5d:5357 with SMTP id
 n16-20020a9d7410000000b006adda5d5357mr1789424otk.38.1686920706256; Fri, 16
 Jun 2023 06:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230615164204.25462-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230615164204.25462-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 15:04:55 +0200
Message-ID: <CACRpkdZdLYT8Uoi0CU3cO71dNXOJxWwf0Y72msMnz1ct6pMSCA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: lantiq: Remove unused of_gpio.h inclusion
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Aleksander Jan Bajkowski <olek2@wp.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 6:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The of_gpio.h is not and shouldn't be used in the drivers. Remove it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij

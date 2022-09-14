Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F885B8836
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiINM02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiINM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:26:22 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420547E00E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:26:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z21so21980911edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=k9MKDLx1zeog5ZY0mV9PJDJQBpJXdcAQGVDM+T/iZyE=;
        b=qmVa7tLTdZ4KSZ75NW0cpBFP6z597wc/CMiyEvk9efwFimRXkiKOJsApb1NPN0fmAU
         TJq+WGVYc804vZ2WPTy69v1lUoPgeYJ9AaZbQEWmRiEaH/Ab0htLv0XAQg6qk0lo4I6E
         pKZT3S2Gwmu8UKJm0hC/lhd1AVTUkuroStGzJvifwyT3Hkxxoj9lcD212pohzNmT65AF
         g8p06/eQErClxoxQPNDOes29eo0stZKfRQwgQZpUVOnYxJrdpAP5q9i1JGyLcO83jxqe
         U5/zf3u2XgLeM8BF7FjdozR/chaWFvYzK713aG9z+4RM331mpkXnZ+EBhig7m+VT1vHA
         COfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=k9MKDLx1zeog5ZY0mV9PJDJQBpJXdcAQGVDM+T/iZyE=;
        b=sL0+O88OiLA3EeLw4qZsJ3HQjaDZxY86ErPvuJ/U8pfwWWo+RXX4rjJ7oZ3xTXLWj6
         7bppvpIne5xLqD/E8x+/uY6ZXrdsL9tj3SLUT3H7QDtpXPu6m1HD+mwc8hw/hGHKZZy1
         DU7S2mMwxWrwRiR1DUFf15J8J8vc9/uO6mqw34rXXTwIbeiCrzyIiQtBhQQl462+pjyS
         GphQPM62TWlBPNcTJLeEOgXlxGiJxJT5TmoxUIi3O1Exfae+yIT4uYMRI4i6vI5DbjFp
         4p7IL0gY52stHDC/YuVd9GMtyiQJ7rHqfejY5uLKiFcwy+c+iXhn++MWdfAbTdrK2jii
         Z0GQ==
X-Gm-Message-State: ACgBeo0cZQcAF801IYGyZSs8Z7667YHMT9dMoyUA69pLO/x3ekCakxtV
        8PHuqeXwDr9/J6OYCQ1YX9bZbnGfR5vS+Bt0kRSQcQ==
X-Google-Smtp-Source: AA6agR70V6yk6E7yrt1VsCzInmzb0sjFBZ3tK/GKgE5x8Mfi8c2D6D4XoYotKo71IpJc+WIviIdGGUTxFy3wBbExO1c=
X-Received: by 2002:aa7:c84f:0:b0:446:2bfb:5a63 with SMTP id
 g15-20020aa7c84f000000b004462bfb5a63mr30393705edt.172.1663158374387; Wed, 14
 Sep 2022 05:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220909153802.3370088-1-colin.foster@in-advantage.com>
In-Reply-To: <20220909153802.3370088-1-colin.foster@in-advantage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Sep 2022 14:26:03 +0200
Message-ID: <CACRpkdYmC6wFX2NWmqmWXem-nNMY27nAPv4XDzhmDf21Nx-6TQ@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: ocelot: add help and description information
 to ocelot pinctrl kconfig
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 5:38 PM Colin Foster
<colin.foster@in-advantage.com> wrote:

> Add missed help information and module export name to the Microsemi Ocelot
> and Jaguar2 SoC.
>
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>

Patch applied.

Yours,
Linus Walleij

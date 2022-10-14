Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0EE5FEB8C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJNJ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJNJ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:27:46 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F356C2CE15
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:27:44 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 128so4263416vsz.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cjnW4tf9c8x2Kot+4dsA36tSE1A+nkdrr9pQjeRPHo4=;
        b=e/8Eg6T4sL2d/8ZnDiMjNkRy01w2HUG9WQlOFFimobkyf+lC2UbteN4wD+9hgX5kqL
         YTFyWdsvdUE2puoNRHdJ7gsClx0sb46fqYhuZRG+zQHTIrkRGK6I72RPinw6QqXSiVTg
         2vZbnYUxvOyZxMlvQOTfgU9AfHuTdjGCiZ3+SkuXiNFPEe3WYNqFozCjMt7+70jIcQz/
         ogcbPTHZeq6TGS4OUwFpfW2VcXDYfdv1AcMDryMyK9EI+9haZfQZdr82q5hJD6ZRg+rb
         9rhsPWE0aTRRp7RF/jfDVKcYOqmHrbq066AnWQPTjer+YGaqWEUwmzKqrp6b5edWz4+v
         b/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjnW4tf9c8x2Kot+4dsA36tSE1A+nkdrr9pQjeRPHo4=;
        b=ydI18yMlLt4b8aW9cuSRJnZID+WxrXAaEsPd/3vJvcBrav0jOUTYRiKzcnkCvizTd1
         OoYssX9nxoy/XiVM3Kwjm88F7KUxCH7KK/T4bRob706tage7/nLQZyaFtin8yZY3/ocD
         s0sCZQ+6qhKuglDgMFs7C33JggJ4HHAdd/qKxON8S/JJBJxHmfkae3+GVmOxCwrw7ItD
         e8gnWR+QFim1ou1/BkOtCmA43M/4KDbI9nfSJk78pAVFNZcgu2TJudQPdfct7Yl+gRcF
         Ppoza9zzO43gkZmaS1HXNnZ//E3UlMQ85Of/++CNbvuGA2eitOrHwr2id3Ly6C7zfWci
         aCXA==
X-Gm-Message-State: ACrzQf2XRdnPb6e5PlzYzIhGaEVhL7Q5B+0pGAp9htPsTtcUxiZJjtCQ
        7WF4goIUHPaRwodZ86Mjgv0FoHrP2ilenr6h2GNmhw==
X-Google-Smtp-Source: AMsMyM6cJ+8YudU/hDCymz25EyARZ8r+Qou4Z3HxJ+UPdqodRApASZer9YjNLOs6CCe1LBlOtcI3yHLb/56Zzr4CEZw=
X-Received: by 2002:a67:cb07:0:b0:3a6:f64f:4627 with SMTP id
 b7-20020a67cb07000000b003a6f64f4627mr2269436vsl.47.1665739664146; Fri, 14 Oct
 2022 02:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221013001842.1893243-1-sashal@kernel.org> <20221013001842.1893243-21-sashal@kernel.org>
In-Reply-To: <20221013001842.1893243-21-sashal@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 14 Oct 2022 11:27:33 +0200
Message-ID: <CAMRc=MebwvKv28084YHihnNGYGTz9FEBcDA8EPmsgqoEif6fzg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.19 21/63] gpiolib: of: do not ignore requested
 index when applying quirks
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 2:19 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> [ Upstream commit 98c3c940ea5c3957056717e8b77a91c7d94536ad ]
>
> We should not ignore index passed into of_find_gpio() when handling
> quirks. While in practice this change will not have any effect, it
> will allow consolidate quirk handling.
>

Sasha,

This is not a fix, it's code refactoring. Definitely not stable material.

Bartosz

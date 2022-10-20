Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF4B605E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJTLSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJTLSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:18:01 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869EF1E195C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:18:00 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id e22so8706890uar.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SwRqOKLQj0/Xq8oBlan9WmyUy+o6GvIxuV89KZTsH50=;
        b=ED5hikbDP1RKUt7WEy5mrsr88SOWQGWj+D8HT4vJM7niAKLqfFunDUCRVuKeO0ZNQk
         REfa3oSU8/7VBxNM48i1CbAsupQPnar6wO0aPHEc65/1H1r5lOzYclwIBAf51zrSFCYL
         L2gGBZAD2DImIYqjVwOgPG00kRBWQ9A6i2UheW4tir1kpsrKWMHORhmCg//gtuy5tttG
         6iDiq1aVdmMk3egJnDRpIGkaO9103xuD3sHc2cleMXOV24lTSuHcl0W7AHY64TxWvviO
         IM36GoiI52FsGNjVV4tbV8JJh9HKeUUsUhrPTlw6delMhybwGCeeXZgzMBv5N0DOqGWi
         dD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwRqOKLQj0/Xq8oBlan9WmyUy+o6GvIxuV89KZTsH50=;
        b=B9rm+sTqDGlTbeNZRuSY/6C/S0bjky+Mh2jZoX78Y1uZVqvSlHfoj6bPiBhJKUpjkh
         gC2dIiHeAXzXPfhTUmKmyliJlmndMksdtfSqnrXQ71pS1xnls1a1kGcv49UdvveCRDpj
         ho0xXNucoBmcQh3dQQdsxmgs66dgbA6d9+GqVnG1737UZpwib69falrvPlFwZ+XUrKqg
         20wKz3tiS2lBPIxQ3DG8QrMwZlSEgFI6/aOfkjw/us71aXP+CTxB+WSwmCU9j2lUIBGf
         W6QeLKYhF3twn4tiDLW+NRT3vz9p81uHES8arRZGwGRAPqaA7OPzWJHyMigm2ALZxo9D
         o72A==
X-Gm-Message-State: ACrzQf1NMrl0MNpiOf8ReEDODZsEyuQx+MMqZq9fQjdu39kJhQhHL3mq
        UNTH+WcGiAdDh3wHOL+3ZK/O1ywqtAZBYCgtgusUAQ==
X-Google-Smtp-Source: AMsMyM5rX7qIHDZSvX38KSmq37iD0nlk3DPHuFt6jZ7wVNSqOOAwmL0t+n94gq+v/20iWZ2reKS9ClaNobU92VYg4pQ=
X-Received: by 2002:a67:ac0c:0:b0:3a9:e899:3b9b with SMTP id
 v12-20020a67ac0c000000b003a9e8993b9bmr755932vse.9.1666264678974; Thu, 20 Oct
 2022 04:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-8-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-8-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 13:17:48 +0200
Message-ID: <CAMRc=Mc8vKhB8phH6pwLOo=zdZWMxuCsO=aY_Nj8cG92V6eGyw@mail.gmail.com>
Subject: Re: [PATCH 07/14] input: remove davinci keyboard driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:36 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The dm365evm board was removed, and no other users of this
> device exist.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E930605EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiJTLgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiJTLgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:36:10 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217AB1DC0BC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:36:08 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id x20so8760053ual.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bCXFh9tQMau2zuQ/4jq3bYN0Iw2TJC0EDk+18Y1jkuU=;
        b=QoWSedfdZ0oQyH/XZ5dKVGcVn+6zMlyC/aYPhxzE0T9gdlJGi0SlQPHGzjpwSs/+oa
         XMfTIslQqM13q6AN+Ol1S8tCvwy7N4DLq30ch4wRUgr465De65I5P18TFVvbTrnxsxId
         KFBy6Q+UuU/KL8jvauqQiRkF/clYUKhI42LObnEIXdq0xjXo2VzkrWFr9Wbv1bp3JDDq
         sxn/cOOFJE8dfNgvaj/He0aRCPk/P/GfaCrpHE2o0gKE6ZTHtBhsKa3HzQpAH1437hi6
         sFvz24/D0sIi86+wNISkUBg/KZoQxpcAG7EcSfE+hQrhYQkg1muI5R15L3RH9BPGwzsD
         r6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCXFh9tQMau2zuQ/4jq3bYN0Iw2TJC0EDk+18Y1jkuU=;
        b=SEjUEAb++WaIw4yyYHnTdESLAfoIQcVI6Dj2lXD1ljHel/5C2Af36eOlKwqsUIslB6
         Hc+xsaiUK9oxz0IWhFz1pMwgUrAzHJhOwK78Su/TovIPTvdm0DmhWhz3Ujtfd654hQsP
         0NjVz0L1aqRSVE9Hylzg3xpeBFWqDunDTtVArU/DNMd58UwbMQJWtBMkZt+URErQicvy
         48oN+B7EznZLnMwxJWOjMDNYKYYMDUETB6VhTwrTJRRpP8PWUIM1+c0sBzNE4G7YSnGp
         rOkGCfP7Ymhhdez3OJ9v4nT5tUlla8Qc/1yVwB2R6YuXjULrBVykfaK/CehsD9aRJLYC
         SpKA==
X-Gm-Message-State: ACrzQf2xanrUQehdXI+8WBQngSw/P9uYidAxSAV5iqCTsI+tG1BXG9RX
        4/X0NNp+68KW5drahAhGFygv2es2HPpLv+4U6w1lO0ndTNOz6A==
X-Google-Smtp-Source: AMsMyM4LS7uotw/yDnkng36Pe4R78cFUD1rCxM5aGjUjfbQmaYNVT29n8aO3i9pJSJ5uGNtaV01Y6pj7gVKPC3a/OVA=
X-Received: by 2002:a05:6102:21cf:b0:3a7:d55d:37a2 with SMTP id
 r15-20020a05610221cf00b003a7d55d37a2mr6272955vsg.61.1666265766731; Thu, 20
 Oct 2022 04:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221019144119.3848027-1-arnd@kernel.org> <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-11-arnd@kernel.org>
In-Reply-To: <20221019150410.3851944-11-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 13:35:56 +0200
Message-ID: <CAMRc=McvKnz-oYE0gRA2OBUmOAx4x9K4s_iSABCmgiMYjMQhNw@mail.gmail.com>
Subject: Re: [PATCH 11/17] gpio: remove iop driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Lennert Buytenhek <buytenh@wantstofly.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:14 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The iop32x platform was removed, and its gpio driver is now
> orphaned.
>
> Cc: Lennert Buytenhek <buytenh@wantstofly.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

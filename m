Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8466B94A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjAPIta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjAPIt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:49:28 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C5C12F0C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:49:24 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id 186so23069486vsz.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9sTr6MqALGJwmJjfPYPEonjgpkyKa7ykJkskKcOLsWk=;
        b=xN0HsBRuVS5tnXRE2/5nRcc0Sjbq/htNtt4ZnV0Cx9pS959pEoOXdPsg0WaQ4BqxjX
         Y1UravJcSm5mPjq5Tnn5qMcYlxLTNBim1QVgBSIkIeVas9qv+nyUSejky22C+1qw4gX3
         jIDrQ6y6w785bfC9i8/i5W9z67Ikt538i76ts5jrYHwLRN3WI1WzPhf7A7uGJ1FYOMJC
         AkucKxs+6j6Nvpj9QQp4IJ0N70ee8ZHxNU2NCK3kZ53uxwjuFPWfUItmC7aCjikR4JkV
         Id7IRJ47YRAr9h74X51/9CZx+llgAlk7WobIEMhPEZy3udCw+o1FasqS1BPwguO3AfIX
         VKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sTr6MqALGJwmJjfPYPEonjgpkyKa7ykJkskKcOLsWk=;
        b=wHy/aLOAjz9bIg4ZIlFdgtV1b/rrCNSLfdd9UJ3oIeXbjUyUps5mwRKdnJHjT5PjSF
         n1axZXRa1GE7wmJv+kG435bw7Cqg7/5kolTekZS0KtusdUP+jTwuVvBeWRI99uLb/uDu
         b0KHd58MLzMGavkyV4TnO0OyBpYrftZTyT0AsOqGUlenpzvgWySNNHCt1xFlahnUxdsc
         wwEAxXBvx2KwQNSrvjYLZmB+SMID+CKZd3/gX3dEN5rq3YY1D8s1QDRXt4LmQMPkMXCJ
         lSUG5n1c+TVIFKlY5HTla00ZazCCPJk6gl6aDoo/DGhgK5foRmzl9MBD5Fwr8odQskV5
         4+OQ==
X-Gm-Message-State: AFqh2koXFYXgBEdN3EFBTuYhNtvnDrxZlLbnOu+EyFl+MF+BOYHE9Llc
        LncfEQ6wGphqzO5I12fAQ5bMJt6neXK0cTHdE1hNwA==
X-Google-Smtp-Source: AMrXdXslgwCOWJ6fvGdSvpkTTbdtzJDfLSm7YY/DjKDgjLWdL7Na7meybpGu/6xdHwIj4BqhSi8K9mp63rgtrP+6X00=
X-Received: by 2002:a67:df09:0:b0:3ce:88b3:d7da with SMTP id
 s9-20020a67df09000000b003ce88b3d7damr8031952vsk.62.1673858963982; Mon, 16 Jan
 2023 00:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20230110014943.2196046-1-chunyan.zhang@unisoc.com> <CAAfSe-uNjzZFTpwRG4h=z=+r7SEmrU0iDU+Q2Wx+X4B91FJHpQ@mail.gmail.com>
In-Reply-To: <CAAfSe-uNjzZFTpwRG4h=z=+r7SEmrU0iDU+Q2Wx+X4B91FJHpQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 09:49:13 +0100
Message-ID: <CAMRc=Mes5CpyAb-SdW9pgLaatccyPN0aSWcr6mBxPVyKMZ5fGw@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] Convert Unisoc GPIO bindings to yaml and add
 support for UMS512
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 3:10 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> Hi Bartosz,
>
> Would you please pick this patchset into your tree, if there are no
> more comments?
>
> Thanks,
> Chunyan

Applied, thanks!

Bartosz

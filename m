Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECE862BA98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiKPLBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiKPLAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:00:40 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E83A5F82
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:48:30 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-376596ae449so163621687b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cFR/wt3y9YnCrykafRz+rVN7c4XKPP1zl0PGh6JnSDo=;
        b=DutzTOKABfvo92q4x8MnbkpyKnFoxxoa0UhmPjrGP5ZFsTsTu4f2nD6DCCTGD7GjqI
         vp7eIGnScP2GByzWsqcBG986rqcJ/Lkg92+2VR3MSMcZjUknD2T/3Tjxesfsn0pKeR+k
         ZYGD3nYhiM4JHUNZoTH8YoQtj52m0UDg0xASyHjKN7vs+3lNm8+iIKc2+9GyD5SS7Fq3
         YHfIN3GiOR3Dnslz3UXPCBKj1/Y2Ex0vv5km0+Wg+Iaa0px6wH8MauNeC9V4GjteY1a4
         lzfiQO+QCXILG0gqw+DDBTIX8/gvYKEGIz8dcJ7m5sRLmr+6MlhBJq/uzgvoa1e8lL6q
         TUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFR/wt3y9YnCrykafRz+rVN7c4XKPP1zl0PGh6JnSDo=;
        b=uyQoB5O2vxTNHjtuxN2Ou0cfCuXY+9Tm+/aVgebyDg1OFl6e0o7Yt9gqnifE41vvEc
         klalVZZmFgRd1lLyZq9HsTPYV82kY80oegj0SK7t9FLvjMJJqedEF47MfjxwO0Mj1nOe
         0sqynsZpcLNXcVC6m/5att1dAyDolZAIiyoYlaqvFGfEvY8ZnvdEY8h7Pn3ieT6nCKj9
         qIR7baplevcAJ/8vHgdCNPelup5ox/tbnQPc+P0CFihivEH6Huy2TX5QyQcnBOwgdfPu
         QuoHRCp7nrqE6nAxQnsIpgGC02b5P7PXwSl5KgqHt0kheM6XD4CY/AHExZisQX2XbhHO
         pUyw==
X-Gm-Message-State: ANoB5plGb2g29ppY7j+ccHz/2P+7YTql1TXvIkJTwuRSV0fStRxXNFvy
        QLRNLggypOHI1OQylZFAjvgEmnOH7S1d04tWbAdFd5pyoqw=
X-Google-Smtp-Source: AA0mqf74CBfev4gBgEF3N3/nHSY+NG2PD3H3ybibJa9dDq6RJECBNhl4JBXlz9ArQ0oXnvTU3vjcfvmi6kG7LGL6Cw0=
X-Received: by 2002:a0d:f3c2:0:b0:345:5edc:2193 with SMTP id
 c185-20020a0df3c2000000b003455edc2193mr21154996ywf.481.1668595709498; Wed, 16
 Nov 2022 02:48:29 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 16 Nov 2022 11:48:18 +0100
Message-ID: <CAKXUXMyVFw6cec09+R_sQ5EZLKt+3W3ypucjZCbzYBOyRjC2Yw@mail.gmail.com>
Subject: Thunder Bay architecture still relevant?
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "kenchappa.demakkanavar@intel.com" <kenchappa.demakkanavar@intel.com>
Cc:     urong.zhou@intel.com, kris.pan@linux.intel.com, kris.pan@intel.com,
        mgross@linux.intel.com, mark.gross@intel.com
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

Dear Kenchappa Demakkanavar,

you submitted initial support for a new Intel Movidius SoC code-named
Thunder Bay, along with a number of drivers for that architecture.

The drivers are included in the repository, but refer to the
ARCH_THUNDERBAY support to even enable them.

The last state I see on architecture support is your submission:

https://lore.kernel.org/linux-arm-kernel/1631771898-18702-1-git-send-email-kenchappa.demakkanavar@intel.com/

However, since then there seems nobody further pushing to include this
architecture. Is this architecture still relevant or has it been
abandoned?

If it is abandoned, we should also remove the drivers again as far as
I can tell.


Best regards,

Lukas

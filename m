Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65F76DB532
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDGU31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDGU30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:29:26 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC767AB8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:29:24 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r187so50030247ybr.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680899363;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLc+WQZ4pBRz1wJlw0QROQ2h6J1zrLr4W74FfPyvbAA=;
        b=kVkD1tAYAkElcZ7BBQmywY9yBmG8wdx6sptBjidZFA9QPihppLD0waF4mRqMnxo6+p
         DUivYJsTeIjpyLKD86XYBoKdpP+HCbaaef/zrb8c/L7MMZJyc7FWD9kOFBKSggzGuvLT
         8KzHCdouUAdjksHQz9yW8tjFOLO4lv21TZw21tx8LAXAUBrXMT888h1TdSVTHexTmcSW
         HCSW2N3LOe5qBKq7n3YGnjL1TkgwGeY6OQh4VL4frrslpUEGPn+GTr8NWdVEaOmyqhrz
         c512c4RbbA/S6hjDIyKGWD9HhsORyCfxkeZl4Q75waPJ4IM+DyATWBm+TxLjVDIIjhFz
         b1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680899363;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLc+WQZ4pBRz1wJlw0QROQ2h6J1zrLr4W74FfPyvbAA=;
        b=KcmBZEln5p/3HhinwOYZ8zL/Z2XCJd27Z0O85hfWcS+idsQG2fk61KNXH8Rvj1UIQk
         KtKllgvQNMB+/HxSolBuDQiTC15dbFTbpcw8qWYq4qm6ZTo20lnC50+WF6jlfO4U7lwP
         88fzMnxRVMn81dfnB/q95+n3c9Ufju73+NObt0zHbzJh6LIaNMl5oHQgnMKw6XBifKQ6
         00uCggJDXVFyaaaREfk6zGnjuha2VEBvX+uJ8sKj8UJ9md9lF8/L+tPT2y2N0z+8HT00
         lW1cKT8IplrNgU/hc+JtLZaZo7saibReN3XKTUoa4/4UzXnEDc95fsZUPz6unG+WSzuI
         ASvA==
X-Gm-Message-State: AAQBX9cc4x98q2pYN9zepKCS4sEz2UEoBMHWAQRpIYRDSxUhWFlX7AWZ
        gVZG6mZazuSsMzjLF7IVX0AduaZLlHX9czK/I54=
X-Google-Smtp-Source: AKy350a8vunwg36H5T9oo47qWv3UVGxH+cKE68blFoScSj/t7R6o8KVq7YXkTMJnomxSbbj8xTfFuhGAnaW0WlvSyHw=
X-Received: by 2002:a25:d4c8:0:b0:b8a:7b2d:6555 with SMTP id
 m191-20020a25d4c8000000b00b8a7b2d6555mr2479257ybf.9.1680899363394; Fri, 07
 Apr 2023 13:29:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7011:c145:b0:340:5ecc:5364 with HTTP; Fri, 7 Apr 2023
 13:29:20 -0700 (PDT)
Reply-To: johnenaomi@outlook.com
From:   Naomi Johen <ms.monamohammed1200@gmail.com>
Date:   Fri, 7 Apr 2023 20:29:20 +0000
Message-ID: <CALgCNKwovsGDUUDTjTncA9CJz68XU15+qpRaYnLMJSuDnJP14A@mail.gmail.com>
Subject: For humanitarian
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear beloved,

I can't believe that i have this opportunity to support you in your
humanitarian bid. I have severally tried to reach you but in vain. My
names are Mrs. Naomi Johen, 68 and I a citizen of Grenada. I lived in
Philippines for years where i did my missionary work. All i need from
you is your details to transfer my total account balance to you to
strengthen you in your charity services to humanity. I have long
resigned because of my health issues.
i am writing to you from my sick bed by the help of a little girl around me.

i would like to hear from you how you have been projecting with the
charity services in your area.

Respond to me very quickly for my health is not promising.

I am waiting for your quick reply.

Yours faithfully,
Naomi Johen.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36506C9474
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjCZNSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCZNSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:18:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E711715
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:18:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id le6so5988778plb.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679836721;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4kD9nrOfHv/ywfhs8TxTy/DfyfeOSiLEybcrvT0DeU=;
        b=ogjzQxhaTtRl9ED1hbkgNRKGp/mIqgr+MISrrhqozPDGd5pADv3y66KY1vVHh9OhVz
         FfBVsJhHMOQWO7ACYHeSHIxecxmLNlKYGKt5p7O8S51L+lXKhB9sLq7pNFIQR+aIZGg6
         wgcVGA1fysAoElbrW+AELorEMZEOhtN8n8RqgIucXcZ92Xa2XnJoiKZ+N7j7m73KriqV
         2u/okyn61LQWr6p77lHVbZXMGs96k60fb67QQuoOQCaueE//pjS2iKkdZyf0dimTfRQ/
         gADAHSd07tWoon3R5xpmJ2BM/U/SsdX/rguJqadiwtZgok/uow/wpzpXfDOBuJffRiah
         5CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679836721;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4kD9nrOfHv/ywfhs8TxTy/DfyfeOSiLEybcrvT0DeU=;
        b=wlr+AWajD7lfuukHLZhjj21tuL8hIY6KwYCvd1N6/Nes1ubFdHkHC3B7FyJOZThlmQ
         g1UZykXYn+vN6662MsxkciwfiUUU6sogobU9lIXGksP1fyMEWPFxpbdDkpNZjOAzK9/a
         4qQtPzbb0C/9XzWBNkyxRc/tXrQ1IIGiTP+4afSL1rm9qAxbixvfRGkjVFD83FJpmTNH
         V5CGEJtaOjq9onJNkjhSB/ECWFUZQN51UuuppcoEGO8dJiKLYWnVGv0wO92P5o9ac4YH
         uNFk7/Mh3xasAUfc4rE0UcaouNVWPG5Yu+3HETHM3RcORgOsTkZHUbWsvu0bF1/6Jfjc
         lhvQ==
X-Gm-Message-State: AAQBX9eeuK1SGYNOEYpxi/WIm3rPNJXG1+k2UIqEQCwi2SL8D+vWodtd
        6n+3U4bF3aUrIJqRyIZYKNqqwokiVHguL8UHdA4=
X-Google-Smtp-Source: AKy350bbSYlbBpSKpyFmdEFlyhLf55fcpNq59JYLIP9kFDoYi8FayFAEEAXj4OcicNhw+lzdp8N+ASl56EPb7RxMnzM=
X-Received: by 2002:a17:902:ac86:b0:19a:6b55:a44d with SMTP id
 h6-20020a170902ac8600b0019a6b55a44dmr5725950plr.1.1679836721323; Sun, 26 Mar
 2023 06:18:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:a80e:b0:415:eb6e:2b79 with HTTP; Sun, 26 Mar 2023
 06:18:40 -0700 (PDT)
Reply-To: samuelkelliner@gmail.com
From:   Samuel <idelphonse.aissy.apmterminals@gmail.com>
Date:   Sun, 26 Mar 2023 14:18:40 +0100
Message-ID: <CAH6fHsZxfonfbDWcXzOkRoKKecqF_RLHmXBXDmbDNnc=hQOYWg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I am aware that the Internet has become very unsafe, but
considering the situation I have no option than to seek for foreign
partnership through this medium.I will not disclose my Identity until
I am fully convinced you are the right person for this business deal.
I have access to very vital information that can be used to move a
huge amount of money to a secured account outside United Kingdom. Full
details/modalities will be disclosed on your expression of Interest to
partner with me. I am open for negotiation importantly the funds to be
transferred have nothing to do with drugs, terrorism or Money
laundering. Thanks for your anticipated corporation.
Regards, Samuel.

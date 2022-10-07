Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE355F7A8D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJGPan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJGPak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:30:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A455E64B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:30:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j4so7928834lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuiVOYBuSRdCoq6JBgsradlYkyFOVbPZ4RSHU4bESXU=;
        b=S7J5cv5ZQR3AiTkEJFpB/rXSL+ffDHKKXt9BlxzAIbOP8w18332i4PtAoHE4DF/x60
         Fv87NWKyWbYnhfji976bxToUYnQaz3TphiDRM+fclcbBGirMCTp4V+GFer4635UzwP6d
         WmFTUs7gAk/H8121eWKBnS0BNm4KhgjRkdVlrPFzZObxrAap9raKjaurnsyMtv9IokFy
         3V9Ujeyu6YrGh9kdpWguVvGZhqFKrmnSfRfii52pLXhM81RtpM5uUCe2rxPSw0IrqVqN
         1OrNXo0iUKNi9j1/vze5M9tAVdO3rYFtnf9X7FOg4ISpqRZJ5IqSBE7+ldnK5pV/2PUS
         WX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuiVOYBuSRdCoq6JBgsradlYkyFOVbPZ4RSHU4bESXU=;
        b=Ng0H+1Y2CPgbdK6NZBO5OTJS5K3JxgsYwMEwLFC7FrqbS3izlhdn4PcYqnxhZFRs1d
         aDWtoLkoGEG6CDbOyCuUsnDuQ8x+0npQrGQCZszUGYFzLCf1aZyu2oM9jF8SH9f/KFum
         Hl3f7ccLIpZOMEaazBcu1fi7KTX0Lr1VpS/pMPJ1JkXO1Vjp7FauEtVzW50VRhciKFSH
         0FJxyeDKhePhkcPU9vktxnoqa5CjRuPZ3To8BKCIDUWGzGAdxhBRCKaUk3Zu0XQ9VuO9
         q0PMBNJ7Mx7ECU/aAttyjXATeW3woXNxvjBbt+EVVv7F4QIf9Zt9AMvFLrr/LpN1tTYe
         6I2w==
X-Gm-Message-State: ACrzQf32u11DkH0XRAxmhrHm5eLzHVcnUTXnzgaEDoCv0pWU6vlx9Zws
        f9uXWmWAl0L7b5qIfmdiIm6HbR2c2lw27VL2uVo=
X-Google-Smtp-Source: AMsMyM4MYRu7IQs/a9kO7Dryt61BgQCOlGOn1S69SgfwIOXfzGJvPq2Ld5Mk6YwphzYfexKidqTfvmAXlOh2eDfAJ/4=
X-Received: by 2002:ac2:47e1:0:b0:4a2:40e5:781a with SMTP id
 b1-20020ac247e1000000b004a240e5781amr1948052lfp.335.1665156637664; Fri, 07
 Oct 2022 08:30:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9a:70ca:0:b0:225:e6d6:7fd2 with HTTP; Fri, 7 Oct 2022
 08:30:36 -0700 (PDT)
Reply-To: kaylamanthey7733@gmail.com
From:   Kayla Manthey <so3001131@gmail.com>
Date:   Fri, 7 Oct 2022 15:30:36 +0000
Message-ID: <CACJLTOaaCZy_u2nAJ+wP172i3UaTmzsVhbzPx_q7VQGw3K8zFQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4902]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [so3001131[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [so3001131[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kaylamanthey7733[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:136 listed in]
        [list.dnswl.org]
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, My name is Kayla Manthey, please reply me back

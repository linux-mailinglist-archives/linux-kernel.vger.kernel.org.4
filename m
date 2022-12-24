Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1A7655839
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 04:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiLXDW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 22:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiLXDW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 22:22:27 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A98BE07
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 19:22:26 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id s22so6743102ljp.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 19:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Moofvsiw7pCLd/J+epglhRewKUHmwjb7RNvZ1kqwNy8=;
        b=hWrozN/dlVVJ7nvUzSCDTflz00fxERzXQSDK2/irFIGMt2pgB1OANkKhh4f5ToidR1
         tgLXmoDyFff+zD+F3TwWF9PipEvw4xROtkopZQFOuGRw5eaK2PLuJEIOX09TxD0yVNWK
         IQ1riayYnk17a8A8TiCYA8jas33U8VQ9sVH7HKWodtuVE7g8x/Avt6hW5wj9cbGpeLYU
         jDHKr3cyo+ZBwa8i6FktVOADgyG7Kz0u9D5q/oJpMtVtY/Rzt7gyodOPbSND6+jqZsXc
         LVJi8YQpry19IImqeYslSP6gZYXiDivY/R893XejViC0ldxNPlGLXNQe7zRbd45LwN9M
         ymDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Moofvsiw7pCLd/J+epglhRewKUHmwjb7RNvZ1kqwNy8=;
        b=OPggdrQlC7pnmiU1y/Bo28/r2ZpwoJxiZ8aWvTOaHGYzyLkOYE3yvMo3J42BFP732r
         oaYNBLJ2PqN7Xhpkw94zvNz6bDIVRZ/VeGHAxFpwxOBSGDIj0sGibTXS8gluDdsd+xx0
         qk8ouhaW0aUMUifzJuhbP4TLHI0qdmRpvAgqMM+mjWT4yo0Pm0HDgY2hH064cv9Cbtd6
         KTxk0lUcz7DGctDfWGsizCb1ePeQevWz8QfhpvXQI6HI7MdWh7ZVy2vaT4ycH2al5en/
         UzrqGpXmU+pGbtkETtC8GJcx3BUbgB41yCFi4j2Zi1CXOMGT8Y8AA9Wm7/aDrwGLw6sw
         S2hA==
X-Gm-Message-State: AFqh2kpCa2NQFCpsGB5fLM6WsqsCQfP08J8BYu1iB70fqDwNEJgNOczW
        ER/v40TMVK3tdtcUMtXvqnmhIKdd1/2+YFrqsqg=
X-Google-Smtp-Source: AMrXdXtNBQckQn6vry8rv9LAkrZr6tIYzEHaBKNo54Hma6tqN9CsV/xmirATUs+rL3blx102b9bHb5rVC1CHSQHPN6w=
X-Received: by 2002:a2e:2a41:0:b0:27f:b519:33a3 with SMTP id
 q62-20020a2e2a41000000b0027fb51933a3mr115970ljq.225.1671852144917; Fri, 23
 Dec 2022 19:22:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab2:4c10:0:b0:179:b502:80e1 with HTTP; Fri, 23 Dec 2022
 19:22:24 -0800 (PST)
Reply-To: korblgeorg1000@gmail.com
From:   Korbl Georg <gs8763177@gmail.com>
Date:   Sat, 24 Dec 2022 03:22:24 +0000
Message-ID: <CAJXL-s-xeP7o6Z77_ERS7zS5U8VFZ2K1U2i89f71ribsOen1eA@mail.gmail.com>
Subject: =?UTF-8?B?Ly8vLy8vLy8vLy8v6rW/642w7J20LA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7J2464+E7KO87J2Y7KCBIOyngOybkCDsnpHsl4Ug7ZSE66Gc7KCd7Yq47JeQIOuMgO2VtCDsoJzq
sIAg7J207YuAIOyghOyXkCDrs7Trgrgg66mU7Iuc7KeA66W8IOuwm+ycvOyFqOuKlOyngCDslYzq
s6Ag7Iu27Iq164uI64ukLg0K

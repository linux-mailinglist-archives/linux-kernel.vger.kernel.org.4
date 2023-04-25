Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0BE6EE215
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbjDYMpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjDYMpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:45:32 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25ECD307
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1682426719; bh=nwrv+FTl9Z30CBHNh9Viy2EMWijwUXnZBpXvdSxeKaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RlYHHPpry1tcRW++kuMdT3R33TyERVYAx+cE9x49Lz3+qGXG612izzAB8mnDiM7j2
         cAh7Mu/md8q9wQNaMGrt+hzYOkyS9+ELfbFU1LVpyHMt7F+NyqmWFnTdjKWLGLVjuW
         ACzyow2P6hvXkUeQXHMw5pJj105gkAPUZlit2MAI=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id B42AA6DE; Tue, 25 Apr 2023 20:45:02 +0800
X-QQ-mid: xmsmtpt1682426702tnajkdbja
Message-ID: <tencent_2451ED25C705DC8A18A290EEC6373E344107@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/LAcuiDQ/3C4t3AsD+E24+X5IsV39QQuYR4YjVHEiY8aUzcQGdQ
         y7rfI+QuFHWwsEWPiyv+EyT+dZngY5T13qR5k/LKIrqU73zYQktPhSob6bWE19isVJWzo/r6Krev
         mGqImZ4CzGsfq1FfpAmhvgUQgD9fzvow9nmKogary9jrKTimTpHnMD4kTt9BoT+Q8j7EsyioOPlA
         Riydp2siRxA8Ftsmdh90LjQQKPBrDN0eiuYp84Qyc5FQmKy8QxXcombCIDSy2Qv5+PgeC4J6MqlM
         VD8kme2yovflI4EWr0b4LkR/mIoS1iWaL18+DMpDJjo3SPQVwpNjSE1/DLkXMKv8r9whXsaO3pxu
         MMdUurhY0EwFkqkNJkAoXMmndLaZ1VjMf/OSQ1NkQg+eKxj3fYXcVtLK+16bRHyRabu4vl30IMBP
         U9qq/t8s1QTlFOOMM0NAXaFsrEkdd2oTlnNwXDw8glOW6x+98NMOihYIOBsLllNMy55ZehW7ZMoT
         +VgZ7DyGqtZB0g1VZPQeMXyNBhDqjHblo/sFtXa/JvL2n2EG04Se044WL06bjkZRZF/GZkS5caSG
         /hawxG3vfZsOGeEvU47Nze9gWrGjtxcmPauP4MPa8II5ywp1Z3Me6aw1mLaKRcAsSVazmNYDKf7z
         v4F+pDF9xuIf43iHim7mGgaxM07sQXoXg942u1SzZt6za1CFVO7feI7z5uHWdOwKMhk1M0U6AFJt
         t5Gt11j4isDS4YMwk8PGmeI48GiGWVYisxraFcBHKKXV1+r5pM/uGZ6r42GFO6ykthkmCdVe4+ou
         0872cZmhBwxI5mgJeBqO/Uv/Kef8P+X1Q03KUUEi2/uO35Jj72aHTeneNR5mmEsCGDkZ2RIKnuEc
         w/9pjZ5+Zpwgx7CvkIXW/511kVl/c4A8muPxbM62ai79yNkdNC0LvfcK3rNJghvEefuN8VMZcPgu
         7vH7GNpehSxxG3jztBKuff4pIFn8xm65Kgqwe4pcBYh1icTnC4OW1kkMaawLGWBj/BRnHydYk=
From:   Yangyu Chen <cyy@cyyself.name>
To:     cyy@cyyself.name
Cc:     aou@eecs.berkeley.edu, i@zenithal.me, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, soha@lohu.info, twd2.me@gmail.com
Subject: Re: [PATCH 1/2] riscv: allow case-insensitive ISA string parsing
Date:   Tue, 25 Apr 2023 20:45:00 +0800
X-OQ-MSGID: <20230425124500.194036-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <tencent_63090269FF399AE30AC774848C344EF2F10A@qq.com>
References: <tencent_63090269FF399AE30AC774848C344EF2F10A@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cover letter is at:

https://lore.kernel.org/linux-riscv/tencent_1647475C9618C390BEC601BE2CC1206D0C07@qq.com/


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D59E6C3043
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjCULWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjCULW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:22:27 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482582311A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:21:54 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p204so5467738ybc.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1679397711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+KqRWhaDx1aJoI/pna5di6cHpQDQbH5Dv0l0ZgDy3g=;
        b=KVoWmCl3lAefXbSjr1XFa+Pxr15fcLxSACIYq0vUNsPKheJwN9PLuMYI4g/xhAjlJR
         v5jPl4mNRlohMGFK3j609Jd1v1JyoCHAGE8WkQQir9p+3GVucIAu8ajbJPbJJzf9oW5i
         f3VlU0/OrWyyNLnaKLuJr/QQ4ZmnEnZCIWWmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679397711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+KqRWhaDx1aJoI/pna5di6cHpQDQbH5Dv0l0ZgDy3g=;
        b=pM+/MRokx/wpdIsiVM5sepqB7Agtc5xgh0Hl1tTRDHXsoUQBA16hxVcDuLyVv/uyje
         Cl9jvcfDs1vWVsm59wxJs8dzTXNrx1/EiW8DdHTIBJcbEkRNF4KsMoQNkX1KfQ1g3wmV
         mUx4glHIsfSYtTO0h1zyXkZQ8UNFferUv9uSveTwPQOM7Wvzo2Kg9tW+svtg2u+wn+ZB
         Q4cb+EeTBU3guGlKQlkEU37BikRwsVGnockDq3I/9Kq/WDBPj/A3KfPPGB31JJrjivNp
         9PcUJ5U8SUWrl0yVePWqzv9Ud55lv+o0urc+s0oBpE2bICsmU1CDHGpqGcMuwsDtjceD
         CdMg==
X-Gm-Message-State: AAQBX9ddVJl26iqg9byOlE73wtVpkvrugjxU5E1dJPqE+SK2yVUA/Y6+
        FVmjtKzw5PTkoBe6+htvlgU1r4viqD806EHOaij9Tg==
X-Google-Smtp-Source: AKy350aGC8yl/vUvR9z4Vm7doUX9SkLJ6MUp8qgSDNHNEIcIwszPmP7Z6Gr3qL15c7ncubDyIJlOLnYGFNkZU0VIB/s=
X-Received: by 2002:a05:6902:283:b0:b6e:d788:eba7 with SMTP id
 v3-20020a056902028300b00b6ed788eba7mr1159105ybh.6.1679397710763; Tue, 21 Mar
 2023 04:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230321033810.22017-1-lukas.bulwahn@gmail.com>
 <CAFr9PXmKsequA3V7QWC2fKQYZgaNRj+q3q=UOBLmg6wxYKiVYg@mail.gmail.com> <59c05b36-3370-4d7b-b8cc-39d6dc36cdd0@app.fastmail.com>
In-Reply-To: <59c05b36-3370-4d7b-b8cc-39d6dc36cdd0@app.fastmail.com>
From:   Daniel Palmer <daniel@thingy.jp>
Date:   Tue, 21 Mar 2023 20:21:40 +0900
Message-ID: <CAFr9PX=5Xj63Fm2nRa8oPdXbrkKOMG7D1Y_EV361HtYjs7GZaQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: mstar: remove unused config MACH_MERCURY
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Romain Perier <romain.perier@gmail.com>,
        Russell King <linux@armlinux.org.uk>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, 21 Mar 2023 at 18:30, Arnd Bergmann <arnd@arndb.de> wrote:
> I'd still prefer removing it now and only bringing it
> back when you actually add the code for it.

Fair enough. Code does exist for it in my tree but I never got around
to sending it.

I rescind my nak.

Cheers,

Daniel

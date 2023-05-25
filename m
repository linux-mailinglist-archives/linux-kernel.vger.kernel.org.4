Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31307710A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbjEYK6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjEYK6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:58:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58D590
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:58:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30a4ebbda56so1931547f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685012282; x=1687604282;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SO7fo8JR0JgUwQ4sGqr+PljsK8P9mCfplN8lTjQzrJ0=;
        b=e7q56MwK10dnbe14VS0WCenwtdz8OwwOAnJXE9a/GmxQpqTw06eJolLAu2qNDU4pny
         2iMb4+hBSXHK2Jlohbb/1OocR7wUIgxypYV6QOMcUR3MVilzkxii64OwjYYZ+FxUchhc
         ubbqdpR2c8WS6Xu1YbuGt68aEJkFSzrieSmnjCADXhbDbJQt4dNKKPc35oW/MjqVLK0V
         tfH+oYX3GPTS0hHUWzwe/IpAkLW0/mu9kZILGqeU8tcZk0DTBuYj1RO44W9+eCHuoPRu
         77BQhesmH52LvB6JNy8eH7s+JZqRnonTW4Z4+dJLtDywFOndiv8h/eq0L/aFeji071T4
         mJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685012282; x=1687604282;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SO7fo8JR0JgUwQ4sGqr+PljsK8P9mCfplN8lTjQzrJ0=;
        b=A4gf0xJ4eeQqHng25ZNpgzyaoBr/It/88YIp9a9jL+yCjq2i6HJEB69mYd21vTvS2c
         ntphFYaAHbL7jSCwUYIe1MfxNrw6IL/IZVFRd0Ef8JwQXC74ExJmay6G1adrN0KrErtg
         9Ku6OMhaHzLAa49YQq1uS05Ja5VDkH4KsJvwFKolD4Xegm+2vqNCKjQj0mMtF/sksPQp
         k/Ql++z/6mbYSYsTGVqEQe1Pd7/CxCm3eRQ7I6QLLuUIPMbVpjkk91TeiDWX6yt6qUqS
         HasVsJuvc+78TsvArXoCJqIM5BJbWJWA0WEtBHVSQZ1R90cZD+Whsug9xOeeJmHRE+l5
         nuhQ==
X-Gm-Message-State: AC+VfDwu6GCoSy7vbqFulpYhw/c/ViXPIwYNunvGc9mSWqzfvZdnVaDz
        Ux8l7alQgTvAn41JpIzvSoHHN+dFG5/Z6lcKoII=
X-Google-Smtp-Source: ACHHUZ5Nk4tCPJCRtw2U+ezjOfPbNPqgTRGiK1Br3JDmpPgnRTeVQO5lZlddjkOats23UXTTCcsXqh+Mu9mZNy4puZg=
X-Received: by 2002:a5d:6a87:0:b0:309:4e08:3f23 with SMTP id
 s7-20020a5d6a87000000b003094e083f23mr1991954wru.57.1685012282093; Thu, 25 May
 2023 03:58:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:dfc9:0:b0:309:5847:8888 with HTTP; Thu, 25 May 2023
 03:58:01 -0700 (PDT)
Reply-To: orlandomoris56@gmail.com
From:   orlando moris <jamesjackie917@gmail.com>
Date:   Thu, 25 May 2023 10:58:01 +0000
Message-ID: <CAEbr-eqtYV5LB7QzUm5hRauybim6ie59ZjJ+h-fYCaA23+WcVg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2YXYsdit2KjZi9inINiMINmK2LHYrNmJINin2YTYudmE2YUg2KPZhiDZh9iw2Kcg2KfZhNio2LHZ
itivINin2YTYpdmE2YPYqtix2YjZhtmKINin2YTYsNmKINmI2LXZhCDYpdmE2Ykg2LXZhtiv2YjZ
giDYp9mE2KjYsdmK2K8NCtin2YTYrtin2LUg2KjZgyDZhNmK2LMg2K7Yt9ijINmI2YTZg9mGINiq
2YUg2KrZiNis2YrZh9mHINil2YTZitmDINiu2LXZiti12YvYpyDZhNmE2YbYuNixINmB2YrZhy4g
2YPZhdit2KfZhdmKINmE2K/ZiiDYudix2LYNCig3LjUwMC4wMDAuMDAg2K/ZiNmE2KfYsSDYo9mF
2LHZitmD2YopINiq2LHZg9mHINmF2YjZg9mE2Yog2KfZhNix2KfYrdmEINiMINmI2KfZhNiw2Yog
2YLYp9mFINio2YLYtSDZhtmB2LMNCtin2YTYtNmK2KEg2KfZhNin2LPZhSDYp9mE2KPYrtmK2LEg
2YXYudmDINiMINmE2YLYryDYudmF2YQg2YjYudin2LQg2YfZhtinINmB2Yog2YTZiNmF2Yog2KrZ
iNi62Ygg2YLYqNmEINmI2YHYp9iq2YcNCtin2YTZhdij2LPYp9mI2YrYqSDZhdi5INi52KfYptmE
2KrZhyDZgdmKINit2KfYr9irINiz2YrYp9ix2Kkg2Iwg2YjYo9mG2Kcg2KPYqti12YQg2KjZgyDZ
g9ij2YLYsdioINij2YLYp9ix2KjZhy4g2K3YqtmJDQrYqtiq2YXZg9mGINmF2YYg2KfYs9iq2YTY
p9mFINin2YTYo9mF2YjYp9mEINi52YbYryDYp9mE2YXYt9in2YTYqNipLiDYudmE2Ykg2LHYr9mD
INin2YTYs9ix2YrYuSDYs9ij2KjZhNi62YMg2LfYsdmK2YLYqSDYudmF2YQNCtmH2LDZhyDYp9mE
2LXZgdmC2Kkg2Iwg2KfYqti12YQg2KjZiiDYudmE2Ykg2LHYs9in2KbZhCDYp9mE2KjYsdmK2K8g
2KfZhNil2YTZg9iq2LHZiNmG2Yog2YfYsNmHDQoob3JsYW5kb21vcmlzNTZAZ21haWwuY29tKQ0K

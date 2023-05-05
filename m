Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176076F88C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjEESmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjEESme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:42:34 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC0DA260
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:42:31 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-390723f815fso723126b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683312151; x=1685904151;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cpy7HUUl9JUJVfHeyZRx3CTbUVGObKlyKlmgTELiasw=;
        b=Qfb9+z3QIhNt+ogmQ+GuhN8GGMk/OA1S+5vqgkL3VVbB7UNWCGKiJRpDR3LYxgT/ZA
         bvBA88JQTrrWCH2XcC8eRJsqqWdwOsvV4B4iLyppf25AKfD74+kXFwPKR64hwjdW0T9N
         qyKZWsfgzw4RztcumCmJNfstGpIM+hdVP7DxbAeKoDie73zlfb5AAMag56DtLXUc+pYI
         5RVQko8dyfVe54BHru209ZjETqnbYKFi9VrrboYl5JCcaEKEE0AG9AdXYvojwDrd1IBw
         z54UEWNO6ZSCYn7rSaPrSn0tZnvxDe3Ikhb7/xXiquaI1WDWJauDuBtuAmJsqPFzUbDA
         eN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312151; x=1685904151;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpy7HUUl9JUJVfHeyZRx3CTbUVGObKlyKlmgTELiasw=;
        b=FwrFfwavH8jnd+os+q686im6mxDe9H7I4y6aPX6ILNrLeJ5pM8s4TRXH0MO/wZ0r3c
         W75Bii2N1jwl+FYnpWTMgBVFbvn3V1cyYgKW9HQEFcbk8UbPmLpNFIB4nz/MUjYmTnw4
         sIV74oi4ivs8W80nvhlTlMVddlb/VpjZ1msbgpilfaXe/XUZk7mTJ9EDrG1VWeyAqAUU
         l52emoui7H4IhSLA/1xY+epxy5iAsbm6POswm8PJE3TLrMR+0w3swdDHg4A3tNGMgrqH
         zgo60EMNmzspBRjU1xsCNqj/XJ/t6n84g7hvHQqFsTqPNCKRKjlXwEYvBBvln0vy2r/+
         6AmA==
X-Gm-Message-State: AC+VfDzzI6U605EVhgFqphwMgN8i3UZrpQmGG/D6XmoWHnIMagY6sDi1
        DjPgyQaU9K1MwXtSkqRhOiM1AIaPKIZOS4gMEj8=
X-Google-Smtp-Source: ACHHUZ7nBP/87TlvNAjdoFwX8dyf3uSgVvecZozAzhUPia9xvrH/Hvuyvgc4IwVU3Zy1yqrtTAOKB4fJ8ioTJFcwqOQ=
X-Received: by 2002:aca:90e:0:b0:38d:fa2c:b9ea with SMTP id
 14-20020aca090e000000b0038dfa2cb9eamr943524oij.47.1683312150969; Fri, 05 May
 2023 11:42:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6108:0:b0:4d0:480f:94e1 with HTTP; Fri, 5 May 2023
 11:42:29 -0700 (PDT)
Reply-To: philipsjohnsongoodp@gmail.com
From:   philips <robertandersonhappy1@gmail.com>
Date:   Fri, 5 May 2023 20:42:29 +0200
Message-ID: <CAGRoA83qadXEkkWOTjYKn4k2zLN51JGOrTge6pcBgTWmU8skrQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsDQrQnNC10L3RjyDQt9C+0LLRg9GCINCR0LDRgC7QpNC4
0LvQuNC/0YEg0JTQttC+0L3RgdC+0L0sINGPINCw0LTQstC+0LrQsNGCINC4INGH0LDRgdGC0L3R
i9C5DQrQvNC10L3QtdC00LbQtdGAINC/0L4g0YDQsNCx0L7RgtC1INGBINC60LvQuNC10L3RgtCw
0LzQuCDQvNC+0LXQvNGDINC/0L7QutC+0LnQvdC+0LzRgyDQutC70LjQtdC90YLRgy4g0JIgMjAx
NyDQs9C+0LTRgw0K0LzQvtC5INC60LvQuNC10L3RgiDQv9C+INC40LzQtdC90LgNCtCc0LjRgdGC
0LXRgCDQmtCw0YDQu9C+0YEsINGPINGB0LLRj9C30LDQu9GB0Y8g0YEg0LLQsNC80Lgg0L/QviDR
gtC+0Lkg0L/RgNC40YfQuNC90LUsINGH0YLQviDQstGLDQrQvdC+0YHQuNGC0Ywg0L7QtNC90YMg
0YTQsNC80LjQu9C40Y4g0YEg0L/QvtC60L7QudC90YvQvCwg0Lgg0Y8g0LzQvtCz0YMg0L/RgNC1
0LTRgdGC0LDQstC40YLRjCDQstCw0YEg0LrQsNC6DQrQsdC10L3QtdGE0LjRhtC40LDRgCDQuCDQ
sdC70LjQttCw0LnRiNC40Lkg0YDQvtC00YHRgtCy0LXQvdC90LjQuiDRgdGA0LXQtNGB0YLQsiDQ
vNC+0LXQs9C+INC/0L7QutC+0LnQvdC+0LPQviDQutC70LjQtdC90YLQsCwg0YLQvtCz0LTQsCDQ
stGLDQrQstGL0YHRgtGD0L/QuNGC0Ywg0LIg0LrQsNGH0LXRgdGC0LLQtSDQtdCz0L4g0LHQu9C4
0LbQsNC50YjQtdCz0L4g0YDQvtC00YHRgtCy0LXQvdC90LjQutCwINC4INC/0L7RgtGA0LXQsdC+
0LLQsNGC0YwNCtGB0YDQtdC00YHRgtCy0LAuINC+0YHRgtCw0LLQu9GP0YLRjCDQvdCw0LvQuNGH
0L3Ri9C1DQrQvdCw0YHQu9C10LTRgdGC0LLQviDRgdC10LzQuCDQvNC40LvQu9C40L7QvdC+0LIg
0L/Rj9GC0LjRgdC+0YIg0YLRi9GB0Y/RhyDQodC+0LXQtNC40L3QtdC90L3Ri9GFINCo0YLQsNGC
0L7Qsg0K0JTQvtC70LvQsNGA0L7QsiAoNyA1MDAgMDAwLDAwINC00L7Qu9C70LDRgNC+0LIg0KHQ
qNCQKS4g0JzQvtC5INC/0L7QutC+0LnQvdGL0Lkg0LrQu9C40LXQvdGCINC4INC30LDQutCw0LTR
i9GH0L3Ri9C5DQrQtNGA0YPQsyDQstGL0YDQvtGBINCyDQrCq9CU0L7QvCDQsdC10Lcg0LzQsNGC
0LXRgNC4wrsuINCjINC90LXQs9C+INC90LUg0LHRi9C70L4g0L3QuCDRgdC10LzRjNC4LCDQvdC4
INCx0LXQvdC10YTQuNGG0LjQsNGA0LAsINC90Lgg0YHQu9C10LTRg9GO0YnQtdCz0L4NCtGA0L7Q
tNGB0YLQstC10L3QvdC40LrQvtCyINCyINC90LDRgdC70LXQtNGB0YLQstC+INCh0YDQtdC00YHR
gtCy0LAg0L7RgdGC0LDQstC70LXQvdGLINCyINCx0LDQvdC60LUuDQrQktGLINC00L7Qu9C20L3R
iyDRgdCy0Y/Qt9Cw0YLRjNGB0Y8g0YHQviDQvNC90L7QuSDRh9C10YDQtdC3INC80L7QuSDQu9C4
0YfQvdGL0Lkg0LDQtNGA0LXRgSDRjdC70LXQutGC0YDQvtC90L3QvtC5INC/0L7Rh9GC0Ys6DQpw
aGlsaXBzam9obnNvbmdvb2RwQGdtYWlsLmNvbQ0K0KEg0L3QsNC40LvRg9GH0YjQuNC80Lgg0L/Q
vtC20LXQu9Cw0L3QuNGP0LzQuCwNCtCR0LDRgC4g0KTQuNC70LjQv9GBINCU0LbQvtC90YHQvtC9
DQo=

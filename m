Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1046B644222
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiLFL2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiLFL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:28:42 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD292DDA;
        Tue,  6 Dec 2022 03:28:41 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so23003046wrh.7;
        Tue, 06 Dec 2022 03:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZygCRQ1Dg3l/MqYYmt2oFaYwy1M9Isk1FWgtgtscaJw=;
        b=RIzC/lR+jPw3BuMTBca+kDYOV6oE6l0uPIleJXL8YkM0/y02seLQTrDw96yvkoRr3D
         r7+e7gHEKgQ3sxHWyJ+7XAu669sbB/FAjHl8QFeb+Uoio858KrzEfteonEvd/hrhMa5l
         IST1UvbBARcwJcQFN1KWd3vwHD7HOx/Q91Xg4Oe9Q1zDOYQqHCnUZJJcjZxvkDGUnwnt
         g84LvvT86Jz+hEkrj3sEhdyVXcvAB6+NEEsn+Xs02ks/twjGLIb1jyH2yCA39rmM9C49
         ElSZVjaBGLuNlN1JfxCv35uJwuFHsFAEpSNGThPuskhuRE4BkmfgkZ1tRq6ieYVflY2M
         Xj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZygCRQ1Dg3l/MqYYmt2oFaYwy1M9Isk1FWgtgtscaJw=;
        b=ygGEtQSA0R/U5brYGSwTiNdi65HZqSoK6QvkpH6Ag4XO2iR8LsyrlaC69Txloqn033
         NTWZPKlfMBAORptHfkzYZVjOxF1qSrISJZbVAh8OViXAAY2ZnkkA5Zt9dAIf+nL5V30S
         htgDKilIGLIsOIPSZuBh849VKg+GjQsSPkyN3IkDOrTdsglFmWO+ew6mQTDDVBZdMW23
         xHNoxygwEdepeNJlHFYn0AwcKgmQYMd2lONk8Fjblc12Qb1L8tGbkrKS8sCekVa96PeS
         jLfYzqlZtzyCeE+7GEsOVdcEzMaen1vgwOH+amvdy8i49TugrI2uBAwtfvKkqhxKmB2B
         QRAA==
X-Gm-Message-State: ANoB5pkWXYcbQ4tI7jKA/puDjJtL8ekUFtI9voOAqlp36A0ed3TJaORZ
        MZAlu/yuBfxlcA+PL9++TAs=
X-Google-Smtp-Source: AA0mqf7ZCHpY/LNHi75NDhWXSSDU/bJXmPtQrkwIwqTi6/4uQMNfX2U971iDJipazGxIlhZWMAQ0lw==
X-Received: by 2002:a5d:6d84:0:b0:242:4ba2:312c with SMTP id l4-20020a5d6d84000000b002424ba2312cmr9600363wrs.406.1670326120264;
        Tue, 06 Dec 2022 03:28:40 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.13.177])
        by smtp.gmail.com with ESMTPSA id m126-20020a1c2684000000b003d1d5a83b2esm4913686wmm.35.2022.12.06.03.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:28:39 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: [RFC PATCH 0/1] CCF 64-bit transition
Date:   Tue,  6 Dec 2022 13:28:26 +0200
Message-Id: <20221206112827.115674-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this as an RFC to get input from the maintainers, since I doubt
this is in a state to be accepted right away and it has not been thoroughly
tested.

Internally, we've been using a simpler way of scaling the clocks for both
providers and consumers, but it doesn't fit too well in the CCF.

Making the switch to 64-bit integers in the CCF would let us upstream more
of our drivers without needing a 64-bit system.

I've thought of some ways to improve this or make the transition easier,
but I need input before moving onto implementing them.

a)

Add a _32 suffix to the old API, and move the clk.h and clk-provider.h
headers to clk-internal.h and clk-provider-internal.h.

Add new clk.h and clk-provider.h headers that include the
clk-internal.h and clk-provider-internal.h header, and use macros to alias
the _32 suffixed API to the old unsuffixed names.

Add new clk-64.h and clk-provider-64.h headers that include the
clk-internal.h and clk-provider-internal.h header, and use macros to alias
the _64 suffixed API to the old unsuffixed names.

Drivers could transition to the 64-bit API by simply swapping the headers
that they include (and, obviously, testing). Code changes will still be
necessary to swap long for u64, but at least the API interaction will be
kept as close as possible.

b)

Introduce a clk_rate_t type. In case we will ever need to change the
definition again, it will be easier. I have no good ideas for a naming
scheme for the new API that will make use of this new type.

Cosmin Tanislav (1):
  clk: core: use 64-bit integers

 drivers/clk/clk.c            | 564 +++++++++++++++++++++++++++--------
 include/linux/clk-provider.h |  90 ++++++
 include/linux/clk.h          |  44 +++
 3 files changed, 578 insertions(+), 120 deletions(-)

-- 
2.38.1


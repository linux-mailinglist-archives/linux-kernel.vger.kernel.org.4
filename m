Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A595F639B73
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 15:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiK0Osp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 09:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiK0Osi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 09:48:38 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA0CF58F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:48:37 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id n1so5718085ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BT171Unjb6EFvUBvn33Ts5USHKYTfqzQFkQsCflakoA=;
        b=ksaDiADiHYUwyECmaFvDzycpKpe9Xd5WJW+hjLSdxUt7x1AgLVaQ2LAvbvADQy26xA
         yPSzlXO7l2F+c3nwbjKuRsai9iHNZSCJedxrampb59vvfhiV3Hv32UBiQhzq1s9IuVer
         ZFNnzJp7A79KSzjIpqwf5ad/GgyewraNFFFEXpV+HDz7x13Fo2xhG0QZIrRWyWcbARJA
         1XR//uhlyS0x3bLxFwP97usLpXBbuwOVv0HtkpJMxLL0+eTs26gJWHdhh9RczSpB/31B
         b4BzzDE/EwCGbMbo9Eb5vTdjz/p0kO7EP9WNJI+gZf6n8y/t590iliEMKJkV6pVxHLLE
         RoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BT171Unjb6EFvUBvn33Ts5USHKYTfqzQFkQsCflakoA=;
        b=ZHWFw0ooqES/MZVA9d9M4WNY4a/LgM6OPTjqTGFfTlK4f3VXTyesflYYE/V/yu2tvy
         ottELytBcDysP8bRiOMyx9iKtI5bfZfcdI4VxC7vYcvjtvv+c+IWtT8+Bw38N62IFNm+
         5Whsl5+iqD64yFu3JdKwq3Sxy/6YC1mxBMs0D4Seb0crZAYzlNJinnpQMdBEBfSvgO0K
         tUIDH8xl6Zn6fyDqzt0RWTZPOncKPpJB2mf/5YS29yV44Km0T3MgkE9oLMRXwBus63KH
         NavuVXJISgpZAVpT+R1doykP3BnTbwZ2MGbStAyqaEERSMOO8Ly6nqV1Ggc8Mx1GxZfk
         mZTA==
X-Gm-Message-State: ANoB5pmCXuEAu6umNl0wDkKGVe2m2nDPBzCsl1s1U9QfFckDmR4na/4l
        zo+I2uW0TRNyJA9LDZMy1h3CZsGR+mto2LwacKY=
X-Google-Smtp-Source: AA0mqf7LWtnvfWBknIx0eTYFZ2ojCNrosyqsqQznes507f9XwC/ZsbL1Hl+LFJFeoSvbyKDx3Pq5eMvGl4Fr0Y8hOw0=
X-Received: by 2002:a2e:9194:0:b0:279:7ffa:15aa with SMTP id
 f20-20020a2e9194000000b002797ffa15aamr5827142ljg.307.1669560515762; Sun, 27
 Nov 2022 06:48:35 -0800 (PST)
MIME-Version: 1.0
Sender: mohammedaahil30@gmail.com
Received: by 2002:a05:6504:28e:0:0:0:0 with HTTP; Sun, 27 Nov 2022 06:48:35
 -0800 (PST)
From:   H mimi m <mimih6474@gmail.com>
Date:   Sun, 27 Nov 2022 14:48:35 +0000
X-Google-Sender-Auth: gYWnCTEBcNrhxjy2J-gWsCV371g
Message-ID: <CALoWANjJkmQS0dc8=kvMCJfLRWf5QcHbLgAZGm54nFopNnabDQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you are interested to use the sum US$9,500,000.00 to help the
orphans around the world and invest it in your country, kindly get
back to me for more information
Warm
Regards,
Mrs.MIMI HASSAN  ABDUL MOHAMMAD

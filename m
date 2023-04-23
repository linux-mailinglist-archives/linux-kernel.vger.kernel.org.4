Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC8B6EBD08
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 06:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjDWEj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 00:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWEjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 00:39:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E73F1FEF;
        Sat, 22 Apr 2023 21:39:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a6c5acf6ccso27222675ad.3;
        Sat, 22 Apr 2023 21:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682224793; x=1684816793;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fug1lkQDsd/4pG0Kl+R0OjPHKl0FqLKys4fWUvpIg4=;
        b=Obd83rOOSRFvCBkbW3J78ZPaQTu8y5AOPr9rr7T7cQjlc+jNNiYCDllVHTrqIvc/ej
         B5yn1pk3iwNCIsBNTXSO7QhNUQrPQNUTpYARxac6enWIwQfrqAwrSw2MsJlNs1+YrXKu
         ODJA/5n0OKBXGGZb1J5Hbf6GLTeNXYwOWbMR5e38w4JsSfU8i7KQKEYl31s12AqbzKLo
         UvGbkUTYuNTuFgI1GQq6a89sD0kkJJSsKf6gEBy9H8Rbcdj0IhN4KF5GlmU1vZnY5BIN
         uGIDPhSTAgBpNcjFaNuNHUNZkeSrL6wSQ2ktVa2h+PpcZ9fgGpBVJ8/O5NXw0BygQ9h3
         gUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682224793; x=1684816793;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fug1lkQDsd/4pG0Kl+R0OjPHKl0FqLKys4fWUvpIg4=;
        b=j8W8CDWW/DqBi8n0DC+Wk7fX8KkRyztl4JlKd2K1Mpx2msZbeqZrkRDHKvT7P/UNy5
         kG5Q9nWUPz026mboxLM7MO2uYJxCHBVAElGU85cT+OkxSFaqJ7auKETPRcXhiHgkYwpo
         kSZEUWwvhNd3hKdh5J4WNKOBFq+QAB/G/xnVFRz95K22Mu/Ej09Vo5WqVA4LKt4R08MQ
         fCHnC1OlwWVvKtBJrUZ7lN1NPNaj6u2R/+4N1Sirzkj5lQ6LG9Q8jsGPdFy7utmmdtTg
         9U5HSpD19U3ttHlewypl8r1DB4ilEu5pgzNgOd+O45yh0Iy0kwb8hE/QbvYWaEVosQqB
         3QEA==
X-Gm-Message-State: AAQBX9e7AITeHXzxTzBnum586bxm1uUNucGu9kgUMRjO1IB6EUX/zeLJ
        S14ZfEmTJZhKRaxPJfYsEo8=
X-Google-Smtp-Source: AKy350aSzO3scQu49GgTNk5Ec0b0XCjp7vanVCP66Nw6OTgmugq6DXMN3d3hdSN6a7wa4Ex171cglg==
X-Received: by 2002:a17:902:d48b:b0:1a6:5fa2:aa50 with SMTP id c11-20020a170902d48b00b001a65fa2aa50mr14180984plg.1.1682224792847;
        Sat, 22 Apr 2023 21:39:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:2d1d:e178:e71:7059])
        by smtp.gmail.com with ESMTPSA id jf15-20020a170903268f00b001a076568da9sm4603919plb.216.2023.04.22.21.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 21:39:52 -0700 (PDT)
Date:   Sat, 22 Apr 2023 21:39:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.3-rc7
Message-ID: <ZES2ldRn0nqkf9v2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.3-rc7

to receive updates for the input subsystem. You will get 2 fixes:

- a check in pegasus-notetaker driver to validate the type of pipe
  when probing a new device

- a fix for Cypress touch controller to correctly parse maximum
  number of touches.

Changelog:
---------

Soumya Negi (1):
      Input: pegasus-notetaker - check pipe type when probing

hrdl (1):
      Input: cyttsp5 - fix sensing configuration data structure

Diffstat:
--------

 drivers/input/tablet/pegasus_notetaker.c | 6 ++++++
 drivers/input/touchscreen/cyttsp5.c      | 1 +
 2 files changed, 7 insertions(+)

Thanks.


-- 
Dmitry

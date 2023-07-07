Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB574B61E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 20:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjGGSMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 14:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGSMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:12:32 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169282121
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 11:12:31 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1b0156a1c49so2047365fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688753550; x=1691345550;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7v0tPqJO4vwiAF5qdaRAlywXBoGchtoeb729wwVvaGM=;
        b=A55TkEqhBPkQbZI4wZOjVwbtRxRynrPlUQmPufiOZxhdUZWnG5q3CLrfxhdspP//ar
         jrh0L0fzCSbx9oC9DpddVsve+rSuE0U99hC9DIvUcGUAIpr+wmfSCMF43iK2B58BJoh5
         Sqg4adrjHmcX4w5GwKdGyYRYiNeAuMn0L9Mdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688753550; x=1691345550;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7v0tPqJO4vwiAF5qdaRAlywXBoGchtoeb729wwVvaGM=;
        b=aI+q6EWXzTsx56MKhxlTsK7XHIjNKIqiGbyrGFQRdi81XDWHzW1iq9p3NJYKwhr6cb
         bUqYG8NLilK+zMfsVPJyd1RwuhT59zfMwD6SZUTcfntDoQHbDZ/MgFk+JmFRmIAEdRSA
         iJTDjmrR8V3n7TIwoRwyqbf9EPnS1S0ht1IIBoOybup5iyxvhVOJ/SJoUpAwt8gF/7aY
         JdMDe+UvS3L3nmt+HiplNAYMzKj/NCC7+WP0muyQaf97n1aXkv5FTx+ntRSBU5H20pKK
         RDxF+ulPFFST9Y/c4grKst4MgM1fZBpIJ4DJEK2dq1JJpmMA0gP+XFeXttsnzAjrzwu/
         ExCg==
X-Gm-Message-State: ABy/qLabu5wGiup7knQkHIisuWgKWtBfE0XGr61I6KqEtvz35UMMeeMD
        HA56HVug+2mS7ZkJNSjJal/YOg==
X-Google-Smtp-Source: APBJJlHGiCf/N85G9MXUCC4vgfH30Uw4vy4FHZuZ/03S7Hsqu3z67Vn50Dd0c+hl0c1GOS8wp5rOyw==
X-Received: by 2002:a05:6870:5254:b0:1b0:4fc5:2e4b with SMTP id o20-20020a056870525400b001b04fc52e4bmr6901497oai.9.1688753550334;
        Fri, 07 Jul 2023 11:12:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090a138500b00256b67208b1sm1794403pja.56.2023.07.07.11.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 11:12:29 -0700 (PDT)
Date:   Fri, 7 Jul 2023 11:12:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [GIT PULL] hardening updates for v6.5-rc1-fixes
Message-ID: <202307071111.63B0BFB323@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these handful of kernel hardening fixes for v6.5-rc1.

Thanks!

-Kees

The following changes since commit acf15e07eb06507c69f92394c36052677029b0a8:

  netfilter: ipset: Replace strlcpy with strscpy (2023-06-20 13:35:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.5-rc1-fixes

for you to fetch changes up to 01f23c5f1526f5b6ff744887aa511b9e69d4401b:

  usb: ch9: Replace bmSublinkSpeedAttr 1-element array with flexible array (2023-07-05 14:11:30 -0700)

----------------------------------------------------------------
hardening fixes for v6.5-rc1

- Check for NULL bdev in LoadPin (Matthias Kaehlcke)

- Revert unwanted KUnit FORTIFY build default

- Fix 1-element array causing boot warnings with xhci-hub

----------------------------------------------------------------
Kees Cook (2):
      Revert "fortify: Allow KUnit test to build without FORTIFY"
      usb: ch9: Replace bmSublinkSpeedAttr 1-element array with flexible array

Matthias Kaehlcke (1):
      dm: verity-loadpin: Add NULL pointer check for 'bdev' parameter

 drivers/md/dm-verity-loadpin.c |  3 +++
 include/uapi/linux/usb/ch9.h   |  6 +++++-
 lib/Kconfig.debug              |  2 +-
 lib/fortify_kunit.c            | 14 --------------
 4 files changed, 9 insertions(+), 16 deletions(-)

-- 
Kees Cook

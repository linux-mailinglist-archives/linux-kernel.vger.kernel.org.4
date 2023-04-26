Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001876EF9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjDZSJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDZSJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:09:09 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AB6768A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:09:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso6204376b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682532548; x=1685124548;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rB7TrgpgMvPpUBvkzZSfHid5q5DXZuUqCvFD8o/k1UQ=;
        b=igu0pLC496enXqUhbMrk9WttvT3AxS0fpVH6YsByipaGO5IC2j1lhTV5To9nPgdpMq
         +w1ZaaYLNUoNPyURrxuuEsuCkwhIu74O6YjszT+6JeLHIycrl1u2FxiHBKqybQjZ9sLy
         0SfBjG8Y+wweQwJF6rCKvxIUwQY9VOYDtLrIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682532548; x=1685124548;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rB7TrgpgMvPpUBvkzZSfHid5q5DXZuUqCvFD8o/k1UQ=;
        b=kA/Y3ezK2Q3cgFRN7QJVInqw+7pdQQgPHV9ASCI4Dyjz780gIcL37Wyfm+wC3AsvZY
         UzFb3qGTsUL9ctkydE4nftJ0TL/7JuW3rMeIP/qAhFymdPO5bUFb19WVaIj0QygCHGNP
         f7WPE/GLZkIhbbC8IeBFe60/jHWyJkWJPoCbPwVNPfffPn76sS9as14WKVHILe2bb7rY
         qejHKbgm4w3jgvld0ZpIYxSAnZPWl1uAP9XWNLGwkKK5U1Qg/BMVb0Vbwu0e0s4M0BBM
         9ZKtuTwTxuzZs8bwfoSklpcTkSQr661Bu+PkjGG+mfn5CwYqIqBSjCtKPZzz9kz/3ryr
         m13Q==
X-Gm-Message-State: AAQBX9fet1JLUXjodPvCZTeOLtJrGs7H7XIoVEiVOIKg7eoLBUmjrYD2
        qTqeIFdYZ2WdtBqdrPhkEwet8g==
X-Google-Smtp-Source: AKy350ZN9oXuJwWpvxAg/36+cV37aXwP9dN2Om8Y4i/HhbJDY/g1iGSDQwNePXTFagDvYCTq//fS7Q==
X-Received: by 2002:a05:6a20:42a2:b0:eb:c48b:d11d with SMTP id o34-20020a056a2042a200b000ebc48bd11dmr27930827pzj.30.1682532548028;
        Wed, 26 Apr 2023 11:09:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i21-20020a056a00225500b0063b8f33cb81sm11923525pfu.93.2023.04.26.11.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:09:07 -0700 (PDT)
Message-ID: <644968c3.050a0220.78a9e.7d6f@mx.google.com>
X-Google-Original-Message-ID: <202304261108.@keescook>
Date:   Wed, 26 Apr 2023 11:09:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] hardening update for v6.4-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this tiny kernel hardening update for v6.4-rc1.

Thanks!

-Kees

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.4-rc1

for you to fetch changes up to b69edab47f1da8edd8e7bfdf8c70f51a2a5d89fb:

  kheaders: Use array declaration instead of char (2023-03-24 20:10:59 -0700)

----------------------------------------------------------------
hardening update for v6.4-rc1

- Fix kheaders array declaration to avoid tripping FORTIFY_SOURCE

----------------------------------------------------------------
Kees Cook (1):
      kheaders: Use array declaration instead of char

 kernel/kheaders.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
Kees Cook

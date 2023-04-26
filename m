Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772906EFBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbjDZUiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjDZUis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:38:48 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC9193
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 13:38:47 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7512da2d994so30928085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682541527; x=1685133527;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JL3yT3Q33W5/BCQtgOVvz2cK4S2v0dqNTi6RS5aes9g=;
        b=aQncxVJNwweVJ4SoWMB7rELbKOfurvS0I6a0zdM1lrhvVqDZQrrDJMUSzZx3Mptof3
         hHxIYNlCbQlhXnRols5xLtFBeLyrpj6DfzYNlc9Hsb9k1gXalzT2MqlI1DBA6fIkWiKW
         ER8grA2PjkjxeiBTq0L7UwE0ojGol+apccBNY0KfZDYwa8rTkHC7s11Ut7dIW1eXKwKP
         0YS0j6qaAJYt9wll9BLk9mUu1dI4h1gfUM9/hcFaTCeNTBXzp815JwrKM7UY/hMLsCln
         yAfdswepq5XMkBZLwVpMmdAs51vX2I/E951uG4nQK9vr01+TvECEE03zp16GHYygvDWp
         pNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682541527; x=1685133527;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JL3yT3Q33W5/BCQtgOVvz2cK4S2v0dqNTi6RS5aes9g=;
        b=C9bIqY6o3V4ihdzTL2D++qM6pAF2ZPwn8YrrE+tqHICtXzkppu524Hb9NofNEz+KHA
         DcNaSGTH7/EO7eF9uA6fzs6ldykr3AFQdR6lYOTCss1kGDO+NB/3Ofqmf+6v//uw/0RJ
         4HuTmvA2omBHxHp/X9ENatAKLiLza26Z5Ynnrj1XZ5RG8AEWJdjK0Xzo/q7V9sKxmPka
         cXult+3GEDvRWA1EazJGuC0nBbhfBAseq2FkIZiIhm1RScT2i3b6JS2FqkDQ4YOh3ffT
         S1z+nSUnLNha1f5DTGZeWhdfEtBrrQYnhfgGCxA9EJzRWGxeL8w1s1VjtKYApDZQlFC+
         EEFw==
X-Gm-Message-State: AAQBX9eMzb1OkEpYYHVKN8cD7Yjb7G+MLft22BvjlP4fXipfI3lDUk9H
        8tQ9oZQJAfadIbC/hdbJlYSzkPGLiPwnscHRz4A=
X-Google-Smtp-Source: AKy350avQLaHMkkF6qL1LVTEP9H9bMoxSZVvF85IqbMOhtT/FX0dRM+i/Z9E7B05dTaexba8pMSIzpq3MsDHM6i2/YQ=
X-Received: by 2002:ac8:4e42:0:b0:3f0:a5a5:cb86 with SMTP id
 e2-20020ac84e42000000b003f0a5a5cb86mr19221155qtw.49.1682541526885; Wed, 26
 Apr 2023 13:38:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:1391:b0:3b8:6d45:da15 with HTTP; Wed, 26 Apr 2023
 13:38:46 -0700 (PDT)
Reply-To: klassoumark@gmail.com
From:   Mark Klassou <georgerown101@gmail.com>
Date:   Wed, 26 Apr 2023 20:38:46 +0000
Message-ID: <CAHmBb7sqUDFqCE6zxoS5WJGh+OjUOZSh34QxCoAhUGC45PXVeQ@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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

Good Morning,

I was only wondering if you got my previous email? I have been trying
to reach you by email. Kindly get back to me swiftly, it is very
important.

Yours faithfully
Mark Klassou.

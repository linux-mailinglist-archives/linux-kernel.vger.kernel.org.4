Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910006E1EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDNIuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDNIuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:50:18 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32683ED
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:50:17 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y35so3317557ljq.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681462215; x=1684054215;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBgMMuS3S+nXOdAGD5zD1EDLkW0bCURYfUeSPB7KubA=;
        b=NLYUJk99xU7r+pN765ipnQaG9lLkDyKe2RnXwtoLkmjGso7R3e/NxcaXy8LcK6kz27
         +m/8FenyJM2vQpPB1abepGwVOI46En6kV28VWp8tQWGp+eA0kcrhhqMimA4/vE5PWwgW
         sygDw/9TcMatp3hCa3afnKBKNgRWE3JZ1o7z6yN9LJFXneQppT1AkzZzOV3tj0qkND1m
         unNh3Y3MwTis4R1Gg7wO4aYDpDQBkffCa/xThX98NuiGY9Q1Z75ys0eyIxGKDnuW64fD
         W8FKpwnqkYTgLoCSoFeKNvGO4BpP2+mWBC4kWrzk7NSO+t16h4/BrjN5M/ukfu88iQs0
         9m7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681462215; x=1684054215;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBgMMuS3S+nXOdAGD5zD1EDLkW0bCURYfUeSPB7KubA=;
        b=FQJCIjH2goAF31cWdTZWQW083HixNi0FvmItnkv0to77Ol+5xn3EdT28/BB23ldyA7
         idbpZ68E9iuh4NFc1Rb8QY3FDDW8JKDyC3w66596tl14/a/72FnlJZLeBIQ8x4ZR3pOo
         2iDkTW3z3CnJn/RMiFueYg45jB5CErp3kclGkMajXQGD4+0N7M+2Y7AE7CCP+2fR0Ki8
         qPo6tVc91mR3xo2COKXKLOGm8L6kkz/cDCVVuTYkZlCG2oicyUzhAR0p7EcwoSuWT3tA
         LsDlHa73dKuA/btC310pquXavVdbGt1WdEHW7wsoQMZWvHy7H7nR+NKwYtO7gMq7B6wd
         AECQ==
X-Gm-Message-State: AAQBX9fjyMED/kRHUO9xrGEEzQqbAW9htsLoUrZxR3Dvgc5bt7rd+KS9
        NXkI9WkKx/hT7g0cLDJ0wpS4TONkm/kIgh4bV/4=
X-Google-Smtp-Source: AKy350bxpJ+021dTXfi1qOpBlTlt6o6tJgcHIgRJydnBxiQ0AIbQGMiAnX2RI6WJT2jeCY6ia3SGXFJt/yKfnNgGm+8=
X-Received: by 2002:a2e:864d:0:b0:299:9de5:2f0f with SMTP id
 i13-20020a2e864d000000b002999de52f0fmr1688145ljj.5.1681462215379; Fri, 14 Apr
 2023 01:50:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:6a03:0:b0:2a7:9cf6:c181 with HTTP; Fri, 14 Apr 2023
 01:50:14 -0700 (PDT)
Reply-To: mrskumarprince@gmail.com
From:   Aisha Gaddafi <koolboy5528@gmail.com>
Date:   Fri, 14 Apr 2023 08:50:14 +0000
Message-ID: <CA+hg5UNj2tJBW=vQyb12Mu=5Dth2+7YgEjJtJ+0JTefdaG+hWg@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am Ms, Aiisha,,I am currently residing in
one of the African Countries, unfortunately as a refugee..I need your
assistance please.

Best Regard
Mrs.Aisha

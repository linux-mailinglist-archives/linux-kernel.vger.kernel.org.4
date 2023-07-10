Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0F674DC69
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjGJR0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGJR0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:26:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD51E40
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:25:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c6dd0e46a52so4016893276.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689009899; x=1691601899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFtR5Yswn2zIsqAIyfzUxYZ7lIpXaSTx1psXxqq1XD8=;
        b=Yvz/elt/8HhORKMK799Ibn1sDr2Dq9plYlzqq+7JfZAwP/Ecu8JGjv0uk42yktW3X0
         gb2jmQPf5M4psBXrzLoRyZlX10c2mBsSm+Nit4smH1P5gSG8etQu6lLokNXyrBPGddaS
         zgzzamsGCJvpEwO0qkj4EXb9FIzAW4i3rjcfgR5swd1DGVVisKo31MuHjExEJgXsqIex
         W9ldSnv8iw+zeZrGEiqUhs2evRsqWk206i5cFLYa+x8EscJTdlQWmSnu0r4NadwLJBFT
         kIOv0et6JH2aTtJG1CJGYEHJv8nCkwCL0jS2DSnp4bggZv4PF/QFvry4rfo46QjjnohM
         3png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689009899; x=1691601899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFtR5Yswn2zIsqAIyfzUxYZ7lIpXaSTx1psXxqq1XD8=;
        b=A+nVMCe+MBO+clvm4JXWl3tVY75eW2ru94yDZn24D8fJFmK8S50UZCxWBWU08LoOM9
         n2EOmJ7dgihW7OQ1X1y4/52Qyt3hW5d9Rw8ubYh7KBdjmeXH9Dikin3eL3vFpuS3UUw0
         iSgIqetA17jQvLNSxL9//e9aZC3c8cKsBeS8soYo4+IfOKTiwgJnma4XjMJGkilJ/6Uv
         4ahS+mb70xcF7YtAueHTXvHuuB7KYOMWE9c5s21KZY+kQSGrMHLiijRJHsvMDfaV6Fvy
         w5sZ4RKQvTPjJuN6Ii9o7HUGhDjqYfhzyUkz9qkDPlYlT9sMnnk4U6wCDIaG1puMzTp0
         rYGg==
X-Gm-Message-State: ABy/qLZb+HsSyu9pYcEo1QK/gb73wyedQW2IVDSpjQpWMq2PlAu4Dvgj
        uzjQ7xNS8DxpM6OI+mFrjEWkhik=
X-Google-Smtp-Source: APBJJlEEa2VOrjsQ01outn5Z4Dad68mUZLHGeqsd4BArFPiF9L06bVj/vezdwfgcbq3nUgkeriQMIb0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:508:b0:c4b:6ed6:6147 with SMTP id
 x8-20020a056902050800b00c4b6ed66147mr116654ybs.9.1689009898868; Mon, 10 Jul
 2023 10:24:58 -0700 (PDT)
Date:   Mon, 10 Jul 2023 10:24:57 -0700
In-Reply-To: <20230710055614.1030300-1-sanpeqf@gmail.com>
Mime-Version: 1.0
References: <20230710055614.1030300-1-sanpeqf@gmail.com>
Message-ID: <ZKw+6edWZJoSPGdn@google.com>
Subject: Re: [PATCH v2 2/2] libbpf: fix some typo of hashmap init
From:   Stanislav Fomichev <sdf@google.com>
To:     John Sanpe <sanpeqf@gmail.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, John Sanpe wrote:
> Remove the whole HASHMAP_INIT. It's not used anywhere in libbpf.
> 
> Signed-off-by: John Sanpe <sanpeqf@gmail.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Doesn't look like it was ever used.

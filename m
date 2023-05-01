Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD96F2F2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 09:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjEAHdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 03:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAHdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 03:33:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6E510C8
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 00:33:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id ffacd0b85a97d-2f55ffdbaedso1206433f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 00:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682926414; x=1685518414;
        h=content-transfer-encoding:mime-version:to:from:subject:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SgMjSBvdzaObeAnWhYrU3ZmuYaRXvdwgdpGSJuGm824=;
        b=qXqJNof+MILjl70ddxlEhYKuFFoW3s1GodXIq/KSUgNSwiVTggzlijrTrNHv7PeTGo
         e21uQdAEKU0vYACwVF5+8Lekht0zleVMPzG3KGFI+0mmYralmCgib/2RzpNVpg7IDE6h
         T7+YTuxywRYIXYyF5ktZgk1R9eDqi7Gjvj2h6T92SrgaUHZsjtmVNi3PfT/nOYqbqK3Y
         VqKQbQQSWxUU+nhsThVMOdg6WLkvyyiHbyrNYMH2VK79jz8jPLzyoDk2FrXKRZ1lqxMC
         libmtVYDd9uf1R9K7A7/iJW0v2mcwixR6jt7VbH4/WCLml2J9aoPjyYRlLmWZ3ptQ937
         ftJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682926414; x=1685518414;
        h=content-transfer-encoding:mime-version:to:from:subject:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgMjSBvdzaObeAnWhYrU3ZmuYaRXvdwgdpGSJuGm824=;
        b=Nzj4zbP21RWSZYpFL9+LRgN1gxXeBIDumkSaOdewjltsoaP3hY5rvDBxT2KZcsav8p
         FsHbJdrtg9oYFFWSCMQKItIg+6iV3/2fXkabQaWsO/uXVWHZh9IOavycyuA7veXeXRnK
         9Uwyh2Elkmq3BoVuKgUDy0WPXmPTmMvnPDGz6AqX7WCC+BxTsZ3TQF3Zdc8W3mcHjXGT
         l5Ea6FSGfxQNxu3dtwgDQq9PD1VJFBko58FBxS5Hrn6m+PSgtGAjO8b9ARXeH4bCfWoP
         c7sQPYyIvnYYAWs3R1kCb7DMaYmP/ylDKiM7R5vvDiTMDqXu++tBHnCyPJcbgf6n10iF
         4qHQ==
X-Gm-Message-State: AC+VfDyFP3cmXPqOAgFFih/eZluIyGHAdW/eQfz5Xw1p7T5mQDmfROID
        UY2pT9GvxSFcVlwib7bM4bWgHnTs+E18uQ==
X-Google-Smtp-Source: ACHHUZ5kPd+ytltde/7j/3QgKnRpMCyWkQzPikuKr3k5uynGvXTbwdtvwOzKODZrQq+mtbgt2fzISQ==
X-Received: by 2002:adf:ec09:0:b0:2d5:39d:514f with SMTP id x9-20020adfec09000000b002d5039d514fmr9935567wrn.65.1682926414238;
        Mon, 01 May 2023 00:33:34 -0700 (PDT)
Received: from [127.0.0.1] (91.141.57.120.wireless.dyn.drei.com. [91.141.57.120])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b002c8476dde7asm27415212wrx.114.2023.05.01.00.33.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2023 00:33:33 -0700 (PDT)
Message-ID: <608edaad1f2b3dfc9b2ac7c6026a430c@swift.generated>
Date:   Mon, 01 May 2023 09:33:30 +0200
Subject: Re: mediacomputer.de
From:   Frank Beck <frankbeck487@gmail.com>
To:     "" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mediacomputer.de steht in K=C3=BCrze zur Verf=C3=BCgung, h=C3=A4tten Sie In=
teresse daran?
Falls Sie weitere Informationen ben=C3=B6tigen, freue ich =
mich auf Ihre Nachricht.

Noch eine erfolgreiche Woche

Frank Beck=



_________________________________________________________

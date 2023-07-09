Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF83674C141
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 08:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjGIGQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 02:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjGIGQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 02:16:44 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A08EE4D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 23:16:43 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5701e8f2b79so42754257b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688883402; x=1691475402;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmlwvXEoimVTfsyyyYai0GQlqo3zzXGhdH5Gfvmx5TY=;
        b=Bp5MLvKPSk5zMbAC/lttAdgyhC6wqBrx20Zr6vebn+/0U+fjSDRgD/l9Z5tUmJ67TZ
         vtzfcWzCq9eFkMP1wm+iNthhOOTdTMAUfemY994pc1Vcsk4/nHlq8vIM1LCGXMdPOrUB
         U21MpugVWLPMpmOSYigcx5pHCVVItOA+ZqUaxPGgfysELso1+wGqj5Wnp62wcEm71XOm
         jOBl38WhtzxvBwD6cak1rDdOdkhOBhT4JC7yK2jyZ/IDmbDwPOivr0BGiSqOgEtQettM
         pmH+KLXC9g90nw9aDDvE8KlonfY/glvE4j5x+XvvndwhZJNCtombGtVRls7GTt5eWP3J
         39bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688883402; x=1691475402;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmlwvXEoimVTfsyyyYai0GQlqo3zzXGhdH5Gfvmx5TY=;
        b=g+TFAsA/ADBgC/YCoZJ2UCjM233SvjgvW8EEd+70ZjiUtjcWpmjDZ+4EeYXmWFapUP
         JYt98LoR5vtBYSHAVeBUjzK+mqiJjWQUyoPpU5AGf/RECpiN61QnY4BEV+X9fQfSH8a2
         +yUP8tb5U/r4efaO+SXeKWg8TlckGnwkEUp5AJqFlzada83PrDdRgqte4hf1V2clzK3L
         enorNZRI9oELmgyNJ/plahbJIt8LOI+bcEAh2pMsIuIdzezGAWGeGC2ZuEM2xQZZv290
         fdB1/VUpUWLMO1DP8ArtrWpCLryJcCHfUK8AhwaKb7PbByPds+E0PqmWEaiN1YvRSra7
         /jpw==
X-Gm-Message-State: ABy/qLa6Cm0r8hrr3M63MVFJp3vwVzSae3m9a5yS095e2Cfh8xXg9IFQ
        1QC54ZO10SQTv65nfWQ6MdXRlcmaJO9NC2tgdxY=
X-Google-Smtp-Source: APBJJlHDyeGMLRJh1TqEFXuQL5gNHvL979NAqymoRu2852sJo5Wc5PVm71x+nJyUxH/c+0ShKcWO/9pWFC+1aec0z8Q=
X-Received: by 2002:a81:5f83:0:b0:576:b52d:4946 with SMTP id
 t125-20020a815f83000000b00576b52d4946mr9750194ywb.30.1688883402409; Sat, 08
 Jul 2023 23:16:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:6211:b0:35e:b32a:1b89 with HTTP; Sat, 8 Jul 2023
 23:16:40 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <coulibalynina15@gmail.com>
Date:   Sun, 9 Jul 2023 06:16:40 +0000
Message-ID: <CA+8Vp3Va6YuVNky0j3E1UYrYwr56aeg2aKtMxvgOUsLM-3zVTw@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear,

Please grant me the permission to share important discussion with you.
I am looking forward to hearing from you at your earliest convenience.

Best Regards.

Mrs. Nina Coulibaly

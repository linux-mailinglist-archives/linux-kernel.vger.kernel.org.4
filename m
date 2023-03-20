Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2493F6C0C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCTIYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjCTIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:24:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D211E9E4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:24:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso12929943pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679300662;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vXJEuXGL6bDH3PwmPPaT3IM8ABOywFoq2Dgyfl9GkNU=;
        b=n+mfzmqOFxZIaeBGdi7plJsb84IQidbPZCdTZd3c33zPhpNYdRTHw5R6n4tU/aqBz2
         bIlF6yPcWpdrU/g3uJxxmxqFXvWFHJwthv2ZvqiJo1uyai5EOaWydEr9iA1LQEQhDevP
         eQPZ/0JnNJfZc6r28fwp0tdAFPjyGdp3SAjHb9588VsJbw/R80KjU3yYsuyFwSiZ9EK9
         hym+/RJrom2gN96vZNEbf8Oi7hAoj8XAcXJCw+NJ7OtVsYSzD7zd/pLm2kNFQKmA4ZwM
         npTQlysrZCTJLSU5/KWAL/UpMUHkAvWmjX+0idXBWZNtxKqDy32f09ib/iGUcnpHkuo0
         HxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679300662;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXJEuXGL6bDH3PwmPPaT3IM8ABOywFoq2Dgyfl9GkNU=;
        b=Lo1+fn1ZPLSHLRhDIfqqrVB+GJAHeN4iFXbZ8Gfc94HSix+VT7OVBR8BEvZFOA9++W
         tkingjannZUIW2OY4Q99y0vEzUYAdgVx1ZwWx07NYhFCAOSOh2quJ2UYaYNWCscP1j88
         kOmVVjjycg78oV+rRs7bgAbHh9jJ90/y/g2Kxsz55rCopKcoXGKvzwwzwc9aH/g9FaOx
         8KA9u1hIiRoR/rHQOelJAguYxUrgmTuf1XKOFPXcpd/GdbxRjLt+aS6dq38lrYycjYOC
         x4qTxl6b4mZc0I4lfmINMV8jL+YhSxNe1gmKrJj8eMhnOmOhv0SrtffKyGxQT0SyrQ/7
         ObIA==
X-Gm-Message-State: AO0yUKW6Aa9p1hqX8UWBczsZDmvENVjW5QiBHx7Ab10Ihlb59gWAxiSe
        qGEMQ6J+WJr/Zco9OQtRf6k/ZxFBCcC0Phaq8rM=
X-Google-Smtp-Source: AK7set9GzDdYtXbS0Cf4yAA4xqveR5Vmohd0FI0u+fdQW6Ug7dxgg8RitZb0cnV8InVskl+KrxUfwhJXl3LAAiWnvBc=
X-Received: by 2002:a17:90a:5b01:b0:23c:fa47:e763 with SMTP id
 o1-20020a17090a5b0100b0023cfa47e763mr4371695pji.0.1679300662083; Mon, 20 Mar
 2023 01:24:22 -0700 (PDT)
MIME-Version: 1.0
Sender: anmoniteashale@gmail.com
Received: by 2002:a05:7300:fc14:b0:b1:4517:6f5a with HTTP; Mon, 20 Mar 2023
 01:24:21 -0700 (PDT)
From:   Miss Sherri <sherrigallagher409@gmail.com>
Date:   Mon, 20 Mar 2023 08:24:21 +0000
X-Google-Sender-Auth: -HS-ahRR8J6Jge_3KuHHTR18V9M
Message-ID: <CAFF8bF4snVpLsT-+vJHgpc1oAR0Qch90pBWD_QX8ogT9DmgOqg@mail.gmail.com>
Subject: RE: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

Sie haben meine vorherige Nachricht erhalten? Ich habe Sie schon
einmal kontaktiert, aber die Nachricht ist fehlgeschlagen, also habe
ich beschlossen, noch einmal zu schreiben. Bitte best=C3=A4tigen Sie, ob
Sie dies erhalten, damit ich fortfahren kann.

warte auf deine Antwort.

Gr=C3=BC=C3=9Fe,
Fr=C3=A4ulein Sherri

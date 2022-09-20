Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBBE5BE6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiITNLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiITNLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:11:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5951A40BE6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:11:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so991037wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=XAzDYQxpLcJQ15DEP4UTiE0elKKEdLSe01IFkqD7taw=;
        b=V4fg7TMm+n8WFyQJ1mY5aXpI8vuG9FVw99PYZyvLJ8aj/n1LV8tWoemOORB1vs0Nx+
         NXaU1VEV7N5eb3Pci6agm5Qk1kydAGoXFYGktrZwrTRyBonZR1CTFKmi+Yt2d/sPls1Q
         vqmVu+Rr+PUB6jbm9YOYebWZpB/xmzcfS6pet96fmMYS6UsY8Ug41aUUxpawZrfzrrig
         uMpj2aJUGEDfiqAUEsaXhYX2/beYj/LNzE4tyyQXXwqsfzVkSXEwYL3b9N1GvK1AuR9s
         l6UlgpDr9lRLzQBfeUOFzvhM2ZSpFSdaPHeWp8TKapEYKbMbQEigx52nk7WO9fn1RCSF
         nTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XAzDYQxpLcJQ15DEP4UTiE0elKKEdLSe01IFkqD7taw=;
        b=4uhb4sjvV/QfZYWtJ1yTqwzhF6Ief5ZmC7a5HQWLecTaHbjNmnj99556qLliQlHLxj
         /W8wSS1VYIPDs577sBFyUCjA4gYzc0UVrWIKcVU/3tp7d120jhmZhx1gOlg6AI+cSBle
         50q4REU6ZK3vDSbO9a8KvBklS+ii0bIXZVbO+92kD8iS/pvBBDSQsbQFbck4M3kEjmk/
         BjENiItExW3dvGqiZqeGOAbV+IKSWwW7dTdZcXFb9cT6H9cLGxZ5cEmzAi9l0nB+Tf2c
         KSL8b3ixN3aWOa1ryZUb8w/E0MHFiUe8noF4oM5uxBrmSVWwuwhTlZZPbGLH+/psHggB
         JADQ==
X-Gm-Message-State: ACrzQf2J6fJDhq6o+GBe61QlwZD4+yA6iUdIuuqtp6jasxAIqgvdjRlv
        WzEvrkE0ThXcgVMiJE5NWQZKkKGLQA5GNyqQxok=
X-Google-Smtp-Source: AMsMyM7wycy2aiv0SwUOkB8HTBfAJiDmuqPXKUj0bSK9kQNY9x92M/yAVXriRwtmO+nWqvx3NJ4tFNTELfq9jEwAuXY=
X-Received: by 2002:a05:600c:211a:b0:3b4:75ee:c63e with SMTP id
 u26-20020a05600c211a00b003b475eec63emr2453885wml.44.1663679483988; Tue, 20
 Sep 2022 06:11:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:5958:0:0:0:0:0 with HTTP; Tue, 20 Sep 2022 06:11:23
 -0700 (PDT)
Reply-To: a16udu@gmail.com
From:   audu bello <jhadgrs@gmail.com>
Date:   Tue, 20 Sep 2022 06:11:23 -0700
Message-ID: <CAKxEN0tv3kApVZ6xzZ5To_Qwe8vXdQo=rNWjZRD8a41kfC+z_w@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Could you help me received 4.2 million for Charity Projects in your country?

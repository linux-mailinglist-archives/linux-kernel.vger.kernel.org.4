Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294B667F3A1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjA1BPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjA1BPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:15:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F4B1ABDA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:15:15 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p24so6626007plw.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yv7zYtQy/M6cqwz5Uob2XU2gKEnywH1EntmNRq31yLY=;
        b=gN1gEqQl9J1fh5YOYrlD5o1MCt0UhGwb44NNugiBObHS9D32K2BmC8sE6NGqVjaxuX
         i5EIXZvSR51U6gfzaebgrF6N8HkhacvWaLZ2Tgq5qk/k1FWY3XY9+ClV9o0Q8e75rr09
         HcPGGiH8qZbubW5NuAPFokaIwU79U6m1NEGDbb47SyxCFxYP7XVrMxiF+vuOFVtU9tR5
         LLu9NO/0WFOIJVAdq1/A1cGVGtqb0ZIPkqtjfH8nrHqZYenFttKN1W8xb0QK/EzF/PBG
         4TxGLOmEoP695HE9A/GSxFPvve/OceX2d17qeM50yjQmaPB49IH2euEa1IZrI5HYBpkW
         iqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yv7zYtQy/M6cqwz5Uob2XU2gKEnywH1EntmNRq31yLY=;
        b=t/KdHz8INmjqQzkRj1/Y1XKPJSDTK4wCTICJycsDTAW/cNHtu8qjQAzUgXy1oZh+4v
         hruuaJ7tPKdKsMmS8nF5nSFIJTozuZ9WdwMgiZWZgYakWYgdj08LEU5Tvaz1GkNXCbWx
         mr4NBmgm4th4dwEuJ3fUKBwV4v6yXhS+19xFk5/Kp3YC0BHmPlrAjYRyukc9bkENtAZP
         9gCHMqs0Wlh4qM+F3qNsD9UA5lvXQBFaY/B9Z73FCkjTAYCQkPSYpmqj2wq4f0aM/4ev
         ZVAc45T2W0ClBdYHdTh7lL9k9kU6+N4zuV7J/3gbK977p7OPIHRYQgHNum47z+/nnQSl
         3JQw==
X-Gm-Message-State: AO0yUKWqD8PgjKpSViU2wSTk56Ja0RER808D/DXop0c9guJssPdD92mb
        vlaFH8LuE50ISkIpySJBCSYu7nTQJx4JvXHOGdQBvCPmMVyX2w==
X-Google-Smtp-Source: AK7set/N7vLoaN8sSe1uO8Ol8KhDtC3X6M7ZahIUICn79FuYMGO9rcF9S4LxcK3K6NAR86tsvMj7QpR5al6DHvqSZAk=
X-Received: by 2002:a17:90a:740d:b0:22c:5f7e:da5e with SMTP id
 a13-20020a17090a740d00b0022c5f7eda5emr276317pjg.4.1674868514607; Fri, 27 Jan
 2023 17:15:14 -0800 (PST)
MIME-Version: 1.0
From:   Chris McGimpsey-Jones <chrisjones.unixmen@gmail.com>
Date:   Sat, 28 Jan 2023 11:14:46 +1000
Message-ID: <CAPaMSD3MM2BTW0REi4onUCPCLzz1B=-x0j9Uuvf2NHUOSefQ-w@mail.gmail.com>
Subject: Latest RC causing web browser crash
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone else with the latest RC having issues with Google Chrome
browser, causing it to crash after a couple of minutes?
I reverted (temporarily) back to Linux 6.1.0 and it's fine.
Tested a couple of times, the issue can be reproduced.
I don't know of the relationship between the kernel and web browser
and it seems odd the kernel would cause this problem, but there's no
disputing it is the cause as I can reproduce the issue.


--
Chris McGimpsey-Jones
Freedom Publishers Union Co-Founder

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112497466A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGDAq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjGDAq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:46:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF70130
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 17:46:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc244d386so54044065e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 17:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688431584; x=1691023584;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FG/b/QRnIhbtKTcfdhlOHbGgJiYrm2TIpeeA5uYugAw=;
        b=rBUwBAQZZafxJ+sfFiHiONbawr8VOoLzcm2z3WdcydNCOphzNfYK/oYrNXN6B79mK4
         PfD+Aylz/A9KTnlQBBhaDAeeEtWYGSv88GfQMXWN3YDP7RZPbm0LnXZgjv8fbxMFbcgk
         Pj8mFHq6wOjVjS47g2lKuWoORwoB3RMvBXta6d0354Uuui/PHCSeDKsbRLUHMVFbSg+V
         mEcYzJIpS/6CNwKfITu82YmhQy81feAXYIcwaMpc3OSJy3mKHsTLMcg+jFPjIMowawjB
         csKtvDTw91YkIWvvpHDoSTcICmHMjitvwyNlTrbToO776tQWTvs/xmFfLUnDuiA1qKcb
         q3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688431584; x=1691023584;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FG/b/QRnIhbtKTcfdhlOHbGgJiYrm2TIpeeA5uYugAw=;
        b=BmMoabHNQjtRPWWHamgbSa7ykiXeE9cwZRvFNReXpEi4DwmybVvLT/+DzB8O9Qzzuz
         SMhklNUs/64ExDFlR7YVtO40mflWyCnf293PzRBRA44Fb2U1QKIlCI6T007Vedw2D1Dg
         87vuEIJQlIOV8+mt701EW1q2IhMj0LwuydLeO/l0iQ7TRhOXNAZolgctLBbrM2Kqb9xJ
         wOPtXyHpc9EehjCFgt3bDMgjPia4y8XeMHHcvgy37mKDnkY3kdjTVFcyUkmO7QK0Vqo9
         Es5Jr/dEmLpedZ09TP9krpsoZoZS10OmV1lLCjVASulrWx6cw79evloVU/CMzUoASWG2
         dT4A==
X-Gm-Message-State: ABy/qLbthM4kndS6lqMtNiqjKgoI8G1xEprdpKPjUVWlm1QCfbnsdbEo
        dNCmZXxpEnJmdRQU4yaE0wqRdbT7pAndPB4myBNlKayX
X-Google-Smtp-Source: APBJJlGi+GiYdIadXVoBUTU7TAVWmPPVcZ0IBZ7TTyQZVW60ZZz+JQ1R1jA0rV0aWXD1zqQo+o33SEqdOQ93aJMo970=
X-Received: by 2002:a05:600c:2059:b0:3fb:d1db:545a with SMTP id
 p25-20020a05600c205900b003fbd1db545amr6043448wmg.15.1688431583773; Mon, 03
 Jul 2023 17:46:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:1a47:b0:290:25e9:9dde with HTTP; Mon, 3 Jul 2023
 17:46:23 -0700 (PDT)
From:   Budi <budikusasi@gmail.com>
Date:   Tue, 4 Jul 2023 07:46:23 +0700
Message-ID: <CAH0GyZDWhSo+otkEPRDwvHyE29N5ZjhpFT5m4jRnt6buV8gEpA@mail.gmail.com>
Subject: Anyone please do big favor, help
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please one sincerely help, I need huge help

I build kernel but there's few absolute interrupted compilations
resulting in few .o files are defect, cannot be recognized

In 'make' and 'make modules' this'd be no problem at all as  is
capable of resuming whole the process
it's solved by deleting those .o files and then redo the build again
which will complie those  particular files only

but in 'make modules_install, it won't be
real case is within Kernel 6.3.9 package

So how to modify the makefile in order to be able to copy/install the
just built modules in pause-resume fashion so after few particular .o
files of modules deleted and rebuilt with pause-resume, then the
modules copy/install is performed on those only, not the entire
modules

Please help me out, as I'm so incapable of modifying the make script to be so

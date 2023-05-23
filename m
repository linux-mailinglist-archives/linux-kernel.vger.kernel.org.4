Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAFD70DD9D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbjEWNjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbjEWNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:39:09 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E1E9
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:39:08 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-439494cbfedso676099137.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684849147; x=1687441147;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=seB0BW52cIqQpYVG1g9Ozjia0uoZ6SCPaIZCwJ8LzHphPCtCJJtu7UhiMw1Wddc/LN
         6l6mqKbI6VN7605L38yMh/N6fuR5xsvwl3v5q8rq2ciQQhtP7xzhUMmxl88D3bRjPTTO
         oyvBQekd7g9s/cIkcZN2rSp4Yy9LhxPyqMyYU6AU1G/OmgRvkAn37wR/PnrImgoRQtGB
         ZcWWNP+xCe1e3HsLW8DeSZCKwaDSG96uWV6GimrHSc0xPMtlE0emauQ50cujf06HCCiM
         +OU+7NYA1CfFEzoDacpYVOHL/XlbOSvWM8yLO+CmA8szkVqu5VCVkCMGbh+nhJLmFtjK
         WMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684849147; x=1687441147;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=hAJkKIQmdhLJXahMgxpZ5QNdk6D1PnY3+WXmi2hW8K50xc8OoLOVrlogcPbFoEBw92
         rJpLxHsVC6Fm/LHnSBAk7c1T4bp+y2vIN+qrsRovtMur2cmFJHi+UEOLnFgm6vUWWIAv
         HWavcxwH1vNryfq79uheNbAao2XIM4fdVPXwRZedrpQwsm2j8mgo8DR1M0Xbp0amQTsB
         LUgqTF0VZcSgaWpIwCy1AkuJeN0DMvyXMaRtaSFtqW2LQPd4YyAW8lGtvkLz+0E6AT+h
         tK5ddFoW+C5l1+66wort1XO65pdD3NUZtIC/JAeONAdDTPKadhdZr5xQsV/axMLt/JXu
         AbFQ==
X-Gm-Message-State: AC+VfDxtY6N+hlgU5AwRt9zdBfTsgDAWvXcgTNShjyLPKOWG8T4I3s/p
        Q3loWI71JIDYhcTAj+arkuyySS/SHMRCyeg75GQ=
X-Google-Smtp-Source: ACHHUZ4AsxV58LUXd5LZn53JxGE7OlAAD74m+1dt0zr+vpwcvKojg1gL6TmaXq408b6mCOgZjZXgi8+SYjZSUrDEdCw=
X-Received: by 2002:a67:fc8a:0:b0:434:66e3:74b4 with SMTP id
 x10-20020a67fc8a000000b0043466e374b4mr3534108vsp.8.1684849146914; Tue, 23 May
 2023 06:39:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:b9b0:0:b0:3d6:a455:74b7 with HTTP; Tue, 23 May 2023
 06:39:06 -0700 (PDT)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <abudumimi920@gmail.com>
Date:   Tue, 23 May 2023 15:39:06 +0200
Message-ID: <CAFNbOJST9XjSc5oi+e93VXk3BQ4tzNxav=JxeS1zwPDkq1bqXw@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.
I have Dual citizenship which is English and French.
I will share pictures and more details about me as soon as i get
a response from you
Thanks
Ava

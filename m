Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2C65BACF3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiIPMHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiIPMHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:07:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845DFAFADA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:07:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u9so49033962ejy.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=OQ8zHrIX70m98Oe3Z2xil8x9KKcY+DJQWerhvs21yklCJbj0er4JrSdkhrWEdL4cdw
         p703XLHfp6ksj7uFlg56h5KuWoxdB0Z5qMNDTsjT9a3QQxZe40q4Dcl1AEtgYFRUmRgb
         JyO6tzyZJxrUPdaH/m9I99qLd33lnQgiA3fBkgIKy4qvAm4KNap5pnKipqw/pDQdOsF2
         RMVosVZX40XjPNoppGc1VxTGF/4qg7I9MhjgMiHH+8ARRhtbE4XdLcvqGqdTtxhpoOwr
         yl4T1vsmWlC0wf/mYdDRVvQVSQruQmelYMxnEFt0ILguRW8+tpUXQssBQnqOj4h3j9f7
         ENpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=GpKdwOONgb7EhaWXGUGQrKTTvYm9SftbUgWE/wofkiqMySdsI+y2reBzxdQ7jUePnr
         Q0Mlmp8vSeZlemrwfi4JElryrFsVE6wxVcztLFDbisj8LOQZQLheSzWTn8pIhE/xQCKC
         ZnEK+5pDbqwsQ6s5Rbl//CkySnshMpKZc7xikgRfXsv9u2OqpPqs/zhiu0LL/6KKoD7p
         I7InNYhCpnKO3vHVK+pnXMha4fmr9jfK+IzHKPyqpNitGnTmINtZ5kcppck48N2jAcWl
         x0ELRom26ZE850gbsUKUTT2VIZAZhkravChWVYdyFyYi2ICpVThYNfxakxfWQ28j7hV5
         O/0Q==
X-Gm-Message-State: ACrzQf2dnaAsiPOm0faaTINIa7YTY5f9+EydDQ4cTNB5PRjwV5plvzZL
        u0UZJlZ4L4R1HXzya1s77P5RQ8Hvi2cSTfHFtPw=
X-Google-Smtp-Source: AMsMyM50Qt7qDEVjUjOeh4Zr3qhxIqEfsGOFmjXgAwKOxJcISlt17Ll3jPrBgOzPcw9B4a7Th2rv4TTzjVtoMHfw+4M=
X-Received: by 2002:a17:906:7312:b0:780:9b5e:36dd with SMTP id
 di18-20020a170906731200b007809b5e36ddmr2568880ejc.200.1663330057120; Fri, 16
 Sep 2022 05:07:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a98:cb43:0:b0:181:f8b4:ef08 with HTTP; Fri, 16 Sep 2022
 05:07:36 -0700 (PDT)
Reply-To: maryalbertt00045@gmail.com
From:   Mary Albert <edithbrown048@gmail.com>
Date:   Fri, 16 Sep 2022 13:07:36 +0100
Message-ID: <CAKt8mnavM=Bdn-e0nh0YT2-GEYodvmchN=5ouka8rEQP1p3qVQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:629 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4817]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [edithbrown048[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maryalbertt00045[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [edithbrown048[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
how are you?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA176493EE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 12:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiLKLeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 06:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiLKLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 06:33:54 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1BE11450
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 03:33:54 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c140so10543369ybf.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 03:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UleXfybfkB/Pp7XCNYIxvDWfUpO/oLpvjkUbrsMk7bk=;
        b=Q25zrCZXP709n/XMw4x+UX7OBSl6c+AjQbOxCUyl48XplNa/cc7voFvYpl14KeA0/o
         QMZdlt2fQ0Jbs1dCR/Bl9sj3VGUFDu/XpWQPV+5YGVLoI5XEZ2Jfhr8n/XqMsdG/cSIF
         lO42O7TYzny19+GRk7R4rDttMnEhpqRZVTy7iop+/d2XI+ButrxPfj8EqKk2AEVXPzBA
         AQwkFFmCjPYFwl1aDGN1OmIuHAUPEFWiQLS6+MF8kirOeJ9Q1YK+PSTMWMV7HYWogDMq
         A+ZRkatlOKGKX3zU3w5rLXyp37wo9DUTf5aFbrIii/xlKDINim3wlZthexATYgBWxxUs
         coKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UleXfybfkB/Pp7XCNYIxvDWfUpO/oLpvjkUbrsMk7bk=;
        b=0WQdDpkN03sn5avJC3M5dqFXqarOJ7kHbO/1pEIjOSngN8N9VWfMCpPzxcOUtVeGWZ
         nRPl4PerY3kDI8Ss5cJ3yFFytNJHXVvV+7x2lOnfEjVu7RBfi5/A9GFisZXG+FiqcQ3B
         oL16IZsxYiAxMXxlaeXehePqWJ9yYJLG6vJxls7NKuTB1PeqcuzevzRYAzJKnTkGDijl
         TOS06ARbw42JlRE3ARBtd+bWNIw0sLLZ3PeDtt8Uqi+1VhsCtwHZVyeidem52MYh/xdy
         D8+ZpdAylYlJAg+Eo1kylfJ68WbTCJFWAxK1rXKLbsGl34TuGj2HJaqBbKUUeJJ6K8L6
         Yc/w==
X-Gm-Message-State: ANoB5plMc1zvfLhVZ1IFn8cqFNbr6TAAX2ThMY7HWJl4/FTCsieBm9IJ
        mSD0HMY2a9pwes4HdZOJaaQLXawjuE9cQ1RKh5g=
X-Google-Smtp-Source: AA0mqf4h2XIzxaEOlBi2IacDxhF/nDvdLDtUOLbTGds5/shNhpRql/ycTkwk6J8Q9S3wVnD+fBOvC2Q6qm6s2IkOa88=
X-Received: by 2002:a25:818d:0:b0:70e:58c:1c8b with SMTP id
 p13-20020a25818d000000b0070e058c1c8bmr3416311ybk.229.1670758433277; Sun, 11
 Dec 2022 03:33:53 -0800 (PST)
MIME-Version: 1.0
Sender: agolmiassoudavid@gmail.com
Received: by 2002:a05:7000:7004:b0:3df:cb01:8d42 with HTTP; Sun, 11 Dec 2022
 03:33:52 -0800 (PST)
From:   John Kumor <owo219903@gmail.com>
Date:   Sun, 11 Dec 2022 11:33:52 +0000
X-Google-Sender-Auth: w5A3quRCjB4jmnRS09eLZg3-MgI
Message-ID: <CAMRZDD8d_uwm77kELotyKvfmCO+JHZ7DXqJHR94KBpGw=dv+xg@mail.gmail.com>
Subject: This is very urgent.
To:     undisclosed-recipients:;
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

Greetings!!
Did you receive my previous email?
Regards,
John Kumor,

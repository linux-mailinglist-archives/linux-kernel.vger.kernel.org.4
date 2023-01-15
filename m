Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25D466B36C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 19:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAOSeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 13:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjAOSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 13:34:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77540F744
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 10:34:21 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so22206043wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 10:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/6FHJgf5zBOp6YsoIvW0Bfh7uMHR9BufqIzFear0hc=;
        b=GCP1dXjaKbzko+n5Uj5mYoGcRWWEQkuPIJjmS5UThDNeI9b9x+ql2ffiQjloGvw+6C
         qsPjSIrPdAOp07z4tfEU9T3nlUQJ19jqoy2ktw75Tat5dN+deXWQPoBm/O2v3Uv6iyRG
         zzZ/xForlySZiIMLDtUgofDojZ5kbW8zXwBG7im8p0pHeE+dR4Sk+uHul6s4QwoMgPy+
         PhSZCRjpniFwjYNJ8wc4jE6/jnNn8GyOOIxN6jdwNSHkk3by7LzJaxxbhqWvan4vNgsv
         lsawQjBRgckDlbz92+uxCVbf4IsU2n1apMMI2b1Ws2PA8qQlw2s3HGUYPF9QkDNDGup7
         eH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/6FHJgf5zBOp6YsoIvW0Bfh7uMHR9BufqIzFear0hc=;
        b=BdnJBa1y/zBDSgDZPep6QhH65Em0gqsOCQ7s0/JJAnzWoKZcFeJFuXvbmCf5IPBSJy
         VS+RfEgsHjMSncMKoc9YYRubjqCXenVs5GkRNPwC5/Qc38IMouqWd0ocifD/Jp8uh9Mv
         ZX2G1VJhOZ0M7OzyB1TC/7qS5l/WL9SF+8mdF6zPh7UWzUaXKDAYNYe8D+NzU21F4l8I
         mX/Ggvw9/aPkLwCL/EqVkDXwZQ0EOaAW07Fp6AmCEImL9Wd33rQWd1mJEh7YEZ8oPPgt
         /B0jHMKd41aAwZw64P8kH57vwWzeB929tldqxh4MHHvdzt6B4QHeeCUHu6rlQvKucNR9
         YK2A==
X-Gm-Message-State: AFqh2kqt3BKVIjKBNxkWRdppcmweI5+RL70oKeM6Tb/jchsoGB8Oz/f5
        4DJD+ufluuWG3aDyJHAXmOoPRBGuprCr6naSiH0=
X-Google-Smtp-Source: AMrXdXvm7gwETptNXAoHKltVuP5aSNzbfjFikKpzqhPyvPBn6QsgZ7mbV7scqggHGYF4FYGYZ+e0jvZ9+03uCP7noPA=
X-Received: by 2002:a05:600c:22d2:b0:3d1:f0e3:722c with SMTP id
 18-20020a05600c22d200b003d1f0e3722cmr4428181wmg.33.1673807659894; Sun, 15 Jan
 2023 10:34:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:4906:0:0:0:0:0 with HTTP; Sun, 15 Jan 2023 10:34:19
 -0800 (PST)
Reply-To: mrs.limapatel@gmail.com
From:   lima patel <confidentialandy35@gmail.com>
Date:   Sun, 15 Jan 2023 18:34:19 +0000
Message-ID: <CAFe=aPtZyv3MNfdFLZJskKOHFkGxD-=eJCGLexZbU90KU_mh8A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:334 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5314]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [confidentialandy35[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [confidentialandy35[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I do not have a formal relationship with you, but due to my
current situation and circumstances, I contacted you. I have been
suffering from cancer and have a short life to go. I have decided to
donate my 6.5 million dollar inheritance to the less privileged please
help me to fulfill my last wish

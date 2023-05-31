Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F337187EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjEaRCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEaRCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:02:32 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B40136
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:02:31 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-ba82059ef0bso5233174276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685552551; x=1688144551;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2awcT+0JgCeSvbodyRK5wx8XefAu35aN26RnKecP3c=;
        b=ru3LJWatw9eSDRsclue1WsWIAxDaumN43vY6opCFT1uTJnhV5qbyqlLmijzuovu8Nm
         3SjSIPob1flROXiZ/+I9rX/Opy4E4ipaOua7v2rzbHaBsPAogoMmE6ndp0QkOs10XZEQ
         MS2NSWPHSQbySLRlPnWkU66Cx5ulYCr/7PPcI4Rf8sxK0XHMg/EO//ovKXZbEA3umyD3
         pwg/pWfc8W2NEqma2xhp/ec4GA5Qnt0NY72uixR6htP8skXxdb1XS5RIfYorr/tgpA1Z
         9JC4XdO+zHxDuToUyN/HWNUGGeraNWl6hS+5ebk1AWXREaHRRLYi7wTWJZGkZwfrktMg
         EwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685552551; x=1688144551;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2awcT+0JgCeSvbodyRK5wx8XefAu35aN26RnKecP3c=;
        b=cDK5zcd1BIgcBkuMN+M7uHCydNO2AndFLZj367mte5SMidKpkZvR8IjwmmnFFqMK4f
         j75i+GCVnAmOjARjRlmaQj2C9/694QnIyI413Nv0Pm7dx0tITkXJv4xDiU/2NGNJwdaV
         k8lRXJ8Yky9CkhzYr83os9tO2TbQk3MNxYP4MMiEo0AazW56z+0fxltKvm95QAb3J6fD
         dMzmcKBTOoS1XQKNuxWEIxOSvfoGeH1Ir73gQqey09zceetJy9e9r02qS//ycHcf1TMD
         c6rDkBpdBQ2+t7lzlDJgMeskijUhttMiUaay8vSAIyXtDHYD/mrZfXsB8WHFDAeC+dWY
         N3Tw==
X-Gm-Message-State: AC+VfDwA/eJifuejTjjB+Y4C8m+Rt//X1qrWeuT4A1WeX7VVegYP4et+
        MBostjdw5fCJ981QH9fdorAkWNMQGdpzkbNUmCc=
X-Google-Smtp-Source: ACHHUZ4dQJlXj60cxvsTiSM0dtaKbN4LMCi1vwHfOB99S/bor3Dy8Gb2UJe3mTHf8rjZL55t2EEfWPILd3VShBm1Pnc=
X-Received: by 2002:a05:6902:154c:b0:ba7:cb72:3588 with SMTP id
 r12-20020a056902154c00b00ba7cb723588mr7649878ybu.9.1685552550720; Wed, 31 May
 2023 10:02:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:582a:b0:35e:4011:9d19 with HTTP; Wed, 31 May 2023
 10:02:30 -0700 (PDT)
Reply-To: drlisawilliams53@gmail.com
From:   Dr Lisa Williams <williamsdrlisa@gmail.com>
Date:   Wed, 31 May 2023 18:02:30 +0100
Message-ID: <CAJbSCCRDPiDMKYJ4bXV9Y=vOcZe5CFqc8LrBctb_MFgTJfY9XA@mail.gmail.com>
Subject: GOOD DAY DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [williamsdrlisa[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [drlisawilliams53[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lisa

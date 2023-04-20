Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AC36E95C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjDTNXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDTNXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:23:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7525830DF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:23:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-63b5465fc13so869156b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681997028; x=1684589028;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tKnhLV/0an3EDTNwSj7sYj1CNXXvGDWf0DWPnlsvj8=;
        b=AGOD2bD//nzZzCvZdSmL6zCpQFMJg57ddfFFxpUQ7rq7Dxa6FDCP6i1wJci7Pr17h/
         FtIsGbuFvlFJijEPjWnUXJkRKsoJC9irZSVtpxEGolAohIx9RVC7srMp+qPiTCxCj8wy
         Ysn5xtoebK5rAqYDkdANvorxX/5Nny5B1wfhMzHbT4cihq+qTFUmLuHw2rP24IUmu/yc
         LbxzZXXhpqXk1TCMI3K9bCHhj79e6OhSN+O6sIhvFeITl3T90UZ5dJMhkhvyoL68qbCh
         X7ei47pMZeMlozBEmyOqY6arXihs02CPjDVi5hcBMil00/ZbxsmIKSestTMHU8IPK+SC
         /wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681997028; x=1684589028;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tKnhLV/0an3EDTNwSj7sYj1CNXXvGDWf0DWPnlsvj8=;
        b=Flq1r90L0EedwifMWlBEnzla4NukkS4l1Pxp01Ov2JAbAQ1C0sk0wxgZ0/PIFIsQOm
         ePaIQAtCRM5Lfkp3YNokQ0kmrsc2dAg03IifX+I+7q3yNz74zKV/lFxI0oVbgbsRxHxA
         5ePmCk/eNihYmdZBetubXVH39kSQuYXx5xBHuBzbnm1vp7mYoJq/faPkenppHfIiWhsd
         NsCjVZhkrIiflO1j2N1p7hMWE23DugGUlA2mTL9fpc1HcCHAnGvpnRkDmchF4b3qSwpt
         iRqDq7SbGFmFr7sGQxEoP9P43w3+w+j5PqnH72rqlZNspZCdOkLwc8f1cVW4KBd1DsX4
         8eeg==
X-Gm-Message-State: AAQBX9f1wyeBOrIXb694qBVys72JSwFofAi3ZHycRm8T5qmL7f0oTT5f
        ime5h/aEepqP/oJIgwKFqs3bPspfy3A9GKP65Pg=
X-Google-Smtp-Source: AKy350a5T17NZgTBHISp1Yy1EdDkgoY8zCyX/YnBT9NrOZtNwTcsAAq7ZVuNGRoS0OWmcOuUhxDdNYYxwJFl4IELGfM=
X-Received: by 2002:a17:90a:fd17:b0:247:1de8:8263 with SMTP id
 cv23-20020a17090afd1700b002471de88263mr1855822pjb.4.1681997027975; Thu, 20
 Apr 2023 06:23:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a21:798:b0:ef:bb3:57ed with HTTP; Thu, 20 Apr 2023
 06:23:47 -0700 (PDT)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <rw36223@gmail.com>
Date:   Thu, 20 Apr 2023 06:23:47 -0700
Message-ID: <CABnv2btcjJ2bA9PSm37ttBeAz_g0gTSmdRyWMxM6J2Ggfnr28g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rw36223[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rw36223[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

My name is Mr.Thaj Xoa and I have an important message for you just
get back to me for more details.

Regards
Mr Thaj Xoa

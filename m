Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A25EAEA4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiIZRvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiIZRvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:51:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9BB33A33
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:24:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso7546760pjm.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=MEd9l/fYe/xgvXbGZYW1JJjOWBQHxsYSYbU8Q93KhlM=;
        b=DySj+RdxKH2dtEcWWvpU+cxEeqZD02sHHyHvmFeeJAQvhvdTRFGjbcdZwo48IQOyKv
         pNPEaQ5+ORK58KkVvCnwJerwjecfrXOULGRRRmfANc4GHlxwnaqX2ZhsfKH9SUMD0dcY
         BPUi/tL5o6OerAJz7xhcWrTTv6Lp9CjR4u7kxnx1QOpovvqmnaZnwl4Gnte/FWvdXNmW
         7s9T2hT5qFj25PkXUN33u/jBKOqc+6cEHX5/016S9rDhpRYKLOcsom9Wi61D3drXM63P
         IgdfrvS5hvhYnNULtXb6HNLVFWc5N2AYILRHj3svSIeLL6c8fcCw4ZzZoG3BtlCc1p2p
         682A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MEd9l/fYe/xgvXbGZYW1JJjOWBQHxsYSYbU8Q93KhlM=;
        b=04nhGvHtDU/a66yw9ZOkVco0UMmOQsruMEZG1OburbrCJjwWhEzg+ECO9Ptk0p7a0i
         SPY3z5Ye+o6QWyyQPLXYdc9t5Ub8Nm5M3/6CzL09xWOBGSyCI7beIJsFs109NrHtdYxs
         d+bt333RGgblBDc8i4lU1w/A0hIlSwAnCAmbpstVcgEcbf8ak7fk2QzNws9Ov8bOz/Yo
         r2OL+czuE8BhSdp8+vhpwOxpk/Z0nhyRFz2TmG4fPdLznEGb+nCTKhvCFrqwb28DdGwA
         6WQ9hZYjLBCZu0HrowxAtJKBphdKlelNPYVknpAlngR/c18J2E1upXKlbpUn/ThZINHv
         QLEw==
X-Gm-Message-State: ACrzQf3rTlOXa+Ssyg8wVwdRNagLnSPihHO5CW/vA7geBAXQm9pNdage
        wBHerN3ap8kSdTLmlXHX5+Zqa7D6t5THoa41RF4=
X-Google-Smtp-Source: AMsMyM5le03F7twMM0lIlPlKKU2WEM91cmRn6jPG/EZdkHIeokUbuiNkSgEwFZn3cwNt8guDqP7YomXU/zRm4KftteY=
X-Received: by 2002:a17:90b:4b90:b0:202:65da:d658 with SMTP id
 lr16-20020a17090b4b9000b0020265dad658mr25969298pjb.130.1664213054338; Mon, 26
 Sep 2022 10:24:14 -0700 (PDT)
MIME-Version: 1.0
Sender: bbchitex8@gmail.com
Received: by 2002:a05:7022:f8f:b0:45:11ab:e19e with HTTP; Mon, 26 Sep 2022
 10:24:13 -0700 (PDT)
From:   "Mr.Patrick Joseph" <patrickjos09@gmail.com>
Date:   Mon, 26 Sep 2022 10:24:13 -0700
X-Google-Sender-Auth: FdL8diSQYZaxSv1U0Ckr-N_iDWE
Message-ID: <CABNUN+Je=jyYJbvaXJ7eB1qiQx8gOfu5+MT+9Q_680XqsR-xQQ@mail.gmail.com>
Subject: Reply Please
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_60,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1043 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6823]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bbchitex8[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bbchitex8[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I am Mr.Patrick Joseph, a Senior Executive internal auditor with a
well-known bank here in Burkina Faso, West Africa. I have a business
transaction of ($27.5 million) that will benefit both of us. I decided
to email you directly believing that you will be an honest assistant
in this investment business proposal, if you will be interested please
reply to me immediately.

Sincerely,
Mr. Patrick Joseph.

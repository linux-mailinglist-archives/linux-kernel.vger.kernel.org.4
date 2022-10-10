Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2395F9D97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiJJLaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiJJLaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:30:10 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2434C025
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:30:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id by36so12897287ljb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIqnGOnuCdILHCjBRH2XyEMbuxERKZxFFNMV5qYWuuE=;
        b=V07BKUaPdd1W4UWVBVCu8dymfp738G1JxtbFalUXVHIoI3lvFcPE9dcdebmr+OUx+U
         Q94qRLyUTjJJEyaGk1wR5n3fWra9/vTzVSmTeu0iW0a52rhJzKh9BdhDRANOJUYdKISg
         U04YYaZ45SSkEojQAXThUhKSJBWD069Sr4pqqtbT6Iz92vKSYhdItk2is4AyqkG6Dbb8
         jRu6BPOCwlVDkx+xYz0UY51PtR8f3j/ekBENUBnZnkdi1bO0V+sVTKFmLQgSvJAIvXzH
         jCvTEsZaQ6SgornDRkuRXbCQGw4ZJnSRwbaSXnV2nKo/OXlo9Bl4rKNsZBYAyvHQ3gU/
         vSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIqnGOnuCdILHCjBRH2XyEMbuxERKZxFFNMV5qYWuuE=;
        b=w2AMJcnTVNke5u4YC/kxJ41hTirfa+icwf5zhfprgPFg0ucAOMg152VcVqWtn1JDMe
         S99Qa+JQbhrmWrq5VXzE+XH/AHXSM/sYaJToINiym5vgDtyT80MBWJDCv1SwaV+HgvA7
         Qm2NkSjgv4+jU/zjnF0ZEbR+hYzniXgqhFxXfKWVskQXoloeCjLX0Rb3C6NWgFZATOC0
         YZfNpTB0sE+832hDRdxsfTFsw2hG2Rrs1qou5aQ2NhJFw4KzN+/rBf9hdQKbjhd5GGnJ
         X2Ypi2RYLhyu0O5Ulmg+vVoS+7Vg76Q/fVKhauY2EFxZ67fBYgxO1ajSqZl+OemjcKk+
         DOgQ==
X-Gm-Message-State: ACrzQf2ikL1SkwEOP3gWmjrgzVfTsqQNoaTVXs9fdY0w1xVb+6MlVDVS
        PASu3kLBcoFaXWZ6pZeHESvkgqhMXZAMuB+1xAs=
X-Google-Smtp-Source: AMsMyM4l6/B51uhcPweKFwRxdZin1gHlKdLtnHF60XlWCkT1bnDuVtxZkBVuZouXWgGslLkgN5mQg297prS/KimJu10=
X-Received: by 2002:a2e:8552:0:b0:26f:b0c6:f1b with SMTP id
 u18-20020a2e8552000000b0026fb0c60f1bmr486479ljj.165.1665401406258; Mon, 10
 Oct 2022 04:30:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:c60b:0:b0:226:b06f:3371 with HTTP; Mon, 10 Oct 2022
 04:30:04 -0700 (PDT)
Reply-To: financialdepartment0112@gmail.com
From:   "Financial Department U.S" <jt2044189@gmail.com>
Date:   Mon, 10 Oct 2022 12:30:04 +0100
Message-ID: <CAHgQp6VwuVBKrcBWsqbseP6rKA47_KX5nC76CkWKp7qhhLxH2A@mail.gmail.com>
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
        *      [2a00:1450:4864:20:0:0:0:242 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jt2044189[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [financialdepartment0112[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jt2044189[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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
Dear Friend,

I have an important message just get back for more details.

Sincerely,
Mr Robert Liam
Deputy department of the treasury
United State.

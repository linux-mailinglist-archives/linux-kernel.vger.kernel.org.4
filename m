Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFDB67441A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjASVNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjASVMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:12:39 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC3437F12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:06:38 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id f88-20020a9d03e1000000b00684c4041ff1so1948669otf.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FoRX2f/YZd1ew3w9a7uXRMrccel34cHi9ReaKIRWJg=;
        b=oJOlW+iIdsgztiJbGIFj+Ooe2Z71Eij/ZHcbu3TSXSg6mQDzOU+7alzWESWWIVbDyU
         xBJJ1tKToXA6l/al5COqFvmU3ZDh0ByU0i+gMdNbmfWyzaBvqpViLjVEx/ulV4kXFvkl
         sM0ck5402dz7IhpBEbzh1Jts8GGfTpjZiCI6+MbbgbOHQC5PeTuPY1ht9Sv29qsP2V1j
         ICY6lU93Y57QpcI5t1zi2A4lDpnjcSheF82Jq/sugTFJMlSUq4ms7Z60d6rSCQMCRl17
         ysPD0FUAmHEfhFNbvpTg8NOUp1ndlXhe+LbTqvJXLUKkbwDZXWWYM14jxH1t0r7A1Nz5
         vKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FoRX2f/YZd1ew3w9a7uXRMrccel34cHi9ReaKIRWJg=;
        b=Wc14DTXBVmCxAMIV1LuQZfKEohbQ3povYNEf1FdpNUyNY6OWVP03JIZOnMJVqI9Ygm
         INphaPbSUo2a5UBx/PBqtXyOilTwvwP+CAsmXCfPx5xPENdZTQUxaazNSJ0SAG8rylD3
         hkWkWWG5UfgUrPGcuFGeIBgRIbn914jadVQYOuBZHNXMAIiE0vsOmtsSaXZFxjcPH0kT
         Jzged8MKB0IwRmm0K73NgOeed7sRIlQ3cwwnBOyE+GQInWGyscnVWvm0GmEJckXd6XKD
         RjEOe5ypwHLOh6AvibuhTeN58XsrZl/NdXIdVIbaoSnzpNY7jhzpXxcWn7nd1ttQ8Af9
         r++A==
X-Gm-Message-State: AFqh2kqaiDH+2+bSPiZYNzoNHaP2YMQxhe9NZiKOuSIs/KTHjDyPFB1t
        ZjE8M0/5XqHprrB854y/xfEuXuYZfWleOiH8kvM=
X-Google-Smtp-Source: AMrXdXvtQGM1RFZ5r34V3iH/NxtjsptBGyiUFXMhttSYYiPyjC01TVh6K9xCjDvKfOMl1ZDm6S6+fg63HRHNemCpw/o=
X-Received: by 2002:a05:6830:54f:b0:677:2287:3c79 with SMTP id
 l15-20020a056830054f00b0067722873c79mr543874otb.104.1674162398194; Thu, 19
 Jan 2023 13:06:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:6f8e:0:b0:49a:4a8c:dbca with HTTP; Thu, 19 Jan 2023
 13:06:37 -0800 (PST)
Reply-To: ab8111977@gmail.com
From:   MS NADAGE LASSOU <nadagalassou3@gmail.com>
Date:   Thu, 19 Jan 2023 22:06:37 +0100
Message-ID: <CAAPPVT03RBU7FK7dyVL-0xSd_5rUAUo7NsLbSw1A8XTtGbvbng@mail.gmail.com>
Subject: LETS JOIN HANDS FOR THIS ACHIEVEMENT.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:331 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nadagalassou3[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ab8111977[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nadagalassou3[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

I am Ms Nadage lassou,I have a business for our benefit.
Thanks, i will send you the details once i hear from you.
Regards.
Ms Nadage Lassou

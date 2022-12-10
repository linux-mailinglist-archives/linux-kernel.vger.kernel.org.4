Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B627648D64
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 08:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLJHOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 02:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLJHOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 02:14:50 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCE7205EB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 23:14:48 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n63so3249020iod.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 23:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=AGwHj2LTSDtdyjKyOfW3ww0TjlsJ9cuw4CVL06PxT9Z9sILbpkfkPkUEzL2SX+sWA3
         cQDmGBXRwG69rXWF3G8zXze6lUNQJ6miKrGef0rQnYs+Yv0vwcJz9UB0k+pkL4D8ftdv
         q9DPmCMnX+xSLyyV0gnkbh9FYOSDVwa4Yr2VzoVVZNgKyAb735Mt+En3yTDkjy0C/7Lx
         HxpzQ/nniJdRVaRWsfJ44BIEMFy3GYVsyCZXF8sCY6YZyiagoaFM19EKvAluGqAiwl3d
         0M054RytiTK7LrkDnLzehJXPCrZOWBr0ubbvSVb+WQXz1Rc8Ud1spj05ZdW2WuQ4WrVX
         ju6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=jCKxc8qHvX9Z1YRr4O2ibI2ShMd54NldkRZzuuY1OOWR/FiIcUQASlYKGxez4hKcZU
         yTg9WxkkCD8m3LwVjaTU1iSfdTV/fagucBoQRig3Xf41aiXyz6fEf8lqJm1EOW0PblEv
         /0C0zYR9MRtid0FP/49dh+fQPmb1zfkFSXQ0YlHl7dGsC7sA6cLR1AV6YtW2JvdpO7Yl
         1oogOhOuFHkmT0mV78C0rW9NdAPRefz8NcYIVl/8xgB45Ag2WQ9AGHhQQO3ju5i8qlnf
         Zkn4BWIhufMdMotABcaNeqU5Kw7to9HRa/t4ZONTH8KCzuQB7EZ9kzXgdpoVAE2IIaGL
         bXsg==
X-Gm-Message-State: ANoB5pmM1/bYNTCSD0D4WQo3JZmy6zZNVz/rOYXyyKlY9tldgp2Obk43
        lUxUPGlMqA0oDg2eCvjiOyBhClvH2Wmw4DlD9Ek=
X-Google-Smtp-Source: AA0mqf6dVtdgIvDFxQAF7zgj0tBRGXCYum603o1r5Wvye4F0QGkjL/B5qzahQuKUjPAu3dlLm0j1Tow5QeOYSIwfD2s=
X-Received: by 2002:a05:6638:480a:b0:38a:3357:8a4 with SMTP id
 cp10-20020a056638480a00b0038a335708a4mr10497374jab.53.1670656487709; Fri, 09
 Dec 2022 23:14:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1e02:0:0:0:0 with HTTP; Fri, 9 Dec 2022 23:14:47
 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <tracywi178@gmail.com>
Date:   Fri, 9 Dec 2022 23:14:47 -0800
Message-ID: <CAAxj-_gMgHp1MifJ=zdch-g6pOJ2WmXd4MLJ2s2oRbf=i=71Qw@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d2f listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tracywi178[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tracywi178[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava

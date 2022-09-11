Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850E65B513C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiIKVLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 17:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIKVLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 17:11:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046AB17E21
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 14:11:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id go6so2031864pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=neMslesTLFGkDrNSg5TMEjVXMqr7T8WuoAoV+VgMUco=;
        b=ZYUWtNVE3bSYBAE0i5Bu0UFAQd2Q4jsrFrqpQlz4+2kMYbe67idp/t4jjVFkun4Xmm
         CtxoiUzN2zwLSBdqUlTO0/5II0nFx/DdYsp27HDtX6KaqARQABDkG2pIqvWQSAc0Kg0i
         UJ/ZWtE4ogjcDLPDH2sMkRyJ7XBkgegZsu1Y8kFcGFbARJ8E91EStH7xhT11AOs+Zo9f
         EHB3byTHKH325zpMhb5FFe3DclMQkZTs3vqv7yHj765LgQ+T1F5Db0sC1AhayQGd8JwQ
         c1+TFUJGd2zd+e2tnf6uj+1Yw+zyBGKBumocsEn3PO2KhTLHjNtWyRTxgecOA7UQoo2k
         sokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=neMslesTLFGkDrNSg5TMEjVXMqr7T8WuoAoV+VgMUco=;
        b=4LN3aeW4/stOH8cys4AsBeMjqi61o5i9t7GxjoRHwI6sNrLaH3hafkKPAn/kiPK1Wq
         oKbFHfEowV+hZeHQnLL6oyCqTR7KDPwBoY2l+z9SxxYUettxBjrNwAVRsB8eIMMoj3FU
         UZwbfHMrSlb11WmFHw+Cp8Mga4jAzBoGJccs0Y5VKFzuN1qljgZg1N3Qj0b0Ro0eh2uv
         vG+pRZwnz0BD20drV8lIDTcphphKPYKXKkHpmR65e4yRYWO+JzN4ncJAPILt6Qv5Gb/t
         56a21tthFsgrOa+fx5DsLLnHpaq6uBV2L77MGze9ndf1RYf9dK59ClwYnZdJze6bxfBR
         zIWg==
X-Gm-Message-State: ACgBeo3mIKxBvLDG3mtn6Tm/lQUdY+uovOb1FZ3UUdkgfqb1CeJcKoPC
        eVeTslfZsgznIbh+WbfbkhPVKMTPj30OrHP3JDk=
X-Google-Smtp-Source: AA6agR5TtDIqz8zJE5qU6jGx1Z7RDe4QrGvaDZoBBgRC31ghdF/9c/p/t6zRjPg6ZSqs94v84yGAXW5IyBgwCiPEQbY=
X-Received: by 2002:a17:90b:1d0f:b0:202:be3e:a14a with SMTP id
 on15-20020a17090b1d0f00b00202be3ea14amr5511840pjb.102.1662930711467; Sun, 11
 Sep 2022 14:11:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:3112:b0:576:a9c4:be04 with HTTP; Sun, 11 Sep 2022
 14:11:50 -0700 (PDT)
Reply-To: zjianxin700@gmail.com
From:   Zong Jianxin <joanjeropngetich@gmail.com>
Date:   Sun, 11 Sep 2022 14:11:50 -0700
Message-ID: <CAHmv3xbsEs25=JhEi=vyk2vfScFwN19KSSkROzbvCMcO1mHRFg@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4966]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [joanjeropngetich[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [zjianxin700[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Did you receive my previous email? Please respond back for more details

Thanks
Zong Jianxin

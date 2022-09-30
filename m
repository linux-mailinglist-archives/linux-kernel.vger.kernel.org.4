Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ECC5F080D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiI3J5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiI3J5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:57:15 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE79B16EABA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:57:14 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13189cd5789so4858303fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=DQrk3DT7sCku3N/92bipj4Vfdh8aiH3S8qO0itMTRoY=;
        b=aAYTnEsh16dJstAc3UmdxNu7PWX4GfcoPxBpJh7mZWfbAC7EhEKaqRDhCHpmeO7BBD
         n4idNs5jRAatnk5IXRjJG4v+zji5dOBoZLHEFPHI7JtuUDDF1eOH4QvjeVlYoo2QJXTB
         npX1R3JxXDa8tQHustibmwPS8BAA/cNmwLtzvETENzP8HMM/mpzmb3gVRgEpMN0enzFH
         wM+2UXmtIcVib30oAXRIp8pPXQ8lDQbXU0gvy4lg595XRdnACpJkwLpGlEK4/dPncqZ7
         HtsxUL6DT/JFvOi+E8xMJe7j+C9Ih3p/kkHbk/ygyiNs9OrB1DZZcueacK011aWIU1FY
         cjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DQrk3DT7sCku3N/92bipj4Vfdh8aiH3S8qO0itMTRoY=;
        b=ClTklEk54b4iYEa/+sYzQhJr2bFFkeUwVPtrWaZRiOk47lrgIaB5S2yRKt76MoJyqY
         snH9kGiwOd+PFVjM65lVZYoI488yGr8yNmCNph+Mqd86r/wNXosiHg3NDBOGPf7oP/XV
         0obppDFwNcoT9eFdx6199+Dk3M/yvS71FWbaHHK5OYdd1G3SmVDelmxYncplXRl6bPHd
         YIXfl4qA9YSxWw854EFK4JFlOY6m3T1VxVei/yPtpsbrW6L83esrv8G+j4DAR02/rltE
         vt/+TWMtDkCCPDuXDdgoOXlMc6koXTAcuqHMi8jsFKwxCwIgcEa1jv9pO3Z9lT1M+7Xn
         llag==
X-Gm-Message-State: ACrzQf3Tjo16PpBh1qudBWjAWCuL8t9iKRtd4fO4SOT34/Lnt0szKZ2S
        lKtyu9RqArwWPhPNWyD7r/eQFsDdTXJ2kxJWMp0=
X-Google-Smtp-Source: AMsMyM5npCiNvw+5p5YqsK0hxu1NI0B0e67qmljWIgitV4w4DiplDIt1gG5q9S17W4cLPSF8xa1PQ+aAz908LoYQToE=
X-Received: by 2002:a05:6870:d28c:b0:130:efc6:9790 with SMTP id
 d12-20020a056870d28c00b00130efc69790mr11642616oae.2.1664531834026; Fri, 30
 Sep 2022 02:57:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:785:b0:c1:231a:2884 with HTTP; Fri, 30 Sep 2022
 02:57:13 -0700 (PDT)
Reply-To: joycedavis.usa11@gmail.com
From:   SFC Joyce Davis <johnayite555@gmail.com>
Date:   Fri, 30 Sep 2022 09:57:13 +0000
Message-ID: <CAN_3t98MPYv-uMsXckUBOSBRLOQ916B+Xa13z77PbUwVF3Xqhw@mail.gmail.com>
Subject: hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [joycedavis.usa11[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [johnayite555[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [johnayite555[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to have a word with you, it's very important that we
discuss it as soon as possible. i want to share with you.
Thank you
SFC Joyce Davis

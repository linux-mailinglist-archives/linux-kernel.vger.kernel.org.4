Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE402607F30
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJUTk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiJUTkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:40:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51E92A73B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:40:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id bk15so6493504wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCfubAeNznnX/AzluWAu7NkPDRYfii44G0R9B/8m2X8=;
        b=n1I4AU3USkOtGuwn+2O+mEazB6HBRndTQcLj893hetIl57S9277pvxqdWZpHd4TMxw
         d+l2EcVf+PhGL2fI6nPomuri0PyUbDjSultAu1lJ00a+Ersbogeg5f1FLJYqivV6I3AZ
         RQT6uCFlgd29X1VB2nqA9HODT09bYkepuGrv2o1oQhsuB1hCO61vuftEiu2xq0l82iH6
         Wh/YGRumwZQtkBVZjk1ql6d5208Vs+JPuItNsieIvvDRbVXDGbaXcl0bmr2TXfjy0/v9
         pJ4+9LKj4Ajpa13E7D+0IKkjQkQ2M+kjXipqJW2cIbMUWCsNNqWM96LySA4lsFg65V2n
         WQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCfubAeNznnX/AzluWAu7NkPDRYfii44G0R9B/8m2X8=;
        b=qdiuqCaLVoW8EKY/XRzuUYvOcds7fGenDRRJ22OXR66cQ9qgKKFIBozXLl7PMGDOmH
         R88si3E6lloW6O8sXEf356ISwbprevJFzUGASIVJIyMmVFEO0eJbdFOpDYH0SfOY739q
         Ri7LqicQZ+OEM5VYOHtafSrRep0MIfOph70CJbiZ4A+rlnjOjki3qAV6e6UUastlmhLT
         8Ta61iwoAgjjht0vRKwXdWfg6QzwU69k1rgJF2BL16oaYnq6oO7ERdSURoP1L2eGbWB1
         EVwdH2lsPd2V9VyaadZ/r04GKTegZt9zuNkAiLb4lbn4H3VFxZfW5sdAuz/lBGzZ7iQp
         vrSA==
X-Gm-Message-State: ACrzQf3zc5HLIpNw6IWj/AJdxOaN3dAkG4QQ7uOfunIgxXJuamkxtqV5
        xG+Sa9ShciuefvNML1L9afPqL/Jh/z7UfFEUzDI=
X-Google-Smtp-Source: AMsMyM4ewzan4N6kzc/SprmL7GXilFSncZqiHu8uE9w0v4FJCYHlu72IMCElIi22JluG0cz4Cw2BqjjXlCF7p1Iq9a0=
X-Received: by 2002:a5d:5a82:0:b0:224:f744:1799 with SMTP id
 bp2-20020a5d5a82000000b00224f7441799mr13272364wrb.582.1666381216188; Fri, 21
 Oct 2022 12:40:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4692:0:0:0:0:0 with HTTP; Fri, 21 Oct 2022 12:40:15
 -0700 (PDT)
Reply-To: usdepartmenttreasury63@gmail.com
From:   "U.S FINANCIAL DEPARTMENT" <emmanuel84968@gmail.com>
Date:   Fri, 21 Oct 2022 19:40:15 +0000
Message-ID: <CAOCfXBR1FbdEQg3+VH7L8oacjvP21UygRCPu49AwKgxozzMb-A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:442 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [emmanuel84968[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [usdepartmenttreasury63[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [emmanuel84968[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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

I have an important message for you get back for more information.

Sincerely,
Mr. Marcus Hamlin
Deputy U.S. Department of the Treasury
United State

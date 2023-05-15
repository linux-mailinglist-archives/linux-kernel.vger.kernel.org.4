Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4100C703C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245159AbjEOSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245110AbjEOSNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:13:09 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDEF18C95
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:10:31 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-559e53d1195so186803987b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684174196; x=1686766196;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2awcT+0JgCeSvbodyRK5wx8XefAu35aN26RnKecP3c=;
        b=II8OM+hqNliPegdvKwjXlWLcMGHQHEa4CfQSk/7BE+V1KwIG7MGi7x/8NukC82M/L5
         212m7GAOW7PGjlLZPbDSkSrsXnbGRLcAkvIqKOcnp9XPG7+lRjrGLWV2UcOh+TS4xFWK
         iay2vDb0DJhKXszG4DrjHCclf9N+NDQ2b1QCMoZJzQwMDFwdxNAxt7vroQ5veIJpAbg6
         MXu951L6wM2pEJbf9Zvndj7Wr6Y7aOT/CP6lAur0498feUfyhvBltC5R5kghUn3A3cKv
         bzzbHoGDlrQzYtGK4OnJ7QyEuc4PCcSSlhsU82ykdFM3XcCsPyIkNn/DqLJpB/RccuNc
         I4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684174196; x=1686766196;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2awcT+0JgCeSvbodyRK5wx8XefAu35aN26RnKecP3c=;
        b=WCbsfQJ0liOgP+heNMPQu/cyPNIcqMwwDL0TqD8lM7B9WxjZFipIvWVg4u0ClRFkHY
         tZooLvr1zJp0TpWgcrhB9Jbu9aAlYGu9mp4zElcxR1DM9VgBDQLQ0tyxFE0ykRjMvxk2
         0gggSnfVUa9yhYgFs4CDiBBT5xXGmGAkZ2cMd3Z4cA0mmn+iCQrtYstzn+lado34TDJm
         iRew037a8me0Uq3gEUry0H+aj/4BqBBzNtzrccWRb5g93cHg4M/eWXGtvn5Xt1f0rQuf
         RL5zB4MmqWjnYI1zNgp0eaAziYMhUQKggyFfpuINXe+YU6KOi2ghqtGSNGuHMXXLLTmp
         HI8Q==
X-Gm-Message-State: AC+VfDxFMKVzfr4cPcQluFBwW4fGLN3PqVV2UMz1zf/U5zQw6rzu4xLb
        7Fi0OPxAuEcofB2sxEVUANzStIMByfAEGvibT9c=
X-Google-Smtp-Source: ACHHUZ52YE3TLfouPusUDA2QxJogPtTkZ/kcH5jBj10kLMmZZ+/PiHLTHZ2qTm6whnsebVS4vP51MM2jULqHO9wMRpQ=
X-Received: by 2002:a81:6e8b:0:b0:561:206a:ee52 with SMTP id
 j133-20020a816e8b000000b00561206aee52mr8112038ywc.24.1684174196050; Mon, 15
 May 2023 11:09:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:962c:b0:358:16:da29 with HTTP; Mon, 15 May 2023
 11:09:53 -0700 (PDT)
Reply-To: drlisawilliams53@gmail.com
From:   Dr Lisa Williams <williamsdrlisa@gmail.com>
Date:   Mon, 15 May 2023 19:09:53 +0100
Message-ID: <CAJbSCCQyrLrPhY3=+x+2uXoYaZ4iAOhrXVQh=pucw6u-PsxN=w@mail.gmail.com>
Subject: GOOD MORNING DEAR.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1141 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [drlisawilliams53[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [williamsdrlisa[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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

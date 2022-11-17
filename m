Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2EF62CF9A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiKQA3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiKQA3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:29:10 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7AC45A08
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:29:10 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 63so111043ybq.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptpAuz6wBAg9E85YTijlWlQ6KM9q6IpHeJLRCU6Du2A=;
        b=k0Ok9itAisdvfhbOrqbOstzQTbmJard0gBsiRnI6b7MXOgiNlA+NJ1gfYXFW7FVp5r
         v8SuuIVKBrOpOF/R5mm1uzgho1e0ZkSb0AI7Gku2WhUu+eJ+l58GsYTG2BEbXYUC5Loh
         LPnwdfI30EyIww/fPHiGQf/JvBr5beZd1gCDBS+r0aY52z97Seb99yLsSd12Uq8+S2nZ
         pCtLINBvr0f0GYTX4o6DR/KjlUVpjWNvt4dPHHCql1OFXlZI5Sy4Mv2tv/gGNQFC5QPT
         +4ZkgNuAIiaibeYNiD6NYy7Sv0PbOSqixVWZDpaC/SBhXCX8O/VmToiph8CdHcM7QFLh
         I1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptpAuz6wBAg9E85YTijlWlQ6KM9q6IpHeJLRCU6Du2A=;
        b=f1ALeHwKdoJb5tGOPenpE1f3TycO3Y2RosQSd4OjJqR0D+MCW4wk6jZYn6VwfAgv+z
         IfsEg5lWvKzzamuRrxw+Wtiy6tMMh8yLkgWhAIooWm6bsJMznGgcRIDG4VbUD7YzDY5x
         /Mf/yuZSb8NJbOFSTBJwXx35qfhJA1EXvd6rIcZrp1dakSVr+0rfhC6S6ZmFr1JQxtEY
         S93unNCHQp3w+tlzDZnNH4NMNX9hnXydaaWg0THMZooP66SDiRP5z3b8TUQ5qZO+jrkc
         AON3f3j+uCEYxs3WrP1g890n+fIYNFCqjmtFMmHALy9M8O5r0tx/bbi0IvtkuXjrb+xu
         hrfQ==
X-Gm-Message-State: ANoB5pl7DB7q/7Vr4MAmKQOmzGsh9xco3l0O9/Ob5b0wzgpDJVBOw9cY
        Dknny16na6O4m3RPQPhJ1CxT0uMQdfgImswUQLo=
X-Google-Smtp-Source: AA0mqf77MWqNBK/J+kipbNJ9dneESQ6NgoMujAtx6Q0taRn+Hd/HWjmCqXU4SmMEEj/IPuyQT3oTWdNCka3LLJjs+Hw=
X-Received: by 2002:a25:2613:0:b0:6de:a395:564e with SMTP id
 m19-20020a252613000000b006dea395564emr120306ybm.490.1668644949481; Wed, 16
 Nov 2022 16:29:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:84c7:b0:3bf:566c:3677 with HTTP; Wed, 16 Nov 2022
 16:29:08 -0800 (PST)
Reply-To: gregmsgbox212@gmail.com
From:   Greg Pot <ibemsgbox20@gmail.com>
Date:   Wed, 16 Nov 2022 16:29:08 -0800
Message-ID: <CAEGNGnJtn3GAh4M8KKNT5UtPRY-SP41JSGV3P9PXq3NcvP-q8Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [gregmsgbox212[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibemsgbox20[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ibemsgbox20[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Would your organization be interested in supplying raw material from
your Country to a biotech company in USA/UK?

Regards,
Greg Pot.

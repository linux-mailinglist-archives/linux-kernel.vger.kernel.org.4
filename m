Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F02C629FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKOQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKOQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:59:24 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B332657F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:59:23 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id e68so15054279ybh.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DSlfSel3yRE1C1IwW4OrAqTmK3GNN9Jwi8kn6ihhjw=;
        b=Gk3LHfJX0PL1KaQBnsfQKkyJsix8VYqJ7WYEMuJm34ATmQw5GIHiZkolfhm88vS3xe
         v8nDraL+J2tbWc0qrVpOQNQh+f5L/MeJQvg5TMSbdmBXp+Fj1uyX802YfxqqzEDF1b9W
         9bm0pNtVahkL1ARNLD7uuMIgJLhP0EyrYUwPWSLdLn7hIkNCbuoPTI+XS9gfS7ssY9RF
         PSzZ8u3y8xlBYcBiFGv8MWPy/Zo1MoPPojOMY9EWpaE/M2pVDNqikN30oTLg99DT2fz5
         0X34eSvm2WHJG15NHgoxNtcz0w7uR9+BbrQFGGU1LnQDDEOCmg0XZW/G2IxvzCsk6Run
         Evqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DSlfSel3yRE1C1IwW4OrAqTmK3GNN9Jwi8kn6ihhjw=;
        b=s8ZgSz8Ufyb3mAaQ2Pru7gLbvAPUZd7uSz+uc2TJGcm/GTViEM2WXCFvEdCmh73oWA
         PoPqdn/Gh8u84XQUEQ1Lesg9qKnnzRxjylS5Qjbc5VMKH+IBDC144idFYHqhy4tWiLtG
         REQslH12KpqiTlEaMx2J6zQoRCFoOIPLFwNogmWWmtKxY9UluVrhfOliDIrCmwk8E+Xq
         FV3oPRe9HV2blO4gT/65GrK6aDQETfqwaj02L9xARdLE7evlMcQ6EFSVUeiOXxjSYXBU
         3it+JM1tZ5yE59DZvzx8tnqZA0SiBonUn+Dan8PPXj+OGRdKxxXk1n+bNuWueKQmLeee
         i4tg==
X-Gm-Message-State: ANoB5pn/eZ0Nxr2rwHy8CI7WS69VZKPYdfEIDBfbPchzMWyD4xl1/uDt
        aEvuQ3IKjKOrV5+Cgt3tqFPNcwj+KcyPVnegxb0=
X-Google-Smtp-Source: AA0mqf7NB9kixi/5NOpqobObIZ6sWXZ624+rQnnx9WA4W4v//Y0sIS5lDZWRHMShxYvHJuOQLiDss9LgX31r/i1Ahss=
X-Received: by 2002:a25:ad14:0:b0:6de:8ec8:7342 with SMTP id
 y20-20020a25ad14000000b006de8ec87342mr16158634ybi.607.1668531562370; Tue, 15
 Nov 2022 08:59:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:989a:b0:3de:29a7:6631 with HTTP; Tue, 15 Nov 2022
 08:59:21 -0800 (PST)
Reply-To: mr.rwilson11@gmail.com
From:   Richard Wilson <richardwilson0012016@gmail.com>
Date:   Tue, 15 Nov 2022 16:59:21 +0000
Message-ID: <CABJaJH_pDFVuTs=zXzjBVW=bf4D5XitP8WcwpuP1Z8i+MMrayA@mail.gmail.com>
Subject: Deposit
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
        *      [score: 0.5147]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [richardwilson0012016[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.rwilson11[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [richardwilson0012016[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
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

-- 
Dear
I am contacting you to assist retrieve his huge deposit Mr. Alexander
left in the bank before its get confiscated by the bank. Get back to
me for more detail's
Barr. Richard Wilson

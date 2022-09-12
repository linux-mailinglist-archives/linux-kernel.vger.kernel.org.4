Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432E75B5900
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiILLKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiILLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:10:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B813E9C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:10:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z97so12170947ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=mCOkIqCvt6ZSae/V88P0bDeKu0Tur05lOeHs9gogGPo=;
        b=M4v9GARHbj0P65xwfiPzwUrylloYP0mvQc6VoX43SUEocbbMZzILVah4PuTfyEAZPg
         hPGngTmScAc/iDEr5iz/Z/a/tkRPrk4a/BuzBhy+ldOf3y6KhG8IUo1O8Y/ksw+3OkoC
         D/8Z84Hn0gor4vxKNSPXq2FkjOTH63kiZLWU4aFDI2wH3YBh/YDuhHV9PtSl/AdN0mIn
         uCIugCq+UbgSsrjJYinVe5CRmb7CbAqQvnJJ6YoLdN0h8P9EFHBUyMKuLyHw2sqS5PKe
         gnn725uTOKQIQv7j/GGdP2bGj0M+UN14BPOsKqJrMSSrTHNWhHmVOCWb9f58VTWAPs2V
         H8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mCOkIqCvt6ZSae/V88P0bDeKu0Tur05lOeHs9gogGPo=;
        b=i1t8HTZOKDw7LxZLaeZlwVUBXUFVj6030qgJ4glMdtOSQwWi3mXSxndh3yvQBp1/ni
         HV0VzjCcromgtvicNYo29OTdaQhJ2Fg54KJDU9tOfqIPsasWQjYluTv6t+u+Y7uBIxH2
         Co7TzhkwStSUft+Cxm809tWMLgb66ed8EEorq/9fDJZaXnKkVz9R0bzNhc24GuvcvTP+
         ea2wK+Ve2IwNq1edQEXEuvlajorlOrLqLt4f3cm9sAKCHodxRXnAbEQGLKMpvo2R1k22
         9trxHeus3CRoZROYN8oP7mOUftfm0y08n0JHiJ89kSPoOyeDk9vJp+O7MyLidf6UD464
         64WA==
X-Gm-Message-State: ACgBeo3kJn+5lyYxT0fTKRFhs91GndfQ3i6T5oTxBp21oiKiVxKJjqlz
        xOkhM5XjfzsLXPEzdMyVRr/QVmM9h6pG0b2y0kk=
X-Google-Smtp-Source: AA6agR5sxVPLJOcpayBDd+7c2qba9x+vT0Y8mYbj4M5BKGoVmCwCsn8UnFWVMoigh9g6kJrI1hvNH9QsQp5ejnJgGeo=
X-Received: by 2002:a05:6402:5179:b0:44e:d177:3a21 with SMTP id
 d25-20020a056402517900b0044ed1773a21mr22275349ede.20.1662981011316; Mon, 12
 Sep 2022 04:10:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3e43:0:0:0:0:0 with HTTP; Mon, 12 Sep 2022 04:10:10
 -0700 (PDT)
Reply-To: boudelal90ahmed@gmail.com
From:   Boudelal Ahmed <sir.david.blunti@gmail.com>
Date:   Mon, 12 Sep 2022 12:10:10 +0100
Message-ID: <CAOmfjEy3hc=k_KVo=7jJfkyTHxUUd+VJPSJOSAGSBHw2AacRVw@mail.gmail.com>
Subject: Good decision
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is my pleasure communicating with you today.  My name is Mr.
Boudelal Ahmed, an Algeria man living in Istanbul, Turkey. Can we work
together?
Kind Regards,
Boudelal Ahmed
Tel+901711- 232810
Tel.+90 532 291 33 25

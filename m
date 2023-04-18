Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2106E5638
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDRBLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRBLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:11:20 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D94D40C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:11:15 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a9so25114162vsh.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681780274; x=1684372274;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pOZWpHPONtN7zZsVX/5fsJwnQY3VExlQWj07foyji3A=;
        b=sQta8dS4v6QjbacRoEX+3emtAM7anNzHsZQqTRdI4BU9olLGWAJbgwkd39LNsAOOfZ
         tME8s3iu8idRsA8i+Hs/r6sUE/3dDWuG6AX68TWFHriWHzRgyhOZLi1UvxdIXchyaus0
         gr7rBaAt9mkfWxD+n0QjJZH40r6LEkqtqxNAGwuFJaiaRU1n7IGeMLn8ckH6cqjbtI4e
         f6JrhKvgYwh5B9cOGn4gmdZIY473CQ916cjHt21DrYDTv65FpRrtRuO/9KWQSNVnpBwQ
         6SjnV/YFGgXvJQ35dNBdA8nZePVEgwdVDEhIkgZdAwJBKarwHhisj1SXxiirN3R/bmbP
         hSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681780274; x=1684372274;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOZWpHPONtN7zZsVX/5fsJwnQY3VExlQWj07foyji3A=;
        b=XHqH/oDnDB3Ro7YCVBsZqvqk1S0/bo+V65L8wyVQvCtzvck9o9PdJz82yphpgNEXvC
         T9+xrqsGoJ+wXBjEUCpaLaD1winTsV/pWE/AEZm652OrpEvUdqwZYNfYwGJkLGNJJzeE
         EKuEQD0nOOvNMIJRhqry/4EX/e+bZT9zqhL8zqgwKXY1Cq8ztFTjAz0QP6kFFObmHxxW
         4qXnPv4KdgM9HW6RqKV8S8MNkqpNTYxjLOPVOdqLXB8TWID31lDe1d3w8kOpsqF7ldHD
         8WWRABsXuyGrgN75BQO62wyCd2aViLRSCi/vzyPxARVu6n4FDF/HRjTh8oI7M9FryM7p
         4TLw==
X-Gm-Message-State: AAQBX9fjs8Vmd0LkGXrq+tB98dDqb6l1IKrigwuax1B79GCzDuZNZRbf
        YTUiYsy5XTYEe7p9S0O15fTyD2MPJa54OBxslYw=
X-Google-Smtp-Source: AKy350ZbL/23W7VrPqiCqHw0RQUHN/19JgcuB+fbJ9qlP5XCo9lFlRBrFmpqh4mchTkARDrl2ENe//Yh2L3oUMFpw6E=
X-Received: by 2002:a67:e1cd:0:b0:42e:5599:7021 with SMTP id
 p13-20020a67e1cd000000b0042e55997021mr5369210vsl.5.1681780274465; Mon, 17 Apr
 2023 18:11:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:22c6:0:b0:772:9f37:85ec with HTTP; Mon, 17 Apr 2023
 18:11:14 -0700 (PDT)
From:   john mike <johnson303mike@gmail.com>
Date:   Mon, 17 Apr 2023 18:11:14 -0700
Message-ID: <CAE1oSEf6j8CQhUbDSX_o8r8svX-QR43CVF1EsEAfgUTgrtHU=A@mail.gmail.com>
Subject: waiting transfer
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valued Attention
Our recent record   indicates that you are eligible to receive an
optional repayment of cash fund!! $750,000.00 which has been found in
the security vault registered in your favor under your email account
waiting to be dispatch without claims.
the account is set up under your email address  can only be obtained
by you (receiver),all  you have to do is to provide
Your full Name.....................
Direct Telephone: ..............
And delivery address........... For immediate shipment
Thanks and anticipating your urgent respond
finaccial@citromail.hu
Yours faithfully,
Johnson Mike
Section assistance and   Verification committee
USAfro-Euro   Debit Reconciliation Office

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27847677242
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 21:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjAVUQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 15:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjAVUQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 15:16:29 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9525113D67
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 12:16:28 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id jr19so7042567qtb.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 12:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=MV93Rha993qbgUM2fIbMtzal1h1y1c4pQf7btEiAgwQqR481g66Y7Ewh4oODMlYsUM
         By5j0l5vOmH6l+W+NZmEbKwPAhZXTqCwcwJLFUygODy3v56yPlUEYDWPsoMpIz1NBoue
         KU9UDyo0RjRxNsN2TrQUfVsN3zJ3VNpmmLl57MNSqKal2RU2vB6XK+MpvJRihWkz8S52
         eQqxmEXVxvEDm93wr4A9UY4h1LtriliIpsPmLt02FIRDijL0RvfBcL6X9uU94pkIiPz6
         +my7znDUEH/Wf9SyMrgMHGdyJqQEIcrCaCx4QdWJx/MKRiUF6nob4QtSuOjPq5sIuhTQ
         6zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=ckrbYQNyA8mKbocQY6bJR5L19vQWMEepKdMjC+GBY20Eo18VbjbgJAWe+Cdul6sBtk
         TnAUG//z+Oqn6kRAe4jiKXYrcn9mwpHWHWFvtn3e+XehyinRJ2nn249PrFGyEkrSO5/c
         axr/zfDYbijkhtx5m2VJjDe2JToOW8SRf93lQx7fw5rXsi50cAlCd6EdIuTULu9iJp29
         Czsfp1gyoQt/legbiTAixEZmPm9bzgTYUmrh6Y1Cr3K/DkKksJJcU95kHECYTR/6yp6f
         nDnNjyvocpi091kWLHkLx3+aW8iACoKYuG0petcp4SyVmidoL2+xE4b8NcCjenOG1Ib4
         s8Dw==
X-Gm-Message-State: AFqh2krqcem3vIr7Ueg1vNPYSx12SNGj/NscuZX/1l0NDhGA7d0+fQor
        KMTFpm+2sufE5sYMSEYvNJ9gKwIzyPiIVvk8Naw=
X-Google-Smtp-Source: AMrXdXt0Rc+AMJu92jc0HWagyAERbfyK7MxCY1fBJyaJX1KGLWg6++jghdky9dq43vgi9vpDU+5lzI2EUQZuW1jP2Q4=
X-Received: by 2002:ac8:1497:0:b0:3b6:30bb:934 with SMTP id
 l23-20020ac81497000000b003b630bb0934mr996136qtj.499.1674418587187; Sun, 22
 Jan 2023 12:16:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:622a:448:b0:3ab:9268:4e7b with HTTP; Sun, 22 Jan 2023
 12:16:26 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <mrhamidouabdoulaye@gmail.com>
Date:   Sun, 22 Jan 2023 21:16:26 +0100
Message-ID: <CADaEA9Mgx9DM=DH5e0ihFRUmE7KYV15CBUuoe8T4dr2=0s1NwQ@mail.gmail.com>
Subject: From Dr Ava Smith in United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.
I have Dual citizenship which is English and French.
I will share pictures and more details about me as soon as i get
a response from you
Thanks
Ava

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E02E5F43E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJDNDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJDNDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:03:15 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B04A61B2F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:00:38 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id q11so6249003ilj.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=eVKfZA3SwiGf8qlPzooH70x5W9OPocalRMd2pDz1Njs=;
        b=iiDFnAI+tLNxExgdWvqn6P6QnuZKv9eCoj3Ot4CEKA9Jm10ivdkVOb31X5HR3FqlwT
         iiLuISqkFVlsL/JqqdvMWpMzlocBRBro8nAunu2Pf6926unXwMmuADuu5Wv3V7WzKbwr
         PdXCqy1xd4vjeuJSAXnm+pAs0Z41fTt04Vwle3pY4o51okcdPkttYW+nDWSIYwBDhcDp
         P6ea8jESWZQ6PlJnN2eal1n1+/zcwkhlmoEYo9cNO1Ec4UY2zPuAAcjAzXxDVr5oxlYe
         D0oLjDTb6D5DGiBdwhYhOqmmWmDCcxIIrF6DpKU8JkTdu79MUntvEMebg/GJJSHA07jB
         tyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eVKfZA3SwiGf8qlPzooH70x5W9OPocalRMd2pDz1Njs=;
        b=PuOaWCAHNBE8eNuRA0O+JPTb28PX240m/6zp+vBnFkoFD0iKd8lQOhLeWg2lER7ihY
         RjtbIntBmFWBwJmomWcAMUkvLQeme6LV8aT1tmBpGq1nFwJXpf+9170GxQ+0N+Xh2UP2
         H+QCeTrv68elWhoipZUe4iQNG7td/iA2E2862HplUOBf94lAuPrWNN01GYvquxB65wkr
         WHHtPhzJBVzX9SYJE1EpZk6VdO5L0DuOWw4JWYMmIWKnT+hstmqEzwGc9YmhgXBRRcep
         gd33wCBh4t40geLlB03t7kCM7Depagc3WWWghaCQynJU4WWPle7WQ7yL8WMvDA6uwSvc
         idhw==
X-Gm-Message-State: ACrzQf0SjGNMjGkNFXj97FxqfcflFEzH6VQ25QSDNztyh7EEkC/mBM5y
        MvMif5X8LWzCIA2Mx3fdA3nZ8vwXP8Q3RnlHppc=
X-Google-Smtp-Source: AMsMyM4VC1u/1DHs9qFWWaSdmmuPyXUdNAZY5KQ9z3hky75uxqiCHbWyKkEFG6urSYR6hTa2sl8gLG+Ma4fS1KqmgzU=
X-Received: by 2002:a92:1945:0:b0:2f8:c7bc:b339 with SMTP id
 e5-20020a921945000000b002f8c7bcb339mr10840267ilm.171.1664888437521; Tue, 04
 Oct 2022 06:00:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:4b87:0:0:0:0:0 with HTTP; Tue, 4 Oct 2022 06:00:36 -0700 (PDT)
Reply-To: mrs.feleciajonathan001@gmail.com
From:   "Mrs.Felecia Jonathan" <mariamemariame047@gmail.com>
Date:   Tue, 4 Oct 2022 06:00:36 -0700
Message-ID: <CACO-VYLWu4ULz=w-bAejhk0Vjuyh3N8FtbVfzG_dc5JuJZeC1A@mail.gmail.com>
Subject: THIS IS MY WISH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:12d listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8068]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.feleciajonathan001[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mariamemariame047[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mariamemariame047[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Am a dying woman here in the hospital, i was diagnose as a Cancer
patient over  2 Years ago. I am A business woman how
dealing with Gold Exportation.I Am from Us California
I have a charitable and unfufilment

project that am about to handover to you, if you are interested please
Reply
hope to hear from you.
Regard
Mrs. Felecia Jonathan

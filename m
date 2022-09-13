Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8395B7692
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiIMQfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiIMQfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:35:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F67513F4C;
        Tue, 13 Sep 2022 08:30:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so1838782pjb.0;
        Tue, 13 Sep 2022 08:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wdXJc4cOP2OBanHA5cgFEXNr8vURWUWRGVRnE3vx/QI=;
        b=Gi8gKLK2wERK5uNEY4abb4G4eHhfJBGdgVCs20+xzEFcEUSgl68r/rakyb68hSnupu
         gkNZO17hLBlvKZN5/8FG1/qbNTTZpYaKnxFy+aMDoqp1fhpaqOJQPW2SZWxOej+7HQhe
         yoV85cRJhC63/Ih5ditoyEyRPlUN8xhIHEsR6CRkkxQ0vzdhvJ5WIwV4+JlcME16/dur
         swp0jHCFG2WX7WHBL2WkX2mWgLI+kd1+ugD5ZokC2+DodV64t/5WbS1kDf17SCTH/n5u
         CcVH6Y1KkY82XOxCf2IjbW9IfWO6/BbCNtNvK44piDDiFpCD3RwlFRteLgfm60O4EXFi
         5HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wdXJc4cOP2OBanHA5cgFEXNr8vURWUWRGVRnE3vx/QI=;
        b=nvoVJeZ5CyOBR5mdOQ1EwDytvN9bQGB7ZSY7r+AX07Zy7LVZkQw/QtN3aHC6eTBvUq
         meUFbt3m/xn8X2Z6YLTCPZQcJt4W+fdcENRgNuIME7V0Yj+/ooxwsCGbjgKCWHY7hVx0
         fszG8dzGZIpNkVj48sURZ56TQCdc6R09b3zg97dhCL49jhI4gPs1/dsnJIHv0iUElqcY
         +cTFr5KZZisE/6YeSCgkeSbtymW38Ku+1rIu1qXNlyngdYMxeY9Soew+Rdppz6JCWgt7
         hpUILTRIKgojFX91Ciq5P7YCZ0bqLS+UiKRQY8vSp4HeQ6Ewc2TXmDZX2dP8JIbL4HnY
         vUgA==
X-Gm-Message-State: ACgBeo3QFkL0B2CxzNRJ0x5k+YCfrnxEFvxlz5ba5fAPF1zY4lfSND3l
        L+2rDL9NVyqw0beBhmcUpW4=
X-Google-Smtp-Source: AA6agR4+WK7BbMgNUMHNP8zdqPSV1DQAbXELqVUe3+Tui14DERAWMK+4Q3GcYF4NfTiInlDeMgZnwQ==
X-Received: by 2002:a17:90b:4a43:b0:202:8d29:c172 with SMTP id lb3-20020a17090b4a4300b002028d29c172mr4487010pjb.177.1663082900141;
        Tue, 13 Sep 2022 08:28:20 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090311c600b00177ef3246absm8697930plh.103.2022.09.13.08.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:28:19 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        91tuocao@gmail.com
Subject: [RESEND] docs: x86: move do_IRQ to common_interrupt in entry_64.rst
Date:   Tue, 13 Sep 2022 23:28:01 +0800
Message-Id: <20220913152801.30966-1-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_IRQ has been replaced by common_interrupt in commit
fa5e5c409213 ("x86/entry: Use idtentry for interrupts").
Move do_IRQ to common_interrupt.

Signed-off-by: Tuo Cao <91tuocao@gmail.com>
---
 Documentation/x86/entry_64.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/entry_64.rst b/Documentation/x86/entry_64.rst
index e433e08f7018..4f12152570e7 100644
--- a/Documentation/x86/entry_64.rst
+++ b/Documentation/x86/entry_64.rst
@@ -33,8 +33,8 @@ Some of these entries are:
  - interrupt: An array of entries.  Every IDT vector that doesn't
    explicitly point somewhere else gets set to the corresponding
    value in interrupts.  These point to a whole array of
-   magically-generated functions that make their way to do_IRQ with
-   the interrupt number as a parameter.
+   magically-generated functions that make their way to common_interrupt
+   with the interrupt number as a parameter.
 
  - APIC interrupts: Various special-purpose interrupts for things
    like TLB shootdown.
-- 
2.17.1


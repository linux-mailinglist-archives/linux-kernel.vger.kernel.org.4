Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955DA5B479B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIJRNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJRNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:13:41 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1420E32EF6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:13:38 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 129so4811003vsi.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=RFA95P2sfKzmZYQGrCdd3AMm9JCqz+tKjJnaICBO+jk=;
        b=oV/hNubUuPdfc5cVkSWOnN0hXsssmgcuGX5Itlbbaslk12llYQ6/St6snUKuENKMbn
         PZ5o0FSz/rNWydqGdCckuRO7/qOcHT/OX3VDv+7GWE9goOPF6KOOa5ZbpDaLHcj3Hsjn
         2jV355xd8omxwWsHctoM9VD16HBzhPH99AQLz73Alw4VUoNP33FhXcqgF2Vd2ahqZVXB
         MoCkXP/MA7HpuNSVi414aTCf72xp+QM1Da4B+KlAmBjC9go9ZNJH3iGUNMJKt4yJwM5n
         Wq1dgraoVwmHmLtqnwPLEPr0lLllDHcvFEawwTJOA7l0QCV/WeYRadRpSmMpVop2NlTz
         qRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RFA95P2sfKzmZYQGrCdd3AMm9JCqz+tKjJnaICBO+jk=;
        b=ZJU1b6bHodPMfpUvRaaQ11ZJhMdzrHeRo8n6SQg9GCiQLxerP5QWAEmz2n01jzmS58
         iZHfvyHnTVyK/4+lUX8YQNRt/aPjS0DzrKQmJzRFEvMdLs2gsG/Htp5/ujYmBi0gDSem
         ASc2n1ClYXRRHX4h2UDFsaOP1s6MBjxFLeP/Dxhm0tHVBatU4J5HzF+2srAk81QHY+3Q
         PkJPeWVoV0gnWgv/t2uWK8Ex/zXkb3Op4gUX6EwaGFOGzvV3vP2bEoBgClJOEZwwCFZx
         txgJD8qkX5mG1Lgk/QG+uSKqFeMduqb/JZmANWn2GQIsrfN/arVh1gE2TKBJgMKtPFBp
         nepQ==
X-Gm-Message-State: ACgBeo2zPVTVBQLNaQS1GuhgGayXBubSTUqwuMbtaQNcJCzCjB5sl+Hu
        xbiliIMOi/k5wZvhMAK44lAHDtUQC6CXOsQVan4=
X-Google-Smtp-Source: AA6agR4L6hgom8pqr6oTLUUmeOo6wGqyiin5/t5ynmqG11lGqEAZWnKTtcbeK+y21YoAAN41RVjf3nIDSoSmqlFNNFw=
X-Received: by 2002:a67:c007:0:b0:390:9389:6766 with SMTP id
 v7-20020a67c007000000b0039093896766mr6844441vsi.65.1662830016743; Sat, 10 Sep
 2022 10:13:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:c322:0:b0:2e6:bb21:8511 with HTTP; Sat, 10 Sep 2022
 10:13:36 -0700 (PDT)
Reply-To: mustafakaboreadb@gmail.com
From:   "Mr.Mustafa Kabore" <bj020250@gmail.com>
Date:   Sat, 10 Sep 2022 10:13:36 -0700
Message-ID: <CABA=fxJG7ge2xFL=Vrbc+VCraWOH+97GkkrYU+u7zO9kfM3XJQ@mail.gmail.com>
Subject: GREETINGS,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello dear,

I am contacting you again further to my previous email which you never
responded to. Please reconfirm to me if you are still using this email
address. However, I apologize for any inconvenience.

I await your swift response.

Thanks
Best Regards,

Mr. Mustafa Kabore

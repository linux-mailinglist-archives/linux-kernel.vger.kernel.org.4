Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D987369C04A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 14:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjBSNLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 08:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 08:11:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BE710424
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 05:11:21 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id r12so1575802pjm.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 05:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmm/YNDqSQghMDQX55lPDlYWGePy3db21+ic3NGFbKI=;
        b=HnJKjFepvTYDDYTYD8jlv5IZKuWCRAo9XSc3Ozwlq7Fpe1rbQxrKblbGZIOIsME8fj
         wcxqhNQsYwqFfgyPUIRBDgjZC/2h01WXhUVQxA6bi7OHGOmI2btggvt9ePT76eKJ6eo+
         ZbHe8D+FHt9cZagY+HDg5YQ/CPrPo8EjvGpoppaW43qkC0DN1DMWY3lLgr/u3kVGDd+y
         YFmJL513F4wm4RfmdP1MMu56SP1qvy++qHWIbzia4nOywcoKzy4m6QyC80Z3m3cvMbWE
         OLE3gTW4TdD2wGkRbepGPkA00EyxlD7Uoh3nJd4XEEr1P9J3flRql9ghu/Onb06igMBb
         AiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmm/YNDqSQghMDQX55lPDlYWGePy3db21+ic3NGFbKI=;
        b=Rj87QbxBoieLVsf76zaw0CSxoN5y4tPV64JaXy5hIg9Mpz5AK7lTxju92mYasAn2Aa
         IJW0cO5joxpKa82Hl9INbCj9OUYuKcyEaIhGXttyGiyPVdZ93Cgl0XezRDYifjfM+dnO
         mPCnOY83UIQQf4vblC+CFV/SFXZnrJt7XNVs29dKTnejd+tMRu3tFxmwTHIejeUdRLVN
         f2yy4GCOOT/6FMWzUgWy4x2hMfm2nAAxQ8gKc6Okw2zBHl9ope6XomDe+4FpF0eHuNqK
         fn3bPfqxSEpP2LDHizyC5EQ7k8aG9h1V8kSCxLrhOZLFFXkVMENQ3yNK2LoQzhaV4uUU
         N05Q==
X-Gm-Message-State: AO0yUKWT5+F/cb0SOCcDZP+iSydq4aEeDBYA9lX0QjCYOsP40rn+7gg0
        ekyOLA3jYHIcrBq2El22D4eaohinLhZ8iw5PdHo=
X-Google-Smtp-Source: AK7set+jiaNytP+uPOgqb31N1kdMVpo3z+yyECuUMf6uz9SnEyZCKGk2kb7iBMrbhECi/FLCGSwuxwkAu5lR+jr8JnA=
X-Received: by 2002:a17:903:3293:b0:19a:b151:eb8d with SMTP id
 jh19-20020a170903329300b0019ab151eb8dmr68739plb.12.1676812281523; Sun, 19 Feb
 2023 05:11:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a11:2d1f:b0:418:f69a:af80 with HTTP; Sun, 19 Feb 2023
 05:11:21 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <lori.j.robinson.us@gmail.com>
Date:   Sun, 19 Feb 2023 05:11:21 -0800
Message-ID: <CAO0nU=chj+-oDZhuvy-aWkSBALsV4X2dBWFkryZ1tOBD0tQD8Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello you see my message?

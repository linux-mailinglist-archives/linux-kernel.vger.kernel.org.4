Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ACA70ADFF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 14:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjEUMGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 08:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjEUMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 08:05:55 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6081BD3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:56:12 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6239144bd59so16467886d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684670171; x=1687262171;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vR/aSgrJHdEUHH393ovuG+gdb9mEVG9SSuRJGcP6Heo=;
        b=Wdirt828U4kFg5VqZH4MpQgZt+SNwy/3kKyKDRrL//VLcyBNiWsoHNCYzaaNfzOoYL
         wpS50YMo9JlD4sd/L5oj2aDgxuBbXT5Xn6J4xzx/pqjlmymeLFSBkhAM5sPYDWMT8Ie/
         Nt42kCoDxFl1oM+681qc9DK2D4hUIcsgsKUZIg4Bo/oqo9+iNWQcF46J5QELHmPULtti
         nrD42K9yBZ0FrSRanlk0nla5IG1thQflsHP9fhQNrAl+IdeiIjkSrjtoNOtWUgd83MsJ
         rqZhZOtgK0WMZaNXAnCOvuQhmyhJ/rGPsa8UJDZH5AX4RY4Z8O6upuxZTKo5cgdJfA0C
         EsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684670171; x=1687262171;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vR/aSgrJHdEUHH393ovuG+gdb9mEVG9SSuRJGcP6Heo=;
        b=HeataryUqJrlEXK8mV4dKsU5qHcAsQb2+4Od2rD+rTEQ4SWxZJs7798gm1V3uno4tp
         rpg5UpObcjYja+SpFviWyDCArZbaVXa1Eb92W66+qFGrLLk9hRm2IbIScHwSooH8OBip
         mUWnDORAy32lcGCti+RytgHo4bUwHY02+mEyNef67AcPmAIJRaa2S4RQNQpdKOw0EOJI
         ZpHDR3pcdZM6sYTZNfL7LgLl3RTZNY03qowcsz3BXmv2qcDTYvSVG+BY2pN4fGdfAzds
         XKaOIIULJ8NX9SQ8Q8YM2Nizp49upbAzZ8Q/KMM574d+JX4x6VhfWPDYPI04jgfRpLKD
         9jxA==
X-Gm-Message-State: AC+VfDwLAbcM+0sAIAssRHMomUP+cqMNhguU17Nnih6yuPZ0Dt4FDdRu
        iKRB/Gd8MStQqg1Gxx0pKGDQvWxx3EViVa59OxE=
X-Google-Smtp-Source: ACHHUZ4+7FiqpbotmcA964UQQHpj+IlwakcRbi2lNer9f8Zkw9u+yy/2yWdoMzBzRsG1MP/HynS+gaeUrhZoJHuweQg=
X-Received: by 2002:ad4:5d4e:0:b0:5ef:8ae8:9adb with SMTP id
 jk14-20020ad45d4e000000b005ef8ae89adbmr15043853qvb.37.1684670171274; Sun, 21
 May 2023 04:56:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:8bd9:0:b0:5e9:5ac4:6997 with HTTP; Sun, 21 May 2023
 04:56:10 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Dr. Rooney Harry" <osane706@gmail.com>
Date:   Sun, 21 May 2023 04:56:10 -0700
Message-ID: <CAC7OyroBg-Xrba=kO2wgVeK2t0Ko+z1EZXrR_WH1r7SVvUr3pw@mail.gmail.com>
Subject: Very Urgent,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
I tried e-mailing you more than twice but my email bounced back
failure, Note this, soonest you receive this email revert to me before
I deliver the message it's importunate, pressing, crucial. Await your
response.

Best regards
Dr. Rooney Harry

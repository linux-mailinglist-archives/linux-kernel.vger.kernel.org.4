Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DAD727602
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjFHERw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjFHERt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:17:49 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E1F213F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:17:47 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-43b2fb0afa6so24041137.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 21:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686197866; x=1688789866;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=UCk/ibjtuyv9s5yp3pLxODjZK+gD5ck7PtDrZSmdSko/Fwq3vw6ekQK1Jf7Awjpwrw
         Xe5sYQGe7TiMgq7bul3O0haRPj4kgNtBvYOVg76YbuIaYvRuZEs2vV5qg53pLOnSXH7I
         g2kHHpNYWnFAvSAUWdtKIpgMHkodzJUuJBLJiW7b7y/4XAgLS23eM5Qteq/elUCEDdAl
         xticvNjnI/K859ZRxjCl8o6g7uVdc8VNk6Ahi7iP3Dvbegmr3LjM/ZLkngrm1hAun15A
         qK19UYUD5fH7wpzQ/viBh74UXRcLEhlSOsuIWeuzbwNwsSYTM4H1Pexjtm8JjSr0Y77x
         XFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686197866; x=1688789866;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=L2TmW2p1fQIdwuqGZNXdVh5jJP6R4XmRhQxzxWYrjRhP7K6H+W5ptSVVPV/Q0Udbuy
         /xUQ8jztFiHDDiXcmtGop3Vm0He0KvhFEOtnxCtk+r3NDgeanUrLlCIYf13wNtw4TaPS
         VliTCHoBNQEjrs6D2+ECC+eZ3pwu2XqMcYYo+lwR9Bq/PLutAsTIYBodBf+qoXnNwhnV
         yEfUWdG56Kkyujs2UiHXqnpkmfXqdKoQtF0LaAYXY/EcPsbsVpi61NQNbINyfSjKDG+O
         JC5UBQw+jcSZU1L9hnxPJArLvK5WBV0ZnBrG0CgQRKyKO+ujE890V05emritXbe3sLot
         Fbsw==
X-Gm-Message-State: AC+VfDxeahQ8nBnUte+d1UAiKZ1BB0sPlCKRe7G3firD3gJRkuEUlBq7
        /9SVsz8Yzde+d6gqVOyhi4Y6x1sk/0AwTH2eoQ4=
X-Google-Smtp-Source: ACHHUZ6hvzbyDICVTdpY8rKmCE5Mwhsz0lr6HWlE2yo7op88V3qrymHjdgQSuUu8XCbZD2x4HRoazww4M1+6f3d/beI=
X-Received: by 2002:a1f:4f86:0:b0:453:4cf2:780f with SMTP id
 d128-20020a1f4f86000000b004534cf2780fmr2637663vkb.3.1686197865738; Wed, 07
 Jun 2023 21:17:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d66d:0:b0:3d6:a455:74b7 with HTTP; Wed, 7 Jun 2023
 21:17:45 -0700 (PDT)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <abudumimi920@gmail.com>
Date:   Thu, 8 Jun 2023 06:17:45 +0200
Message-ID: <CAFNbOJT4skA1S3TYQj-dTsb1BVucm2PLJC8SswuP2X6_xpPirw@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.
I have Dual citizenship which is English and French.
I will share pictures and more details about me as soon as i get
a response from you
Thanks
Ava

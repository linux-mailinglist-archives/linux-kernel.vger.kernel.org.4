Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB81622755
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKIJmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKIJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:42:44 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D369FD04
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:42:43 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46-20020a9d0631000000b00666823da25fso9827741otn.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qnCMPIlSjf4QEzzMc0Ok9DoXpH99ZITXVWKF8o6EGJ4=;
        b=BFqKVT+YW0i3aM2EwcrETot5fZ8ibqJrup/8LAsxNY4tcG+yWJc40HpglNwRgltoNq
         rUO7vd1b9ZTENoe/URe3f5gVVOIDxmCvQ6n7kcFAKfRUjQ/rauIz831uQT5ZRxej/XxU
         ISmxVRscn+n21/3+vesvtSXOWvjW4UXCr7UBtO4Gf1xKjF2iSAUkaN7WFJVrmmif20Qq
         ADo98+uo2gevyalviOKX29yFt3ymeksDVGxlHXxxfM42MAmak/OBJEzqbxu+HBV3KWcp
         QJthNpFlu3JDqmR0M2xS/WG17WgyUPg1lYKUJPbjWefG4PL3r0+hed+EuFs0a3j8yN6a
         b6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnCMPIlSjf4QEzzMc0Ok9DoXpH99ZITXVWKF8o6EGJ4=;
        b=Pw/prP5ZC2LoX4C6iJbcoSpnPFWcdrv1zOgbWDKB/k+aOT+UBUiCuEp4l7rwXRdENe
         pMuJH4bNHCpeCo6dZXJ0AMt91wQYaGeWl202S4Ivi4wgmxpezUZNKT82/MFJuYPzfgIT
         OjrufDd99+TDzL6RaeXx3DwR+II3jj9XppxquuLlmp5Oy2OatYYWGbJzvRTiyZx/paPF
         sWZolyfp1P/Xe4cPW5udBsBWr7+1TijDVfwpwi3wmBLcbn2ohZ9zMfaoLVXbeGM2F33K
         uAkiRiEWmkqW5bNGthbR/2IHi4+QPNGEa2XLcJPKYhI2ZOmM5q1aA8afa3zE1hER4N5/
         Ag+w==
X-Gm-Message-State: ACrzQf2QLq7iVSILvkGDsxWtgP9ZvUPchzE7+3zMtLhd1wYClMgFvGQc
        gDyqSQmYhtLk8s7pGWkFql3nu7N81dmRS9vDgp8=
X-Google-Smtp-Source: AMsMyM4PDcRFYEBkXuz3zHjXBIKOauBzNNuACpOEi+qmaVvi8tuZvAiVZHAfS2YxmnPlXSTtFOMLZKeJN6t4bBmd1AU=
X-Received: by 2002:a05:6830:628b:b0:660:d639:f380 with SMTP id
 ce11-20020a056830628b00b00660d639f380mr28413976otb.181.1667986962949; Wed, 09
 Nov 2022 01:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20221109084142.226960-1-zyytlz.wz@163.com> <Y2to4/kH6Gu+ykpk@kroah.com>
 <CAJedcCwzQj7pLzejX01PeuwL3a-DwRFmAEBLR-CR3_bAc0tx1g@mail.gmail.com> <Y2t0euEvZYQoCW42@kroah.com>
In-Reply-To: <Y2t0euEvZYQoCW42@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 9 Nov 2022 17:42:31 +0800
Message-ID: <CAJedcCwqem-Hj=1fF0XsEfyaeA-eAP6B9R_o1AC5trt2ap+Cdw@mail.gmail.com>
Subject: Re: [PATCH v6 RESEND] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, zhengyejian1@huawei.com,
        dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, alex000young@gmail.com,
        security@kernel.org, sivanich@hpe.com, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, it helped with the test and found an unused variable. I added
> > this line as the mail suggested
> > ("If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>").
> >
> > Should I remove it?
>
> If you submit a patch that just fixes the issue that the test robot
> finds, yes, that needs to be there.  If you are fixing up a patch that
> you submit based on the report, no, you do not.
>

Thanks for your illustration. I get it now.
I sent another patch just now, which moved kernel test robot from
reported-by tag to tested-by tag to show my respect.

Best regards,

Zheng Wang

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A980F5C0440
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiIUQeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiIUQdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:33:43 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A189A00F1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:15:31 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id c81so6521678oif.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nho4Mx1okgWawVlTzUYe67i9YWynaM+oXQaK+2MMuvI=;
        b=VwqCvKnPJ7HggbwxjUkIkIQa8H/b7PRW5aOthoIKPKSz1DK+gLZjQ6BW4nlT6EaaVo
         FQTCFBHAgsK3r9PXjfda17cDQYAzny1+jxbYFIKGrPqDUy5vTb8wIgXRTWmeXA0g556q
         rCYCPmFCWZOzbBCa0bTpi8Ecw8GT/IUH8FkWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nho4Mx1okgWawVlTzUYe67i9YWynaM+oXQaK+2MMuvI=;
        b=qRcqMMIKYyPaohr3b3Nlqw86K+JHPl32uqISfoC8mGXymdTfzyvjNs8ivys9lRLgTL
         Y0Q2928PoXceGzPyMplMJJmRH6Yqf272t6qt3X7/ROiSOJAk6edsatP0MFQLF6+FstTG
         vVjDajXgQCx1pay/Fl2MuQJj3Am6v3cZrPQ7i+KSHm2WppuwuKHEWiiOW+85EHMwNeuG
         avMx4jB13UopZyX+JRSHU+amwLcTW+bOginA4Bq4gBR9SepRYXO3E3rRgYZC78QUZlXZ
         ExY/7XFX6y9her8n/hZkBpBNmhVCcZVmugDlA3lGtlBhicpymtyFO8mkDiaaqRJu9c3x
         fJ7g==
X-Gm-Message-State: ACrzQf0XbRxnGuA9R3Zb4iskaWJ24oLkP9tIUbPWBSwYEwEavNBL/Rtc
        VC8Bt/B3NE0Hc2oQvC4gs7qOusG/j24HHg==
X-Google-Smtp-Source: AMsMyM6Fo9h0DEUpNpq3nDlqm4M9b5qBQUw6+oIbsArB8Q+U9XsOW59QrBXkVtkVYA1afBydt3XBlg==
X-Received: by 2002:aca:de43:0:b0:350:7f0d:967d with SMTP id v64-20020acade43000000b003507f0d967dmr4170219oig.260.1663776930226;
        Wed, 21 Sep 2022 09:15:30 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id k18-20020a9d7612000000b0065af1b094dasm1523578otl.28.2022.09.21.09.15.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 09:15:29 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id t62so8633839oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:15:29 -0700 (PDT)
X-Received: by 2002:a05:6808:11cf:b0:34b:8f4f:314b with SMTP id
 p15-20020a05680811cf00b0034b8f4f314bmr4277924oiv.126.1663776928733; Wed, 21
 Sep 2022 09:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <1d1844f0-c773-6222-36c6-862e14f6020d@leemhuis.info>
 <fd672632-7935-14ff-e2be-0db8443b0907@leemhuis.info> <YyrI/qzx/EWapzck@8bytes.org>
In-Reply-To: <YyrI/qzx/EWapzck@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Sep 2022 09:15:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgU0PyYHut+8zV+kNCxOZiCXd5J29Eisiy8badzsk8Msw@mail.gmail.com>
Message-ID: <CAHk-=wgU0PyYHut+8zV+kNCxOZiCXd5J29Eisiy8badzsk8Msw@mail.gmail.com>
Subject: Re: How to quickly resolve the IOMMU regression that currently
 plagues a lot of people in 5.19.y
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 1:19 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Thanks for the noise :) I will queue the fix today and send it upstream.

.. and it's in my tree now.

                  Linus

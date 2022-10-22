Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA63C608F86
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 22:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJVUI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 16:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJVUIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 16:08:20 -0400
Received: from 003.lax.mailroute.net (003.lax.mailroute.net [199.89.1.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F8C11D99F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 13:08:19 -0700 (PDT)
Received: from localhost (003.lax.mailroute.net [127.0.0.1])
        by 003.lax.mailroute.net (Postfix) with ESMTP id 4MvspV3hTpz1spkm
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 20:08:18 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 003.lax.mailroute.net ([199.89.1.6])
        by localhost (003.lax [127.0.0.1]) (mroute_mailscanner, port 10026)
        with LMTP id hPbx7KS_toyP for <linux-kernel@vger.kernel.org>;
        Sat, 22 Oct 2022 20:08:17 +0000 (UTC)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 003.lax.mailroute.net (Postfix) with ESMTPS id 4MvspT3WkPz1spkh
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 20:08:17 +0000 (UTC)
Received: by mail-pj1-f72.google.com with SMTP id w2-20020a17090a8a0200b002119ea856edso5568425pjn.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sM4EI5EG8aFU0eCqXxfKOVx9vcJ9fHC3LeTBs0eo7r0=;
        b=Vp5HkvPRblNR7maW8zuZrwdq2lE0SXcr+CtwyVTGZn1L2pCKCKgh8KnAif6jf4iD/B
         7Y+G1PZa4tMXeu0plBaywXBc+Bee92QSCz4JGUjigl4ll3QxehlxMlaTNPi9ORTNGU7s
         UFtfLgxAoNQrSdhlo2lLPHKK/FWMu29+tyrv5eUMdH92woXr2Xb7OBFbHu5Vq9s+aHt6
         a3duvn8piFheu2ThyPoG6e8hTQmq7fYeTKg8w+n0MGamtMpOe1s2BliDMcbZTAl33JLr
         kduISj+Ex0nvmXiXCpDWCjJ76TzfGU67GN/DmKbYnv/At9tXskaIitYqnsMe40iRr4dT
         +TEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sM4EI5EG8aFU0eCqXxfKOVx9vcJ9fHC3LeTBs0eo7r0=;
        b=nZR0L6pMbzIF7nA6GiS+/JtLEAVk45v6kYh4yQMK0FMbDmwNZe4ZvdZyFu7KBcbsD+
         U5OXxhA/7wn6QsLSyCcn/1yFyLd3VJ++Ne+V3+rjnDUwQCh0fPUoGDD/+qBKhsFApUBo
         gNk8toyPZJm53QFztkQCpnTueKkn0UXutcr1Fv9rkXNmraPW+mXCNO8HjnfdXvbpbsG6
         ssWMVD3AIHSIBRzdhlDwST1IOldN9Z1Ag5BWCUiJYTgI7Pt7O+CvkV2yYKp4FwNDeFpu
         CSMS75NAVotFXN1en6z5+LBsiPphkKqcssO5uS2OanlhCC2664SN5JNlqY7Oa1g0PvGr
         CShw==
X-Gm-Message-State: ACrzQf13Qcj9NFY2Sw2rUI1Pw5UvjZy9E5L2xvg2oKxSFziuiPKSgkS5
        qiSr+NOnSpuuYitL/YgeCp0gyesHVcU4bs5ZhIm69IktiQQ9S+UQAfU1r5cuXPGmAWDVjt8HSid
        /xKd+f4lTAoDrCAnIC6CjbEjRmFtCOc76A9l64Utdnlz0KYUd3sb7WYs=
X-Received: by 2002:a05:6a00:8d0:b0:53b:2cbd:fab6 with SMTP id s16-20020a056a0008d000b0053b2cbdfab6mr25812761pfu.3.1666469295620;
        Sat, 22 Oct 2022 13:08:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4TQlnIFWemjieXYFHB4kZCU06MWCA0fuLbWzeSKkOadrNWOw5GKkPPMHCMsnRSY108W+f8AO/qejDPa7Rc+Pc=
X-Received: by 2002:a05:6a00:8d0:b0:53b:2cbd:fab6 with SMTP id
 s16-20020a056a0008d000b0053b2cbdfab6mr25812755pfu.3.1666469295383; Sat, 22
 Oct 2022 13:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <d4898956a848c85fc93c3f7d25cafbfc49a46e60.camel@zohomail.com>
In-Reply-To: <d4898956a848c85fc93c3f7d25cafbfc49a46e60.camel@zohomail.com>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Sat, 22 Oct 2022 16:08:04 -0400
Message-ID: <CA+pv=HOrpzS8j6Pq=GD8_U6n9VWA8pyTwKRP40dixSHsZ3=MXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Staging: rtl8192e: rtl819x_HTProc: fixed missing
 blank space
To:     t4rmin@zohomail.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 11:48 AM Aaron Lawrence <t4rmin@zohomail.com> wrote:
>
> From e6635103e3cf2426220767955b99d2e2b62a7329 Mon Sep 17 00:00:00 2001
> Message-Id: <e6635103e3cf2426220767955b99d2e2b62a7329.1666450553.git.t4rmin@zohomail.com>
> In-Reply-To: <cover.1666450553.git.t4rmin@zohomail.com>
> References: <cover.1666450553.git.t4rmin@zohomail.com>
> From: Aaron Lawrence <t4rmin@zohomail.com>
> Date: Sat, 22 Oct 2022 20:46:25 +0700
> Subject: [PATCH 1/3] Staging: rtl8192e: rtl819x_HTProc: fixed missing blank
>  space

Hey there,
Could you resend this without the above? For whatever reason it was
included in the message, even though it shouldn't be.

-srw

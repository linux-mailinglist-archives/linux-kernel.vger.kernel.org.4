Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D2D6BD142
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCPNsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCPNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:48:00 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D616D309D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:47:41 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z10so942868pgr.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678974460;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87dcZszEk8ij6lSi/CqcaBS8yPG/kXnAghqk+AMY8Rc=;
        b=Kny1ONjPfJBPdTIRToypv13GhfVuxXXEoLCyj9Ts7qmqWDPpie+0wTHWdBM+sqEhgL
         yZSgI3DmVOpWXPXZzR+JZsVjztKzwdl3CxDSB9/prT1/CSs7Ce1L9rKKa9A6VE0rSOwK
         hkG2MJXzuB+Fpn87UL9gLyybnfc4zCjxwE8SccuyMVkah5Rx7f2+1EtZ7vg7K+O0U4pt
         7etEPY8nIUy3Z/AzRmPuIMMBqFdPRWz7UJG6aowRllWpaMz7rhnxTAOPI2ENiioH9KxU
         ZJ+l929oRmUxNGmI/sVZN/ZpNqCsaH3rKdjSEoMgVmyvsRT7zt1wX3g9iIG6WnNVD98d
         +utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974460;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87dcZszEk8ij6lSi/CqcaBS8yPG/kXnAghqk+AMY8Rc=;
        b=LQ3zVyW/62F4YSOYVlLQKgXNtAD0O+EHb9KaoKZz5QEujPyS4GcwSdJiYtsvjo1Aod
         l971U1qV3g6/I2Ghf9BTcnxubB0yG5Tb8Mg+bVs5uba/mHaSqw+jw3D2W0v2pfVRUWyg
         BgOM4vjiZhGb7JEB1opfAUH9Va931xJEUdsLYKzW5r+7WEDsWilvYQNItn2FX6FMqkrT
         OzMPb1bKUGwXPVeHCAwz669d9udLgPxJNG7CB4RL6sOnOAFy8j86Ny30XRVod77OHnUO
         1Z/RkX6nJ7/gcJCVqyJnrBwHpe/USZ8KKA8ACYy9JmRknHZ11F2eQE9QSN540ng2gI8j
         aj/A==
X-Gm-Message-State: AO0yUKWKNdEl7ER3gMOeZDwiKfqMFkMLENbWPiHchYuzKhw9TUlBO4Vt
        mDkXPx4TX+kTs7mr5m7GxG0LM2ipu+ZC/Ge6fGc=
X-Google-Smtp-Source: AK7set/iKSZcPGWXXv5l2BxxVe6y/A0g6LCEpaFP2g2jDa0rkZcx8P7vYKdE7kv/lA2uqsLb7XUzYaPF+eUQTyulrJY=
X-Received: by 2002:a65:6458:0:b0:50c:2b1:7a8f with SMTP id
 s24-20020a656458000000b0050c02b17a8fmr128383pgv.6.1678974460594; Thu, 16 Mar
 2023 06:47:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:6703:b0:418:f1e9:922c with HTTP; Thu, 16 Mar 2023
 06:47:40 -0700 (PDT)
Reply-To: enocvendor6777@gmail.com
From:   " Emirates National Oil Company (ENOC)" <jakubjakub871@gmail.com>
Date:   Thu, 16 Mar 2023 06:47:40 -0700
Message-ID: <CAMLysXorDT4OzNpcz6HuNzS-ypHQ5BRn7iqfs1ciHMdE=dhg7A@mail.gmail.com>
Subject: Emirates National Oil Company (ENOC)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:533 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jakubjakub871[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jakubjakub871[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [enocvendor6777[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings of the day,
We are inviting your esteemed company for vendor registration and
intending partners for Emirates National Oil Company (ENOC)
2023/2024 projects.
These projects are open for all companies around the world, if you
have intention to participate in the process,
please confirm your interest by contacting us through our official
email address  project-ae@enocvendor-ea.com
We appreciate your interest in this invitation, and look forward to
your early response.
MR. Nasir Khalid
Senior Project Manager
Emirates National Oil Company (ENOC)

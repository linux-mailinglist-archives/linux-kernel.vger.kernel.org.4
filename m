Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578F36C30A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjCULpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCULpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:45:33 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54C74AD22
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:45:28 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c10so6184185qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679399128;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4O2f8XGzkywD255IID/Ub0j2AGpmUAgWJ8HH26vB43Q=;
        b=fGA/iT6K2dDWzeWmZhonYqMMuBNpuSYXDeHzLto/OUJmQAOnVPbkex3QrGyqDugzmx
         1B0y6rz9LjcL+OA8Bh7wjmac7w/ymwh0tx8tHdpIE0amtypJe0rh4sTO8gR6Txo3MIFq
         XDZIOUc0afn9kkRldlnB+9mNLwVmxxj0+obeofkbXclKAkh1r9RM/UbffNzJ6UlY6SsN
         ScZpHpyV9MnnfunjLQ7kpar6lfc3F51txw81CX/fJIHBA6eW7NDkeeB8OEXJ0KftLaom
         PhA9EIPO9UbmlbDVtuSSDNFajhZ3SGhcjotHUcvMQGPrmOaU2we3ADJgEGacKcXtfAzB
         udMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679399128;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4O2f8XGzkywD255IID/Ub0j2AGpmUAgWJ8HH26vB43Q=;
        b=cKUogRygPlZiDtgvZRKyfLI+UiIkSYituzrytKnPMUAsUMLornbOlUazp3Tl52M58J
         zNbAP+q2H3PtNVz7yhj3uKSkw7++tpHq3uZCIYnRGugRZ7D2IvO0QyG+WiW49GwoBsk1
         24kyo8AYLtExJpcA52/KvpRyooCNwTrNniuSVRhMLEWTJosF2XKuYAZn+tTMD13WoaEF
         aKvA9WGoD5j/2q26fXSoDMJCl6FBHBeQosw9BTWk+DEdimQ9RjzFs+HGUoXDr6Z+FL37
         YVSXiNe7pSlqIOEXe8AH8l5KLLDkoONngqeBIulLO0vhPuHGKapsC1IEUVB4ps2X3jIw
         ff0A==
X-Gm-Message-State: AO0yUKX1MgcVW5Zc0MqN0eIswo7/7sjWnxzuFGLXmxWgnoUU2711JC/R
        9vAGtOGGYV5No6AsEhDftTrqInREISFLnLkob9U=
X-Google-Smtp-Source: AK7set9fDZ/bPQj5kPOFy/iNVD4m6M9bdPdpl0DSt5Zg87yx0umYD9ZXqGEEMot2PcW/MzQrIKRgf7h44kt4GPoxEj4=
X-Received: by 2002:ac8:7f88:0:b0:3e3:8172:ff23 with SMTP id
 z8-20020ac87f88000000b003e38172ff23mr619439qtj.13.1679399127664; Tue, 21 Mar
 2023 04:45:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa1e:0:b0:5c8:9235:4185 with HTTP; Tue, 21 Mar 2023
 04:45:27 -0700 (PDT)
From:   Bright Gawayn <gben68387@gmail.com>
Date:   Tue, 21 Mar 2023 17:15:27 +0530
Message-ID: <CAG1+V0y4mqLW3hFLcbLj0xoYCQiPgvhSPNB45z5T6KqvR-ozOg@mail.gmail.com>
Subject: Business proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=ADVANCE_FEE_3_NEW,BAYES_60,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:844 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6578]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gben68387[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gben68387[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.5 ADVANCE_FEE_3_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 


-- 
Sorry for intruding into your privacy
I am Mr. Bright Gawayn,

I got your contact email from the international business directorate
and I decided to let you know about the lucrative business
opportunity of supplying a raw material to the company
where I work as a staff,
I am an employee to a multi international company.

we use a certain raw material in our pharmaceutical firm
for the manufacture of animal vaccines and many more.

My intention is to give you the contact information of the
local manufacturer of this raw material in India and every
detail regarding how to supply the material to my company
if you're interested, my company can pay in advance for this
material.

Due to some reasons, which I will explain in my next email,
I cannot procure this material and supply it to my company
myself due to the fact that I am a staff in the company.

Please get back to me as soon as possible
for further detail if you are interested.

Thanks, and regards
Bright.

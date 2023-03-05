Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFFA6AB156
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 17:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCEQNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 11:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCEQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 11:13:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315F812F0B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 08:13:44 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a2so7656758plm.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 08:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678032823;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps43Ql5Tjnd+rS8BdUE8H1PpwwGazEWm6mc1DzBYYUo=;
        b=P+5b/3j9gCzEw3NQgmMDrEYyNGQMac0oBAJKo+XR4OMoHkfyo8Gaomyd0nrEaDDB74
         0kFd9Dm8VVp3sXwQtLLAlReNKdUPDgYA2NkpXCqXdh4643gpIwC54BhHdzYG18a+4cXi
         slP02q287qHHL/1880HF6CUiaVpSl4y2O9JY54KuGyWyXDiUtARLwa2qvKD4Zn2lxIXH
         sCt9qFBtMTSw+86YUHDXNyXmXcVcoR5AXf19Zgri6hojolkuXfIzQeRyBMddN9sL/jkL
         7ou/huHExlKIl2/9k5kC7IhXlahqLYeGuoE6HldJXHbc+IfR+HpMrRW7NjZvFPPFKgVW
         ijRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678032823;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ps43Ql5Tjnd+rS8BdUE8H1PpwwGazEWm6mc1DzBYYUo=;
        b=nG/RMCJ1mWtCUzdbgVCYpsThpfCVxXNGLJ2Wx5hVUcul692dAElEurnFT7kxaRwZaD
         5wljtkhrvZIrjUnDa/s5AsfSoCkThoANnQDbqr7SafuRbM59NWHJ68dK1mh5/lX2Oggq
         we37jusR6n6O/2dNiyjqH1Wps8biLZ3PRmkZ4CLTtkENQcIwzRENpjnJ2xY8EnRWYeN8
         Qt5RNLmIsC1sr7qwxOllrJDyqtT+hZpZsOgl5q5yRa5MK/KCvJU1rJRIyEpChTVc60Eu
         YiLlZVxUhACBB2W/IdA6phBc/jpNOuCgk8NniuP5cKVy2qBff3KYGAeg99nck44AN9lB
         Z/aw==
X-Gm-Message-State: AO0yUKUMkAIuEEAoPoGjlPTb74cK+28n3xvFfgjxXy550TNgOKXFWlNH
        D1Jqf8fpzMHGnGW2EZmHuz6DfA6POirzEoXDN0Y=
X-Google-Smtp-Source: AK7set91lNlJT6xEw4tEqcTet+zu8im/xvqnjKL17GnWY2Nqybfx4PpMf9wJuPzQ/JQZAAlDaKpBbKDnulxltyITBHI=
X-Received: by 2002:a17:902:ab4f:b0:19b:5233:51c6 with SMTP id
 ij15-20020a170902ab4f00b0019b523351c6mr3077516plb.0.1678032823422; Sun, 05
 Mar 2023 08:13:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:8c08:b0:446:b333:430f with HTTP; Sun, 5 Mar 2023
 08:13:43 -0800 (PST)
Reply-To: fionahill.2023@outlook.com
From:   Fiona Hill <leea4982@gmail.com>
Date:   Sun, 5 Mar 2023 08:13:43 -0800
Message-ID: <CADa=nC3vCT_k2KJSt2cMyDov1EK7-1GnDAPYmBVh9nqSAVNySQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5410]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [leea4982[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [leea4982[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [fionahill.2023[at]outlook.com]
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

-- 
Hello did you receive my message?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6632E5F0D88
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiI3O3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiI3O3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:29:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71571A1EB8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:29:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 10so7172515lfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=WT82etd91PDSUL/8+27QkPwmNaDjHjZz1/B6ldVoOBw=;
        b=Cqv2fYdAfSX2gOsDgDUmZKhrUEAbcejBuIqOMrvYgK2rvwQSv+bHvi08AI/d4qE/3Z
         35UYRbAecqcaCNH+SX0YM8PBVjo6HKdtkGtEJXXe7SO/WjYWv2nZa3WG3vG3TttjpaGb
         MsZPc2h4mtX6Kz8YCJ0ern1sn9hHNETEIV2mNZ+FYxvBWtTSOzm7deVl8DkopNy/gebx
         uLcolIiFShwqZz2uY9YdtFsnNkPMBLR9iraQL/7lvPz8iHn98JokkzT1Bmg45URWcxwE
         S1ZErZ5GEPUhz7Q4csqShU+/eDJm5FW2bNiYxZcNlByG226/DO0aqZFSYCW7n3XmI6Sh
         1YgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=WT82etd91PDSUL/8+27QkPwmNaDjHjZz1/B6ldVoOBw=;
        b=46NQ54GLUo2/xJCTkeiEBCwNRp3wRBzQLohvAAt3gnzE7QX9z7t2rzyndvnbqHg3sF
         fLQ0MwRED6dOUllpKWXZ7e4e81Jtq3AaadLWf9N9xUYSOP3aDgOQVI7p1pNFRf8DeE6m
         q0THVfwpomafdyICtBUzN8Z+L1Q+MvwYpYl3ovJhzUXDM1UVKv8+YSNCz+Saayo1ISUv
         Cmgu8F07kT99ht+eoQwNsmQxnHJtf7CBdzS+u2n/UeuXvyZ8oxwVw4uygTy02EKdxAlB
         XFtWMMNEBCP2PuRrDvEpwcFSmnx8RSTet9I8QaR+LCW9C95h6T4K76R8PCa9Ip83nho7
         mkoQ==
X-Gm-Message-State: ACrzQf2560lAw8BtGw2yPwKYsN8hn4Tz3nKCS9r06MmuxLENs77cbQS/
        6DO9nvM+1hTA9MfD6J3bcYeyhffjeUj53n39W38=
X-Google-Smtp-Source: AMsMyM7jPVyCBwV+uwZIZLEjN2LKaGe3r5OJWoDr6seqKUxZmXbi7tI1oZWOcgChaiiy7gG9QwGvwgNFnRY7+lwv3OI=
X-Received: by 2002:a05:6512:b8d:b0:49f:59db:62ec with SMTP id
 b13-20020a0565120b8d00b0049f59db62ecmr3247554lfv.566.1664548169233; Fri, 30
 Sep 2022 07:29:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:3daa:0:0:0:0 with HTTP; Fri, 30 Sep 2022 07:29:28
 -0700 (PDT)
From:   Maya Williamson <aw7338485@gmail.com>
Date:   Fri, 30 Sep 2022 14:29:28 +0000
Message-ID: <CABCwc850GG2+nYDNrRgSHkfSy48J5v2ZMGCVSvoovOSo9VhA2w@mail.gmail.com>
Subject: nice here
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

I'd like to talk to you

Maya

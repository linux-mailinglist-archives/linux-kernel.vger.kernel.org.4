Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A654603B61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJSIX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJSIXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:23:10 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E57CE27
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 01:22:50 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id de14so10913184qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 01:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCJsXsDD/iNK9yC84Ot8gXJYydwvdgJYruOO+RMKvrI=;
        b=BFSR4WVhAXfB1vlb0cUgghmsCkWBRhqgD6lVihreVgg0Ur6b0TysDdmKzJ/V3RZItP
         2VGwR/gxZPw5eLhG8UVwdrJPN6JvFW2EWGOOWUQwOOt69EkBSKMg/n+eTYeb/Xaftcpx
         0MRaeDjikhPvT4P85syFkT0PMsbBDuZLIsslwR9vIKR4pV3R266ZjiVeWWuCwDgrs1TY
         4fz6nx1kqNJL7lUmzZQzpfyxZ8gnv+qKMZxQyNMeqp02ONzGdf0nrvrzyyeSCnSzq5th
         njgOftXzyJ3pTWAFyAn364PX+ZVbZ/jg9uM7kvCsABV/zdARBWrjAbQUN/V6lHZpCCBO
         Tkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCJsXsDD/iNK9yC84Ot8gXJYydwvdgJYruOO+RMKvrI=;
        b=OqVRd8ICjwkzPVByuxpd18mmPqrYaZ7CQ//M3DcefsmmTa9r9pQL5d5wxJ4mYn8s6R
         bYBTNGSzJwKuvoFvA5YK0LjUi6U9nmhx5VXHlKLsDfve9rOV3JvKrp8ilm2xRJp+UjIX
         jryl557d8hNGhAIpSieP+s6/yItL0nZehLu3ss7P3b43nUej+7txHqZJRUr1Uye3TqM/
         rqRQXppq19cao1dUp1zJhcZ8VW43vMC65C/07lCtC1n2sC/SWq8vXlfyfBZRYW+1I3Ke
         j35PYjimPzQG0TU2+6BkXelXOKbysvdexCpoh/l8y97t6zRn5aNMMHqgTHuuCJlaS0BO
         xoFQ==
X-Gm-Message-State: ACrzQf0mrPJqXQyhQIB6fo+F77oJZ2kTkyucudLQyYyk48TTSk08bJC1
        /0tQcuYBtLWxC0jiCX6sGjUDZGPQ3hLOuKDplTX9zMVsD6pSRw==
X-Google-Smtp-Source: AMsMyM4lpOr7xF2OuedJ06jrmINiWWb6Iolu3B6EalrgIgAhqCKEx0lTHc5iycAzzdfgxucK3mfdcaeahaKaDKVmug4=
X-Received: by 2002:a17:902:7b95:b0:178:ab50:76b5 with SMTP id
 w21-20020a1709027b9500b00178ab5076b5mr7288103pll.161.1666167400757; Wed, 19
 Oct 2022 01:16:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:d2cc:b0:185:457a:9333 with HTTP; Wed, 19 Oct 2022
 01:16:40 -0700 (PDT)
Reply-To: abdwabbom447@gmail.com
From:   Maddah Hussain <aloyikechukwu03@gmail.com>
Date:   Wed, 19 Oct 2022 09:16:40 +0100
Message-ID: <CAJLuiHSMgW28O7MG91mcZnZdzMzbkJKGna5G_xdHGbYkJx4tKw@mail.gmail.com>
Subject: Get Back to me (URGENT)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abdwabbom447[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aloyikechukwu03[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aloyikechukwu03[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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
Dear,
I had sent you a mail but i don't think you received it that's why am
writing you again.It is important you get back to me as soon as you
can.

Maddah Hussain

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7FF6596BA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiL3JZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3JZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:25:00 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEEDAE7A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:25:00 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 18so1959915pfx.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Em9KOz7Z4HbmSs3XsIqoezy5V4/6T6jB3yMfk8wPI8k=;
        b=Y0RqKZaNQ8pbon3m4s1JPLQaWsYPTwnPRVJ7dnXbC/Y3KJaWmV727ULIpS60UXsrHH
         TvmtQZHQEz9tEjlXc9LwV//MGvwRhsOfmE25fEj9obtThA5j4wShjBqiJRr/DNaQwkDd
         TeKSX571KbQnmFFAHmz1dO7uJiJHuivlVNiOSs1ElzdwUc/YCG6kyPesfYWSMixS5x4o
         IDM2WWXQSdxVkO/eHvmo+zVaLqkrTp7K1vBh6YtMtIWZ0VVviEFjYTh5sthSkuDn5pS1
         vAqRKa4LgPgJV61dOQtDYklm2Epj8OYVkAK5AMJp5LC1ycIef+4o+uAkSZ0ZPXlSsI1y
         DehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Em9KOz7Z4HbmSs3XsIqoezy5V4/6T6jB3yMfk8wPI8k=;
        b=hZGqqGcrOGdsEhPifqR4qGqbpVFV4eTesMc2jr7ilf+yQEe+vDcwKBTeitepo6gDY/
         plVUG/E7AgbZ/hYD67rUcSSLfxUe2dmbSybVJhO7Ertqp7+DyXcxmJusSevwU/CZIG3y
         UBp4Mjnm0POAxjNzPhGFr0VrzbZEm1qjd7nSn/hqjNf/YHCk75sxQocs1EenalUoCr3c
         i7tuM9ZnMG88peParAXBBxwXMMNdiMU/V1MwvQqQap4kdCArCl1Svz+iOP3j8GD9kj6q
         1bczqEVGFBqXRWbziQjPQeH+uefhKxsWgme3XqRHtOqV00ttPXAwczt6+hoy6g690TCU
         BWYg==
X-Gm-Message-State: AFqh2krGysTUHcrr8L6IaC/ODfE2vs3zU3sGZI7d13+mhoWgfDPB0zgE
        i5lziZG90SsIRNGqSlzKYug9Do+tA+HTcT4RdIQ=
X-Google-Smtp-Source: AMrXdXu5NoUHtg9Q+FsgfgbVgN5bNCSz6MfmuSS9C8EllfzTkoiorCVI5B/gLiU7Don56OzrIp8K5nzVHOF2cfXq+NA=
X-Received: by 2002:a63:f258:0:b0:479:54d0:8ca5 with SMTP id
 d24-20020a63f258000000b0047954d08ca5mr2212208pgk.563.1672392299243; Fri, 30
 Dec 2022 01:24:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:f484:b0:37a:91c6:6b91 with HTTP; Fri, 30 Dec 2022
 01:24:58 -0800 (PST)
Reply-To: elenatudorie987@gmail.com
From:   Elena Tudorie <maiilyszerbo54@gmail.com>
Date:   Fri, 30 Dec 2022 14:54:58 +0530
Message-ID: <CADPSUkAANxo2DLO6+x0rihgLRebG+9fMAv1=wixWZ3Ob6wR60A@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

I am Ms Elena Tudorie, I have a important  business  to discuss with you,
Thanks for your time and  Attention.
Regards.
Mrs.Elena Tudorie

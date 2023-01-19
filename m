Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29A56732A6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjASHll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjASHlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:41:36 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E014C676DB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:41:35 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id l125so1311665vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=arXgsIF6/U7i2RgiisZ/KhoCYkzC8neYS4+Xn5a7R/g=;
        b=dtcnENlOck3VFMeTWvGpeAZIfHcRucFMbIMfXQ5FGWVKsTB/19MtMnDR+7AvgO6aei
         nb6ge8MECcUZUcjhJ4rWTILsdL8HFbDxizf8CiPGwN4w2RfGqZW5xf3hnOTaqgEpW2tJ
         i4T57X8L8c9hvLcvpqFKRw8NJKoaaDAz8kXxqSjLJVAdmcmYkIG8X71EZdl05qE7MBMq
         IzhZLxV+nF6In+ev6AAZsvEXaWX6a48JRg0djf6KlUtlksEkK5Trxc5kJrA+tJKbSuwx
         UvNCig9J79/LhZ+U3iH/nNsDv3PC+qybjsOJL8eO/VvgDpQwzzEdCE6WEEnLgUM+hJ4v
         Vs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arXgsIF6/U7i2RgiisZ/KhoCYkzC8neYS4+Xn5a7R/g=;
        b=4mpeJitSSzSH7KrZ3iFRwbkt5LLiCmpHrTKMemk+iH+zLmIQWX5BnMUXS3YF9HMxyw
         TgQrBZQTDqk0a0QIrv/ThEC4gEoavjHyzd/NfvLFwGvGCsUl93reCDFRcAJEw8U1ibvK
         jT87pkVqhouPuH/2JK9+nhxhSIcR9OkheHSzgSxuPEK+A95uHC7dbP4EaH48+Jy8TV4A
         fDYVEtiWHMylo9eKqOOmnCh83faoAMntvfD1tscn/l+58RzbO9or9uzM32IMU9Hx2L/o
         N6O+6nVMZANgdJWaaYOwrG9EWeRLWgCqJq8UWC6O1xMSzIq9YMlP3VdiWyxCZkZVu6zW
         cWRw==
X-Gm-Message-State: AFqh2kp25G5xnR7MLAK89qYB1uSqdepuojX3aEg7dlDqAMB7A/R4fREh
        aF/NY5VgqhCzLY47//IOc9qkxOMfdHA/WKQeW0aQH6cq/t/Y+7EsoxQ=
X-Google-Smtp-Source: AMrXdXui9SgZfUz04rOdHO9jqtdZTi2hgrfFmjdGT0LP0wHDsch+a9q//0OkBjEhov4MZ/biylvj5cdMRH3CeJ1X+04=
X-Received: by 2002:a67:c01c:0:b0:3d4:30e:9314 with SMTP id
 v28-20020a67c01c000000b003d4030e9314mr1240685vsi.30.1674114094542; Wed, 18
 Jan 2023 23:41:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:ddc1:0:b0:380:3689:ef77 with HTTP; Wed, 18 Jan 2023
 23:41:34 -0800 (PST)
From:   Olga Aleksander <toolsbox1976@gmail.com>
Date:   Wed, 18 Jan 2023 23:41:34 -0800
Message-ID: <CABa=d8pmvhixxbzF0X0nYhx_wQ7fZbjkL+=nYZc8i=VaZWiPMA@mail.gmail.com>
Subject: FROM MS OLGA
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey dear friend,

I'm Ms.  Olga Aleksander from Ukraine, I would love to  tell you  that
I have a profitable proposal to you which you could benefit at least
huge amount of money as a reward but can I trust you ? I'm trapped
inside Ukraine so I needed a trusted friend outside whom I can put my
trust on. I would like to give you full details in my next message if
you can assure me that you will not betray my confidence in you.

Looking forward for your answer

Kind regards

Ms.  Olga Aleksande

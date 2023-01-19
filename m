Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7436738C7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjASMjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjASMiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:38:23 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4460F7ED71
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:35:03 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n85so894575iod.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQbD+o3e6AGfj4JrXLW4n4TAW6xDycZlCjij+AwmP6o=;
        b=aanUOmVhKuSxk0yM3zH/O4Bjwh/zn6MBXyuKl5D09cefgSzjBCDl2Fclox+DWN8z7N
         91ylZu8dGXzVcWRWIb+BnWQ+CHRmcSRbQrk/TaigbldmAX0gI/6ZOYUA3WCHrS0Ft3Yq
         /4AZZ+5LXqc8bYs9t52ZnmMIToiS20OhzLmGoNQ2vXCsnt12Ls5YiRmtqe3Z+AD5Mog3
         WvIZWhKpuD2j8bl3O5v9PMc54YzpRsdPaOGQJq6GmKft2w8tR/hkV7pxukgBygJY76G0
         llMeVtjx5UhzJj7D4rscEYgnnVZok68N2LGZHfDJdtZQXOO7Nloy2dPpYArvoR+ht1uQ
         uLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQbD+o3e6AGfj4JrXLW4n4TAW6xDycZlCjij+AwmP6o=;
        b=nrWm3FS4KVnI2cd+sehHy/4Vu4/3zsuOFKCiFuKxg4Ejv0no5atA0HSu9zI4p6F5FJ
         pxtYJIZiuravo98ynUcXDVvUpMHM+nsLRixDcWi314Ru3tmwrXMSeZj5gz7+24cuj4Xr
         RtuoAiS25ZTehEB7rJuNJJYzHWRJ2jchkW4dUQm/3P1rCmomKERJ65+kCsLXlFzcdb04
         +Yd2sVEwQxlf5scWoG6Qf7WkZOUZsXAsOi2x9uVbtvPdRRvH/QLodG4rtDdRtWuy+5lH
         7dPyjl9I4BsoUu4O/GA1+PeEeost2EelMMMBxvJv9Kd3Ntpd2vxRbAcPIRD0lze4fRbr
         jzjQ==
X-Gm-Message-State: AFqh2kpL5AC7gojZrfNUzQkBvrUazWLvduFA+ZooZRrF3CHwKFc5aWuB
        qIYD9F0xlBXBaafqOVDvC/aLz8YiLf8N4g+rkbA=
X-Google-Smtp-Source: AMrXdXuHR2fsJzwVzNKCk7JHcBcd1sWvREZZdinhjj6Spy/5aZQ2oSQijhzFqmNRTR4OSt1EusNZ9O7oJ6ejR7S2ISI=
X-Received: by 2002:a5d:8492:0:b0:704:a571:c597 with SMTP id
 t18-20020a5d8492000000b00704a571c597mr700063iom.215.1674131655878; Thu, 19
 Jan 2023 04:34:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a92:d783:0:b0:30b:f2e2:b9eb with HTTP; Thu, 19 Jan 2023
 04:34:14 -0800 (PST)
Reply-To: te463602@gmail.com
From:   "Dr. Anthony Omoyibo" <anthonyomoyibo9@gmail.com>
Date:   Thu, 19 Jan 2023 04:34:14 -0800
Message-ID: <CAN5Lstyx3GEf3iHhWBCa56q-YKp54L+sc6=z3ukVP8pTuiDkYw@mail.gmail.com>
Subject: Very Urgent,
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

-- 
Hi,
I tried e-mailing you more than twice but my email bounced back
failure, Note this, soonest you receive this email revert to me before
I deliver the message it's importunate, pressing, crucial. Await your
response.

Best regards
Dr. Anthony Omoyibo

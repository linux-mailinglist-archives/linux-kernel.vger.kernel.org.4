Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9AD693CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBMDHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBMDHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:07:19 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B49ED7;
        Sun, 12 Feb 2023 19:07:17 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id h10so1657390vsu.11;
        Sun, 12 Feb 2023 19:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kcHnI96zNjfQlLYDodJwKwSlXVI5y4LSVOx8M0TZ8ZU=;
        b=K8g777QIwrLgN+pFUq/PZMZ/+GWhoFo9rfesTPx1SqpoegLAlgdTVtd/dbX/6tC93b
         KPnWn0ig86IlPq/7dvzTaHb2v5WqAhborapk+r+F777pHrrdX6KRE3ZVz8kCIkcUePFv
         UkU4XrOPpNBsVzc/ZhFQeGq+MlI0rpjez0cAYw+57Adcl+KLVtiyvjUCm7UeJVN3YDTY
         7jXvsNfha33LcNHeZ+Bg11ipscl7H7p7IgXw6SQQjDoQSdiMLKGNimllZ0iJURkQilGj
         CztYuleQjtiWvUQudWoZd+ro0m0NFzreUrRXga2K4KKGRVSba50XopmeikUU+WQAMkAX
         mx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcHnI96zNjfQlLYDodJwKwSlXVI5y4LSVOx8M0TZ8ZU=;
        b=KhQuFRbDlNi/78V+QZqORqztndro4jUpNJs+5QcQKcgHBQakyFTZzewwggmk5nrvMM
         UkzV8FgU4gY52Sigs24oef3Z1l/LrGa6hvwov2+oOA2uEoucINzIab4OHG2eIBAxI4iG
         G+LSoykghvO9ylpHr9WuXThv70clRymK0uJsgpYlt7AIjw+zTJfdrJKLTC+bwDcxZSB1
         y05J9wihbodinpp+6kNsciXFEi6Ip81qLAMgmC+2RSOu6NGZ/bVQsQN/+lf23PQ5h6na
         o0zsyGU9kNtxX/i88kknVW2JDSDUfSAyvT7zra1iMHWxQU8X3ata0XG39bq2oHMI1Ot/
         0Rxg==
X-Gm-Message-State: AO0yUKUtfE0opfwZHdGfUQRbzFFUe0agaOgbSirXXCKgOXDg4QdVRZgI
        KgBBxBPGWWYbhTXuB8ZUPwXD95N0zQX8dBAIzMM=
X-Google-Smtp-Source: AK7set8iEjeN78Q7+12/hG2Oj6DiGKxWZmsCx8JOLarTr8A1PYmgakLmXoZmHMsilJeX5BhTiaU0vJWHNrlWguub4Xw=
X-Received: by 2002:a05:6102:a22:b0:412:317f:e15f with SMTP id
 2-20020a0561020a2200b00412317fe15fmr32440vsb.29.1676257636873; Sun, 12 Feb
 2023 19:07:16 -0800 (PST)
MIME-Version: 1.0
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Sun, 12 Feb 2023 19:07:05 -0800
Message-ID: <CACsaVZJvXpCt37nQOoe8qd1EPUpfdMM1HwHk9tVO8HdU_Azhhw@mail.gmail.com>
Subject: RAID4 with no striping mode request
To:     device-mapper development <dm-devel@redhat.com>,
        linux-raid@vger.kernel.org
Cc:     Song Liu <song@kernel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi DM and Linux-RAID,

There have been multiple proprietary solutions (some nearly 20 years
old now) with a number of (userspace) bugs that are becoming untenable
for me as an end user. Basically how they work is a closed MD module
(typically administered through DM) that uses RAID4 for a dedicated
parity disk across multiple other disks.

As there is no striping, the maximum size of the protected data is the
size of the parity disk (so a set of 4+8+12+16 disks can be protected
by a single dedicated 16 disk).When a block is written on any disk,
the parity bit is read from the parity disk again, and updated
depending on the existing + new bit value (so writing disk + parity
disk spun up). Additionally, if enough disks are already spun up, the
parity information can be recalculated from all of the spinning disks,
resulting in a single write to the parity disk (without a read on the
parity, doubling throughput). Finally any of the data disks can be
moved around within the array without impacting parity as the layout
has not changed. I don't necessarily need all of these features, just
the ability to remove a disk and still access the data that was on
there by spinning up every other disk until the rebuild is complete is
important.

The benefit of this can be the data disks are all zoned, and you can
have a fast parity disk and still maintain excellent performance in
the array (limited only by the speed of the disk in question +
parity). Additionally, should 2 disks fail, you've either lost the
parity and data disk, or 2 data disks with the parity and other disks
not lost.

I was reading through the DM and MD code and it looks like everything
may already be there to do this, just needs (significant) stubs to be
added to support this mode (or new code). Snapraid is a friendly (and
respectable) implementation of this. Unraid and Synology SHR compete
in this space, as well as other NAS and enterprise SAN providers.

Kyle.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630D06418B0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLCUVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLCUVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:21:33 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341F81D329
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 12:21:33 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id c7so5130817iof.13
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 12:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=OjLbk44Au+Sdmiq/+s+1/FHnlE/VSjCTCYggWoHGmsAetgZc/TOjRukNwaVxUz7ExO
         wTizLz2s1JOzUQEKbydJ05TXEMS3STEuNqTIZmcA6lukr57+LaX6MU2qMvAo6xKDNvkR
         iHoo1vqy7tPgshtfde787TfQfmMIGxyrRDeMb88Mq+ZVjhGrw/nY8v7+TRsTfHwvcRUt
         ZGMKOiBYS2F+yryG2bPCWTxyozuVrzpy2d1r8v4z1cxdhEcwjMCe5jmdbpiGtjuVzsEH
         x7J8UgWEc5D3O1bs/nWdkQhWa/96maKaz5DABfMnJKSw3dfPcR++ciATwByL0uHNsJiZ
         6Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=OfENG2+5EHzMJ+Z6OZCsb9yfWSsl5bbYyNvhJFOA5dTa8ylh27H8RA6H6YKX8wbuos
         0TRPNeEE4EwO/ap5loOyt4/VCV0tk0FV6gfpkit/JTm0zqHbHjGar/7ClIBO+jhOqmhd
         3u3wEZDlGw/zPm1FyPAAmo1tcz6ESpU7/887D2c26W2qppmOOcIwVnt76B/T3lKwG0Io
         9SqJAliSyZtyOi71cHI0gueXWH4uTnkgbFBfROA8UpzICzWZbSZHvQ+jdhrkszNKUGW/
         Yi94mJs8mghel0lWr0haeakBsledEPL8Xdubkf6Ffs5uC79kSS8B+h5PczUVUvumsuwp
         lDRg==
X-Gm-Message-State: ANoB5pl0J3n4gHrkKCI65eM0VwqPy+v1XYSHARD5AoqZIGMK1ihGiUXT
        9P2tIlHEeWThXp3E7As++FxBRVjNzz7bGqK8aiQ=
X-Google-Smtp-Source: AA0mqf58V3kscjtrt6gBlthrN1I1F9/e3zcb8BnSI0WRmKGzO+L3LAfl2kc55zMo1175Blvh8WfytHUK/59UG2m1/ls=
X-Received: by 2002:a02:cc2a:0:b0:372:bf99:b645 with SMTP id
 o10-20020a02cc2a000000b00372bf99b645mr27868827jap.278.1670098892175; Sat, 03
 Dec 2022 12:21:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1e02:0:0:0:0 with HTTP; Sat, 3 Dec 2022 12:21:31
 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <tracywi178@gmail.com>
Date:   Sat, 3 Dec 2022 12:21:31 -0800
Message-ID: <CAAxj-_gA1LcTMuN4=2mDf_xuJ9cXU9FrUmEb63mewaYS=67ChQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tracywi178[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tracywi178[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava

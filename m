Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B314721E1A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjFEG3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFEG3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:29:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424B6D3
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:29:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-65131e85be4so4331973b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 23:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685946543; x=1688538543;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=a+X4pGHKR/jj5TYST2O08TGIebSbz5svSc02POIOdgXnxLVkzgLGz0akyNQD2N9JsG
         noSxYBxzCQIyyQKH7lOwV6cmuyk9NJ2+b9SVUAXpLfjZk2BK26AhKhDE9cNZBm/rS3b0
         UoeOGe/sIkbVdzhoWMaDmkoqLpCukCkuNrpQfhSN69vybEIDOptlPpE8cgJwVuUuvU7k
         hNIC2J4nOD3X/7RxemJm3RXGZn8JnN2ua92wsm6b6ZVIwbYOfZw+8fxAnq9fqsDbE9xJ
         Z4FHGYddWJFMxc0IFQ/qLM7WiMBon33xONK3lErN+oZhrwE+CNhiRpccnIBbh5hcOWMH
         Zn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685946543; x=1688538543;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=l60HI7IOZUNGvI+tEqkSt+5ixJlgX3QKIk+yqMNkTFo9cZBMmqU+1I6AYV422zP7wA
         d2lnFTYrLcV+qYqvNoMym/AE9Ebv1PkZtPGHmW5THTKcNu3MBt8w5p9f7J+bHh8Qif2F
         eoQjJ0QYD0WaA+5KcsjoNiuC7MPSUwJ78PxWJuN93d5+BOLnLfbXSa91dbs4JLfn4bc5
         9iyK/L/WvBTFV6DfZ4iZH2pwhs6pQhmxuAcN2mmz5AP2wQtNBQvgfzIDvrzEx4kcKrWN
         oH3AIorP7Dj681AheMKmjprtW92rm8C44M2ThzgxqpUpkyqdCm1h1JyfPOVQ6IPr//GO
         1YTQ==
X-Gm-Message-State: AC+VfDxgQ6dcUZKnFAbjbahsz+p92Z/U+5SovLw21X4j+Ic9Iijxz9X8
        kc0s79X6I1vlg2uwiquuHuKOgVmbk+83bjRYnbc=
X-Google-Smtp-Source: ACHHUZ656m9/uQsE6aGvp3O6sMgLwx6cT+8/8CiEXsMiI16t7aPffWl72/XKm0jhtXDG1iLwrVTfWUvAkNhu2Xhld94=
X-Received: by 2002:a05:6a20:7f8a:b0:10c:89cc:bc5f with SMTP id
 d10-20020a056a207f8a00b0010c89ccbc5fmr7140786pzj.20.1685946543486; Sun, 04
 Jun 2023 23:29:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:169a:b0:475:3cf4:1bf6 with HTTP; Sun, 4 Jun 2023
 23:29:02 -0700 (PDT)
Reply-To: officefile_0112@yahoo.co.jp
From:   OFFICE FILE <hih92699@gmail.com>
Date:   Mon, 5 Jun 2023 09:29:02 +0300
Message-ID: <CAEgGz=9GDF5njgj6VVBNnOnR5KqzOZMKWRnZoh9LaddBs8vULg@mail.gmail.com>
Subject: Contact Damoni Kitabire Chairman, Stanbic bank of Uganda Holdings
 Ltd. Email: stanbicbankofuganda@gmail.com
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:42d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hih92699[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [officefile_0112[at]yahoo.co.jp]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hih92699[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



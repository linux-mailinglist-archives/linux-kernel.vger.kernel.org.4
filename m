Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34E25BCA0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiISKzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiISKyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:54:15 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5247127B34
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:50:16 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b35so40701466edf.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=0VQuOBOAInh/oCFmAgnHFTRx83AeymR8zc8R+S3NTFU=;
        b=bhrz7rkefUtPJx/8fYirhYCJBGMwYebU341OgUhc60sQ5UpLJ7XtJYM888lwDnURzH
         B1M9DK+VZNhXDRxMyuSH6Hrjn4J24BrRSWLt7pdh+vW/xMEHX3gs5Bb9P5vH6+YiZGLR
         guuaF5QIz2yFu7pLUzleRIcaajWmGa9gnGg6QS0hKzlOAEtJqFyGRAPaR5pYWKz2mXZf
         2Bk88D5VwHuqtlEb//KNJcMeUcHvhzMzsKgpAhc47Pf15WMm1ZOpULDQRnDi4PJI8485
         gcw36wrzSkNjmYMycfjLrJvXW4LX/9kKcW+cvDQydrxayXbGrxNyjTHdhkZeJtlGTnM+
         zvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0VQuOBOAInh/oCFmAgnHFTRx83AeymR8zc8R+S3NTFU=;
        b=omfrSSxEEwR8YRTaU7G7BTphxoWa0Sat5nZGJbvJPKLAzagSFG53F8rCq5EiGZX5F4
         ZqErzeDbOGICnndhgHxEBkKnba2hkestnVVprYwK0Venv7PTtbt3wz+Vf9CjgrsTJqWo
         Utk8VyG8BDQ5iSnGkC6v8Z0G+XbosFxzD00hgIwOAjG1993MhP6Xd6O01Ow3jYuapimJ
         1gxGwKngqVhXNpYcLW3/S2BLhMy7jTfRNhbl55DD7aaLU6q4P7v43iRMlKPTLWnYHSCS
         +g15P8yhyGRyYVWloVH99/chcBpceYckBTbxvjS0zCbIHJeNlXDK9+KNC9X9nIHZFkSc
         llIQ==
X-Gm-Message-State: ACrzQf2racBAtF9eOS5I0KD1tgX3DKI9Wlo5GhuKlcByZLqmylUmsmYV
        0GziigWPxt4vj48kgFE6K4q1d9HMRrZiR9FEwLg=
X-Google-Smtp-Source: AMsMyM4G71PLyfiAhMrom7idEIMicuoJmc0L3JjOVYKZBwaXjRmVnZ8RO1oZsFwkaws3I5ux9sHkccULqKEasV46oBo=
X-Received: by 2002:aa7:d617:0:b0:44e:d2de:3fe1 with SMTP id
 c23-20020aa7d617000000b0044ed2de3fe1mr15302383edr.104.1663584616384; Mon, 19
 Sep 2022 03:50:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:a24e:b0:77f:b065:93f0 with HTTP; Mon, 19 Sep 2022
 03:50:15 -0700 (PDT)
Reply-To: davidbeames02@gmail.com
From:   David Beames <incglobal108@gmail.com>
Date:   Mon, 19 Sep 2022 12:50:15 +0200
Message-ID: <CAN7_iphbD7f39HO-p2kM6p=XEvFUAJsTN1uBeSSjM4jpPs4tzQ@mail.gmail.com>
Subject: REF/UPDATE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNCLAIMED_MONEY,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:543 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5025]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [incglobal108[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [davidbeames02[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [incglobal108[at]gmail.com]
        *  2.4 UNCLAIMED_MONEY BODY: People just leave money laying around
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day

Reply by Email to confirm names, last name, and phone number,
in-respect to an unclaimed Fund in our claims file record,

Yours Sincerely,
David Beames

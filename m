Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5A2675A11
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjATQe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjATQew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:34:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0B5966D6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:34:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v5so7420562edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3dAPtmGWRYS7OKs5vakwS/w55xKsC/jYWJOuUUtC+/g=;
        b=S5ByMyRKRzFW6BZxNndqy8KNGc6X64zUDt3nB3D2QaiQlFL4LSRLSsqXKPV/p15y4a
         qcAtatidtxCmYO0zdoXpCOeivyE2wUAjlh8NtN4SCxVypmY+BVfwaOuwKjNd8/QyuY6W
         FOjbVpOz9YYdYtfXbsey3eFFY6ZfSIyEGM+4c5cDupVG8g5ym6o5Qz7iIjARv5fBhqde
         K9bJGW51znfwT0CN9GVrescaffiMcZah4UKOZj+UpphIOjssF3xijrPR5yp59N8/xKA/
         i21Z8uQWGuvbA+g0yaCsDsavUjo9afupYND9Q+rruiaU5Qu3teoxpRoUPuxiE0yfcIw7
         R8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dAPtmGWRYS7OKs5vakwS/w55xKsC/jYWJOuUUtC+/g=;
        b=eHJNaiWWb8HLoUwKZdXiS+t/UpnjDUNMEbFb6zolPpcbeIHzWamFfhV14XrUnE+D8W
         hqFB82J/7oMKH9L84wZHD2yuIMbCJdS6WhWD0WKYAJE7n++ZewrSoFMgcu9xW9yXcePi
         d6C0BrLznA0GYb1MpgU0V2JxuZ5YHwZU/Ibv3LTF5tQOqRxX1tyLtxTC6ZjQ+hH3TvBU
         oRQ75iFHFQXcd6WwldoXfEXFyfmdQGam6/q85I2AjjbqfIkucHHE4vg/6KidSHCyO70H
         4T8UA64sDBOakplJcJIL0IL887kfUDZdYUhARMGgB4dJoAOPQANwT+xdRuMfUBgITbvU
         iQlQ==
X-Gm-Message-State: AFqh2kpl0qzgP6j0/lkAcRUsiFD1X7YoKQTD3G30y+dBT9iqXQUpP4BA
        zH4qCH4tmwYB08TBTJJAWUYJdwgF6IynwB5rmc6dTXIWFm0=
X-Google-Smtp-Source: AMrXdXuiZvxVO02BZCOz33dlajgKd+/e3Io65lQIjOwfUzNv/lI+056nA+sKepTFNW1bdo3cv/jnTS7xkGvCgjXBVsI=
X-Received: by 2002:a17:906:2983:b0:868:b146:b29a with SMTP id
 x3-20020a170906298300b00868b146b29amr1126805eje.398.1674231962158; Fri, 20
 Jan 2023 08:26:02 -0800 (PST)
MIME-Version: 1.0
Sender: agricultuaproduct@gmail.com
Received: by 2002:a17:907:a4cb:b0:79c:d3f4:4fdb with HTTP; Fri, 20 Jan 2023
 08:26:01 -0800 (PST)
From:   "Mr. Daniel Kafando" <daniekafando001@gmail.com>
Date:   Fri, 20 Jan 2023 16:26:01 +0000
X-Google-Sender-Auth: Vdt5c_qyWKwT7xlEpfpefOquv3Y
Message-ID: <CAJV9CctCwNXPsyOWdmQ1r3di9OMXrFzJjZN0NQfQCQPpmv53dw@mail.gmail.com>
Subject: Am expecting your response
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        LOTS_OF_MONEY,NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [agricultuaproduct[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        *  1.5 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend Goodday, I am Mr.Daniel kafando.and I work with UNITED
BANK OF AFRICA.Can you use ATM Visa card to withdraw money at ATM cash
machine in your country? I want to transfer money to you from my
country; it=E2=80=99s part of money taken by some old politician that was
forced out of power.

I will change the account details to yours, and apply for a visa card
with your details in our bank, they will send the visa card to you and
you will be withdrawing money with it and always send my own
percentage of the money, and the money we are talking about is
$4.2Million us dollars.

Whatever amount you withdraw daily, you will send 50% to me and you
will take 50%, the visa card and the bank account will be on your
name,I expect your response. promptly so that I will give you further
details. Mr.Daniel.

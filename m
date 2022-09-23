Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350825E77A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiIWJvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiIWJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:51:00 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEDAB6576
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:50:51 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id s6so18952523lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=2qrmcRDZqwi31YkwdnR1i4dWD3broD3YXrZDrzvOyNI=;
        b=HUxqy2qr6OehzXQV16cjRzMAJLPs/TetH4FTDBvm0rMCiSbnTphIo8EU9i/v/KWhQU
         LdI6Y4dYmb5NJRoIOG8YxLP39MyVpJN6J8CsrfYeSTOyysVydX6yvtqOhMu53sxVtTbI
         r2lf6sa5iuecDbLEQSKLMUizIfVKdfNz7oBBWMqTLoATSAEKywHXjZh6vSPOyTrJrhMi
         XMf2c+aGRl33DaChy10V/vmFx8GG2qLjVtmig2vjft9qPMTXEBIr55jvHHVx5rn3YRf9
         8He0YBJH73p0Akx0R25MPi7LM/IpR6buresc0aaPoVJN+g9hWnp6GCizDKZg/RSJQ+gF
         8rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2qrmcRDZqwi31YkwdnR1i4dWD3broD3YXrZDrzvOyNI=;
        b=p42QrSPx7wMhvZ/pG4NWp/qZicyzT7mfgahBZkKYlWzkFfIiOhpGY0a5Rnw9W4zruB
         buwoiN+FMksTgAjPNUNOCCEVPMyeHo332rLfzwJs0WOABIm1orGjnfcYSbAmkbrE0Aux
         LCxdKCgBXwyl3rKMDb4xkCq1O8YwdCE5lr+q8vwk3B/BxmN3Q2jAaqKFyw9N5KujsvVn
         FMESAiQXGmsO54c5igQdm07cISR/hQLOs0sletw1E65Vve8JRmw0Ln9+4m96waRpERVB
         W3LFzFqXA76xtnOGVeFLdBxV6mmnhrtqjmWbyCgLs2AjSusCLg2N5VylFoV2zLJZqZeG
         OgGQ==
X-Gm-Message-State: ACrzQf0cGuwYF6LbVZOA9Ok6rLt5o9IRlFlOr3iDLlYrIysYyElaQ+0z
        8Epk2iXyc3ApHpoqh7aD76twBjm+wKjUwpbpu3g=
X-Google-Smtp-Source: AMsMyM6eCIScuuP2Zhj89/HCtI/dYMQioFerBO5zcg2vxxpqEeLVc+qrUz3tMl3UfXEAR98MjKb94uUfEttyeM4ZGCo=
X-Received: by 2002:a05:6512:e9f:b0:498:f1e5:26e5 with SMTP id
 bi31-20020a0565120e9f00b00498f1e526e5mr3103316lfb.517.1663926650299; Fri, 23
 Sep 2022 02:50:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:80c:b0:1e7:be54:c292 with HTTP; Fri, 23 Sep 2022
 02:50:49 -0700 (PDT)
Reply-To: markwillima00@gmail.com
From:   Mark <muhammadabdulrahma999@gmail.com>
Date:   Fri, 23 Sep 2022 02:50:49 -0700
Message-ID: <CAOhTmf4CMHGL6g=PXp9s-vz1NL2qSB57edUiadUwKbLz5gQr1A@mail.gmail.com>
Subject: Re: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:143 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6574]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [markwillima00[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [muhammadabdulrahma999[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [muhammadabdulrahma999[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


The HSBC Bank is a financial institution in United Kingdom. We
promotes long-term,sustainable and broad-based economic growth in
developing and emerging countries by providing financial support like
loans and investment to large, small and
medium-sized companies (SMEs) as well as fast-growing enterprises
which in turn helps to create secure and permanent jobs and reduce
poverty.

If you need fund to promotes your business, project(Project Funding),
Loan, planning, budgeting and expansion of your business(s) , do not
hesitate to indicate your interest as we are here to serve you better
by granting your request.


Thank you
Mr:Mark

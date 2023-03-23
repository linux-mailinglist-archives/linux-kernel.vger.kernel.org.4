Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8199A6C685F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjCWMcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjCWMcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:32:13 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CC924C84
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:32:09 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id n17so14834761uaj.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679574728; x=1682166728;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e7njpxHsBp6Zpf7USz1qoQfmvdgTSOIgFyvT8AM89S0=;
        b=mETt/7fL6sCVOGgSUC4X42zdsee75/cOYiPkOOc5LOqxbCxCUIAYoltj3gZ18uG0/m
         oqO9tRdCzdGMbghra0/eT/po0Rn06U6aHiaK6teZLWr4A3vK4wq5qkuZuBcLKkE24SBr
         3DzXRppzZikj8q245oczt5JYJOCM3bn6ToWEF3Xf0McSnW8Dg2SS4EPCdQgOj4V8IRZv
         AqvvKOtr2ksbZYxByWF05aSoTYNuL6vgr0wpdk5B21du8+pl9tG5mN5cawYllUW5m8OH
         Lfm1tB/9j8fipCoxzpIJ3RaqLpHZpfW/z7jS8Z/MYwV86XFC+1UxQn4z9/veZ9ewKpgA
         N9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679574728; x=1682166728;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7njpxHsBp6Zpf7USz1qoQfmvdgTSOIgFyvT8AM89S0=;
        b=eqtBDvcvJPBw4odH7zVlIIvlshoIB/7g/qJz8B7stfNWNOV85rutwEPmBYdDSNB0jr
         CtJow07Qd9EPoLckhOVv7gfDEm+P6PhrRQkdH88lkJKZkE/ZCeUMHUzmbfb/uzSA5l9W
         6ALtnV1gX+kTNCIM5VG9TrkZlIr7C+SC9+O0C+BOuMVxsR7hqTDcu9p6TrzA5k38hPB1
         3V8vwOrFsqfAIcSC2Qc65D9lxWqf0wH9jqPUp1jzbh8CtkJ+P/vXjk+55XHfLHueF0M2
         TXh8EwcVAd6UX8M4mp3vm+GI5BEYdQSO/3PgBEeVc/suc3NV+IVxXV3KQg3zWfbN8ysQ
         NDnA==
X-Gm-Message-State: AO0yUKUnZIXWIMC/VpRbI8IjSqXElWiaACZO9bba4rT5nXgRcrRSgsHi
        GU/oudtx9DJNWzzbw2W3JjIBMXuxrvMEYz7BkAMpHNL/yvMBTsBW
X-Google-Smtp-Source: AK7set9GUaTS0WQA6zj4s6oFOTMi3x+SlwBDmNRW1jDzCFtFHeEdv4OaBc3otAZ9GOnxMc5mngJt92AE+1yxY4lcAkY=
X-Received: by 2002:a1f:2850:0:b0:431:f19e:fdd with SMTP id
 o77-20020a1f2850000000b00431f19e0fddmr1740727vko.1.1679574728470; Thu, 23 Mar
 2023 05:32:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:abe:488:0:b0:35e:bef9:d1e0 with HTTP; Thu, 23 Mar 2023
 05:32:08 -0700 (PDT)
From:   Naruenapang Naruepai <naruenapang.napa@gmail.com>
Date:   Thu, 23 Mar 2023 12:32:08 +0000
Message-ID: <CAD93zBBzZ2j8zOUhwr4CRtq4bUF_D5ARwQpLkcf3zQdRAniDzA@mail.gmail.com>
Subject: Adolfo Yarhi Gumez
To:     linux kernel <linux-kernel@vger.kernel.org>,
        lionel perez <lionel.perez@305miamirealty.com>,
        liperez21 <liperez21@gmail.com>,
        lisa reinstetle <lisa.reinstetle@kw.com>,
        lisa <lisa@lisaperrysells.com>, lisa <lisa@mycfrp.com>,
        lisa <lisa@sofldreamhome.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BODY_SINGLE_URI,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SHORT_SHORTNER,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:944 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.5 SUSPICIOUS_RECIPS Similar addresses in recipient list
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [naruenapang.napa[at]gmail.com]
        *  2.5 SORTED_RECIPS Recipient list is sorted by address
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.1 SHORT_SHORTNER Short body with little more than a link to a
        *      shortener
        *  0.3 BODY_SINGLE_URI Message body is only a URI
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://onlsp.app.link/TIC74xhSnyb

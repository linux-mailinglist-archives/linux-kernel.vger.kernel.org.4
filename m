Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4B5BC2A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiISGAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISGAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:00:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AFC13E9A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:00:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e5so27076652pfl.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=Iv5uBfF5M9kU491T8bKcKlilZnpuX7sv/dttBGICVbg=;
        b=X+6/DDqnEtEJkhnhbPhwsVOI/A6cpICF5q/P8ECP5eJJPri1KLgp9miOGGexZE3UdJ
         KjrKttRyZNi3KwWh+WTHjXUNDj4F8XX8/tBzIEipkeOc+rEqAsmrQlzjl+msfU9+mpCU
         v0Lm4vr0vSW5lclo814+mNX89wZ6mjEiBJ+Uh/njdEVOgR868qE6XW8NM4nt3Py1Q9NF
         ltSSZ0EfHq7dZQOiNYWAUSiKrecil07eCBXdZ0Z4ljtdphgH98q5qLya63QZ7VAHrbCC
         3WXyjpvizt+n96np05iO3fLbra8VA+wELVVg9ERa6KVIl9pU1s9xN3v2ZjjAf1SKRoyq
         16iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Iv5uBfF5M9kU491T8bKcKlilZnpuX7sv/dttBGICVbg=;
        b=SIFUvaCrCR5zciU1r5g9GPAuewLA4Aa0UNZXf/h1jtIL4tmCsZN/PRnw9zhG1RKOdm
         tzxzD5FnjHELRydHRI561ekGqMSi2bOzYh+hd4Fbz6G3VlZuMSGMH/SLSPOndWGo6IN1
         8lT6V5QpiBWl9+Fb48ahiZnDJ3UGBJjN/+n3H0wCHbm6SILBePk0OZqcbUufdRIy7kZy
         o9WI/kccFBRHzE69JDCFud5i2jR4SWrQh8p2PouLqibIq0QbYpHjnQoV5nXO70WKlG5Q
         y3cQaBDYP8v/d4BetbGN39gPfDMPHyHSmA5V34bzIDL1Ej9TjZQ+bgwq8lV3ajJWWESL
         QY7Q==
X-Gm-Message-State: ACrzQf3KW/ezJYzLhKkZe6mzJbjEG75ZbpkgXknhxuyiWwp2bxReCWaA
        AxlgBqEOWOpLDHX6zVPpyJCSO9bdXrXPb0tc7eA=
X-Google-Smtp-Source: AMsMyM7OFptj5vQXxt1+NcbHuQQhlafAcaIPvKXjNbu/bG62zpHeIcnye8EDxIFQMLLkgiNn+bZIe1vj2u4LJ3xFopQ=
X-Received: by 2002:a05:6a00:230d:b0:53d:c198:6ad7 with SMTP id
 h13-20020a056a00230d00b0053dc1986ad7mr17498926pfh.67.1663567230041; Sun, 18
 Sep 2022 23:00:30 -0700 (PDT)
MIME-Version: 1.0
Sender: thomasemem3@gmail.com
Received: by 2002:a05:6a10:6f2a:b0:2f4:6097:44c1 with HTTP; Sun, 18 Sep 2022
 23:00:29 -0700 (PDT)
From:   Hassan Abdul <mimihassan972@gmail.com>
Date:   Mon, 19 Sep 2022 07:00:29 +0100
X-Google-Sender-Auth: X-G39PuYk7yqf3zUQ2_P2a2V2u0
Message-ID: <CAOH2t16Sz9oP1q+b0OMCCXyuVQ-U67bRQ49spfDG8kvF2oAWsw@mail.gmail.com>
Subject: GOOD DAY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,MONEY_FRAUD_3,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I'm "Mrs Mimi Hassan." married to Mr. Abdul Muhammad ( an
International Contractor and Oil Merchant/ jointly in Exposition of
Agro  Equipment) who died in  Burkina Faso attack, and i was diagnosed
of cancer, about 2 years ago,and my husband informed me that he
deposited the sum of (22.3Million USD Only) with a company) in
OUAGADOUGOU BURKINA FASO.I want you to help me to use this money  for
a charity project before I pass on, for the Poor, Less-privileged and
ORPHANAGES in your country.  Please kindly respond quickly for further
details.
thanks
Mrs Mimi Hassan Abdul Muhammad

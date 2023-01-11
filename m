Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B45665E51
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjAKOte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjAKOtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:49:22 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B70E0BE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:49:21 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id s3so9049075pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvGcltGHEZtmIUygQvDyURpCDrkBBZcFV280L4qV7tY=;
        b=aXc2UrwAzQAkd1kWKBFiTOPpIRBdRzGe2fpB/7wbXByClQl/9/rPbll5RtrvIG9uHO
         m9UXveHhTef3/rxL4pk1Y3uGAO51nSJAVnvnQCUlHD0ETDqaWJNQ28jpmkUsNpb3X1Hr
         0nUWUA28xEXnrskcvvVlLqDazOfKrJMQUmCufowPbD0vWb/OUOaRQnja2bwl3wmiXnx8
         9z6SLuM5/5fBP8znPfQ3aTmTEQoE8IBSL+/FJ1cdxN+EqxoWKFlLbAFAlLiirQGeM7e0
         hxC8Cd98CAGIY5GbuokgS4ieF/YcHbJnVtp35KG1HIZRl2sIc57YnyiqhjmsF5KIpLsu
         X2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvGcltGHEZtmIUygQvDyURpCDrkBBZcFV280L4qV7tY=;
        b=p5w6OuWTGsOoAHxof2U22YF1My2jJOtx4EmQe9OTLpXccaoD5acIKFs16eR+lIcvsT
         U5nRfuePrdoDJcKL66L0ZDZ/W/BLGUZta7jL3hWcJQgAjmLu0swJDE6gh+D0iCvevai9
         mZXXZPlh0RQuNPIada5DTXsl+6kev3jEL89Y3tqmbtRU29emaYr+EBVJoKRUbZc0sUec
         Vx+5oIsu6ji7fJkL/xpBVKPlQKccClHo19WOkB9/hQmlEbjK/fUfAlwylJXdo5l+0kkn
         tNWwrbArcchSqRP4GaCCxsWUJ+7HyPxFJkHfoFKt2qPAwGQLBUneIgARBWB5/jif1jKu
         YRGQ==
X-Gm-Message-State: AFqh2koJ866n6RbD12PKqww1RoQPgJzUuXrpeMgMZj2euObA6nGNjE1y
        w59ZlPriN9uqtuGP4pBK5WJGW/Q7ea2wXL1h/+A=
X-Google-Smtp-Source: AMrXdXvT/CmZZSH1RNppQcf0A4kT/LW3dVcDuqne2yum4buuryFRx0jeDuhraWRl1zMLPi8cJNQv/aNT3Ca8HMDQIUU=
X-Received: by 2002:a05:6a00:806:b0:581:2427:e8b9 with SMTP id
 m6-20020a056a00080600b005812427e8b9mr4467409pfk.13.1673448561052; Wed, 11 Jan
 2023 06:49:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7301:1692:b0:96:9070:250f with HTTP; Wed, 11 Jan 2023
 06:49:20 -0800 (PST)
Reply-To: jmrs30982@gmail.com
From:   Elizabeth Anna John <johnmomah16@gmail.com>
Date:   Wed, 11 Jan 2023 06:49:20 -0800
Message-ID: <CADo75648cvodKX_gTNHPOV1LXA7-YsTwDX2kULmjVj_PL-HHBA@mail.gmail.com>
Subject: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:433 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jmrs30982[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [johnmomah16[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [johnmomah16[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a business that will be of mutual benefit to both of us, Reply
via private email for more info : ( jmrs30982@gmail.com ).

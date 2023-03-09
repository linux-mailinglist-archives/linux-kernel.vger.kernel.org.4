Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C716B27BE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjCIOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjCIOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:51:12 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667E6F4B6B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:49:36 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id g17so2612581lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678373360;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IEW8M/aeCm2sE5fVkmadnoct+8r+q1Vjruu3SWPyz4=;
        b=JDGWw6n/bGtww37vqF5bJEUF5OLuzOGZoRY3GeMOF0jknYjbBC4WV51Qe3htdU4oB4
         KaLBMDzhCwVC1vD/kxoF9lGJUtnE5u9RZAARdJu54kZLN4L7lguTv5XkyzR4DIMedS5Q
         Ap20WlP9mnwSWYVuPLalJo9WTO8CD9m7xL5G6OGu3zbvNlbJwxJObleGQzMx0LQj1lnL
         mvtoBMcRwu9mXunuhwdrZmg/Pl6oyYiRpOrBKxM9rnpXgsVVsaNAd54Er485w13aFkM6
         56iKRoSCedVc1svUs20og8E0aK1MCoF4yv96W21egG58IzZlEz+8oE3O1mJuBR1QQJVN
         +L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373360;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IEW8M/aeCm2sE5fVkmadnoct+8r+q1Vjruu3SWPyz4=;
        b=Vl14g9UlSdjdLRDhiZyAswvJcZzCK4jJvJO1YmrlAI8P9dvFO9QFCOvpU5AO8Nwl/N
         8V1ht1H9dEC7HSkan86A9Pn91c5R66kbU1ZbyU9Yu1RU5trXxzJHV/rrAwAb/uXNKss0
         rHgUU954A4l61YNaPAnCO+eW8yUcd4w45k+qfx/2TdCZygL/Xxcx6JZ5pPcI4xlTB55c
         P2nyeL9dLIeePPfjFrUg5wkbwTvDz6p9WAxpXRljsD26lUt26AxCV/CdRaK3rh0ou7qA
         4tDuV2AR4PEy0Ou6g5EKW+f3EEOL9CgV0s7oqseHT+mL/C6qNqbEonGf4qdm+t4CvPNH
         +cjA==
X-Gm-Message-State: AO0yUKX6DjaQ4yBdrSVkmrzTJoWAYjhQpwNjhPHOv2kAlNg30WflV3K4
        biBLcQ7CqbFsIVJGlMlRcdvy45BmMw2+jESuqZg=
X-Google-Smtp-Source: AK7set+JGAQzKxmezNd7RQx8YEGiJc1RmAtTo+6cEJpQm6vgJINCoqE/RuqNP6OEM0zj+lk2yqH0G8QsAxMhcjQgxSI=
X-Received: by 2002:a05:6512:281f:b0:4db:1e7d:5d42 with SMTP id
 cf31-20020a056512281f00b004db1e7d5d42mr12673495lfb.0.1678373359921; Thu, 09
 Mar 2023 06:49:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6022:9116:b0:3a:4b9f:4650 with HTTP; Thu, 9 Mar 2023
 06:49:19 -0800 (PST)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <devynurmalayousef01@gmail.com>
Date:   Thu, 9 Mar 2023 15:49:19 +0100
Message-ID: <CAApZ1XwamMYRdqTQ8KLsA3my=iG4wuCoyrDWKFTX791BLZNPbQ@mail.gmail.com>
Subject: CAN I KNOW MORE ABOUT YOU
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:143 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7491]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [devynurmalayousef01[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [devynurmalayousef01[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear how are you? Are you capable for investment in your country. i
need serious investment project with good background, kindly connect
me to discuss details immediately. i will appreciate you to contact me
on this email address Thanks and awaiting your quick response yours
Amos

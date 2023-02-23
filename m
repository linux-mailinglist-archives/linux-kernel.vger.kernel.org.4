Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDF66A0FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjBWTBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjBWTBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:01:43 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391253B0FE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:01:43 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d75so2680212qkg.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7M+H5IGSZ9QQxs2fZYNmrt/6EAHlXrZW2C4wkZBhh0Q=;
        b=YoPyX0N0QaY2nP3XXURLEzcqpSEMAQcWKICU/uw0OuAcOV3LaxORzkrVGzoPxd4fBl
         YcPU2U5GMkZFSu54k01fl2WtA8Pnd9uNJ9MD4NLngbexBeX19YpLSTGKNyrPod6Qszps
         Z+dqrDcOIU4WRpqeU18N39kUFSontQ8NPaFl4gmqqL1kpnyw/jJAYeGi7V2fKqFblb+R
         b3Goeg6G41P4KpTAwqY6AZDTZTdQ9cI5aFW+18vGO7tzQ8c3dx8aFARosQTL/73iM7yH
         v77WGDsiriNA8PJPLkBWaM8Mtmj3CSDOk02Osm19J3hxUazeX1ewM0EICcs/xHz67bvE
         TMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7M+H5IGSZ9QQxs2fZYNmrt/6EAHlXrZW2C4wkZBhh0Q=;
        b=VAq94FFmtgyOHwKQihJDeLmp6eK6XyIQ5hqCYOy5F1KY2GVB/+5ey6Xc+WI+ZLTBkV
         FL7vzohLTUl+bCGkXTnwV6gBDSUtDexxxo7W6VY5v2NydaVwiggKWu1FEzKaanBEcRsS
         TzslSmPcYthvyK3RjADgT5ubMJcOvzh1TzLoXOCts/23JXBqw0NG5gskA9zeS/J6OgVW
         4LLYejsIzIp0UcHC/xmKfDKN5U4rYbgth66hujmP8o8zgdaH0PP1vMPgl56VFYaDQEjc
         t7Uo6TWzxRrCt7vRf5E2j+UlIGKaFSqEX1TIucmIyxFJpZjon70Rv1+C582Tk69khHn8
         xPBQ==
X-Gm-Message-State: AO0yUKVFzgRNoC4ONSiNpEpYfHM/MlfZW9I4TmYLfdZiza0Dl9q604fy
        jPZ2kQpKZEW5Mx80dnsBSwV+xBwHaZbQ1iwsFtA=
X-Google-Smtp-Source: AK7set9Y+JMjGaFtxzWoShhRkthFQPrAaMdbT3ot7tamjytIhQq/dtFjE6+kK/2bPR4B2q8hu91oLDcqLQsIcTCw6IM=
X-Received: by 2002:a05:620a:19a6:b0:73b:7f8c:5571 with SMTP id
 bm38-20020a05620a19a600b0073b7f8c5571mr2834955qkb.6.1677178902050; Thu, 23
 Feb 2023 11:01:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad4:5581:0:b0:571:f222:95cb with HTTP; Thu, 23 Feb 2023
 11:01:41 -0800 (PST)
Reply-To: lillymontes49@gmail.com
From:   lilly montes <georgeshelley488@gmail.com>
Date:   Thu, 23 Feb 2023 19:01:41 +0000
Message-ID: <CAHuCAmrO9JPwcE4z8FjK8=vzpQaMEc+ZCsg+ru6S6u3E967tFw@mail.gmail.com>
Subject: =?UTF-8?Q?HEAD_P=C3=84EVA?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:742 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4969]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [georgeshelley488[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [georgeshelley488[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lillymontes49[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eelmisel n=C3=A4dalal saadeti teile kiri ootusega, et saadate teile tagasi,
kuid minu =C3=BCllatuseks te ei vaevunud kunagi vastama
Lisateabe saamiseks vastake lahkesti v=C3=B5i v=C3=B5tke minuga =C3=BChendu=
st.

lugupidavalt teie
lilly montes..

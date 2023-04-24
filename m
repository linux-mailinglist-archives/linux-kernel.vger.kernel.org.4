Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848E26ED422
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjDXSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjDXSMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:12:30 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E8B4C23
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:12:29 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4409786dab8so1546954e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682359949; x=1684951949;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEdYnWu92iTKsdOky7RuvLMp4SJoRZDPrcAqoMC5U6I=;
        b=c66pOj9eX8hnEqqOa08HRW814ObWktM2UD+bigXi0K8HUwzLctRkUTBlRoi2ruhS3+
         dN4kL7LmFrndrETDQ8xQUfukSwUOKQF+NxeneIBsXrCGw//O7q90vRExTBwA+Skgbah/
         /tugN0ejJV4BhnUo13wK27Hr1L7Qlo9FAXoTqLXGaiTR74GvZXRibRArMtZw4ibQq3mt
         WJ939Qx0+JN4GGAUJ0j0mEjFZuqpEsVXKowgCENYadXeLhjf7Rw4WjpdjWm0ImXn7Rkh
         g8eTDJLJcSSkIBG0DjPfL7n/cxZ1UyDYWmN1a/Uh10WB0/yYzpgg7F8Pq4Z5sewPMxyM
         5yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682359949; x=1684951949;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEdYnWu92iTKsdOky7RuvLMp4SJoRZDPrcAqoMC5U6I=;
        b=hGJ/Qoby//o7TBWncghjQXM4vmuZAtFejhRoBoBMizHmjnVxb9uJBFvfS+nddLeTal
         WOBwdD7iro1Y3FDYczHAGLEO5g0/1Pxi+2ozhjaLIZ6oN5g0VlZcsoJi6cPsRd5N1Sjs
         cTf7bK1Brb5Opz9RVEzRDkuBHMhzRBw6BZsYgArXDAo5QGyFtSKjikrjNByyxuokpTYY
         U1NvMjLgTet0ugnd82WduOBgqbS8Jy1Osay5OU64YBw/tJ0GO62oaJ35wrGThbpb9nc4
         s+tfIXRtHjDyQS0T+S69qGU3lnogQKNcLD8h5VAqJ4scZ6/ia0bftRv4eknLGT1Zt+pM
         r34A==
X-Gm-Message-State: AAQBX9cYg1qHkCCan4oRjoRupuMFbnTj0l7A17eu2Sp2Ll3ykI0reOzR
        l/qTDjKoHyeOC81VdnGP17e+si1CysqbOEksnPQ=
X-Google-Smtp-Source: AKy350YpmTQ4HfWNyt44nYSgWeC6A6RltdQ6pD8dglMrV8Bt49cRAzHFptGsUL3k4/hFaa6rJ80aNGb3FTH8adpnlXQ=
X-Received: by 2002:a1f:da47:0:b0:439:bd5c:630 with SMTP id
 r68-20020a1fda47000000b00439bd5c0630mr3438609vkg.6.1682359948816; Mon, 24 Apr
 2023 11:12:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:abe:4a03:0:b0:365:446c:53fd with HTTP; Mon, 24 Apr 2023
 11:12:28 -0700 (PDT)
Reply-To: choipark90@yahoo.com
From:   Choi Park <ubacustormerscar@gmail.com>
Date:   Mon, 24 Apr 2023 19:12:28 +0100
Message-ID: <CAGMLrsX4CN3KdNf-aC=WRYbGAy59j23X2ig5JR6CXzaovg0oGQ@mail.gmail.com>
Subject: investment partners
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello my friend how are you doing with your daily activates I hope all
is well, well I got your contact as I am searching for a reliable
reputable person that can be trusted as my that client  Mrs Ma-Ri  Kim
from  Hong Kong   Directed  me to get her someone that she will trust
to invest part of her money outside Hong Kong   for her under aged
child  if you are interested let me know I hoping to hear from you
Mr Choi Park

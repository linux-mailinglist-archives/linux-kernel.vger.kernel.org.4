Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07B45B5184
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 00:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiIKWQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 18:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiIKWQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 18:16:12 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B21A3A6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:16:11 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3321c2a8d4cso80154737b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=eZgsSC8XzBlKIexQoq+wNofxMPl+dfYAVWGbexaRn60=;
        b=lsLdtayTj8ecp7t/uPvf5uFqvwOzd5fjKkzXSKFZ97VquwJnUvSRsJRn6s/jjwTq4Y
         LWeB6kM4XMfZ7tXaEAZE59T5Q+UlR4PVwd1GqL4Zaig5Pa+P0JvgmoT9LS6fdy4VRZIA
         JvMRhb6EMcRCvcjhPkijDV6E6KUinQ0LM815P7dbVSByNRnl2q1gUtPUcu1Vdt+j9/1A
         rMmH5Hy9O8SdwCyW5/gOZjcEdei71rJTovw6YyIX2+EuL06MzJoW/L4emHQIKeIg9Bbh
         VS6ghQmQI/YGmtZJuLyYb0Fc/mI1vvi6IPXkBUIl6OoAapm0qJHsEF7OMlzX3OO0T/m0
         uqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eZgsSC8XzBlKIexQoq+wNofxMPl+dfYAVWGbexaRn60=;
        b=1cOlGIO9cAfrNdjmWTr1p+dn5ASxUXBKpqvVfUBZcsQpdysK+hEwYmt2VXj+bmw8Tm
         +viGO/VFkvR0G+eGkPv6kAwP32x8hricnxLVS0I9dniBIhSLddlUm6Mio2Qb9uGLgx2O
         Bgf8M3lmAUeOvGw5mvWiOzAtLwJcxLaq1uiG/FZEesOiToo1gjIbmK7Ae9Z0RnguOVdo
         c5CFQwdfJEIWqS3p1eDT3NAMfSaDhLnjm6OERQ3QIeC93zImc0/PurpQHGFS5Y/Naur4
         4JUjM9O3avkdjYHpolV/0jpIHnxCryOy5ktNt2xzS6isE21c+tS/l/yJaaAFDzTGmM1Y
         CGog==
X-Gm-Message-State: ACgBeo3MbEAQ81C3HirGPdw5E4ptN3/ANp2+S+Dw0wc4tP/FH35buvsG
        yW+0zMC/gzihY8Ayts/Hz25BQyEJCNVTDuDyXGk=
X-Google-Smtp-Source: AA6agR4EKCEQ9pTk6fXip8A8M18BFbhEQc/i4uaQ3OiCZ7ETfTFg5WtQbdxs4uzwwGyPuNk1M8cn28yP+OX7jhBBHb0=
X-Received: by 2002:a81:156:0:b0:345:4493:6790 with SMTP id
 83-20020a810156000000b0034544936790mr19547738ywb.117.1662934571092; Sun, 11
 Sep 2022 15:16:11 -0700 (PDT)
MIME-Version: 1.0
Sender: aishanafiukaura@gmail.com
Received: by 2002:a05:7108:53ce:0:0:0:0 with HTTP; Sun, 11 Sep 2022 15:16:10
 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher01@gmail.com>
Date:   Sun, 11 Sep 2022 15:16:10 -0700
X-Google-Sender-Auth: G7Nx6Vkf8mY7GFlmHdzUko1IcgU
Message-ID: <CABET1+g+wuUhRAX=PLHZrnenrvW3bMRcfLp_gENgCTbWqh54_A@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Best Regard

Yours Faithfully,

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14246BACBE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjCOJ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjCOJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:55:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA0A82376
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:53:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d22so4212692pgw.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678874027;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yf06OZ7wRPY8MKmtaErAxCAJ30Q+ZppQW5ABseJw3Z4=;
        b=HtBHRC6vrQ5Vu+s96LHiLlLjxc5xxRTp5UrdteKLJmA1o8KdqSPsyEQF0xOmX8KF7f
         b5xnCJ0TCAaE/MyghruONCtWmCeb2Vy8+jLClRzJV0YDY8wKh0qcT/uLO8brv4R3MdoQ
         KdU9TH2e3qki0yo7H6bzYYk/UotFd+VlbBMfJ98qEUejYIKy9AZDPGIN+2hO5UAgAumc
         Umv/uCmC5qbrMx7RqU1sImRylKdc39nPZjcOMZFb0oYy3rIMgdoNGz9r5tvA5tXpr/0B
         QNR1FhFH3QvVPM2GLwPGl0E36f1miKL3FKW0hhSWtSd1xtspAG09vVT+1VuKNp782V73
         q2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678874027;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf06OZ7wRPY8MKmtaErAxCAJ30Q+ZppQW5ABseJw3Z4=;
        b=kqqzVs/rvEe8iw/Dz8F8QHrb+oKjMdbhA5trFSsYtYzvvFtWAw0u7NMbva/e40BpHN
         jAcvmtVJsIB0cL5JaC289jJHSEBjdXKF+RLzCvd5cw/vYub5VXQrBX1dDmLenKvhqh9I
         GN7UoL4ohiVdGtElydlWzvtCZtL6oht8dxuOX8cnc/fbszu50/Cce5lSksfFF2h2dIei
         cMj2rnoNv4M1qDyoRgm7f17Odpc72/35rVajjUIs0yUyO/+r3wjhnGhONhFTg2DY0SZs
         YZPXmaC7PJPqhrHf4MswUh9LL00AGXU0/bN1+3SqzMs5ARTvxqybH9pvqs2/7F0PF2jU
         KZJA==
X-Gm-Message-State: AO0yUKW961ksTKqe1Qk/2OGKCj6RQzZHKp8UHxz1rd9y647kp4FOax2t
        hSQbyoXAqVPrLId0eYJgz61dFMETG+pDXHn4i4w=
X-Google-Smtp-Source: AK7set+noPcg0fln9W2Idoc3QyKDYVrUaSvBuDG8K6jH3w3qJ4MhxvxZjxQ0KuCxvDp6WFmZoimBUTEgls9g4u09zUs=
X-Received: by 2002:a05:6a00:14d6:b0:5aa:310c:e65b with SMTP id
 w22-20020a056a0014d600b005aa310ce65bmr16611886pfu.2.1678874027555; Wed, 15
 Mar 2023 02:53:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:1294:b0:3bc:b806:4340 with HTTP; Wed, 15 Mar 2023
 02:53:47 -0700 (PDT)
Reply-To: fionahill.2023@outlook.com
From:   FIONA HILL <ibrahimangela820@gmail.com>
Date:   Wed, 15 Mar 2023 02:53:47 -0700
Message-ID: <CAJFyUJYt-i9_N-L0eXktyMUtCsK5BbwesMmN+ZweoW9yBdcw7w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:536 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9985]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ibrahimangela820[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibrahimangela820[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [fionahill.2023[at]outlook.com]
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
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello did you received my message i send to you?

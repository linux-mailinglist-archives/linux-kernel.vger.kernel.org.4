Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4C16B9854
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjCNOwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjCNOwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:52:33 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1C1A90AD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:52:33 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5418c2b8ef2so142374897b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678805552;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWxp10o6SutV8Ut2SPOyU50CO9t0iyh+TuUkX3vQXfA=;
        b=Li6nLQKTAlc5aF+NqmUBUjtgjnAw1yd4vs7d6cOJMeq9d+C3T/kZrSeKV7Go1Yf5Fh
         J0f01/FDmoeVsl/lpebygEOKHYLEQsw8fG7LkpVAD8esj/wPdehhcie5q1eoiuwuA8/o
         Pnbfa5/H/UKc2sabsgfjSbuqtoJavsoiAuWurKjfgiu3ytFBqlh+65RFU1qnF9acJvpU
         Q0WmTcymlYoxaIuUE07UwpX8isk5QWI1FH1IdDZJcXXdO4+oJdJOPXGKprfsJU8AzDE7
         mbXknixbWOdHWZacXxT7zq9YvG/JPiOxlFw0/V84Vo5+URVVxgZWkg4BS+C4MXntBOLu
         5VRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678805552;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWxp10o6SutV8Ut2SPOyU50CO9t0iyh+TuUkX3vQXfA=;
        b=YlDZwrm70QDqhmmeEEeXjyatIlB1haQjnL2L/HfMrVPhF5zyFkQjIX0kURB/R1ILsM
         3IQmqTOr4IZBc/Abw7lPymdHj6z8nYoMOejNhnxEFOUh1C8dcF2MAjKXm0TtfHiV8jOi
         DRlTB/id007BfREl//GiuiW9QMKdydhUIVcR5r0SbinI58QCvjfEWJltyaRYNSGmeh+B
         xJX691jJl4Ek2B4XVjwQeqUPFvuH46rpVLUJ7+BlJpTcnV3Zg/xR55g10ldw1GjI2On5
         EZzUHKMM1juYG3VK+1wgcLkKMQ+b3u9nheaWDnFs5NHPcl1VA7t7ZmqBnkP2sgqY2FGu
         mHrg==
X-Gm-Message-State: AO0yUKVZFrejBcli6Qh0tFlqMNwo5+u14pbnpSJTYClTo0eaQIuCpr9p
        jnSTqWfHmNYF6WYT2G+S+mxkWY6wKLQnxXTvoTI=
X-Google-Smtp-Source: AK7set8eyn8tNWi0Qg2gYHo8Qi7GB4wYqP4CGGwffWTvg4x+9/RAl+wV5PdXhxhlMlAS5W1CXUthU4bTXBR1sveZnK8=
X-Received: by 2002:a81:4005:0:b0:532:e887:2c23 with SMTP id
 l5-20020a814005000000b00532e8872c23mr26308544ywn.9.1678805552405; Tue, 14 Mar
 2023 07:52:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:ac20:b0:328:74ce:89d9 with HTTP; Tue, 14 Mar 2023
 07:52:31 -0700 (PDT)
Reply-To: americabnkcapitalloan@outlook.com
From:   Amadeo Giannini <vantry.wangedgewell@gmail.com>
Date:   Tue, 14 Mar 2023 15:52:31 +0100
Message-ID: <CALJR+mYxPgcWdexb+DVbki5Np4Js=rYe5uDDHSoD+MoxaYX3zg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112b listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8845]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [vantry.wangedgewell[at]gmail.com]
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

Are you in need of a loan? Contact us now! Amadeo Giannini.

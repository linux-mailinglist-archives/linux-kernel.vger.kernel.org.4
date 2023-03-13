Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A127F6B781C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCMM4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCMM4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:56:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B6565459
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:56:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so7782444wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678712177;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/X8j7tJ0Pv690VPyQSrbyEoRfhZESMezpxyxnwYuigU=;
        b=eSXdUuNswkQAWzK2dVgS3922Iq7VomG3LbI1FUCjmhUggxJ5Ocp5Ga/TH1BcJRLtlo
         G4ZPm/uGfEll3P8ciEZ82rg1od4drSt8h+gm482K2MGQmEBjXkCYJ/PLNmABCzs7cNNe
         9Y2kqvPW33ibmdSfLCpW+GlY7vcwjFvglaQOb1Sjy0aXDSZrrDxEWg+mT6l3xAtTC/E4
         hikDEYNKjLL13Ba7HdoG8Vf5xwNDUE18D8el8GQNTDIgbo6JC3MuLlP57bLaKtBHRrvq
         Fod2S+qRKpU9GIHtuCturg2P7Cc9DW8upQ15ZUXLDEJIFKoO2bHyyQQ3hbgXv2g81JHC
         AooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712177;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/X8j7tJ0Pv690VPyQSrbyEoRfhZESMezpxyxnwYuigU=;
        b=7J62Y/Xg3olu/+VRFNHNEU9TVbQLuUPSEaJxn7qfBqM8jiBbdsK+kPYTqwQPHfw5md
         817XzS6CSGPzpHt0u2QQz00Q1MnFwsFQiGjtch2DQMDpP1I9fZ+kreUD5FUV8nZifE+R
         FtMcflV6U17jNKrbxMcJ3bO9A7wLeCvB1jXa4mb/cWuiT5AGiILOpFWI9BabfAgHD6Fq
         DekgrTm0OExL4Qx/voAXW/Ja3zhWugBOccTGaKzRnllqSO+TmswWhUYNOLSpKrlCejVP
         dWK3iFnGPSoB/A3cHKanZ898mb6bO/8KKvxULjoP2Dnp1KsT65E991IlY3C6a67sc4Ii
         279A==
X-Gm-Message-State: AO0yUKU/vg5R0+OGE27qsiXIE/kqDdyG0pg/RPnvAPD5gUhu2KHWc8dx
        TGuFEDDQkGgvKIma1KZYTWz3d9QrW5LRIEaN9U0=
X-Google-Smtp-Source: AK7set/tHfSNlpb8WV26T5Kvn6VqZISAxWcDH3XwDoQe4PqD4XHWIckLgquCPC7XpYEViyxVVboet8MzXf+ToEHg85U=
X-Received: by 2002:a05:600c:a3a2:b0:3ed:1f9f:41d5 with SMTP id
 hn34-20020a05600ca3a200b003ed1f9f41d5mr1434950wmb.0.1678712177086; Mon, 13
 Mar 2023 05:56:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:e151:b0:261:c9ae:2faf with HTTP; Mon, 13 Mar 2023
 05:56:16 -0700 (PDT)
Reply-To: lschantal86@gmail.com
From:   "L.S Chantal" <r71549532@gmail.com>
Date:   Mon, 13 Mar 2023 12:56:16 +0000
Message-ID: <CAOzyb2-9H7eaymaJ1icxFriAnp4Nn8xtHNGAyjcsORmu=uNBRw@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:341 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9939]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [r71549532[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [r71549532[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lschantal86[at]gmail.com]
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

Hello dear, how are you?


You are compensated for the amount of =E2=82=AC5.1 million in this.
Payment will be issued on the atm visa card and sent.
To you from Santander Bank We need your address and address.
whatsapp number



thank you

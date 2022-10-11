Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7F5FBA20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJKSHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJKSHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:07:38 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D55B2D75E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:07:35 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-360871745b0so74722637b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7nMl+IIoVXIZCC/DKHT3CXI2Xf2HP4geGz0+dJZi9s=;
        b=FG0qA4ikAjxVKa3sHpnmD3r0ovEhAB/bTmLX8VaAqEoTpZLQ8gI6+KCa2X7rXzcUx3
         rJST5MEvmq0VI70J8hjHeW0BnsDmXHjn1DU19Jfy8L1wC2sLYsljtxyV47EilRh2TLtC
         9cB+K0rCTEfq02tPXJzGGRr2QF9LJd3mCke8WtuRcb9fZqpXu9hc5PKyEH03JR7y3FCa
         fR9MC0LDUvDah73tE2PvE3mCpnHEUVEXCgJH/S+cEMd13lcLv9SWquKndDYNyeOjDrAV
         6YYxGSJpZ+hIfCaCTY2Nyncsf03owIdhplfLFZJjPMseBggOY0NJfZkPV3LWUppYNKkJ
         0fRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7nMl+IIoVXIZCC/DKHT3CXI2Xf2HP4geGz0+dJZi9s=;
        b=P0apyP3Z53UCOsfLKEOuC4moXHID+bIj+gDrCsKfK5l7cMNDmJRLWYzN9F/aBCQ2Gj
         uDAu85nkMM7O5EYSsk7S+2le43SzZftaD1pjvt8EeW+NULVLvAvOTfRwZVgtM4ppRkgO
         MWCRQKseITheEYVS1DFt4UQacDCIMvWKBSNftsTv3jwSbhCfVaYDzdS616zIIeOCRB/Y
         4WPC1rbsp+9rO8+o5morcqpdgwDD3LBfsEsn8b9twti0017+5esZw04pVn5MZtWspmgP
         UxS+4IsPooxZ5vjQaEStmdmKyVjg0q+tqSx+WEXIwL3oN+vII4K86W1wOMI4lFT6H707
         BS/A==
X-Gm-Message-State: ACrzQf1FpxpbwP5i9JCKG7Tiltai/mgITYyAb3TaIaXeRXkQEsWerGBW
        J6RzwV9b3RMcpN7XRNdgy+jIpqGH8L5u9QnK014=
X-Google-Smtp-Source: AMsMyM6OCvagOVxxxTEsfErq9xBhIJJgtNqp5+7CYXRzAiyXlU45PahqHzXqTx5VO8MUR+9wqIhH0LJTIZYEhX9SSJw=
X-Received: by 2002:a81:6907:0:b0:34a:51ce:3b38 with SMTP id
 e7-20020a816907000000b0034a51ce3b38mr23284332ywc.151.1665511654327; Tue, 11
 Oct 2022 11:07:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:1749:b0:3c5:f473:56e4 with HTTP; Tue, 11 Oct 2022
 11:07:33 -0700 (PDT)
Reply-To: illuminatiinitiationcenter56@gmail.com
From:   Garry Lee <johnalinda8@gmail.com>
Date:   Tue, 11 Oct 2022 21:07:33 +0300
Message-ID: <CA+Dt0k_wprVPDRPoDepuruBYd2vtSZ60hGqdrTRy=NsRMSYouA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        UNDISC_FREEM,UPPERCASE_75_100 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [illuminatiinitiationcenter56[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [johnalinda8[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [johnalinda8[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
DO YOU WANT TO BE RICH AND FAMOUS? JOIN THE GREAT ILLUMINATI ORDER OF
RICHES, POWER/FAME  NOW AND ACHIEVE ALL YOUR DREAMS? IF YES EMAIL US :
MAIL: illuminatiinitiationcenter56@gmail.com
YOUR FULL NAME:
PHONE NUMBER :
COUNTRY :
GENDER:

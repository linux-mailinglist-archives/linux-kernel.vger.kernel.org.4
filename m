Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523B673F9B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjF0KMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjF0KLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:11:37 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD6BDD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:11:09 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id ada2fe7eead31-440b4b0147bso849735137.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687860668; x=1690452668;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MFG1KNlvf1Axxy9iiCRuF2Wv9mzsHvQM12J2RA1vN6Q=;
        b=mLUKvwxGcWfZMjMQwm7TqFPmn4dTfkxsu1j2mSiWB81cbuaOlOoc2CM/JDB1UWA8k4
         zGi9lIKF6/mbRapKguDvw+R6JkR784eBEJeE28s99SgiU1KOmb8e0mJpLb5tCmaa783M
         zWhnU/VWEESvL3FbwM2OT1inLF3GOGxu24U2KtOIlgLnlNS+s8KdwMvaRBDUJDu+8ARJ
         sTzgCcgTN32pD7ChV7gV6Aex6K7AMrUtezpax9ioPqo7+cbvTiUS2+rjp2W3GUE8eowC
         jPSt0/3Fpg1E0DNQwZQdJGU9wFh8J8UraOLgnoZg2NW5itxF8FYU1KJ9uQXYgPqLHKAW
         bJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687860668; x=1690452668;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFG1KNlvf1Axxy9iiCRuF2Wv9mzsHvQM12J2RA1vN6Q=;
        b=i4Euqxwbpw4UEWb5hwAN36GjgBChQ2k4XnZKB2fRDMTlNsphOeEHNr3afop1JqWgHf
         AJCZfumJHn5v1ViOOs5jtjrZbI7XYdsLT1IWdpNReOZwiCJSOjDFrdA42t5K9aD4A0rm
         fh7dFZszxpIWrCVKAVDCL0tAHvYmG6M3kWQG3GsCApY3GXtUddxgOoTgn98oONn0h6Ag
         iHk3zPR9VwQI1/H8BoFNvMc6SFut/pokBLeu1GHBHaloGbLcI6ih8YzaMwWqDZTGNtr2
         sEjsz/KCpJEf9fBaJISPnLx05ChfLeutProsfn+xyTtmSjE5IgCsNRQDXU7mPMAp3sDw
         /ZYQ==
X-Gm-Message-State: AC+VfDyZwwBqeVAcprWno2ZkeAiC9PLkCAo9wQ3m0GAs6sY/AYZiSjLp
        Nv2MYRexbcTx26Ie6rDTLKmAgqprHox7zve3lcQ=
X-Google-Smtp-Source: ACHHUZ7jYkWfN09AJ+nA8kQv00YmErzl/11qjBBEHQl33pEg29DOolCxhRr+0yHGYyjLVFEwCairxE9HtQ+hXFV7EHU=
X-Received: by 2002:a67:fc41:0:b0:443:682e:2088 with SMTP id
 p1-20020a67fc41000000b00443682e2088mr1566797vsq.12.1687860668227; Tue, 27 Jun
 2023 03:11:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9a02:0:b0:62d:f4ab:a2b2 with HTTP; Tue, 27 Jun 2023
 03:11:07 -0700 (PDT)
Reply-To: lschantal86@gmail.com
From:   "L.S Chantal" <ezekielcynthia8@gmail.com>
Date:   Tue, 27 Jun 2023 10:11:07 +0000
Message-ID: <CAHE9hdkB6q+hy=P+Nbv7x1BYCBZeCdYRHv0CfAm+eSzuNVOnZw@mail.gmail.com>
Subject: Holle
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,HK_SCAM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e42 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lschantal86[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ezekielcynthia8[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ezekielcynthia8[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.0 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SANTANDER BANK COMPENSATION UNIT, IN AFFILIATION WITH THE UNITED NATION.
Your compensation fund of =E2=82=AC5.1 million is ready for payment
contact me for more details.

Thanks

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CADA660F50
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjAGOGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjAGOGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:06:41 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0CA272A
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 06:06:40 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h26so4464962qtu.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 06:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYW0KpUefNbsb+TIFKxeaN6DvLsZYHJVc8Ee1/aXPzM=;
        b=bQGXeIZW5oR0Xgm9INOjEISApHRJhKuQMZxH0BMSBJDIHro/NvuShx/iK5xBt/qULl
         PPUFLBPBaqDch6IDcq1cj+nJaITeKkDPEUnFgjaonrCr3dJWzVJX4lo9S+I8rJx5fFUQ
         n+xdSMgaKQBl7COeyNfCFRMv5OMQ+yjGwOg7jMgAGtKOjm51OC7/ti1lSpdqzbiRw2Vc
         oTFQsufVmzxprv5l+3qoptQ30tEmmn/V0VwqJS9vPp5l6jHzcR35SDp1RVO33R0VaM/V
         uwnpHFzepOffvsG7IBjq5Cd7yuN+8DUZ6HCMSyvfXujIDbYlPmNO7qtwI6YpOPlzzrxB
         BlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYW0KpUefNbsb+TIFKxeaN6DvLsZYHJVc8Ee1/aXPzM=;
        b=Io90wbUHrhJGqpPEqOuLC+b9NQ3fLZgaxbotGcWxnpAf27JGyHX41qJYcMX0QBqlwl
         KvJyfj4E/MuecQBF4WSRhdY6B9HDHyB0Kd5iPZEPgHFdo3ddnDRP89hjscns7upuuSPl
         Q1vv+YWwSIM3WCkhXBzqP+2e4u6nuLZQUPaKjXRSDjyPjJP3cQaayTTeL7qWK65eZ2OF
         j2Cmxe+GShnCSNtzg2Y0PXtJp731xZA6oChFOXMr8xlLHpxuJ8t4QiDjfvspmIG7CQgo
         HNGTNhWUFTB5iMTJg4VR6ZR58nwpnxdMzIRuZdI6lLSBAZQceJxP1K/KRN/9OPhkJz1x
         NGBg==
X-Gm-Message-State: AFqh2kqo+2HZYHP5FnK43zoX21Cuopx5MW6LR5dUPWscjrEItYZ1wzRM
        k2agE5L/UHZcQ+92lXJLUVCTywWMBBYzoiOaw4M=
X-Google-Smtp-Source: AMrXdXv7H+7RQ/kfMW0F60dp6T4yZtERE2LOpL1afbncXT1mXXxoYmRUWCy5slNrTyHVRV7H4O+sSVTFXkfFGo8GNdM=
X-Received: by 2002:ac8:708e:0:b0:3a7:ed31:a60c with SMTP id
 y14-20020ac8708e000000b003a7ed31a60cmr2389463qto.636.1673100399447; Sat, 07
 Jan 2023 06:06:39 -0800 (PST)
MIME-Version: 1.0
Sender: umorsalif@gmail.com
Received: by 2002:a05:620a:25cb:0:0:0:0 with HTTP; Sat, 7 Jan 2023 06:06:38
 -0800 (PST)
From:   Ousman Omar <mromarousman@gmail.com>
Date:   Sat, 7 Jan 2023 06:06:38 -0800
X-Google-Sender-Auth: LnFvcpvnGV0orXJrLlQTSaSmssc
Message-ID: <CAEnUKdTeGuMcN3UqEywvOThNqW+PHrJ1fw8kRx_aNtXVTFABrQ@mail.gmail.com>
Subject: If you are interested--___,!!!;-
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_USD,MONEY_FORM_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm Mr. Omar a regional managing director (CORIS BANK INTERNATIONAL)
Ouagadougou Burkina Faso, in my department we have US$ 9.5 million
united state dollars, to transfer into your account as a dormant
fund,If you are interested to use this fund to help the orphans around
the world contact me with my email address (mromarousman@gmail.com)
and your personal information's below..

Your Full names.
Your Country of origin.
Your Occupation.
Your Mobile Number.

My Regards.

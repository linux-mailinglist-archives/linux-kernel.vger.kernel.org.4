Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E0B6F30D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjEAMYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjEAMYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:24:06 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AB01BB
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:24:04 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-5f3da4f91a0so11328446d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682943843; x=1685535843;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+IMQyG08SdQLNbyRHdHEj2dhFYoHP3MS5X9DSwFtrnk=;
        b=krSJBXJUhf5SWfhB4vJbJuaOV6mQ2xffj2gv26YaIi3Rt5OHUGhBv5UfgE7IQG4+rX
         t3WqIOy2MREcWvCW772kfU/UmWgT/TPzGiN4fzYZ6B9GbFS12lCuu2lMqhlHbfli5TlB
         vUCrSgrPhN88uIYznEi1n83QchYeJyDQLpxCPcVBFI+6oNKb/5w0ebhgIuelPSHKp60E
         Jx7EF88oePkzoyTvw9//bAjHZiBJ6PkNK17ktr1Mm5rozDZQpGrELfgHpIwpPcHC4ijG
         DhxFegh9uCarDnqXTUHoZNH0g7o2n/b1TRAF0w0nNNblPh1pHdxJ9yXgf25n/Dtn2gcr
         XAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682943843; x=1685535843;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IMQyG08SdQLNbyRHdHEj2dhFYoHP3MS5X9DSwFtrnk=;
        b=e6N1i5CxrxW6z1e22yv2+v35hycNw25oOjylrvipoSK6gGDwUy9GOs1zRfjX0WzCYU
         re4OeVx5Zw0Dbz9vphkyQdUg8nIa5ZZY/SHfiTgcxVJvSHbRYDHzQTAqCXsSF8831J34
         Fo4WTWaiQwkl+LYv7oKWVBa2UB2W2q2kDEYzZPuDCK0WSzLGtCSbgpGLCKtcflkihpdR
         I4GOKvE1gII4mzKQdQ7MN4IBXDleQoeyvgeoA+faJqZ6Nnkdw+r4s7hCX1BKrMcSga0r
         WMez+WKe9tEFJM3QYwCxlZrPMyrXe7gRvMyEMvY0OzxeHh+6V4/D7FjoRXA5Q8AdEAZU
         PBJQ==
X-Gm-Message-State: AC+VfDzgPGEwjeCn8afbsD7Eooii2CAvgGeImgrP9PT3st44J5JaxBv0
        aeYszcyZiAnrk8T4lZnop4yxVl5oFcvQf7a1Tdk=
X-Google-Smtp-Source: ACHHUZ7/sYnGTAYpgVOlH8ccCGOOKWCBLY7BZszFG2+7kg2kQuZl7hW7kbn3jym7b+yuk1KMGAsEwSaP01oYsorq7nI=
X-Received: by 2002:a05:6214:3011:b0:5f9:ba55:395f with SMTP id
 ke17-20020a056214301100b005f9ba55395fmr17891252qvb.52.1682943843506; Mon, 01
 May 2023 05:24:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa56:0:b0:5ef:5e02:42fb with HTTP; Mon, 1 May 2023
 05:24:02 -0700 (PDT)
From:   "Moha;ed Faye Lamine" <m.fayechambersl@gmail.com>
Date:   Mon, 1 May 2023 12:24:02 +0000
Message-ID: <CAAZjU91x0MCXvL8AbcnfzLVQ424Yv8bWm_CyWGpsTfAmyZrRVg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f33 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [m.fayechambersl[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Director


  I am Moyamba Susan looking forward to
investing in a lucrative business
  venture in your country.

  Meanwhile, i need to be sure you can
offer the assistance i need as a
  business partner.I would like you to
transfer US$6.5 million on my behalf
  which is deposited by my late father
.

  please can you help , to have this
fund transferred to your country and
  we will fly to join you after the
transfer of the money?.I will give you
  the 20% of the total fund for your
assistance investment.

  Please reply to susanmoyamba1@yahoo.com
to assure me of your partnership
  otherwise ignore.

  You will receive specifications and
details when i receive your response.


  Best regards,

  Moyamba Susan

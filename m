Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5556B80D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjCMSfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCMSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:34:41 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681DB8737A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:32:53 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id x14so11853856vso.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678732348;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gK68d71BdAuxvyUvoGgRfRqMNS5Snq3vUvWzE6JJ78U=;
        b=NouBiGMrk0eotnhDhu5zgb6PRXUMNBWr+m7MtVGpbxPzEGExQaECwfPTbWSujo1ag/
         jVfqWdGq3q23mj6nqVkcu5yqY9GUsVSJ/km/dNczupHIjXaGtVVmyi5oTT6OUBTUNFmz
         B9GaM7bH8AI4tSld/CKsh7B+o2sXpcIBizxsfQw6oTNAUTM2NtDD6wdvPbQhMiOSI5pp
         /Y7a6NAgKkCxPIi5Id8EtgnGvN2QEN/kaVlO8ummlm+9jfdidb+CGB3IifZK+1i9x/IR
         L2VewHy5so+QzAtjLdsPoBjOV1WsmSDkxfWdZ0A/RPEABV0NGpc/4q26xHTxCiCdU6WN
         ssAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678732348;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gK68d71BdAuxvyUvoGgRfRqMNS5Snq3vUvWzE6JJ78U=;
        b=B9XxkMswcQkzNGwnILc9Di0N2zqiz/M1PRmn3sGi6LcvmtqyoAcX0hKQnNFEVCgsH/
         4AWLI5K/RFbbG6kVXzVmGWnXB3Nf9Ki02ssRjGbgLrXoGwUoLvVzCTKC/KgOlCzVN/s3
         N5UfT+4fsMdETUUYl3P5JKQGgxF00Rn6uThllzWsmy4JrvyiPicWhtEKhgE8+ih4eX5z
         ywnQimoVRTcvH/7am5o8mNqaNTxTHwknm/vi5OeLxL+atvQAek0HnIgb35bfYo8wH1xb
         ezhOLEHI7pQRVPWYHfvCjlLZcSL9KXjFTzXP6b9CCfACAtnC9RLertdLqJMX3Ka4f3IL
         wQ7w==
X-Gm-Message-State: AO0yUKUeh6ch3JVjWUH9YuB5Ov26p/D3uzvPJPpwlc/2IoIIcz1toabU
        iMsvo8JKzHbvG8J7nnuFzYD6P/t9qv0aJsJ3jxk=
X-Google-Smtp-Source: AK7set/VkPji6U19UgDaeNL7MB1/wtMTmIeyHoSSyi8sxyUkpz40vrh9glTUfCbe/ZDDweNHXOy1xWh0W3pENrp+F3U=
X-Received: by 2002:a05:6102:304f:b0:421:c4a3:b607 with SMTP id
 w15-20020a056102304f00b00421c4a3b607mr8408101vsa.3.1678732348434; Mon, 13 Mar
 2023 11:32:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:a5e1:0:b0:3ad:f687:ace5 with HTTP; Mon, 13 Mar 2023
 11:32:28 -0700 (PDT)
From:   wisdom raymond <wisdomraymond0667@gmail.com>
Date:   Mon, 13 Mar 2023 18:32:28 +0000
Message-ID: <CAM1J=0u+Xh=LN_ohcO8A4k=kTrXv9G_Y-__f7pfk5_gxLNQyOQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,HK_SCAM,LOTS_OF_MONEY,LOTTO_DEPT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e29 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9492]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [wisdomraymond0667[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [wisdomraymond0667[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.0 HK_SCAM No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 LOTTO_DEPT Claims Department
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SANTANDER BANK COMPENSATION UNIT, IN AFFILIATION WITH THE UNITED
NATION: Your compensation fund of 5.2million euro. is ready for
payment. contact me for more details.     ( david.harden.chantal09@gmail.com )

thanks

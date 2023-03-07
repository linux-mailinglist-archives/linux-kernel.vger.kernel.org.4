Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CFD6AF832
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCGWFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCGWFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:05:45 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4848AA718
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:05:42 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id p12so5020276qki.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 14:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678226742;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=NSH/S7X1yuGRTUYyS9x0kN7yD0PhmysjGYw/zKQjH64I+z06icDV4bPy4CRmRwmcGI
         CAKTBE3eGnE+whYNULEMjkxabDk/A5pOi9/ExVqr9eY6kvp5456EaSsVDdmwQKx2gSrL
         +ohUWb0NCHkpjXss6mw2wgcKNZQ0m5iPLdJ8PgTtrGdCv7mJVnS00ALX3Dml9uwVUVL+
         zId9v3yadhUYloznoAjvouk2+R2h3UjiXPvuXwq6dXMAnICB7GmKJqORNmEljEur34L7
         McCysLGnwSdh/+Ju7YDnIRPzHsWcDBnY2ji0N1EBrvU8gBeHpGJrIogemcMORbC+YedX
         05tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678226742;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=NLXV12UHfnMvR6vihAVQ/AXV363LVHXkeDfXJ+grvaF2k0bZsH49C98EK8Bwz7Yhw3
         k+qgMMxxf/9J32aD29VGOwtygny7i6+4Cd9j3SigobtGUumaa4EPdWRDKar2k0/umTp6
         11r45dE/9ynWg0+b24GI7U848WsAMz+GpJ3Q86v5o7K4xkqQpLIUtwKbuEnwEksBomWl
         lJ1FVgfkVqY6b1AQgh6fI5Nk5dUgWgV0mx2H4jP6TPQCk+iD6y3aTeDVXISVdfwzcHiE
         LM73JFd8rJ0r/qvSbgoFJjqZuSraUiDKLdNrpWs8WzQYlNTSigns7xEZ4sm5eNXxKo5E
         INrA==
X-Gm-Message-State: AO0yUKW0TpH4MG6OKkeamKtenv+P9pSLp84lA4b5I/XBjHtISKIynjh0
        UmPjplVX1kjiftjYoEKRaLzyFJdlYvN4vfqQHp4=
X-Google-Smtp-Source: AK7set+j76BKwAhYCld5S5MNdP+vOk7iA9+lLcFlFirqR6TOW3ZsB9jvv3wOVOO+Q2B5A3kT2eDIZaZj2yIJOGNEdOM=
X-Received: by 2002:ae9:ea1a:0:b0:742:6fd1:3344 with SMTP id
 f26-20020ae9ea1a000000b007426fd13344mr4642627qkg.12.1678226741839; Tue, 07
 Mar 2023 14:05:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:cc53:0:b0:4d3:1813:ec6d with HTTP; Tue, 7 Mar 2023
 14:05:41 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <mrs.gabriellakennedy09@gmail.com>
Date:   Tue, 7 Mar 2023 23:05:41 +0100
Message-ID: <CAOBm9TZg8myipQPMWshUYRnN-ye4huPS+90H_ejQmpPACGdzVQ@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:735 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrs.gabriellakennedy09[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.gabriellakennedy09[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [avamedicinemed3[at]gmail.com]
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

-- 
Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.
I have Dual citizenship which is English and French.
I will share pictures and more details about me as soon as i get
a response from you
Thanks
Ava

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1716D0055
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjC3J5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjC3J5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:57:22 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D52681
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:57:20 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id r14so8060272oiw.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680170240;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4Oatc22JtM+BUIo6e3BXQa+qIqHhhXX2E3hXuu3jy0=;
        b=MEIRUDSeSjsJ/ubDYsAUNK0KzimC9z9adja8vOF/p1LCpI0ung7zn/59XCdiAefKi0
         rbdjjF2WMgQxgVQdeml7QOpR6PhHb+IvoKzitL30HfQEMow9CzrFI/1e4/u2jzUjqLGI
         GJ6Rdyk8wRtzCjbp7xwYrKzNQsOdKQ4NeGcyeSGNTPdmY7AlrrWPNvAjPM5cP5ipf+bz
         zhwyMzFuyhy9RxtqePjMtTt9z5ICqlGc4x8IrSeAUebrpE2M2XCja9ohWTaq7jN7mZf/
         bN290Ojg2RS4zDK1CzCio0OKG484QUVo5EmHtyC7FndYb0Nrh5jO5zOx512tqhaFo0Fz
         uJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680170240;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4Oatc22JtM+BUIo6e3BXQa+qIqHhhXX2E3hXuu3jy0=;
        b=kDCjAOjEJkUznwv3HBKs/Lph6l4IQa3MWCdKE8wLK7hZh6U9SJkuKJ4quF8c1bM1ZO
         pYuM0B7pHRVVafRgGOhY/dVbaW+TGYWFJm5prfcWfqgj1Jl1Qs77qVuYQM3sql/kktF+
         HvWVL2cy5Sk4Tzgc+KXB0ZbDDYYV5x9mo+hpb665CqXL2Xra4PXfSiDugGuW9qo5ypDR
         4OHV9uv41XJX8uKqtt9srt3QfdEYLinM/wb/KFpQ+fbNr9eXV4YEwGr09JyLM6yXgR5M
         Wwzd5QcskHdOw3YHxzvfkGGUvfwdS4np6gtevU/CPyoLluuUI/NJ6WqO/OJ3LT2Y2N+5
         tvDg==
X-Gm-Message-State: AO0yUKWiXrf/F7UlTGO9STTZiZesfvhfQ88d30spGAyJBeqdgkul9UIg
        G5f8HNC3NSozvFVJU+4xLpGnTeYBGHIagyM86aE=
X-Google-Smtp-Source: AK7set9fd3/b4YgdH7gqUa4rLLW+uB3iN9Z0Dt+EXxCjKRxuFKM+/lgXuT4zgllZzIxrJo+mDH5RzQydj3BdH2KlwmA=
X-Received: by 2002:aca:3cc6:0:b0:386:e33f:84f2 with SMTP id
 j189-20020aca3cc6000000b00386e33f84f2mr6081414oia.1.1680170239678; Thu, 30
 Mar 2023 02:57:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6870:a549:b0:17e:e69:91e9 with HTTP; Thu, 30 Mar 2023
 02:57:19 -0700 (PDT)
Reply-To: justinekevin013@gmail.com
From:   justine <warrene.buffett022@gmail.com>
Date:   Thu, 30 Mar 2023 09:57:19 +0000
Message-ID: <CAKPpSizvxQ9KrS8g6a=xk0xRM9jVBeg5BXiER2SOmLGfDH_RPQ@mail.gmail.com>
Subject: Good day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:233 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [warrene.buffett022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [warrene.buffett022[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [justinekevin013[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.9 URG_BIZ Contains urgent matter
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 I have very important information for you, but due to the sensitivity
and importance of the information, I want to make sure I am
communicating with the correct person owner of this email address. I
await your urgent response and thank you for your understanding.
Email: justinekevin013@gmail.com

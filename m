Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C076990B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBPKJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBPKJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:09:33 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3683E616
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:09:31 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id ct17so1098322pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3BgJ9YnLOtro5qrAnHroTnQbB+rS3iDxL2X2KHZzO+g=;
        b=XpVToGJ4oo35ISQ1Gkf0XvYJ3zSIced0PfMDTIKkGUv+wH9HLpBa99QgVP8Rqd71Fg
         y5B0xx1xCqT/vihkwtzF03p3fUJ/Xkk1yOxRN/lrXEEZyEnFP+5w3RvuMNvIMKrI7ls5
         qIVVpljvNsyPcUYRHZQRrfZDW2TnmVOYZpX0ly4yTEyH0O7m0C0wKrL8s6IhUqehO9uJ
         xKE8U0Jg3dOr+p5vQZ9b6AkquQ/Yo/2QxUUKXpQbBcsnW//qJiTdjvGCl/S61WPzZnEM
         Zf3iI3Qddxrw1CtRqEbyymNgaxsjnL77MTdfAKKd3zCa9nA31htZdHBNrBi8SukirRiu
         fBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BgJ9YnLOtro5qrAnHroTnQbB+rS3iDxL2X2KHZzO+g=;
        b=jk8uCgOl/v4ert6diDC8DZwUJhVBiAtrofBp/lqorwN73AQ2l//ifQtVaaUgZkTxqp
         Q6vEVPU56U0JMWFGqiGJGgWygsTNJnFKqlrkyaq7L/69JsCS3R7p6IkXIPSDxZxu1AZz
         gFnV7sBMB9tGnVC1pzYsJAZ/02NWDSTZ5LevzmnZiw8rfXUt7vMK/Qp2+qTUnjT9UmRN
         N9cfdJnk07Wn405n0oi0Kx99KU9Zr8oX5kzxIs8Ys2OBTWD+jZc2oBsetIglLonARVmV
         I0vSyglw7JoHyg1jlnqHRFj6NppPnPj7ipDsXjARHFAqKrlD8Sw3Hlgxb3G/1ZoGCPkj
         ldCQ==
X-Gm-Message-State: AO0yUKUeWsHgTSoHg7C10DY033rj72oayRqHutPnadsbzbSrmXBJJuQU
        dH3/KSDPvvZ+HsNPSai5SH5u6IhPwL5A8T2xrV4=
X-Google-Smtp-Source: AK7set8GQ8Bw/aTJFq8RaJH7pyhHHf89PX6rFy0Qfqkr3Vc4R2pItW/AFFfecF1r91mAqIDrJBgWB2mV3pCLoNjSBnc=
X-Received: by 2002:a62:84d3:0:b0:5a8:6730:306d with SMTP id
 k202-20020a6284d3000000b005a86730306dmr918050pfd.31.1676542170177; Thu, 16
 Feb 2023 02:09:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7300:bc8b:b0:99:84ec:f633 with HTTP; Thu, 16 Feb 2023
 02:09:29 -0800 (PST)
From:   Zahiri Keen <zahirizahirikeen002@gmail.com>
Date:   Thu, 16 Feb 2023 10:09:29 +0000
Message-ID: <CAPWzGoUg+O3SfNjePR89Bpwc6zXP8YbDm7hm=jOk1oN=XX3q2Q@mail.gmail.com>
Subject: VERY VERY URGENT.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    I know this email might come to you as a surprise because is
coming from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri

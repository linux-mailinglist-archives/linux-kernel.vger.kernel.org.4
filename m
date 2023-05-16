Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21D67048ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjEPJSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjEPJS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:18:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34FD5FE2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:18:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so24346630a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684228677; x=1686820677;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1/mYDthqIZEuEOLDfdiZBvh92qN4dXiUcAlu4QRTyt8=;
        b=FUXD/7D4bUHD5qcq6oGkOeW11ZFVffyZ7/5vuo9bkvPPDA62cOeivYDCAgYOjuvKCM
         nSa1W1qPuptcpS+ulOSrg3y8T3jWlxp5pwkaYlQzvbs2loHUuVFo1M/NLF/FmN8m59Ym
         X5oUdlZjjnHbF7swOHWTFJBzqpULGKVIzkhJ4Cj28R9e5T32UQSGL6PkyYM5dDPku3oS
         mEldbqrHcr9YuGgZAW91KXVx+Ub6YmoiR7h+9PJPzKV9QqL3SJbbnLNpJR0+1oK+UKlH
         NmHisxPYOSWs6Zn5rq0q/qz5iK4DTQyU1xup84W7ieL6SYzY3/VXNj0tSOEILkJ7lXFp
         KwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228677; x=1686820677;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/mYDthqIZEuEOLDfdiZBvh92qN4dXiUcAlu4QRTyt8=;
        b=ebtwzGpB84wiOrXJklUJ36CTbTykMbhbL88zji1FQy7YL0zXGFTPeekir0p4EGvGVY
         v3Qy5VGePtQmVVN5VtFyJnQPdr7GeMpIUdGfW7wj8Uo9qBfKWTcvJFSmYX6nfdha8rZW
         CA2FZCp3GUODDpRyEGk4aTdJaEbXa47kNI+U0+KNz+60ldn2EBBjG7s1prUIr8o6+DIa
         a+M+6sWyYSPMbQjbWSU8TQXMo8p3Sr2hijLFkpGI5IxT414adacnUBmFAtqrQ9AfBpFI
         YFArhMGSCJGT9F2tFsmRhxiHf5X5qq+lITsf89YvT7uMH0xyJoeFlPSUiVPxegTcjxNG
         d1Vg==
X-Gm-Message-State: AC+VfDzao31fsnM6MEPDsHUM4VW3kbtpGlLP1SEiUh/rZa4+mf9mgTMI
        +96NBx6oGRMVAexKpXNZBtj6mKhyTvUT3kIcVdQ=
X-Google-Smtp-Source: ACHHUZ7RRLuVNVmfRRFBgLRpObj5bDFoMtWk1tAKaASyaLGUBFfPEs0hbHYm+NQKK4RGmLItNDhQBxG5dTnpvdUDVLA=
X-Received: by 2002:aa7:cfda:0:b0:50b:caae:784 with SMTP id
 r26-20020aa7cfda000000b0050bcaae0784mr27958675edy.20.1684228676085; Tue, 16
 May 2023 02:17:56 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: abusalim078@gmail.com
Received: by 2002:a05:6402:1a39:b0:50b:fb8a:7b0 with HTTP; Tue, 16 May 2023
 02:17:55 -0700 (PDT)
From:   Zahiri Keen <zahirikeen789@gmail.com>
Date:   Tue, 16 May 2023 09:17:55 +0000
X-Google-Sender-Auth: MPZ1cts3o1PVr8Vwh37Zx-56cJA
Message-ID: <CAH0O5dG=xYZCvK-Gsv+qkf-Vt0LMbTyebO5T+Q5T8BfFedUdeQ@mail.gmail.com>
Subject: Very Urgent Please.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri

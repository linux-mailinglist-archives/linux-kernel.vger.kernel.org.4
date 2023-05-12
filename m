Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF87700A84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241366AbjELOmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbjELOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:42:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597261FEB
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:42:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so90118063a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683902555; x=1686494555;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn/vJXIMWCoSAtelKQZexwzcMfgGyT+seXXih0qAcsg=;
        b=j81H5AUq3OfT7e51/P1rD4IL2gyoGTPooiZ6kvhebSkJunR7kVgw7AtpMJpOj839Uk
         8NdFIGzHt3+pa8evbWBnNVcIqDSvQSU1bkuRceaS9gHUKdN1ZzZMA/Fb4gGS+C1SWp1L
         rXQ94q4mB0royGy2fudeBCDqReWz0h2v1jjMfmv7QF8Ps/a5gX2umiICRM0LbHwl16kj
         2sXsy6j/9gU6fnNuKFjY3EOccjongY059MakcyL4lFmgQGVOaNWXni25Iafjs/Eng139
         Cwnb2sBmlQh7+X5ZZsB+nPgKfHe1wyYXIKSGZjuENp2iKwu8HilpXH6AnvXjieplG00O
         RL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683902555; x=1686494555;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tn/vJXIMWCoSAtelKQZexwzcMfgGyT+seXXih0qAcsg=;
        b=ZUr7n+d7r0viuPt5Q8Y565Ob+FAcBR++zSaJ2IjYq0ozv/K/B0CZd440Ya6cRuZT7N
         kKtAx/wBDxnUEXBMoMBiBRyZvmyLLEXbNXoXqUABT/AVck1cyvsxISXcI1fOudeNRk3Z
         bbE8LpC0XPKBCQMvtoHSfkr5KOloyHqGJFl1/fRQck+0EUFf+3CBuEuhydm+sOPpqR5F
         zejtQdlV38C4X8HBLQwOhPiIDuO9qxG+4oPYOcBJZ8r3h1LoHnGy3WLnfWaH/HPk7i+/
         JtNvzhAdj2zTjiECMEjOR2Qq5vESwdzDKNkA3zkyhQ+NgWXl1Pdv5g0eQEIty6oImmRU
         197Q==
X-Gm-Message-State: AC+VfDx/v3luuX4D+Sn3xbON3/GKPYIFRrOxJVj+8lPPPOFmnVWQrM6t
        tSZFcghClYETyFEND4AkilrJhQXNiLvuvlT0n+k=
X-Google-Smtp-Source: ACHHUZ7Z+9snQFnPB4Psct1K+M6+0Emkfo9N6IZLGMlcSE5m6KlpXCePs5+hoo5mZWThetKxw8aLKa3X8P0Q2fEvFik=
X-Received: by 2002:a17:906:4792:b0:965:f23f:ac04 with SMTP id
 cw18-20020a170906479200b00965f23fac04mr22496606ejc.17.1683902554449; Fri, 12
 May 2023 07:42:34 -0700 (PDT)
MIME-Version: 1.0
From:   Luzy Mark <onesalesdatlist@gmail.com>
Date:   Fri, 12 May 2023 20:12:23 +0530
Message-ID: <CALs8NgbXxdQJ1mebh9=pUDVNyqOVwzmwKj=WCRc=Q+iZZGJQ4Q@mail.gmail.com>
Subject: RE: NRPA Attendees Email List-2023
To:     Luzy Mark <onesalesdatlist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring The National Recreation and Park
Association Attendees Email List 2023?

List Includes: Company Name, First Name, Last Name, Full Name, Contact
Job Title, Verified Email Address, Website URL, Mailing address, Phone
number, Industry and many more=E2=80=A6

Number of Contacts : 8,642
Cost : $ 1,421

If you=E2=80=99re interested please let me know I will assist you with furt=
her details.

Kind Regards,
Luzy Mark
Marketing Coordinators

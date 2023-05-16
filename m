Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD77054A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjEPRB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjEPRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:01:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8FA83FD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:00:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96652cb7673so1813279666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684256452; x=1686848452;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4/sySkFBOR2Hnso7Rs7LEKhuuYS+AT+syOblrJTklYQ=;
        b=KZX2jEiMydjCMV9CDO9S/JnETPjF74Iji14qD1Zjj1dW9QHuHAONBd3Cjm9wE6kBd5
         cABVbAzprSbLp8Ls5jSZRh75HAAqi6oKEbvuhgoADvZ7Y7WQJRGdymk3ANx1+vL9npNm
         Af5MWNGZ/dDBFty860l2h8yAJpzyKhCw6bbBAocXzvDJhepXImwKMgGdtxoN9BWptqUU
         0zYGiETPaqwVz+77Etryx3IpjgMuUDVaAnfmpG8/b1yoKBGeuMIF5hnPsamT+rjYYvtI
         5ayoGOhkBf69DeNOFWbXyStNvPFZQ91LRYqN+eT8snanzgF3KbjW3uZG25QqjIJNTOS9
         p+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684256452; x=1686848452;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/sySkFBOR2Hnso7Rs7LEKhuuYS+AT+syOblrJTklYQ=;
        b=ipE5MuTWMVKciMZxnTCnJBatTJy3QNlgOgfLvdml6wUXxgFyBbraSLqXlWGNk1Hvkl
         x+Isjl8Jds9PnkNf+mBWyhfwoO5N5LHaq/MHhL1W2Qf73dVUsYyvixMtGojiDGaaryfD
         Ul0mNijruidHHfxV/tYKrQYv60FZu7yMljc03/He+T6v/YVY7XWpPoQtS1zA7eNDUCYS
         0lVDglWeABQ8WHo6Nh87vs4EWcFKSdL1JnJtB1IWxQfkayf+5gklovrXvBrulSzMREbp
         alOh0ezl+DnZduPZ9kJmYE1UWUmErkYs4ia/8VayteidOHbnoVLYH3E6MDCxNyfryz1E
         FUpA==
X-Gm-Message-State: AC+VfDz9Tpi9Qzb1bcakiBXdjvvD4ipFzbksyeCRax9tMUAjIBhtr/24
        TANQsXBgyBX+X2errymAcWAdTjOqx7nZskiO31Y=
X-Google-Smtp-Source: ACHHUZ6kTW53oKW0VOzKMVoj25QsqmvOWm76vMOZZDSoXjDJNAs84+e6qqXJ+y1KHQgDZ/3vOx+xqYVbUZPyuFwkte0=
X-Received: by 2002:a17:907:708:b0:961:be96:b0e7 with SMTP id
 xb8-20020a170907070800b00961be96b0e7mr34104667ejb.48.1684256451466; Tue, 16
 May 2023 10:00:51 -0700 (PDT)
MIME-Version: 1.0
Sender: extra.bognon05@gmail.com
Received: by 2002:a05:7208:1494:b0:67:3fcf:83ff with HTTP; Tue, 16 May 2023
 10:00:51 -0700 (PDT)
From:   Miss Reacheal <Reacheal4u@gmail.com>
Date:   Tue, 16 May 2023 17:00:51 +0000
X-Google-Sender-Auth: QUVLr_GK5jjQ7BOIvl5YhtODo3c
Message-ID: <CAFONc4zWypYeo8iOBxMrjViKL+vjQVaFPd-xoDJCPezL1uZ5tw@mail.gmail.com>
Subject: RE: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej,

Modtog du min tidligere besked? Jeg kontaktede dig f=C3=B8r, men beskeden
kom ikke tilbage, s=C3=A5 jeg besluttede at skrive igen. Bekr=C3=A6ft venli=
gst,
om du modtager dette, s=C3=A5 jeg kan forts=C3=A6tte,

venter p=C3=A5 dit svar.

Med venlig hilsen
Miss Reacheal

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689306E59F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjDRG5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDRG5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:57:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168EACD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:57:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ec8133c698so9159351e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681801027; x=1684393027;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wury6L3OQG1ufIvX/grHQuKDJEwij1r17BDLWsHICdc=;
        b=K8Inm+OU8VtYD0LQDugV+pE7Ktfhczo0L1Jj3txBlrsem8DyET5OMcBQ0TquM136OP
         pd8hZshXgZw5vCJ2brh2LnpXe0jBTdzeAO5DiRk5+eDjPjedM0ZZFCeZzsaLW9M7x6/W
         wDgA8MELYGl6EjKAlMKF9d96dnAjLwPgBNS1E6YcTx8m+9il+RzEkmc+jdYKSuraRW0K
         ahS7AeoXx4VB7AwEJn+DgxbgeQbRGBnFIVkSxG/6/DfILt6LhtCdH4GDKUmls0za5hMx
         ZTxEyRACELH/HnBhW3euyIT2IdVeC3Mwij26EmRXU6GrRfkbfzDajuSplUkrOKaCmHES
         pI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681801027; x=1684393027;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wury6L3OQG1ufIvX/grHQuKDJEwij1r17BDLWsHICdc=;
        b=BhXsWLW4yNKh9+fYVoc+eW49xj1sKNRx7F/gwgho6EnfMlEB+zhIF0vqGQRsZIIhEI
         KXazyYyluHj2SMJ6CMDXyI0XYRppFIUT14jpxjJivQOJHmHDM6KQ4k5Jybto0ZsfjTP/
         pUa3SRyKilOZgs1czNGuHOQTG/GC6+RYvLn/xMshCKjnz5++ME45h5jKGBa7ijND8c1e
         JHdWlYnbxLt6vgz2On1JphGVqgbydGxobd4ALUg64PkNKiwftZjIdqdl8BcqxedKXptI
         7R2nbgON5wsnbInyXPRjW+fIA1cidjDFS2dxa9ou8aqazsBi+m93fwDiHJJNKTIOoJco
         bXNQ==
X-Gm-Message-State: AAQBX9fVhcDQUrbpeau62IsBptH2ZQGpy/PHZD/9iLwW93qtEDQhx61L
        vVbaQ0tSiQyklNlw/bRigwI4yyMU3eyiHKj5oyk=
X-Google-Smtp-Source: AKy350Za61Va+MaGjuZXhEYFJLnK/PMv2u8jJswSUNP6GbBTPg8bn4cwdqyI4iKCV9AgGrE6MQOJQwH8ou+GdhEgnso=
X-Received: by 2002:a05:6512:280e:b0:4ed:c2d2:8079 with SMTP id
 cf14-20020a056512280e00b004edc2d28079mr3121052lfb.5.1681801026888; Mon, 17
 Apr 2023 23:57:06 -0700 (PDT)
MIME-Version: 1.0
Sender: alijames564@gmail.com
Received: by 2002:ab2:494d:0:b0:1b6:a3b5:7d4b with HTTP; Mon, 17 Apr 2023
 23:57:06 -0700 (PDT)
From:   Mrs Bill Chantal <chantalbills0585@gmail.com>
Date:   Tue, 18 Apr 2023 06:57:06 +0000
X-Google-Sender-Auth: TUpqAY40TwyZ0kjntMmZtnIV7NQ
Message-ID: <CAL9ZXOZ1E3sGHiHspdyBPcfsgodS2oTWZYj0k=Eogf6V-=u+aA@mail.gmail.com>
Subject: Dear Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_00,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear friend

You have compensated withthe sum of 3.6 million dollarsin this united
nation, the payment will be issued into aym visa cardand send to you
from the santander bank, we need your address and your whatsapp
number.

his my E-mail address  ( chantalbills0585@gmail.com ) contact me

Thanks
Mrs Bill Chantal

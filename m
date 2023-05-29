Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34355714F79
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjE2SyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjE2SyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:54:13 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7977BC4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:54:12 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7748d634a70so284075239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685386452; x=1687978452;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A9FWaINC+8yc3RixwuUDL1/QxNvvBSU54/4pwy3a5GY=;
        b=scTnaOneYSXBUS0fYOF++FZss5VdXaKeIJPre/nf2dnx/eUMVS9xd84WAsnH0GJ62s
         9yrp9X9ZFMtDtpIC/NXU6ZufETiN8YWiv/Kyii+oE7ZCLnEmrvHoQKOSAaBgr2TIrbq2
         avF9VR3lsGcGUXk7IY49NE9pvup0fYEzOLcxIkBTqSXb5jWi/sBcQ0mjquZ8z/fGbD5r
         T8wCDSw/x9Zw6+mZOGQV7rqERacu5jByb1l0pUUKkRA1hp1QCzvMMSt1tl3Wm55FE452
         zCuOmLziROhaqw47/Gd5G5nTCZc4Bi4oSVMNT/IvyAJ391O26DBaMhvCK0eq6lMOC/Q7
         9fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685386452; x=1687978452;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9FWaINC+8yc3RixwuUDL1/QxNvvBSU54/4pwy3a5GY=;
        b=cq3exkoIOiUCuUiO0FisispTOtHusaPzwiu68HPES94Zj9C7qYz0Atwd6ZjBd7TtHm
         CTm1YSDoQWC8lc38Nz2+IYZpXpqqvfKqDzmBAFe+T7VfFLN7GmtrPoWHC4a3AOtPSgn1
         2MXJYzp59q1FHswavxSFrULoxwm/4Hb0lnS4/vcrm+66ixXSUMsFX/yQ+otbGEg9UlHc
         wkJqSzGbExQmBootuMtSJDbXsM2G/RaKDgYsOwB0RqPQOlz6PHi0UEO9SDae5Gm2Keyb
         EgOX4326tDVe6r59WDfbwXjUlcTfDGrWi3vCEdJNnoZY/4kwl9pIKEBE0RgN4CoP22ec
         7dZA==
X-Gm-Message-State: AC+VfDxuMTmyDGXsQC+LRgHI8G7Ctib8hUWtqq8jbOjI3V8lETTPomMr
        h19c5p+kWNYY0s50ZX6hPUay0DNTLIFnORoyTCY=
X-Google-Smtp-Source: ACHHUZ6hlHm209Y66SO0/rJhZLpiPwCKDbsjdZ9eMl/K7NlCEuxQvblyzaBCnnTH5sYRVlOFAdCpV6/wOB521IsZaJs=
X-Received: by 2002:a6b:6e02:0:b0:774:85bf:1e9b with SMTP id
 d2-20020a6b6e02000000b0077485bf1e9bmr8541481ioh.14.1685386451839; Mon, 29 May
 2023 11:54:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:2607:b0:418:3d18:3e94 with HTTP; Mon, 29 May 2023
 11:54:11 -0700 (PDT)
Reply-To: a00728298@yahoo.com
From:   audu bello <u2195ra@gmail.com>
Date:   Mon, 29 May 2023 20:54:11 +0200
Message-ID: <CA+_k-obPWDB=HMS3Q5vG11fPO2xQagjLqU0OHmDUY6zGVJ-GSA@mail.gmail.com>
Subject: Respuesta urgente necesaria
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
=C2=BFTienes una cuenta para recibir fondos de donaciones?

Gracias
Gerente de Auditor=C3=ADa

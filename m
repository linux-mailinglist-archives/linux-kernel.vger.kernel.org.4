Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD9B73E030
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjFZNHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjFZNHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:07:04 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D966A0;
        Mon, 26 Jun 2023 06:07:03 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-635dc2f6ef9so10480276d6.3;
        Mon, 26 Jun 2023 06:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687784822; x=1690376822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bzV+HdC4kmJ0LWj7BLRKmqDlUjACEGBJoVFUaNQGeU=;
        b=WVGiI6wZJeRGq4HLjPF/va4iBdmeEk32VxZUgl1vbN7uOUwQwePhbvDxPg4JvHHryf
         SWkoaXnpIUSOobQFDIR5Qhv0mKqvQB+gd58AXTj9nrKscJ2EblshHwuZ0ivd+55+8i4+
         1fwKHIA0xWDHFTfrHL5WLJ/lbycqAHuM9cyveU5nf9oTvmBz64AFa113JiaCg0NzyO4C
         HrF+mGO6PSlUY93xxKBSMPeVOIiH0WT42cK4aSwWE9TcDMDena8d5LTjrQ0VyA5EBEFb
         U9gWEhvsrf1mj1zfuvZnGfe+FxL/dgexmNdUYU7ze0Uu5jxLeGcvrjz+yQyy5og13+ni
         x/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687784822; x=1690376822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bzV+HdC4kmJ0LWj7BLRKmqDlUjACEGBJoVFUaNQGeU=;
        b=Rw4yYnkGj4bG4FjdquAFAPmmDzQU6oiavx8zW6km+KLd1eEbTQ/YPCSvdIFsRTGnrQ
         vUHMfIrF8Wj/5hCeKs1Uwwnqq+JymzDIdUW2yrOJSn3aIdSPAKQXbSOfKdud4jS324ur
         5/5a/QGLry0ncq6DFdcFHGd5vAG7/1v2+r+KdFRN+gtHUbydqIWsQ1WWitJMuU0r+M5p
         jFF9foF7XS/Tf10yJs9UmM716EAtEk5YTrux403P1ttXosyrktn/LA4yu5hpD3w6206c
         0+SbhL1nRmoQO89qTqvBP5vuCamFhewP29Su9iGMcm6j4yyjoI2x8EfhtBXUx/TfcCC0
         3a3Q==
X-Gm-Message-State: AC+VfDzotvKw9AiO/VncIuSNfAplv8kuW/4ShhWsPiBNdJR9VC0PLcW/
        FVk0hwcZdbMHbfXc3JOicXCw3l8j8tKaA4R1ek4=
X-Google-Smtp-Source: ACHHUZ4rl8E5LF7uOr7osBiYPe6siEKq/ffP4yNgUmXe619yrilRBvul7BUdCGz2YHsfR3T8lMI9U1lSUb7Iv8r0Vm8=
X-Received: by 2002:a05:6214:ac8:b0:632:2e63:d34b with SMTP id
 g8-20020a0562140ac800b006322e63d34bmr6671153qvi.14.1687784822063; Mon, 26 Jun
 2023 06:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230626102752.1583-1-youkangren@vivo.com>
In-Reply-To: <20230626102752.1583-1-youkangren@vivo.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 26 Jun 2023 23:06:49 +1000
Message-ID: <CAGRGNgW_eeM2h7JBe98asaYjnF8hwAr50n8dfSabeK2H0u4=Qg@mail.gmail.com>
Subject: Re: [PATCH] wifi: ray_cs: Remove invalid conditional statements
To:     You Kangren <youkangren@vivo.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        Simon Horman <simon.horman@corigine.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "open list:RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 26, 2023 at 8:36=E2=80=AFPM You Kangren <youkangren@vivo.com> w=
rote:
>
> Remove invalid conditional statements to make the code clean
>
> Signed-off-by: You Kangren <youkangren@vivo.com>

"to make the code clean" isn't enough to explain why this change might
be wanted. Are both branches the same? Is there a compiler warning?
How did you find this? etc.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

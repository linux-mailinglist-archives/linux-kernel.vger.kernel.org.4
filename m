Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D7471F5E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjFAWUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjFAWUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:20:00 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FC919F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:19:57 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-456fc318dd4so432385e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685657997; x=1688249997;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gXcTUw8/gzf+4N1Jk/+JzhhoqxoIN0uBNkkWWoz4GPk=;
        b=lKmn3PVqplFZ6Tl/R2OiS7YLMS0fKl3V5pAXFFXtxdiOqXNaSsuy/SVBXluwYu+NpE
         gEjizE8VxFoG54OHCJIUmFYsCVDVj8oGnROUnsd2EpWdvYmUjcHVpY/DCn44SaY+t3U0
         bP7nHvVp6RjpfW6FJFzfE27GIWRgckM77zbcIMxgqmBUyFm+ZcpNfdULnT1BHpOdKx2u
         SR6muvOs/x6Y+IOnatIYMGv2FjWpU57XvrXWRoyXZ8HXPrgixaxGPBf5ONVHSsH3O15H
         gLaboI/BAxNxl+eVnGEPAiS8l0ZQxpgnfpC6em0/WviRKfsWb5PD3zEjJsXLvudcZGtr
         jysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685657997; x=1688249997;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXcTUw8/gzf+4N1Jk/+JzhhoqxoIN0uBNkkWWoz4GPk=;
        b=hmRbwAqTp7p+6vQWXjE7M1lPAubls0M0oTPh/O6ezo6ibhe6vuJQ9036PUKE0+IWAC
         yaw2gNJ63BXYgthT4KdJYbQFWtY55yAN0aDt2H7Hey7zEoNTdBG2D8gCZ1kqtDgeiVxz
         AHy/nQ082W9xM8IcBK5loansfmQq90mwxxPQyTPXBBvtKnljNVtVTXcdPf93d9KyTj4Z
         DeGZhU6PlcJqo8knqOL23ojYE1BsltwYwjUJ9lPeF2aSv9lm5+qSuUV206w7AakWp8rY
         RzoaoZcOkVfh0TOWLrtxRValVTU0tWdy7mHZoOvNyjt4QLD41iRd+M40tSmAjZJSkAZB
         vayQ==
X-Gm-Message-State: AC+VfDyRdVcPe+muRJSI7aE76ZPHOVkCi+CbqNGU9XBvNnUYqj06sn0K
        pyNcwjG0cTEkgPHO+6EIqq53TpRx+urOVfr+CpQ=
X-Google-Smtp-Source: ACHHUZ78m4EtqInwwZ/APQonGYAcWJtCb/PVKhOAOTS80SaR87ZXIAEqf5CzRA3XLj17nXsGQh6JcX55lK+dm8QhhNo=
X-Received: by 2002:a1f:3f42:0:b0:45c:8ef0:e351 with SMTP id
 m63-20020a1f3f42000000b0045c8ef0e351mr1586704vka.4.1685657997040; Thu, 01 Jun
 2023 15:19:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6124:790:b0:371:8019:552 with HTTP; Thu, 1 Jun 2023
 15:19:56 -0700 (PDT)
Reply-To: choipark90@yahoo.com
From:   Choi Park <ubacustormerscar@gmail.com>
Date:   Thu, 1 Jun 2023 23:19:56 +0100
Message-ID: <CAGMLrsVUAv6YRt8A2aRNOEGmHqn9yZRpODMesyTu5xAwrQ+unQ@mail.gmail.com>
Subject: investment partners
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
Hello my friend how are you doing with your daily activities I hope
you are doing well, sorry that I have to contact you via this
platform.  Please this massage is not any way meant to steal your
information, it=E2=80=99s just  to  assist my  client  to have   a  good
partner for investment  . i got your contact when searching for a
reliable and reputable person that can be trusted as my that client
Mrs. Ma-Ri  Kim from  Hong Kong   Directed  me to get her someone that
she can trust and  invest part of her money outside Hong Kong   for
her under aged child  if you are interested and can handle this funds
let me know  by  declaring your interest so that I can give you more
details about this   .
Mr Choi Park

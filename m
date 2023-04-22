Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5026EBA58
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDVQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 12:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDVQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 12:30:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D8AC
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 09:30:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50506ac462bso4084390a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682181056; x=1684773056;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rIe29CHlO6glMfRfhMJG3iaAa/iujXdTRrJTiMwIUHI=;
        b=h8xNhT4zTi/Ela0KOBZZfJdjvSiX8ovmtLo3r5xe4i7nWAiFOY7cDMRQhBBiBPmOXQ
         hyaNiglyy0XqWtHjphMCaLn/A6GPzhz2rXFshhPHHKaMYQLgdtMaCo54yr6BNTx6mboc
         1ogY8wU6yBxQ0NyLDRk2ixKRHJsChCXtmqJuz9S8nGIu2ALw/VT+Wvn4CovFaqtmINKU
         3SgJeDyDhDF4zvvltXEE13ZOV0cod4Ajw6gZTj7tnX1L5T8P1HbWYJJdH9hzVI1xCoKg
         8hubVZBUNpGpCiISHFhTpO2WFmYm/XDUIYEx/xCcXBnhtrWJYfYoyPGE3PwoxJLktIPU
         iQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682181056; x=1684773056;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIe29CHlO6glMfRfhMJG3iaAa/iujXdTRrJTiMwIUHI=;
        b=NsTg6TwB2Z75NWNZm19WmtXsMDRdl1+t+QvJQSgiNlhot1h604atzmWHjg/gcc/Lvk
         qsQNzZUqMyixF5+aJL7F5+/f4bveYI7PDJ56M2ia6uvPCEkAlbmhUP/5T5LB46xHwmo2
         EnjTnB16Q01W6mTzgNKNbNDEx+XZeloKo1DznslsqHn6je/2m91qGDZ1/zy01VVVFJ2g
         TBkFrlOLgN8j9ZvJ6muoH+lMu6b6um/CPCd9u2TFTcVzw5J9bXlOlw0fRhsqasi4Hlao
         XqscU3DSl9yUcYUNQHJpaw1GwK0MQUhvOaNoZ13R5pVprfCdPaAZ0FqB273jgMhMZoZH
         WbCA==
X-Gm-Message-State: AAQBX9c+TgLWQBolifrQEAH8/7q5WNH2dSwafnYY/yQPx7/gT2GinmoY
        oWpncibDCA3DijpJzaU6mAwgt9HjzQksX4hznDY=
X-Google-Smtp-Source: AKy350YiaV5AhTuSkqcQT+ZstiMNObaThmtJiEIn8NxqlgrK+Lh8IXfKuAchqHQfuNyGfMTgAWzmFGpkWF1GTyX25O0=
X-Received: by 2002:a05:6402:65a:b0:4fc:9a22:e0d2 with SMTP id
 u26-20020a056402065a00b004fc9a22e0d2mr7955212edx.14.1682181055565; Sat, 22
 Apr 2023 09:30:55 -0700 (PDT)
MIME-Version: 1.0
Sender: nournoura283@gmail.com
Received: by 2002:aa7:d3d3:0:b0:506:8881:4a81 with HTTP; Sat, 22 Apr 2023
 09:30:55 -0700 (PDT)
From:   Miss Reacheal <Reacheal4u@gmail.com>
Date:   Sat, 22 Apr 2023 16:30:55 +0000
X-Google-Sender-Auth: zJMnqfnaDp4H7sv0-sfIquXEpls
Message-ID: <CAEQzSBbx-OBvMA1xwHtNQ426y59X4iCjB=5xjkh1-gxg_r9Y5g@mail.gmail.com>
Subject: RE: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hola,

=C2=BFRecibiste mi mensaje anterior? Me comuniqu=C3=A9 contigo antes pero e=
l
mensaje fall=C3=B3, as=C3=AD que decid=C3=AD escribirte de nuevo. Confirme =
si recibe
esto para que pueda continuar,

esperando por tu respuesta.

Saludos,
se=C3=B1orita alcance

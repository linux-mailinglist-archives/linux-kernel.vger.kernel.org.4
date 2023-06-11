Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E236072B155
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 12:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjFKKZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 06:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKKZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 06:25:02 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71D312B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 03:25:01 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-19f7e8f8e3bso1375274fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686479100; x=1689071100;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m7ZhYh521wqZIjgkPpyGpRYHntrQZ0TluHrGrja+CRM=;
        b=QgkqUhHM9t0Vsy3HbJa9wcCjDOrKtS2oLpRM9cepPQGFaIxeMUGZxbuZWPp/KVn0eD
         RDkwGdpSV+zeiNWV7Y5XZnV5J9vZVsPYaOmpmkByNNXVWuyNB0pFcRmP74KRIzr+/pyX
         tsEStV9981XcTkWd230MR0nrQFv97FV3YJ2FFPmcoGZFoXryCitu+XctZOroGO21RfcK
         xT6vdTd9OTYiu5VwKxjvitWoA1ZhlAFVe3uLKFxJq2ld28EXoh8PCDiirTC8uSskzhTw
         Ll6Ho1iTBJ3VCRqlMoiXREamiRj6F5cwMEP/UW0aYFN1kCAQmFNwdbQrHRFA2+xNXHa5
         q6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686479100; x=1689071100;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7ZhYh521wqZIjgkPpyGpRYHntrQZ0TluHrGrja+CRM=;
        b=Iwa/uYCRccjtpg3CCxsTKjbg+HMplc/QQ27gSY0vTNWndhP1d+tjIG7Poy10AlfaG8
         4rwNrx/z+xggmI0Sy51cXzLtFqFRo3BxFP/berpqjs7ZXuz+fU3Tmrk2rVEa4VUIiDPE
         BIvbl8ShV+FqOnYUA2X9xpStc9Cdf0Z7mdiK9JvlmApZsr/3f5+o0KkYZamaMsL8q48f
         lGVb+CfhKdDUqLefGB7as+GSkTIVSBknnNm078OYsDAMUB1uIKS+FICBa6STraHmfPVL
         63ZilG6G2vTJg+n25jjVZW0DVN7SjRL9L59kcHSaeyWOUs0nb+N/ob5B9Mh8lGnmFjtU
         ykug==
X-Gm-Message-State: AC+VfDxS87s/OVQ+GFaRDq429705ojIIY8RkaRIZmiA7/Df2+6TU7+nh
        Z2ny+pNt71zNuC+yDPLn88+vwXv0ow5YAZKNpRI=
X-Google-Smtp-Source: ACHHUZ7gScs5V7cOHWCKhiTUmEiLXJWR4Xui2Sv514mEcNYLA7xml28znDt/KiZ+EvM+WWktHCX7JHPFuo8wGGbiVcA=
X-Received: by 2002:a05:6870:72c3:b0:19a:71ce:c9f5 with SMTP id
 o3-20020a05687072c300b0019a71cec9f5mr3126491oak.29.1686479100201; Sun, 11 Jun
 2023 03:25:00 -0700 (PDT)
MIME-Version: 1.0
Sender: evelynmoses98@gmail.com
Received: by 2002:a05:6358:fc6:b0:11a:758f:2435 with HTTP; Sun, 11 Jun 2023
 03:24:59 -0700 (PDT)
From:   Rose Darren <rosedarren82@gmail.com>
Date:   Sun, 11 Jun 2023 10:24:59 +0000
X-Google-Sender-Auth: 6E3pEVZqxBikXx5vRZrjOsX3mmQ
Message-ID: <CAMyT+=KMmJCYNyesDdMrxkhH+rHVsDYOBrGE-pp9UD_LZU8xPw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sauda=C3=A7=C3=A3o a voc=C3=AA
Voc=C3=AA recebeu minha mensagem ontem =C3=A0 noite para que possamos conve=
rsar mais?

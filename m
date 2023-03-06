Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070A46AC405
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCFOyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCFOyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:54:22 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B09E19A5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:53:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e13so9076433wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678114434;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aAJ6vgdB/PZRa7LHw/qPKJPPhGvaYYRTWLmTdCcuqSI=;
        b=RWPIs8Ae+XfRubMVFLn3BoukQZkLpeVMg3a/Kx4MznQD0RvlUOgARNQKc74HbTBn6p
         JhQWC/SQCHGjtqV/JYYG1doDJe44ZTWGlrPaUWhSme3trBeBCyvFGAJzi09XfyrE7TJl
         hYPZcLJyyTWDazSIkji3Al6vW4HRrTvQG8Upo89Mtp0yBeRq3nlUBisVS0zqc3BgTtzu
         ox6ctt7LdKG+TGAIfjL7sHY71Cqi0cafFbAf2KKd5dd3yadUSvThTzFBMNZUXswWUTt8
         Ga0jAtgU5ixGOzrdgWhHFIAYmOnl+jYEhi3H2EQQ7zOUb8ru2bn+tf0pLJNtlYcpyRjo
         mqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678114434;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAJ6vgdB/PZRa7LHw/qPKJPPhGvaYYRTWLmTdCcuqSI=;
        b=AQ/kgnC8scc26eIKtPa7pKJuEzLJEw7WQR8LT6cO1zTYxVZwrwv61Xx1PTUEsy16nO
         A11NoBd7dm506b2U0YnqYdB5TfMHTSDKCHObVwFX7QpmJRJa3eO3TJomp1tY3wbK+k7W
         6ik4aX99dTYUjZpH/dl7+5w1OQMYp21IayshAsM+UckzDec/py+JKF27a00krejgyMwF
         ukSGJl998zWV4H/9zlhVX99PsfF0JBkkKZP0+3d8q0VsGVDmpPxOr5gRWLYBpE0NThpX
         IudGypWYikQVnmuFdKtC5PT/4n8Xgch0jnDUZUZUbSag59hZrloNDIj3b9swLlnkSl0+
         4FAg==
X-Gm-Message-State: AO0yUKUnrJIbMs/szKl3DTTpdvlQbUSY2sRnkJfy/tbTWguEDvSyIFFM
        gp3cB8ra6uV0urlZGD6tjFy/QdXJy0W1V3WXULs=
X-Google-Smtp-Source: AK7set+igPqCKAr+91GM2TmzldnvGBi6DYZCGVbjOKHrgmhQfNFD3Upy+mwnivEBnWmoK2+d814tEWa2pIxiG+eD/RQ=
X-Received: by 2002:adf:dcd0:0:b0:2c9:b9bf:e211 with SMTP id
 x16-20020adfdcd0000000b002c9b9bfe211mr2272252wrm.2.1678114433798; Mon, 06 Mar
 2023 06:53:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:56ca:0:0:0:0:0 with HTTP; Mon, 6 Mar 2023 06:53:53 -0800 (PST)
Reply-To: RaphaelGodwin2023@hotmail.com
From:   onyii emmanuel <onyiie982@gmail.com>
Date:   Mon, 6 Mar 2023 14:53:53 +0000
Message-ID: <CAE9OROdtDAkOBDJP0POcBTS4Gtp3c5fPC1TH-0HWXuZQAdYULQ@mail.gmail.com>
Subject: =?UTF-8?Q?TU_ES_B=C3=89NI?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5197]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [onyiie982[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [onyiie982[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [raphaelgodwin2023[at]hotmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Salutations =C3=A0 vous.

Mon nom est l'ing=C3=A9nieur Raphael Godwin de Suisse. j'en ai beaucoup par=
l=C3=A9
investissement dans votre pays et je cherche ici votre permission
pour m'associer avec vous dans le pays et pour me permettre d'investir
dans votre
pays.

J'ai besoin de votre r=C3=A9ponse urgente =C3=A0 mon humble demande =C3=A0 =
mon
adresse e-mail priv=C3=A9e
( RaphaelGodwin2023@hotmail.com )

sinc=C3=A8rement votre
Ing=C3=A9nieur Raphael Godwin

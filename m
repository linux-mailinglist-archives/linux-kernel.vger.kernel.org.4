Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027776A54B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjB1Ito (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjB1Itm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:49:42 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260433AA8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:49:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t15so8854210wrz.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aPR3wybdLDGQ751O+Ph+iKip/50WSjBMbLi5cBgGIUQ=;
        b=Ob1uDeaFwTz4d7FYhwJIxLslOCCHd62bDImUqeM+dLY9GbnB3MiTHNiMRgFXcijyvV
         shEYiZNo0egocsQvwXCROyLi2I3GyvreLdG98jnDn/PR/HD1No0e1LSauhMGSi5Boh5S
         F1SRFFC6ZTskUEuqMvRL3gRAliT22pQP1/BMhGil+MG1u8WO5EXEOW/l6P37M4qW/aGP
         6DKzhKndMFub6uGndve2VGm1W+RU12IJtqpErBGJYBJomodEHBNSfJz+yrI/oHQcbwSs
         uTe7QSqhwgi4hnCXERvNhE2awlFoNRqExm48dhjU4zEtvO2nHRAokplj4/izTBk1tAf6
         iPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPR3wybdLDGQ751O+Ph+iKip/50WSjBMbLi5cBgGIUQ=;
        b=KpHvkoZ94gsvBQkGCtLKb2oSHxC/b7IoPiAu96jbQLY1Qlae16hmCpI2fXsGMS2G/h
         CoWjWLpBopFTet8fbz6pZWaY+6lTHn36NZyLiJc10Jm2fZdubemYOpXZ023F5Kg4BNux
         w3fkL9Y958fqC297GBRjbf3zhxNacfskslZfC+V8TgOT2dD14uoYYotLeM6sXOG1ljcs
         r+IQc3RownS02NgaNCP2GFihznI7Rp5k2mec9f5rkEgSzDq+2VEaf+24NFtIXC2nll7c
         mX4AWh5gXhA9QkldQkl+UVnyOhKTKgG458Zr60PFh8yKL5Iv7t43kv758j5YTmZpBg+k
         mhHQ==
X-Gm-Message-State: AO0yUKWOsgL5gFh3/zjj1wRNW4FvkYURdCAN+G4N1Q/cxdcOBGcrZ1oz
        Ysquzx/TGiQF0o5yhrYP+YVj2OStpQnoqwB/sqA=
X-Google-Smtp-Source: AK7set+Vbto9JYJspWp542vHjBxLAzikiYg3WsNnxV0HBRiVz3vO91ESMi7g6CVWVRQK//nmUeK5bGDCcxUMCZSUQOQ=
X-Received: by 2002:a5d:610e:0:b0:2c7:80e:4e60 with SMTP id
 v14-20020a5d610e000000b002c7080e4e60mr418149wrt.4.1677574179207; Tue, 28 Feb
 2023 00:49:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:5b1a:0:0:0:0:0 with HTTP; Tue, 28 Feb 2023 00:49:38
 -0800 (PST)
Reply-To: leighhimworth1@gmail.com
From:   Leigh Himsworth <johnerc124@gmail.com>
Date:   Tue, 28 Feb 2023 16:49:38 +0800
Message-ID: <CAE7pvgNTneM09TWxdd-4GmZ092uJQFP6gvG9MR6KxZhT093L5g@mail.gmail.com>
Subject: =?UTF-8?B?T2zDoQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:433 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [johnerc124[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [leighhimworth1[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [johnerc124[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ol=C3=A1,

Sou Leigh Himsworth, de Massachusetts, estou procurando investir um
ativo avaliado em US $ 350 milh=C3=B5es, no Astronaut Asteroid e em
qualquer outro projeto comercial lucrativo em seu pa=C3=ADs que possa gerar
nosso retorno esperado sobre o investimento.

Por favor, deixe-me saber se voc=C3=AA est=C3=A1 interessado para que possa=
mos
falar sobre isso com mais detalhes.

Cumprimentos.
Leigh Himsworth

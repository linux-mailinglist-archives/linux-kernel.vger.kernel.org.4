Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18E729ACB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbjFIM4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbjFIM4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:56:39 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB46359E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:56:18 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565d354b59fso17049537b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686315377; x=1688907377;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QZialscKnVQtdcdCgaGFxhlxvccBoYNjLdFVIr9H1Pk=;
        b=X3Q3loro904hKBIxSpX6V3VVPNAX5pT4JHbeqzOIO0hlWiXEKR6qbPedGV3Rh29tfh
         7LSc2BehZDJaGWyArcTAXyCnsHktZC7/ds9SXIje/xbPvEMA1QVvcNwKcM9WDnfJGw29
         JLhz+giH+E4JE0JDDPGnus1fJiBeWrV4nX6rMfo8SOC0M9cYQwJU+PQdKkwwIuByAs8u
         FfdAjYOSMtwCtRfLCyyYi/+QfMUGW2J/sf01l6Rc8/deL7POltcmVwER4e4UzYPExRTw
         BYQk0+UFjpFxqxrizDHIZJyXwNhFI60r+LdmeEpfou3xrn6M69krxBMWSX2rO7AGWhjP
         el9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686315377; x=1688907377;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZialscKnVQtdcdCgaGFxhlxvccBoYNjLdFVIr9H1Pk=;
        b=YL5AWuNsGU2CSjWXx+nzKjlGKJDgY00rNhhqUp08hO+//WzodJnzcEDuHyjP2oeq/5
         CuAo/rToof3VfFb3GLvEv79Zcz28jgVdci+4Qmg0NESaVKtHrXTPLfFbS6Vhi4by9r9U
         WZWe8nFos2sJQk3/WelATzNKxaU50Hugf9fMQUztfTegqwUK4iSFYJI/aS7vC6HiuC5D
         LgJlu4VWkBT7hvoWRvoxUlLRQm1LHwJQgVlD5fGXcNPzUfwZ/p9JZfRqqj422+MuGERl
         laf0Gzzxh66Q4bJz7l1JVMwzALL2CiGIYTg5687IJgcCI1deQgc+NXyKi5h9LIDwTtXr
         upDA==
X-Gm-Message-State: AC+VfDxMAoJFkj3/7NefhIwt/chTyKMz6KmrvHPRSe5lhwohNqjaOL3I
        o6UpFL4WHzjdSBCw8aQZ9dXLtdx5LnpE/zAWrPU=
X-Google-Smtp-Source: ACHHUZ5kq50IPqfCxZhYccipgFxCbVmo+KwZth3oSSucPPLzrqmHyRtU2pHOBk8g+fHFuau9VdL9KxWq4EuA5oYj8zw=
X-Received: by 2002:a0d:d9ca:0:b0:561:a154:54b1 with SMTP id
 b193-20020a0dd9ca000000b00561a15454b1mr1084238ywe.20.1686315377402; Fri, 09
 Jun 2023 05:56:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:538f:b0:35e:1f77:9084 with HTTP; Fri, 9 Jun 2023
 05:56:17 -0700 (PDT)
Reply-To: ramessursoliciitors@gmail.com
From:   MR STANLEY EDWARD <gen.martinsdempsey001@gmail.com>
Date:   Fri, 9 Jun 2023 05:56:17 -0700
Message-ID: <CAPTSgFn4GgztEaazZUuap4d_DjthjiPX_wMOe4y0Mb6ivvdXLg@mail.gmail.com>
Subject: HI
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4988]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gen.martinsdempsey001[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gen.martinsdempsey001[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HOLA PROPIETARIO DE CORREO ELECTR=C3=93NICO.,

Este correo es para informarle que la organizaci=C3=B3n de la Loter=C3=ADa =
ha
ganado el premio mundial de loter=C3=ADa en los centros regionales y
nacionales. Dijo que despu=C3=A9s del sorteo final, su correo electr=C3=B3n=
ico
surgi=C3=B3 como el precio del premio ganador de 2.800.000.00 millones de
d=C3=B3lares estadounidenses. Comun=C3=ADquese con este correo electr=C3=B3=
nico
(ramessursolicitors@gmail.com) para obtener m=C3=A1s detalles e
instrucciones sobre c=C3=B3mo reclamar su fondo ganador..

Atentamente.
Sr. Stanley Edward.

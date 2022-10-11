Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1E35FB2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiJKM6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJKM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:58:35 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EF2915FB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:58:32 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id x20so4960934ual.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y1bEiNpfNWaupTJq/MT6CaNCMwtQHUlCN6T2ayUv+NI=;
        b=E6q60+NEcJmzbpoJFoPsQslL2+P+P8Q7/+lf+gfwvMGC1h04l3azmTkCqURuB/cEMc
         LTD/PCgr7UmVmm+JfsHpygUl1ZWqwPNUIH7WTBye67odvzQEpjnE1qyxoHow6dGcru0o
         /sUiLE8FcdNqwTD9ot64DQIls/ICKSUcEoZrCA9iSSAhdY+oV77Sm4Nai7xHJQFp/DGT
         pdTtyRLvGWN9MMs9ftr1Pdi1dqtBvi443+4nNPwQcg9hYjpoSiX60sdo40hU17OcJZFM
         buMZQi5iZGQqux1wHFgvMnU4AFOPMupZ0ETSwC3wXQBgGaYW6OLeffKZ1oq5zdGuIOou
         z0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1bEiNpfNWaupTJq/MT6CaNCMwtQHUlCN6T2ayUv+NI=;
        b=34gjNbxcLgljyOSmNwgly3UGE/jhbtk6PrjwclEdlWkhEtpAcjeo4eUPMS094wBaFW
         YnJGPGu080G5KUzJmU/dICwazs4WkUbMOjcu7t2Lr0lLtspjZjLmsxTU9kiedrJ38go4
         mfkMvtt9uQIfTohuuQaoi6yyvo6RRjNPEOORINrSZ/wKRUwDd/sktXBsVaK85FSUpZf8
         O0SbA8AWRzTcII1MtZgZPbZbf+k00ZdJ+ovRkItFqVmvYmnB0rcs1xxbgBLLOmj7QEVe
         db1a+E9qfyBfVgZafzIDqx7BwurXEjCJtnDgalnXeZDxLnBI0v6SvS3MrHnj/XEps7nb
         2aYg==
X-Gm-Message-State: ACrzQf3hDlbjcKaygpOOpDzi3XDIZQUlWHuQAILvECFqc/zhNfjzAlk2
        hQgEMAr89tG4pPBRUBTPgb+HvPZzhNts65/AArk=
X-Google-Smtp-Source: AMsMyM6p+ifSqAAg5h79jMkMR/YRtYTA4Alha3o2Jeb82pemI1s75j67XTRjzpZYb6XZUnkFutjYG1cshhmllVSZcXw=
X-Received: by 2002:ab0:166f:0:b0:3e8:af59:df81 with SMTP id
 l44-20020ab0166f000000b003e8af59df81mr710932uae.36.1665493112097; Tue, 11 Oct
 2022 05:58:32 -0700 (PDT)
MIME-Version: 1.0
Sender: essobassiagbessou@gmail.com
Received: by 2002:a05:612c:27cf:b0:30c:dd9c:5f45 with HTTP; Tue, 11 Oct 2022
 05:58:31 -0700 (PDT)
From:   Miss marybeth <marybethmonson009@gmail.com>
Date:   Tue, 11 Oct 2022 12:58:31 +0000
X-Google-Sender-Auth: -p7JR9FVsOOsyhB05dYEeg1ZbaY
Message-ID: <CAJz02AiwKxXh+rDroMpxQK9esfQcDTGasyFYEFXzuA+0m270bA@mail.gmail.com>
Subject: RE: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
se=C3=B1orita marybeth

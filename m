Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177AB6269B6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiKLOBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLOBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:01:12 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F517E32
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 06:01:11 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f37so12302366lfv.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 06:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30mLK80vSZcSwBOrdpYOKvqdrdKJjCkQDSG3S0CWQyQ=;
        b=Do/WAWsPwSMhLoj4rsrIaqFA2zKH7796aA1Tzl0vUI3ZKYTfvMEIgnTOiZjkpV207K
         efPtMEZZ/hzZYdhGS66t9WxhZAJsETJIAN0zJk6zoYeYdZ9G4P4nu+c1LhycWWoXW9gt
         Xv07Kf0hHfjVg0MnM6liwJu/N/VnFmmwVd/Kr1sZJ+zxBTLgwUstdTRGblVuxnyUFCPt
         2U2bfBHgUGZjf8wMxztIZ0CUxxLYVO4mh3k6BpGgTMP6EEmYQRPVxlvVwGLwFW9cuu68
         EZu47/iaRhfzrCL3pDbs7iIHCESFvBnzLRZZnLDMW2lM4VcJqpWhWija6VfY3nIKOgmA
         BPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30mLK80vSZcSwBOrdpYOKvqdrdKJjCkQDSG3S0CWQyQ=;
        b=KCNZeclDEOcE53d4EQQYaKX1YHbBXTluLN4Sd7aRywCemhDjo0MMJQdXPfstMdYEYH
         AvXrQmhd7wX9/SQILJ547C15+rT2dnG88MP4MGJ2V8VEV7ZGJBJtyYqdfSqt96Pg3Bxk
         o5GGMLmT2DPCs8MqZchp5ApuajZY2MijEMqmRo9mDGoOQaJW4dBWVMzZrBeURLtvS9iG
         zBjnBiPyMAZyHWIucNBmBGiyFcCGITRYsvW9P5vj7Wo8LFnNiAv/RkoHS/SLwxxW6abv
         n1wlzq5ZbeadBmqQer1LL5uB2OFm636YyYpiKbXaYlmSWRCniW/RdJ/yUyMNXeGmtDeu
         HcCw==
X-Gm-Message-State: ANoB5pkYqF9ew8Un6tBrMuE9YwyluoA+q4hmmvRNLG5EJnx2LneQKsun
        OdvFd7ZdClKuwVa8oempBAnOHj3Fv6TfQ7q23G4=
X-Google-Smtp-Source: AA0mqf7RwfQDcFwQDMj42y+ixV3XYT9TYsHLjjgX6AChHfciZ86SOt7fq/X/8ZNzhahsGz8vTuGQaaRHtu1fm/aPV1Q=
X-Received: by 2002:a05:6512:e9a:b0:4aa:1e21:8f1f with SMTP id
 bi26-20020a0565120e9a00b004aa1e218f1fmr1942008lfb.651.1668261669967; Sat, 12
 Nov 2022 06:01:09 -0800 (PST)
MIME-Version: 1.0
Sender: akondotafa240@gmail.com
Received: by 2002:ab2:4e0c:0:b0:16f:cb48:e742 with HTTP; Sat, 12 Nov 2022
 06:01:09 -0800 (PST)
From:   Miss Katie <Katiehiggins302@gmail.com>
Date:   Sat, 12 Nov 2022 14:01:09 +0000
X-Google-Sender-Auth: bMm_z-ZVbAe9QpakGUBPJNQYHi8
Message-ID: <CAM5Ze1u9FyNeck6aKuBLi+kzoOLjiZqLp0mdgREA=gM3iOVmcw@mail.gmail.com>
Subject: RE: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

Sie haben meine vorherige Nachricht erhalten? Ich habe Sie schon
einmal kontaktiert, aber die Nachricht ist fehlgeschlagen, also habe
ich beschlossen, noch einmal zu schreiben. Bitte best=C3=A4tigen Sie, ob
Sie dies erhalten, damit ich fortfahren kann.

warte auf deine Antwort.

Gr=C3=BC=C3=9Fe,
Fr=C3=A4ulein Katie

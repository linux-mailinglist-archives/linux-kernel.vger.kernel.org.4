Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C6269B754
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 02:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjBRBKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 20:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRBK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 20:10:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D6146166
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:10:26 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id dm15so42263edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30mLK80vSZcSwBOrdpYOKvqdrdKJjCkQDSG3S0CWQyQ=;
        b=GSRJn+H2zqXj2DB2FghJzBzeGYy1jGoeAVo+GxCDIUSE54LavFt9PmETQN3vH1MgP7
         EWtMdgyt4HSHYjUlu1U5yPCyCRCdcGAtyHVWGaYs2KRIqhWbJsISWYRexARy4NMFpLgN
         f3QJoDQqD81zgbVUskY1FFQuDWT2Ecj0/xx06+VP2C8ooQ03Edqs4vyx//roCb8NUuna
         DMFrZG19EWECIATnnqQqQtAHYCvZ9oJrUoY3IHn7lCamdWRa0Hv2rhbHnIi4sgZroixN
         qIlzfkZnMyc9PsaujzI2TqnZXcxoI4LMRqZPf+qGvZwoYY9DPiGXBjoessdVX0FjcvwS
         oOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30mLK80vSZcSwBOrdpYOKvqdrdKJjCkQDSG3S0CWQyQ=;
        b=xeP/zU4DLMTGpVHi9BraKfUH+7CtdIP1opUW/CmYJ7TzmOlJ3zmcmNs9pKct+cvPad
         zmRNz5H5bz6yNScDDKQswn9CvoNNJ7jeYdMsbaIU5pgeboegsUgk2ou7L9Nw4dH44ePd
         xmO+ZhvOAqiOMMFxF48Ej8KfXPOFibiYYHcehQ3iCnT2slaevsGjXk6kMGJSxUNdsub+
         2depzQxuDzrHNns0uvOFB2Jtn3BfZRNe4QVFKxwIuCI371NUG5ffK5SvNrPVwKfCSMq3
         ajPv5heNH0HwZ1u10RrbK7UzP4yDyScLuFnprb6KrGAJldv5rc1Xlx93TuDuLD8b/Cf1
         X4FA==
X-Gm-Message-State: AO0yUKVOkVyJBLwYKBfqHUYui0Eu3GbqKMB6XqfaxG1jIutfHW67yBNI
        g0qk1ygBOhEIP1Z10Ys6+kDIZwt8g2PnMmk2sHw=
X-Google-Smtp-Source: AK7set/m+Vt1/EpWvFQqt3kYA2fJ8nwdk3CRvZz4ihTNbKwCne2T0GsrOZQjTPTPdZTFbunr2LLLfLyFAd1tAXCRTOc=
X-Received: by 2002:a50:d08d:0:b0:4ad:7a80:91b7 with SMTP id
 v13-20020a50d08d000000b004ad7a8091b7mr2710353edd.3.1676682624506; Fri, 17 Feb
 2023 17:10:24 -0800 (PST)
MIME-Version: 1.0
Sender: akondotafa240@gmail.com
Received: by 2002:a05:7208:8799:b0:62:8acd:8a88 with HTTP; Fri, 17 Feb 2023
 17:10:24 -0800 (PST)
From:   Miss Katie <Katiehiggins302@gmail.com>
Date:   Sat, 18 Feb 2023 01:10:24 +0000
X-Google-Sender-Auth: 8h-WvYuPGnK36xe7YM64InUieek
Message-ID: <CAM5Ze1svGuvGZRrBHTvpyjFtRBEWWjzFQGDNc5AsCsq-Fgeeuw@mail.gmail.com>
Subject: RE: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=ham autolearn_force=no version=3.4.6
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

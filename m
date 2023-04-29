Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06906F240E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 11:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjD2J4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjD2J4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 05:56:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900E6199A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 02:56:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aad6f2be8eso2797805ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682762171; x=1685354171;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gRKZK+rXpNnJvGnSMrWAgp3p3takfN5fgJGj2nmhKwg=;
        b=qqfHdQ2WutF5i5BBVg7yiQCMlzVUuEbs8DU6xX6A3auwTwS3Ewyc8AHfeRFvJEWbsz
         IBrRp+3hmWzOJbVYFt/HvEogXrXHpS4gLden7253q1BDcJn62+38RcU6NFIqRkRfrf2N
         dzrPVEloUy9DP98OtEcbiT/O8nNrlD0YAc/7gnDSbs1kNT6477M8yqFRlmtT27PKVqcM
         6BrMURByOWheIo3yUM7cwDHN4m5DAIHd3rjuAo3QlymxaJtisCE2QKeha8lesr4Zce6I
         k7xvh3g79H0Ec9TTNFKY7d1qo92GPEgpRSCvznSGdOQ01fLWlJ624j1IsjTGJjVNtkBQ
         WRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682762171; x=1685354171;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRKZK+rXpNnJvGnSMrWAgp3p3takfN5fgJGj2nmhKwg=;
        b=UFzu4+xLHYnTrriJkklPN6G9y1RXkSRu0IRTeRv8mM6bD/eWdiN7NaRIR3KmWvXrjx
         jvMyuRQKI1hEB3w9faU7qqMbIc8rNBwdKXFIJiOgOjgTlTOSXxpXh7Hp4WTs/nBgH7va
         mUTRPotMgWKaNFOjWlBmm5LgNBgdZUt6qSSGr0e7bNqPpeiB4MCPmcZYg3vLEnxv5XUX
         EdHyD5SGlZHQpowLmWRHXUi/seddqZzH64VEmpDOn0GbwTam+/pW6RA1vHMqYR8/qvaS
         dqLLoCLmCeoz4V59SB6teSvXJ77SpCa8XW7/TC51cejm7xhRa3lV1BEnNfCU4W7A8Hsi
         mIPw==
X-Gm-Message-State: AC+VfDwxZRXy2vJgWJkTU79MRPbBleh2koHhhVwypQKWJyT3NX7KkJLT
        pN3dVJApWBTmPSl1Z8+Uka1UCMGfCjUNBcXuuT4=
X-Google-Smtp-Source: ACHHUZ4RbfZR+VJpZCI5p71kI3mp3CMzuGVw7rQrtnV1NKROqA9oCfc4/St7laJD8T9O1tBzYtmfb4nlL5fcMeqo7HM=
X-Received: by 2002:a17:903:2345:b0:1a6:91f0:f7fd with SMTP id
 c5-20020a170903234500b001a691f0f7fdmr9189884plh.60.1682762171080; Sat, 29 Apr
 2023 02:56:11 -0700 (PDT)
MIME-Version: 1.0
Sender: sonia.antoy70@gmail.com
Received: by 2002:a05:7022:6291:b0:62:df4a:1c59 with HTTP; Sat, 29 Apr 2023
 02:56:10 -0700 (PDT)
From:   Rose Darren <rosedarren82@gmail.com>
Date:   Sat, 29 Apr 2023 09:56:10 +0000
X-Google-Sender-Auth: YQeuj7s-O3mcXSpIIyyihM_qWbo
Message-ID: <CABV30ttj40fQ=CHJf_X8mEnzv5z+zp4rmJEAGS+NT4zUmevnjQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ich gr=C3=BC=C3=9Fe Sie. Ich bin Rose Darren, ich m=C3=B6chte wissen, ob Si=
e
hast du meinen abgeschickten brief an dich gelesen? f=C3=BCr weitere Diskus=
sionen
Mit freundlichen Gr=C3=BC=C3=9Fen
Rose Darren

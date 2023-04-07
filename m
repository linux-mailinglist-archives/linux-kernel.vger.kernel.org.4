Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD46DACD2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjDGMzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjDGMzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:55:50 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C442658B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:55:49 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id i10so36826840vss.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 05:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680872148; x=1683464148;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vnr/Na0DANOY+4nAFsyUpDcPPIp3/Rne/9y6T2p+nDQ=;
        b=getku0wFCfhFfXIQsLQ68snTH5Euiw3Thaaqskfyox4pd/Ej/HDOxGjDJNooPx9BNP
         20VwZdAg5hw8zS3mMGBmNBNWahxbRXNAPg9P7dBz3TAE5I/PCjQT2Z/0xIjTtrkwCSnP
         2y2IQJJt77FcoLVmz/JYSg5umXLoHwURc5UHX/tp59ysmvjL1MwV5GKEBMBmJd2o0BXQ
         GLcRt7hn9DGedntPvhTX6535hTIO9MjYTTvdlUweKSSDgNWwpWfmrAoe2+LDawe8CTEd
         fxiuHsBABsKp57x0r8Oz47GuwMC1fHOecQ/3VKbB37qLXwnrHW8RQNRhEfCugTcswymV
         A6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872148; x=1683464148;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnr/Na0DANOY+4nAFsyUpDcPPIp3/Rne/9y6T2p+nDQ=;
        b=B76WyrXRlOZU/DI0eaawIQNvQZ+T3qcohNPLTJUklGwPmj0PJu6fTdotmy+PQuLiYb
         g7k/jiezQGzIqm+clF/NCrcI2nwLEEzUuHjpcVjaN/n3n8yZIhd1D96Ueb6/wLHtiP66
         E2nEqs4h3Ky5IrSVIGRa2nhhHMArgRqwq/HOVbHYjOhkZKq9Eo8x2g7eaUB7vTdnvnZv
         8vBM+6jOZrrJ2a+bAuFKb41N6U4ywrdgn3taYC+q6y1Mk6akPZ2cm4h48ohhneZ8LKf4
         rBqumUfRlY42WQwIQTDeKvN4DgLtHe8t3tlGPPRQlaPet7gE6+P2l5vZpjts8Qjh7v6i
         fk2Q==
X-Gm-Message-State: AAQBX9fwTf6txUmWZXYsqDQKPB7fuCY7VluKVnjKcT7B9JEbZ6Jpd37b
        snQ/Yw2FWoojYl5VwZlxv9u5vXwDq4jPTGfcQpI=
X-Google-Smtp-Source: AKy350anEflsHz+e7sHzt4bbstxMJfe3EU8Tj+36JMmWzTQH7p+gp/hRKTCcveDhuvMvZQOf5UAQTJKFhbYaOPWTneo=
X-Received: by 2002:a05:6102:5705:b0:426:6d5:a55a with SMTP id
 dg5-20020a056102570500b0042606d5a55amr1031771vsb.1.1680872148712; Fri, 07 Apr
 2023 05:55:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:be66:0:b0:3be:8ebd:82f4 with HTTP; Fri, 7 Apr 2023
 05:55:48 -0700 (PDT)
Reply-To: thomasjoycetho12@gmail.com
From:   Joyce Thomas <budejohn2@gmail.com>
Date:   Fri, 7 Apr 2023 05:55:48 -0700
Message-ID: <CANhjusd0SZQgcCA3nQ_+Nx7uV-+LJKWcmVg6R9ROLGZfvd_Sqg@mail.gmail.com>
Subject: Best Regards,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day
How are you doing you haven=E2=80=99t responded to my mail since two day no=
w
please be kindly get back to me.
Best Regards,
Ms Joyce

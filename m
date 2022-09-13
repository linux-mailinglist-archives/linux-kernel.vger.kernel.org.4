Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38C5B6B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiIMKXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiIMKXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:23:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A3557246
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:23:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 29so16859924edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=+IOkPYBVudVE123a/Rn57DKbqImHDs6xTaqKWEnTeaU=;
        b=YTAM1HJhcNX6lY53UXJdPGaOs7WE7S7pfxefPhiWz925EGDz1aW6CZ5SJnAR+vP6rE
         83HIFLZvgzn1o5tpWPcp07eQMv7Ck54+5iLq9VFNOSeSRt8Bn1QAUJOdnqiKBy7D7kyS
         j4n890NsmkpFIhPFJAT05DxNqOLyXg/K4M+hvsfnOjYJKhxvUZkSR9LbpjBsTZCSID1F
         sMC+6lMEY2/EPWiBdXjVQSU+VYgYtiCbSYz6t70K+MJ4g/zaIpDFTr0JODN0hbjA1GAY
         YjPSAJSZ2SnMU0WdLALulai3+C+dIoa17EJU95SJm0mdAxTW1hcEHSfni9/qonkVATgZ
         QrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+IOkPYBVudVE123a/Rn57DKbqImHDs6xTaqKWEnTeaU=;
        b=hnb2KRcjT4DUBgatQiT8GGrBxsmXq5XzA0T8RzItHEojUxW2hryRgaEtj72eCROQSB
         okWCkAU0edVvi5ku42WLLqMGULhAUbGYTRnMTXBUIvSmGRr2KNoU13dk9waTHovJYsC+
         peaE/QqopismSXxpX035JLJ6tvjGoSF8mOI+dyxJFaozi/6ze7sYWid24Tk5UUDuFPBC
         0BaeGXiLlsocYqw/VWwnf6dO80HTvjm6oEh/JXSg+G/73pfuAJ31+o9s0qDku2qJ5LiW
         0M1oMfmLrPZ0x47SDb38Mbs+FZc3o0QUALfTIvZuWhshLpqihOeguOAcs3I9yWQrEqAw
         Wvyw==
X-Gm-Message-State: ACgBeo02E9OmBGEgxDGVf9Fza+iHUQr6PYbiTScINLsKgYUCx7KjpL3V
        q9DaegtvO1z+RKNrj77mw5CPrxboAx2Q5s+UbBU=
X-Google-Smtp-Source: AA6agR6G1X5GPuWD3D3iercwcEkUc0j1P3WmIu2mC4Q+rkErFYz0DZelUTbmLCWrDbTtVggiHMIWe1b0Cb8SfykBsM4=
X-Received: by 2002:a05:6402:7c5:b0:44e:9319:4b26 with SMTP id
 u5-20020a05640207c500b0044e93194b26mr25583736edy.105.1663064585024; Tue, 13
 Sep 2022 03:23:05 -0700 (PDT)
MIME-Version: 1.0
Sender: oyebuchikalu29@gmail.com
Received: by 2002:a17:907:961c:0:0:0:0 with HTTP; Tue, 13 Sep 2022 03:23:04
 -0700 (PDT)
From:   Hannah Wilson <hannahwilson11254@gmail.com>
Date:   Tue, 13 Sep 2022 10:23:04 +0000
X-Google-Sender-Auth: 2Lgv2CL8sLRHxSC2HYObEAJLCRI
Message-ID: <CAOkQLHVUqmwP6=P8xcm8-6xU=prVwapzNpvRC=VLt8AP+kMyLQ@mail.gmail.com>
Subject: Hello My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello My Dear,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs.Hannah Wilson David, I am
diagnosed with ovarian cancer which my doctor have confirmed that I
have only some weeks to live so I have decided you handover the sum
of($12,000.000 ) through I decided handover the money in my account to
you for help of the orphanage homes and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my bank to you please
assure me that you will only take 40%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs,Hannah Wilson David.

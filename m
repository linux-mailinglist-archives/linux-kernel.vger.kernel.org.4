Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD346ECAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjDXLBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDXLBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:01:06 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3A535A2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:00:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517bb11ca34so3122800a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682334048; x=1684926048;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UZK6fcqmoLnvW0dsaCzsBmKBL0VVT0CUsczsN1Zw4U=;
        b=QZgwzf0uTjgviQayBIwyxrftEPY4U2Dd91lDBoM8rxvadp1iuMdtbMFV9DRsIimCI9
         6+T1aXIdmng7yqUFAfw5ShVn1vDIkIJoGnOvuO1w9jmkzmaTzBsN3OAtEkHplHoHxrP3
         Jfs4NbBIKPnPR9OhVgG8z8Tc8s3IeaL/+rqUylvm6m6MDi/CMuFmYgOYAjai00O82oic
         zdeli2pKPb8krANX2q0WHsu+lhiTkDWmJa6k7VjH8dm+I2SjCYUYy8A/3r/BR55hCY1m
         4XJJz0Kh1RUMsHaTgEqNIBtz1ynKJ7e5duo0/WxXiUqC1KM3WfngLzV7+uB4peiWTpOH
         2FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682334048; x=1684926048;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UZK6fcqmoLnvW0dsaCzsBmKBL0VVT0CUsczsN1Zw4U=;
        b=YcDBOc+KZ3OUCIJo2qAZb3pOVQpQLOAGmI/hSsfJDB92xszuM6rzW3AM+VGoa9pU0/
         v7TmNtY8Bh3+ARgKVNwRpWB5WzgEQacAJE4LrxvOyONhB7U9H2z55hvfJ6yGN6TMi+IB
         OHaYlV+8+G8LkBqsJ5xERBwhtj74JyN9OcvvtCa11pTe8AwZCgiCKjfDKiFFGxGfbRXf
         UpFPPtr0p80qmkOvDuyu2zDQqDBZqUY+Ls1SWc+jhSGgvCSZcb8MCIdpzasqG7My4TH9
         00jfiEMjL64V6gqTG5S/zmWtSXjuJWC/SD9itsqTC847Bgaa+ZPE42ffjvULfgIoSjW7
         DVAQ==
X-Gm-Message-State: AAQBX9eOrAyMNnl8WSwgWVeJPEWXxZlcMahs9zm9s/fjMHJvYgAGBrPH
        WSCDEhtQt8xRLQxB/yFU4CY4YxL+YdUYNAq1c6U=
X-Google-Smtp-Source: AKy350ajFH7g399xtIv4oJqMK+3f/tXs9HPykbX1zayjo/DUFgKgQFi7qaZq7b8rTXvF8+2ZIKeQYjmh+V0gNmEmSvM=
X-Received: by 2002:a17:90a:b38c:b0:247:af63:483 with SMTP id
 e12-20020a17090ab38c00b00247af630483mr13645905pjr.46.1682334047962; Mon, 24
 Apr 2023 04:00:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:278c:b0:609:8cb8:4735 with HTTP; Mon, 24 Apr 2023
 04:00:47 -0700 (PDT)
Reply-To: jennifertrujillo735@gmail.com
From:   Jennifer Trujillo <edithbrown006@gmail.com>
Date:   Mon, 24 Apr 2023 12:00:47 +0100
Message-ID: <CAHV__PoFd7u+1LkiDmsHojJGJA9YnxcGaz6oOoQjZ3uEbqfVAg@mail.gmail.com>
Subject: HALLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hallo,
Wie geht es dir ?

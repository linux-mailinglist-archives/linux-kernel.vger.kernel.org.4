Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7036EB8DE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 13:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDVLpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 07:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDVLpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 07:45:06 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D6F1BFE
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 04:45:05 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8a59daec5so23802391fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682163903; x=1684755903;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e2fI4p1pI3so2b6bQ/X7YEL5cKkaSbVraLHj6ERLpk=;
        b=WzEvC7/CEX3B/T0wmhrOsTiWnIfVEghCdmNDNnm7Wg1vhGzHHNtlRZtyjrIgbR04ko
         g/QkaPCxtB30Yj2vdh5u/mK/ZdOrELAELF7HjYkM2V1L3u3AOoY0F59JKyI6FJ+c4HbY
         ZndV+W5eRikTL55oeTC3BRSSg88UTdRqiBdfIjpBdHkWvLhEci34C6/uZiHzLgaJ53F+
         /3ntn0yUnPGNUsy1JGcvqSlZdeXVDxgaQ+/d4/nd8NSq+VCnCIijK23LBrWNMJcIYC3F
         uwdcEiSVB2g8EdD4yDEPvwb+NVxCbKDcb5vRp9hOLaF/a3T72/jEuA4ryVoYyUuUdExK
         P2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682163903; x=1684755903;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6e2fI4p1pI3so2b6bQ/X7YEL5cKkaSbVraLHj6ERLpk=;
        b=iT1rddBaBYYBjFIXDZqT5/JzPpfk9oYdjGquHuwlQ9OfUElBf2YTo7ShSU16FufBmc
         7LUS/zb6GsR35fIW62TUf12UPo36GRMIYOsZ8daRKyGLtE2/FeZBkRsFgzpWa8ycpHdi
         BIDu/eftAWS24vimCoUGqvwskDR19wYqM+vO2X2AFTE2HxbkROFEoH7aCR0r9Qvf0PuN
         4LCkqsGum9GcI8yU/3kqLp2fenzepjk8peVTOQZ0pWtIItLyyY07jUV9IFi2jWD3AH1/
         v8t5EulHCNGJ5DQeI91rGvOtd3Kdg2d2hzi0LbsfINjUkC+fkm7+MeuhScevh8ZRrPwP
         3Pig==
X-Gm-Message-State: AAQBX9cFh51N2fE+COn50fh5zf7pJBTGSzcoOeWDG5FRVAbLIhbVJ/Ae
        ERuKYeMdl1pt+JhDVygez5rQSAkUyQXmgGQU8Eg=
X-Google-Smtp-Source: AKy350b2rj+PCyu8w3vSrLAKEARlM5xoF2QKqVM480od5ukukEqfD1wajkite2xsEuEJ43Kmj6XEfH/e4vKe2FKprwA=
X-Received: by 2002:a2e:9b93:0:b0:2a8:a5b8:1856 with SMTP id
 z19-20020a2e9b93000000b002a8a5b81856mr1300580lji.10.1682163903323; Sat, 22
 Apr 2023 04:45:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:3431:b0:25b:7e95:d4d1 with HTTP; Sat, 22 Apr 2023
 04:45:02 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   wormer Amos <rolsbaraye@gmail.com>
Date:   Sat, 22 Apr 2023 11:45:02 +0000
Message-ID: <CAGkCXQjpWVcbWOCM4isjTRT4xUy1ZZAW+O7+EgMC5AkwwmcFaQ@mail.gmail.com>
Subject: Good Request
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My good friend. i kindly want to know if you're capable for investment
project in
your country. i
need a serious partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email address Thanks and awaiting your quick response,

Wormer,

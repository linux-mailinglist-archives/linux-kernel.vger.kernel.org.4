Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB9A69F0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjBVJEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjBVJEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:04:20 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E792036697
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:04:17 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u14so4086406ple.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/k2bZk3h898qo4BHG2NarX/QNDeGHa0qpnKbc5O6Cg=;
        b=Rt8sW1ClIDgUNVFxLzcgva1Yy7lGzSG5DXFXzNQ+eqyvqVhB7KsP99gFgfVv5wSGcU
         bueVJtdi7um4mWXxnc8hMtlqynqPQGDlVkx3nRuawdu64AQkULPJQmPfopcvO56/ru8V
         kDdM86HS7Zk66bbivcMAIZH26WDn6g7fiqhvPJbzkTc8MSx12b2vlMBTvAHJ0c3YS+Vc
         cPZj8jMiClaz6iQjTtblSevf4XtTk87Q3g8deK3eS274FSHjr5jzuUwh0xMa4w07PJdf
         qjMaVJxrpkdZgXB2YZcGvioWBlrXsXEU+Elovy8yaCkPRT8l28lsTqsZ4A6jhZzqLIVj
         FPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/k2bZk3h898qo4BHG2NarX/QNDeGHa0qpnKbc5O6Cg=;
        b=78sdCe616OfsibnDrchpbnPqK+Jo7O2l7ZqbD+koysHGqmtpF5xhkFXhyb+Kidj8MD
         u597VWAxjiSKNDjTt/A9imfyxr4oBHASE9on7iXcshA/Ps5IB28rgUTkMoSfXYHIJZFh
         cBEPep09R5g3h7Em4wQxvcR8n5iBZ3fQpL9gHQ8L0EhLuK+9cBcH/tawFiSMcKI9IVtu
         CEaKjhfdr5UfEW8MNZbjSTDlyaWrfjCSIkkncJp1cIUTGHOPFhNI/qNqLjRgknOGyDFR
         MgsbGCMqVV/vePsnnsUjXAiatukMepqKjSOR37GN/RHexF+Zte1+AjohrpjF0J3rBGEb
         3YmQ==
X-Gm-Message-State: AO0yUKVOU/B0n3zP07gPj9QZ8wqBWp1JzX5GELJvg4KFxb8GMNXXRE6a
        0X+TAVDKr5y1FZlVlHfvOy25rqso0D4qdITZFmk=
X-Google-Smtp-Source: AK7set9M/KhyeSnVPPt7BD0ppoepq17ZhhJB+MgC8Mbj+Ms7qC4rf0S4hphZ57IOegecXd5/3JEeNhr3ZcqbRpbHCr0=
X-Received: by 2002:a17:90b:1e03:b0:233:bc13:2cbb with SMTP id
 pg3-20020a17090b1e0300b00233bc132cbbmr3132264pjb.39.1677056657419; Wed, 22
 Feb 2023 01:04:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:a486:b0:419:7fd:e8b3 with HTTP; Wed, 22 Feb 2023
 01:04:17 -0800 (PST)
Reply-To: sgtkaylam28@gmail.com
From:   sgtkayla manthey <abdulhadiidrisabdulrazak@gmail.com>
Date:   Wed, 22 Feb 2023 09:04:17 +0000
Message-ID: <CANEyRew1uo2aY1izyPyggxHy2zqY_GQDN-bKX=s7-vqpABx_aA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Zdravo,
Molim vas jeste li primili moje prethodno pismo? napi=C5=A1i mi

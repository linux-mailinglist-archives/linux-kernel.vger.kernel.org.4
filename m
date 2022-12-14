Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7164C1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 02:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiLNBXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 20:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiLNBX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 20:23:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB917A91
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 17:23:29 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so5527410pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 17:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbxBc33A94M2aID6Eun0OEflR/h/t0nbS2BADxZCW1I=;
        b=aKt35Oe2/IarWAz7dww9HuWdIuJLp57XYVDWd1qM9/UZML/I+UZyC3oweCQ5Iyu97Y
         Jf55mRSiBtZsrw6I30HV3zOCA5aebuJ25VWDLCpz3/1bT25VyEkgOw+0uYb0MqMUBmaQ
         4MUE9VBtqahMq4VPd22y0F55XSgNn5aPiYo54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbxBc33A94M2aID6Eun0OEflR/h/t0nbS2BADxZCW1I=;
        b=q0eVpk/g7tiG5qXBQLibXaKBnELOm/m7T/N2m/kFDMQ6aXYkjJL+WXX59JDHLYCwxM
         m8+5Z7YDRM8iEmuO7QhV/xDvPdIjP5loDc/qiHe6fHFXettaUm4tefQQTt5EOmYSVh9Q
         I40UTdpj6CSlx6stzNOSrETPb/MAYKYak+MQflVcMGUo34+mTkVoA5UKUQAkdyhxNmcZ
         8jF2Q7iqFr+x2t/yB+S8MV94g/8VRKeMSADd08eop48XPH9W9DNbr1yyr6TYSaBg6QM2
         pJdZtmEc1cVvBD45y5P5cG9ZSRa9t4jEN69yAzHnJ4YXuM2hbbiXPyS6kvSMvrZ9TQra
         Hziw==
X-Gm-Message-State: ANoB5pmoJNG5mrXG+sTrPPLbPsv9M3gkPOUcmDu9mUIm35EDJLwt+gVE
        ofF1vm+0Fbp2mOuHLjIDTy/RGDph7ogoNnOD
X-Google-Smtp-Source: AA0mqf5Ho1Q4XXNGQaB6DvKwitZGIHYF3CeIeWRSMM/mTUZuHv4spseFwbPkn0XQwTXj32i5Sv8pIQ==
X-Received: by 2002:a17:902:d717:b0:188:fc68:d366 with SMTP id w23-20020a170902d71700b00188fc68d366mr23462157ply.40.1670981008962;
        Tue, 13 Dec 2022 17:23:28 -0800 (PST)
Received: from jingyliang-input-linux.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b00176a2d23d1asm537423pla.56.2022.12.13.17.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 17:23:28 -0800 (PST)
From:   Jingyuan Liang <jingyliang@chromium.org>
To:     bagasdotme@gmail.com
Cc:     benjamin.tissoires@redhat.com, dtor@chromium.org,
        hbarnor@chromium.org, jikos@kernel.org, jingyliang@chromium.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        seobrien@chromium.org
Subject: Re: [PATCH] HID: Add Mapping for System Microphone Mute 
Date:   Wed, 14 Dec 2022 01:22:22 +0000
Message-Id: <20221214012221.3559254-1-jingyliang@chromium.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <Y5f9wmKPQrYYFGuz@debian.me>
References: <Y5f9wmKPQrYYFGuz@debian.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the comment. I made the change as suggested and uploaded another patch v2. 

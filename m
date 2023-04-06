Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766DD6DA598
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjDFWLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjDFWLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:11:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386DEAD08;
        Thu,  6 Apr 2023 15:11:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a5126f2518so281935ad.1;
        Thu, 06 Apr 2023 15:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680819102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig2j9q3aAOVCQfCvRLVncYPX5OlaQ38a/pqikiP3erg=;
        b=OsTTgGfnHHH1TxscBQB9SWado0vEhEMDraf0PVaZq328U+EUc/S/wbqdx5zeaLoUC5
         ky+5x9sfxc53udkiy+tIlxFZFyZPWz8TufbO//6BoL5/pYB3clDOk5gDupUShJ7H/jFO
         XW5YlsReCXXbtv8qTp44j1VJeG435rLnoPo4VtyY50hGxb1QeRJxBRQKOvpWD/75Otn+
         LB4xwbGTQMccvu9Kc7LBq7NlwachtUJzQFIDUGqkz4Pffrtz0gGsBcT6Si/y1GrEVf8M
         ABU8ojVPC1TxCVwTxLvamidc+pw1DmJU+2MnPfZfUUH9ulWIGG40wUJrYVuKZpXwoJ4W
         8Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680819102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ig2j9q3aAOVCQfCvRLVncYPX5OlaQ38a/pqikiP3erg=;
        b=RIdo9D1dHUiQbthtmi10R7kAO0Trb6jIDbNNYKnd5j7pgjqqox1+D9P9BN57IIAuiN
         NOJGnmMdYZWlBFe23sc24bGJ2iisQrIfHs0ZmFDRNNv4WsYTtb1g5j5cLwbnVIJBMlu5
         5DR8VMrhHUXP/3IXNS4QVdHTkl7wetLICghI6yyIMoLB9Gac1kxxUv1gNksJMMDUGXNv
         nagODhxmNmx6eXuhcV071HslTXWnKVHFLi+J7sJI/xKY6d1ILIxnnO7Bul2QlOM02oiW
         b23cFjZiy1BsfJY45x7/BMJ/RBmTzpGxFDhe2LVMxPNZx6FZnxtLp4mM14AsETbefV+g
         4OqQ==
X-Gm-Message-State: AAQBX9erWEEtiegn/qFNHVUllOUEb+9ielQyMFk+UWm8rTrsSvnemUe5
        JthxnzHgMSg5N0uHitwzk4M=
X-Google-Smtp-Source: AKy350bb+gVIZ1rG4JJ3Lwm3aJIH0FKn8eOKdwz5o2qclXtCgbefVfJWkWCvM1Ebe1vooe+xyxlNpw==
X-Received: by 2002:aa7:8f02:0:b0:625:7300:5550 with SMTP id x2-20020aa78f02000000b0062573005550mr303434pfr.31.1680819102651;
        Thu, 06 Apr 2023 15:11:42 -0700 (PDT)
Received: from pavilion.. ([2402:e280:218d:82:a082:a1e:6444:f6a5])
        by smtp.gmail.com with ESMTPSA id t23-20020aa79397000000b00627eac32b11sm1788849pfe.192.2023.04.06.15.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:11:42 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, danascape@gmail.com,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, robh+dt@kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: wm8523: Convert to dtschema
Date:   Fri,  7 Apr 2023 03:41:35 +0530
Message-Id: <20230406221135.4761-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2c32b1e0-20f7-4d9f-9dbc-8725562e456e@sirena.org.uk>
References: <2c32b1e0-20f7-4d9f-9dbc-8725562e456e@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Having a single file for other manufacturers, wouldn't that might cause issues with finding them?

Kind Regards,

Saalim

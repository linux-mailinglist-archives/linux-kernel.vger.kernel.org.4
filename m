Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF26D07BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjC3OLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC3OLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:11:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB43B3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:11:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r29so19206661wra.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680185490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suzBhYGEckJpiDnidEm8UQbSBjCPRce9GnZilv1Z3Sk=;
        b=CDHvrnewhzU2bDj2QxJ/1JEUE1icAzUTwPeXhc99jWN3pDvmcBH3G7v/mVLl2BGIi4
         Py3Cdi9JQE5UPkM6UB7yE8eYKOwfWLLmF0sbkaYbY5XOi95XDHYnM1Yg5Gz6bQXHAqDN
         Z4H4cYw6yItdRsHQ4vzZ4b5HGU7vjU9Kl7nrhOFuycWr10H6p2cDpLyOlRJLMhVSGWvD
         9ctZSg06op0wrCBvJyYmUxnUPxrVY6OS3iQ1Ocsu1oWvCM4vf2KZUVlIPxZ0PDd0hukY
         3c2jHh+SfgIG3eYcUxMHzmHwtW41FigkG9mU5lUWCAt4SCCBDtES7uQz/1XrUdFTNy2d
         R6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680185490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suzBhYGEckJpiDnidEm8UQbSBjCPRce9GnZilv1Z3Sk=;
        b=I/RPInOwdEiUkq0nsN2BNp56rCaEEeGJ+RT41vfc02JpJ90715mGSm0yKpccoz8pZn
         dAD/VQP9xx016PRjLar6FlFiRBXCVmCIInO29NHjI4a6BLTbCTGCFHDYS8VgEaaRJ6ZF
         9pNBA8UCbXikn/H4nOx7tnUaasyt+91cSD7vxQnBNFvCqwfJu52NM7ACGnozULptanod
         2doWvyIRG1e2sjFIHCr2UhsUpUgnzT2Y1pvZ23gTHn2iiamiiQtMvwZqL6rqFSXZVd57
         Vhk6nHpZT9kP+0VMyn2En+i58P2YnC7MgDTA2MtvTnBnM7Fr5fjVTQnAhHK3DJeOdjdC
         CtZQ==
X-Gm-Message-State: AAQBX9d8RJVKSo5XuIpSXSE1drTCFZ2sA8/TI4prlUPI+2/Sr9t/TUwl
        tcO+VoiqUCcrlqBg6cktdGY=
X-Google-Smtp-Source: AKy350bro9ZzpIVJRHW9Gvn4LewJPSesVpqGyWOYSPIH7E/0ujl20zY5nVejXjg/5v17iKNiuhUA6g==
X-Received: by 2002:a5d:63d1:0:b0:2d5:b6a9:772a with SMTP id c17-20020a5d63d1000000b002d5b6a9772amr18420910wrw.17.1680185489816;
        Thu, 30 Mar 2023 07:11:29 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id b5-20020adfee85000000b002c573778432sm32761705wro.102.2023.03.30.07.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:11:29 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     hvaibhav.linux@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] improve arche_platform_wd_irq() function
Date:   Thu, 30 Mar 2023 19:11:23 +0500
Message-Id: <cover.1680185025.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Improve arche_platform_wd_irq() function to minimize indentation and fix
checkpatch issues.

Khadija Kamran (2):
  staging: greybus: add a single exit path to arche_platform_wd_irq()
  staging: greybus: refactor arche_platform_wd_irq()

 drivers/staging/greybus/arche-platform.c | 84 ++++++++++++------------
 1 file changed, 43 insertions(+), 41 deletions(-)

-- 
2.34.1


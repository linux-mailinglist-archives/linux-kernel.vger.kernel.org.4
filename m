Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D6D640C21
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiLBR0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiLBR0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:26:14 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC6711145
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:26:12 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id d20so7431534edn.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=cMIEC+/8gNosY0ckhHMIkQhSMNNRlILZApKp3aKWkGk=;
        b=ZFv1dqJrGN+88HGF5328gY5aGuDl++9QYQHXkAwVOYw9LZPRkFdvZYtFRIRpPmhHBb
         t5NJtTCrjrm1W/ixCcxFXKv9McvWY4fUw/+4XsvGZBFSAZiqyhc4QTBiO4t0X03TATCF
         5KRuAsGxr7Ac3PXPCNsC6GV7wL+soeg8/eys4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMIEC+/8gNosY0ckhHMIkQhSMNNRlILZApKp3aKWkGk=;
        b=aVCJ+SNQphVoeQfmOPJRoNyVX0OyEX065NZEGvjgFnChNAPsbioA/Nt9ZZINWQOkXZ
         FAP41VKa+HK8FcMtFrCP0sTDl6VDJLcFQLxf2FJGioPlGEtJNR+xfuEe3ElLurb/qNQE
         iTheufMINJTSHgzPIsYoZroNx6tWRmYG1WcK1bhWuYa2gUEWYeNSqWGrBRdHXZku4uYP
         PkHP0RVPN0NFEDA0NWV5756UZM9pzpKUaHZtO8kYFoWV3eJ6M3de/DHEQsm2gedczscx
         /4rdigJHMYyE0rgH+IWFFmyAyjyVLxvituLDamicb8YdCJ2CBP3pGe3YffZCOS5e4nai
         K17A==
X-Gm-Message-State: ANoB5pnfbaxu0/F3UmT+4raltMPcLjzFYgsHFRfBZlzMhLtPZeOsTeHp
        IlkLLx6A1fteIn18ycJNvXiTGg==
X-Google-Smtp-Source: AA0mqf50mIO4md8hTYtU2u+ukjAOIuR1Mdxj17ANZWY0LhqPqbyN23e82n3Anx0TSrJMtonRxHTgJw==
X-Received: by 2002:aa7:c055:0:b0:45a:1af2:ed6d with SMTP id k21-20020aa7c055000000b0045a1af2ed6dmr49338379edo.364.1670001970834;
        Fri, 02 Dec 2022 09:26:10 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090653c900b00782e3cf7277sm3202546ejo.120.2022.12.02.09.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:26:10 -0800 (PST)
Subject: [PATCH RESEND v2 0/2] media: uvc: Get menu names from framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:26:01 +0100
Message-Id: <20220920-standard-menues-v2-0-323be5539c22@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=VMy89JO7FygCS8BFCye9k25GaVr7pUaGnXwG39WZsA8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijUrNQnsXT/uQHFhYwg011uDBmLZPtkOnKpQyYM7
 NFaUQpuJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4o1KwAKCRDRN9E+zzrEiHhFD/
 9yq2cXKngNwXG5PP57o3AlUfHk3Blqe2A0A9AG116meFK4k2aGYLxhcPXcxcrDmtmH9gHkdt2TMpV2
 s99pJdVuaWxr8Jh0sUipHwQDamgQYTp+JUthF1syG+xFByhrOgDt+JXk+firiOT3qtqsXvAKiv8QJB
 lH1DQ4x26ucKdePio7jyGReGF6I6lTRjjfSibJW9kmalOXxVikE/qPs63f5XGvVvx+yOs02apX4gCf
 AM+nvHDyqE6FVwg4KHN236r/gio9nL+tAPS/4syZYYynNbRa9yWzACO0mgFyibav7GqwEQhcB1qiGU
 NobqdcfWvEnL+UCrqWBK/zRqFNi0ROiNDTo8IjBnx9fe1VCVOyCmpJqYe+i6/Yk5SvSsLb41qGhDhk
 L+4rmgW/ZhieIZarcbXfKpBT9BsyQvgLAPz62k7gZjm5TnA7YpG9DeHgu9cOeKpdhzBt8/IAaBB7mJ
 WpnW6s2NqnsA5ir+iOBJEtBReBxGTj/SuOlIk8ZYVWwDTgi4f+E+0h4J2O1HwHKnzizSoh1JYkLXtj
 sVJzXU28g06pY+G7MdTc7Wg3MTlo6N2B5bf5KkNJFyivFrBBney51IU96TeMQMrtuOEwWCQeGH4NuM
 AJNsaMUOGhcBgLmFaYhmV1su1sUICJC8wm2p67ym1S1x+CYXrdLYEmBhGjlg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not have a local copy of the item names. Instead use the ones from the
v4l2 framework.

To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v2:
- Remove unused variables
- Link to v1: https://lore.kernel.org/r/20220920-standard-menues-v1-0-839799192e9d@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
      media: uvcvideo: Use standard names for menus

 drivers/media/usb/uvc/uvc_ctrl.c   | 136 +++++++++++++++++++++++++------------
 drivers/media/usb/uvc/uvc_driver.c |   8 +--
 drivers/media/usb/uvc/uvc_v4l2.c   |  81 ++++++++++++++++------
 drivers/media/usb/uvc/uvcvideo.h   |   5 +-
 include/uapi/linux/uvcvideo.h      |   3 +-
 5 files changed, 162 insertions(+), 71 deletions(-)
---
base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
change-id: 20220920-standard-menues-6d703c57f231

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

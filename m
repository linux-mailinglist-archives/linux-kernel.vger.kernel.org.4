Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6645F21BF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 09:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJBHsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 03:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJBHst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 03:48:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8989D2AE0A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 00:48:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dv25so16634904ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 00:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=0dNRhCSxZQZOUnB6Mca/lUl2hW+899dkk7Na2MofKAk=;
        b=C/0Jq7xROQ51ihfdxPjdc3glRbvRcKbubT4hBv+wYUU33uKMWwOsG97DW6xaz52lKZ
         wH0Bu0m41vUZYFw4SU6FSMeAiIdokcHN3dGdCeqEoQt8BnDXWdQlEBSOEiQB7jzc/d5Z
         /gwg0hhTsehuBzmeYgBsQbY9XmJHIf4iU8BttBqmDXQNeVcxlWcx2j7rXeL9H5fmvjBD
         eEmSuIRP0rV3ZAbWumaIZUbxGXg4/Kwp1nSXXQYRzYT+hOjEDW3v2aZNCZBCIOYUP1WA
         +QnxW7IegvpgZzEv2DaR+HSYoaCNb3oEykRMwpisF1Lyt/Jyoksw2cB6OL5bHiV8U2wW
         5fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=0dNRhCSxZQZOUnB6Mca/lUl2hW+899dkk7Na2MofKAk=;
        b=nWr8Db60eCupw2kVEWFuJvbFHtG5a2V9dyjepUL9Kgfpq/7+8gGpQX9lyDDxB3ou81
         z+P79U8czkAoFu6ML1T8kO9r4AmTAlA8mVXG6CC3gSSzRMVh6lGGVQ3IAQV4gKM2pPAi
         5pE/QoGzNkwgJ/JeFFvdc/RcW0GrO/GGUnGVVK1sf/iuEgiCzgpHKJS4+5yUUeCygcaE
         sOggV+IqbphxrPuQI7d0EHtzS4miOzdZMoYJZste1RVvBqmw0dcttylqPRJ/IkIH2ecy
         CstS7dzeag0iKD6dHZn6lcyncclR1A2r0EXFjHEsJ8T+SmyWnudV2d+ZzRqQ+QkCPYHX
         chfA==
X-Gm-Message-State: ACrzQf3luh8IHQp7JLaexszN/MtpnZ9GDz3imXYVyUsJt9DM8AeaZSfn
        xf+5vEkh9YguZ+XMZ1Qpo8k=
X-Google-Smtp-Source: AMsMyM6tO4xmLRAL5tSCnBeYaXZgNzIEE645zLzYTeibyQncrZI8/h0orMWdLzDOS5hIflKPQv2Y+g==
X-Received: by 2002:a17:907:16a5:b0:782:8fd0:88f6 with SMTP id hc37-20020a17090716a500b007828fd088f6mr11693692ejc.476.1664696927152;
        Sun, 02 Oct 2022 00:48:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id q26-20020a17090676da00b0077ce503bd77sm3608536ejn.129.2022.10.02.00.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 00:48:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: some cleanups
Date:   Sun,  2 Oct 2022 09:48:22 +0200
Message-Id: <20221002074827.8566-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch of this series merges leftover macros in odm_types.h
into appropriate other headers and removes odm_types.h.

The other patches convert some functions away from returning _FAIL /
_SUCCESS.

Note: Converting _rtw_init_xmit_priv() and _rtw_init_recv_priv() away
from _FAIL / _SUCCESS is a bit more complicated. I am going to do that
in follow up patches.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (5):
  staging: r8188eu: merge odm_types.h into other headers
  staging: r8188eu: convert rtw_init_evt_priv() to common error logic
  staging: r8188eu: convert rtw_init_cmd_priv() to common error logic
  staging: r8188eu: convert rtw_init_mlme_priv() to common error logic
  staging: r8188eu: convert _rtw_init_sta_priv() to common error logic

 drivers/staging/r8188eu/core/rtw_cmd.c         | 16 +++++++---------
 drivers/staging/r8188eu/core/rtw_mlme.c        | 12 ++++--------
 drivers/staging/r8188eu/core/rtw_sta_mgt.c     |  6 +++---
 drivers/staging/r8188eu/include/odm.h          |  3 ++-
 drivers/staging/r8188eu/include/odm_RTL8188E.h |  7 +++++++
 drivers/staging/r8188eu/include/odm_types.h    | 16 ----------------
 drivers/staging/r8188eu/include/rtl8188e_hal.h |  1 -
 drivers/staging/r8188eu/include/rtw_cmd.h      |  4 ++--
 drivers/staging/r8188eu/include/sta_info.h     |  2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c      |  8 ++++----
 10 files changed, 30 insertions(+), 45 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/odm_types.h

-- 
2.37.3


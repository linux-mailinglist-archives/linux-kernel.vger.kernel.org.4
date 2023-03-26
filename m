Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596D26C9423
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCZMSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCZMSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:18:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEFF6A58
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:18:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r29so5905775wra.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679833112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd4rewnz5GlJ06k4IoKBrqc8s7fRp6iu2hXRsnNCoq0=;
        b=WZBNlXxuFMOGJNSUl8DwXisSvTn4wUNCZ1YKpnx0fzFfIe1pxgFHbTVZ2VBjY3inMw
         dlPpqiHSbpxpUyYgx9lBYIMHUZiI7ipOLdv/KwMdtiNkV6DXkxKUd8tGeymCRslwmglh
         JIc/qxHPQt5hJlqrQhosEylU+vHRlNQROg4Od1e5T9gW3dGpelrMAnZO7KFezxLqxIna
         qsHFgLc91K0fGNVbCculs17si9t0XoSFcljMlJQs+T4zvPod/DFXK0MRCOQ4AIioFv7q
         D6s4ax287nW6My/oxOMKlSyzwVjEE7GE8dqyvJH33JVQMzpOcBKzD5uFYkZvg2ATo8zC
         MUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679833112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pd4rewnz5GlJ06k4IoKBrqc8s7fRp6iu2hXRsnNCoq0=;
        b=BsCGyOR3kb3qG7peZtkR2XTrNqN4ZjjlV+SHUiW0fvVoEaN/KZFkqjUsrCyOGL01Ru
         NmwxlTghYiU1Nsc7NYMhNod8Up3ysMIQbNDSHXhVN+gxxfkGOSJ1tjI/wkzVnnZYDlT6
         HhUA5l4AqrAmE/Q/r2c3hQ4Gt7v9WyTcoonBCspax2ksPkDjITdqVYlWK3blxirlr6d3
         mmBxaUQ+AlcviqSYEFLRpzEiNHaXvDQ3C5KHMI8ncWrG39N7RxhLATEYwileLYqtmMV3
         CvCN+D/xaAVKZ4PbKjV5FrtiMOM93b85PAqdBQYpCq11tp1tto0dKQWHhXu7/C6pF0pO
         gGOg==
X-Gm-Message-State: AAQBX9cVaEqWnvOJTRcwEFrTq0Wvy6iGpxvYEFzON3+7usLaAlHnFyWQ
        mp6Vzx1KHhDF/ZgIeygomAea0mxnDd4FQw==
X-Google-Smtp-Source: AKy350ZQIrHSK/MQ9ecxe125E2gx6RDqu8jh6q7NAvJnvvLW/AkMqjHr/9zTp8or4nBMx75AOicjCw==
X-Received: by 2002:a05:6000:1b01:b0:2d4:496a:5eec with SMTP id f1-20020a0560001b0100b002d4496a5eecmr6740111wrz.34.1679833111563;
        Sun, 26 Mar 2023 05:18:31 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id d10-20020adfe88a000000b002c70e60abd4sm22740265wrm.2.2023.03.26.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 05:18:31 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] staging: rtl8192u: clean up comments in r8192U_dm.c
Date:   Sun, 26 Mar 2023 17:18:24 +0500
Message-Id: <cover.1679831899.git.kamrankhadijadj@gmail.com>
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

Clean up several comments in file r8192U_dm.c

Changes in v2:
 - Remove the 'commented code' and 'revision history' before
   reformatting the block comments, as suggested by Greg. There is no use
   in fixing comments, only to remove them in the next commits 
 - Patch 1: Changed the description and removed extra blank lines under
   the change history
 - Patch 2: Changed the subject and description 

Reviewer feedback on an initial patch suggested additional cleanup
comments. Link to the first patch:
https://lore.kernel.org/outreachy/ZB2a5zwYpBZ%2F6qwU@khadija-virtual-machine/


Khadija Kamran (3):
  staging: rtl8192u: remove change history from comments
  staging: rtl8192u: remove commented out code
  staging: rtl8192u: reformat block comments

 drivers/staging/rtl8192u/r8192U_dm.c | 206 +++------------------------
 1 file changed, 23 insertions(+), 183 deletions(-)

-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3DB6C68E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCWMyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjCWMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:54:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F16D1E1C2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:54:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x3so86063028edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679576066;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pX52XM0zRvUzVxvJJ0vn8RkPlcGXAVjIMg1ZZMuVw6A=;
        b=JNckdacg1naHJJkl0VIq14SjtKjI4d63MZ+jHy+9Ys+WdpkJUXqTaqoNNydpBpFhEI
         Xlod7+U6dj7DELQWKUnQ2N+WkwmkRpqDybX9hJBYNVi0DwHRjARahW0xHBf8OU2x5Tig
         SlD4sRcQIIhDGhuRVGY+9cH88H9ZL6j5OdozW6P2eC7YoMo4L7ldxQBneWTrHC42XONL
         S6hnmIg9+yLDICpPDZfKzISHlpHktiPeV1f/+P21cCgtQgFjXuiKhR8235ZeKVMYFA4H
         wZcUOgqMwT5ASlVIO0gx7p2V27Fv6bLDYPfsux+iVDqBiW4wGpODd05s+eE7W+mrotGE
         gydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576066;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pX52XM0zRvUzVxvJJ0vn8RkPlcGXAVjIMg1ZZMuVw6A=;
        b=fiUnt7RK9OdXWFxdeYARlQcR3BqSPVguOWrxMedx67yBoPFOvCo25Z73lVxJpO5B8O
         sxz5lvduR/+xYjI49laugEXNPyrnWT6VhxbFSY6ROOFV53EDtkl0E+N208xYxuPq3HAB
         +JDqjDFe5SyxmfnyCideltE3L37IbA2kvhdlsYcb+VTe2rCU2dD6+06JsM/AiNcplyLz
         A99IKy659eBYRlN0Q9XXXCERgYVwJHhmcqiXWpWeRHUjaitXpBXga7eWLHtFFUGXE5kg
         avHrdDP8BYtKTmUABdBoKMaXYck3qDw7ZZ6mBzk1BHMd5qqOTtoVFJtT7yeDxAfqYuxr
         370w==
X-Gm-Message-State: AO0yUKUFx+ymx5a8JlpzPTAM2aVi32I0qQh0CVC7qKplHBgzhJTYSgek
        Sa5zZv6jsBdGWybezgcRXUAuSdqe/ofvd1pw
X-Google-Smtp-Source: AK7set9LMVxJwJZSdfFoOY40GVCE/+x+i218n9wj38CKV1SocCzpXyDCtOnuUKGr2eFBVVftW6Cytw==
X-Received: by 2002:a17:906:a855:b0:931:8e8c:2db5 with SMTP id dx21-20020a170906a85500b009318e8c2db5mr10764233ejb.69.1679576066318;
        Thu, 23 Mar 2023 05:54:26 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id z3-20020a170906434300b008d427df3245sm8664896ejm.58.2023.03.23.05.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:54:25 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:54:23 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] staging: most: fix line ending with '(' in video
Message-ID: <ZBxL/yqLU1dEQlta@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting function header to multiple lines because of 80 characters per
line limit, results in ending the function call line with '('.
This leads to CHECK reported by checkpatch.pl

Move the function parameters right after the '(' in the function call
line.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/most/video/video.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index ffa97ef21ea5..6254a5df2502 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -365,8 +365,7 @@ static const struct video_device comp_videodev_template = {
 
 /**************************************************************************/
 
-static struct most_video_dev *get_comp_dev(
-	struct most_interface *iface, int channel_idx)
+static struct most_video_dev *get_comp_dev(struct most_interface *iface, int channel_idx)
 {
 	struct most_video_dev *mdev;
 	unsigned long flags;
-- 
2.34.1


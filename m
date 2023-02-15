Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562CE6987F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBOWea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBOWeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:34:03 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8556C43935
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:34:02 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id j4so8573iog.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UkAnigxc8vfiP/xy4xUkyYLWp1v2oMPjYmrZI7ozKg=;
        b=fNhSR/DpdhPdDoI56A3EhCdY7JWbS58+aiEICYVlA7gl+AWkUTNbIG/atjNRcl+sje
         lyIqK6JaonmY3oxhEbmQPSEmpM0sQJdCA79+tz5MYxEs4BBI4xZSHObsXn9o/f+ekcvK
         +jiV7lGBfGkDEmPwMzlaSo6sNkVwuy9caydNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UkAnigxc8vfiP/xy4xUkyYLWp1v2oMPjYmrZI7ozKg=;
        b=VHVHVPY9KdaKW5r5rcxOc/DJ2nKyjnEpe+FKURkbqRm9d3UPdpAo57iuZC/jsB9sr6
         8P8ruTxl15+xcPT7YuVyJwZJkd1V0VRKLLdg9PPwMwdd3PHM0VeUNQv8BkxDBenJnZnW
         dtEd/gdaGD6FIY/1VTAFrRqc2BkEsgiRlBMSIGGuXEWDLsh9EUOnETblkeGG6tYVKCYc
         SJ84abZVOMKOe7Hbnw8cycg2ZvaE/ITESEJ47FWMiufhraAW3mXugLRGbVH15vjN1lkv
         1ilXOubkyICW1HNXtnznkQey9fCwA1PemvdwtaeClLmbFVAXIkUjRYpTq9J+MSJ8QTTq
         ukUw==
X-Gm-Message-State: AO0yUKXn3WGylQ7iRvqzR74bl6mzDft3gW6gtfCV0C/3qPXEei4DE9lo
        GytEtKTDCRLHQqGSOPaFvjWJ4nMsJOU0sEc1
X-Google-Smtp-Source: AK7set/e91kNoaIzB6xxvRfuTyHdyHPXybCM8qCEGiQAIuXpdlJLh2rV23A7rHMn8ApT6OzRpPB0MQ==
X-Received: by 2002:a5d:890d:0:b0:71c:cf2e:92ec with SMTP id b13-20020a5d890d000000b0071ccf2e92ecmr3047559ion.0.1676500441795;
        Wed, 15 Feb 2023 14:34:01 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:6299:179b:a6e4:be59])
        by smtp.gmail.com with ESMTPSA id b15-20020a92c14f000000b003141eddd283sm1131489ilh.22.2023.02.15.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:34:01 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 6/6] tools/virtio: fix typo in README instructions
Date:   Wed, 15 Feb 2023 15:33:50 -0700
Message-Id: <20230215223350.2658616-7-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
In-Reply-To: <20230215223350.2658616-1-zwisler@google.com>
References: <20230215223350.2658616-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to have a unique chardev for each data path, else the chardevs
will collide and qemu will die with this message:

  qemu-system-x86_64: -device
  virtserialport,bus=virtio-serial0.0,nr=2,chardev=charchannel0,
  id=channel1,name=trace-path-cpu0:
  Property 'virtserialport.chardev' can't take value 'charchannel0':
  Device 'charchannel0' is in use

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 tools/virtio/virtio-trace/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/virtio-trace/README b/tools/virtio/virtio-trace/README
index cea29a2a4c0a..0127ff0c54b0 100644
--- a/tools/virtio/virtio-trace/README
+++ b/tools/virtio/virtio-trace/README
@@ -61,7 +61,7 @@ and
       id=channel0,name=agent-ctl-path\
  ##data path##
      -chardev pipe,id=charchannel1,path=/tmp/virtio-trace/trace-path-cpu0\
-     -device virtserialport,bus=virtio-serial0.0,nr=2,chardev=charchannel0,\
+     -device virtserialport,bus=virtio-serial0.0,nr=2,chardev=charchannel1,\
       id=channel1,name=trace-path-cpu0\
       ...
 
-- 
2.39.1.637.g21b0678d19-goog


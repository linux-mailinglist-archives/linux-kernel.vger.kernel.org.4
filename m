Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC486D6A60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbjDDRWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbjDDRWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:22:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9233A55A5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so133630961edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsfRezrkWzcgntEuPXChWork7/N3Q6fPF9s7UG+klPE=;
        b=u3p08ZoFywIgI8Ewqi/dWG7aOYhJvA8jyprnLLPiQa6zZwFAuqKigqCLYgqHJ1PLKF
         KTxEG1T/vWUDX3rYAkBI6c0mJsmfHPY4Br6WABD7Dmc0Mposya+CenNMH8bzAKbFDZxi
         mzyeZq4KoEfJUpZBIuddA1jQDVetktH3At0CXOXjoQF8ToAXaES8moyezsZONndIsuhl
         RP3v/KNSJmfPhR0inN3qP+mbeOpqRp94w/YwsY2f78XZxl6XWFThD438IhUwDu0AWVRg
         LqyI1pJ9DVwQP3SMphK1LaRT7da5i40LbjFLMZtcVBqhIwY+GsnuJ7xJrAtheyd41qyT
         LPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsfRezrkWzcgntEuPXChWork7/N3Q6fPF9s7UG+klPE=;
        b=MRgMtuTpNuorXCRW6K9kvd4SdUSCSdITAY3lc2qSBRHA3Np8Ln2N1DuMEQUT+X8IbU
         pHuOF8mpweqGb4u5ovLF0DpOWGe1dquiojgTz8tDHWdJnfpHx20I3XtChMqONmrhDn+C
         mP0SdTxBYpyiLaZkRZqb8ZP/bjZcBMe+SgT/nzPiO0jvUTkqwNkofgQ1ujuycI6jmcnq
         AD/hTDVn7Uh8f3+yjX4SSiP8jrFDdFvpQx2VUWxINycm282HKxwxoxh294TdLVb3xAdU
         F8q4ozVsC6UPZULAWU3h4trrTQEKPCWI/08An6t3FOpQZmsQtdwII38oNJrV+IzHYlhZ
         2ooQ==
X-Gm-Message-State: AAQBX9eQf93lvPNQNHwLxmjPqKf/w3VkdAkuLftQEVq//5kd1pCsokkb
        OyqlBQavD+wwgyD/xzeFFO9ZVA==
X-Google-Smtp-Source: AKy350Z8GmLJqT3Nu/TCa8MKc3a4dYI4Y4KCUmcZ4H1eYcHjEIuWBOxgb/jAq6ojWkgAvkP40sZraQ==
X-Received: by 2002:a17:906:702:b0:92f:d1ec:a7d7 with SMTP id y2-20020a170906070200b0092fd1eca7d7mr50288ejb.15.1680628942079;
        Tue, 04 Apr 2023 10:22:22 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:21 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/40] of: Fix modalias string generation
Date:   Tue,  4 Apr 2023 18:21:09 +0100
Message-Id: <20230404172148.82422-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

The helper generating an OF based modalias (of_device_get_modalias())
works fine, but due to the use of snprintf() internally it needs a
buffer one byte longer than what should be needed just for the entire
string (excluding the '\0'). Most users of this helper are sysfs hooks
providing the modalias string to users. They all provide a PAGE_SIZE
buffer which is way above the number of bytes required to fit the
modalias string and hence do not suffer from this issue.

There is another user though, of_device_request_module(), which is only
called by drivers/usb/common/ulpi.c. This request module function is
faulty, but maybe because in most cases there is an alternative, ULPI
driver users have not noticed it.

In this function, of_device_get_modalias() is called twice. The first
time without buffer just to get the number of bytes required by the
modalias string (excluding the null byte), and a second time, after
buffer allocation, to fill the buffer. The allocation asks for an
additional byte, in order to store the trailing '\0'. However, the
buffer *length* provided to of_device_get_modalias() excludes this extra
byte. The internal use of snprintf() with a length that is exactly the
number of bytes to be written has the effect of using the last available
byte to store a '\0', which then smashes the last character of the
modalias string.

Provide the actual size of the buffer to of_device_get_modalias() to fix
this issue.

Note: the "str[size - 1] = '\0';" line is not really needed as snprintf
will anyway end the string with a null byte, but there is a possibility
that this function might be called on a struct device_node without
compatible, in this case snprintf() would not be executed. So we keep it
just to avoid possible unbounded strings.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Peter Chen <peter.chen@kernel.org>
Fixes: 9c829c097f2f ("of: device: Support loading a module with OF based modalias")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/of/device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 955bfb3d1a83..c91bb5899256 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -297,12 +297,15 @@ int of_device_request_module(struct device *dev)
 	if (size < 0)
 		return size;
 
-	str = kmalloc(size + 1, GFP_KERNEL);
+	/* Reserve an additional byte for the trailing '\0' */
+	size++;
+
+	str = kmalloc(size, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
 
 	of_device_get_modalias(dev, str, size);
-	str[size] = '\0';
+	str[size - 1] = '\0';
 	ret = request_module(str);
 	kfree(str);
 
-- 
2.25.1


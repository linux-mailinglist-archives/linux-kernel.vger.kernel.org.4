Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE4870A751
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjETKwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjETKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:52:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C544E49;
        Sat, 20 May 2023 03:52:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae40dcdc18so30529405ad.2;
        Sat, 20 May 2023 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684579919; x=1687171919;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gaWMjg/j3jT1ogB4fxogwoRNw1EsJdomhb6ARkAoWY=;
        b=EqLz8JXSxaupUNwVl2OJFbMf1kqYhBJjNq4hXit/CtTQ94WvH4CWnzuF6dNK1CZODg
         ZLwm2myaaWkLGcuEMfcC5OwBr5RnM5UFmeQTNQtt9jUCeJwYLos6oDBsA/WTnY1+cvm3
         fEyWAegnO3XTnYWcrjBiHGZVIdUPCeo7WjsXzj5bLQM1eRScKAR6kXO2sN2ZkDdZhrTH
         VEEkIuM6AAcg1nZWBHcmTDgvDC7WsUa4fFFLEmSVZkhAbNNYFJbvLIuPohz/maE7IrHM
         JDP2LR0RnJlFWVI/BMrSu/hedkmD9Nae2wcr1MpjKUaapVxxUfzzpDSF+HHvm1TjCVWR
         h7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684579919; x=1687171919;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gaWMjg/j3jT1ogB4fxogwoRNw1EsJdomhb6ARkAoWY=;
        b=dapSj9NKhATSRmBvu3bZ0vTfoW5Hbqjj/oGb69IhUFvTLFes9Mp6pKT/aMD95lUTHa
         2KkKaEudxkWeXCm/RjbOSLpRdhFf5TI86BA0dUT7TmvMiCvuJ9+GoRZwswfWnhA4p8U7
         hpRehklwfwqs2XB2A8mKCaQ+m2hV420BgarnAmIbWOFVdDW3OGb82mKb67tjMw0j00Ut
         We5jog5IrP997jag6pC8mIOgmenJmUkiUYNoWfP9A0q+vCCPbYz3himTZiamOqyIfc/u
         q4HFWFojG0b7pEnaWe9EwyDIXl2wEs+8RtM0y0OB3HWafVI1BXi4fgyg5WO985Ir1PLw
         djtg==
X-Gm-Message-State: AC+VfDxlHIR9/YUzK+kIk1xS+Wfu9EDG8B6YkdaujBlU2mIbnIL7Py8l
        XriZfvdqZCy8DajvBV1gsio=
X-Google-Smtp-Source: ACHHUZ5t+ejrSUhP49O/2UwEVJpqATJqrMYdl5+y2ftHzQrNJ42YLOPdbOvBG2LV10QO0FyH/vqGQQ==
X-Received: by 2002:a17:902:d4c2:b0:1ac:6c46:8c80 with SMTP id o2-20020a170902d4c200b001ac6c468c80mr6981466plg.53.1684579919475;
        Sat, 20 May 2023 03:51:59 -0700 (PDT)
Received: from yoga ([2400:1f00:13:245c:9b1a:1a9d:79c2:5b3b])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001a2104d706fsm1205996plx.225.2023.05.20.03.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 03:51:58 -0700 (PDT)
Date:   Sat, 20 May 2023 16:21:50 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        u.kleine-koenig@pengutronix.de, andriy.shevchenko@linux.intel.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add dt-binding support for ti tmp006
Message-ID: <cover.1684579603.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches introduce device tree binding support and
add an of_device_id table entry to the driver.

Changes in v2:
	- Keep the exsisting MODULE_DEVICE_TABLE entry.
	- Removed the inner comma in of_device_id.
	- Order the included header to improve code organization.
	- Adding missing semicolon to fix syntax error detected
	  using dt_binding_check.
	
Anup Sharma (2):
  dt-bindings: iio: temperature: Add support for tmp006
  iio: temperature: tmp006: Add OF device matching support

 .../bindings/iio/temperature/ti,tmp006.yaml   | 42 +++++++++++++++++++
 drivers/iio/temperature/tmp006.c              |  8 ++++
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml

-- 
2.34.1


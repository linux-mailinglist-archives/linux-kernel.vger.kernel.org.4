Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648F6687F71
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjBBN7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBBN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:59:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AC643447;
        Thu,  2 Feb 2023 05:59:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v10so2073934edi.8;
        Thu, 02 Feb 2023 05:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C4yOiCfMP0qj/5KoOd6moIn3AHrcKCsnXClv4cfnTU=;
        b=JLeYM8r6D7I8hxEIZGXSNrXiCOM1r6JaTyiPcGesBFtSNBlrYczTEh5y7VHxbMwY3p
         E17554goaZ5Rh1MR/xAnCOXn1XNvKmOxhhvifW3UisCHMNV8L0m4aU3CQdmOBTo59u6E
         T+NB9+bvs4/7prBq3D9RmiJNaxzfyS9Z2X/EpA8MrfQjm2Xx4vX1dLYVq2FNn2KvJx4d
         2MFTVmdBSUEW/s70LJvEOJcqQilYpMcWAKWg1WGCzuZH4thNkulTiz8vWgC5Qs/FCoit
         qT4knHMcXpi2WmzqiC/FP3ZEM5eQVfsdsJB8d9vME9hMszTEF3V6DTKPKj9AO+32mpen
         UdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7C4yOiCfMP0qj/5KoOd6moIn3AHrcKCsnXClv4cfnTU=;
        b=ydW6UgV6YJpCGDzYt5xs+ob881btU3bpAfM9emnSLw/paXwDB2pRrehUBaN/faFKmO
         zjWqHCCAkncRlJhG2DlKgcu8ZOJrUfUAlRpM4OmIEJ+Ik1IetHhOobdfkweIWI8qEA56
         t5cCSryMgm6EPs4zkQzRvjn7eKSfSm2mndCAymZfmxKO/FBjXt7JcUlmULUSO773gMHO
         akSo2W4dYAOtv5MlvXPM99U2ZqGvqEcVHmI9anWtHS61d2P3I9bDLivHkl8+/sw2HnMn
         Fu3P7oj0Xw8rsk/fim3vOvoueIwfajGcVvOfB0mTf+iLR6f3k+ZqgwtGcf9MgAJpUZ1a
         zz1g==
X-Gm-Message-State: AO0yUKXGVc51pgYWZqEQDpl3VrdTLP9HIxz9CoBxa3LrIB5awza64uS+
        w+RvGUBpzJo5Vn7O0lCdoZM=
X-Google-Smtp-Source: AK7set+2cZg5uKgjKIT+gcK65XOYzB/T6/0Z7PWmZujYuCIp5ZQcCHjkg4wT6MFMnqE2zF8hXbAtzA==
X-Received: by 2002:aa7:c70c:0:b0:4a2:6c9a:ad19 with SMTP id i12-20020aa7c70c000000b004a26c9aad19mr6082501edq.17.1675346377847;
        Thu, 02 Feb 2023 05:59:37 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p2-20020a05640210c200b00499e5659988sm11120854edu.68.2023.02.02.05.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 05:59:37 -0800 (PST)
Message-ID: <f8747552-d23b-c4cd-cb17-5033fb7f8eb6@gmail.com>
Date:   Thu, 2 Feb 2023 14:59:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] dt-bindings: usb: rockchip,dwc3: update inno usb2 phy
 binding name
To:     gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding for the inno usb2 phy was given a name in more a common format,
so update the reference in rockchip,dwc3.yaml as well.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index edb130c78..422dcc156 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -15,7 +15,7 @@ description:
   Phy documentation is provided in the following places.

   USB2.0 PHY
-  Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+  Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml

   Type-C PHY
   Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
--
2.20.1


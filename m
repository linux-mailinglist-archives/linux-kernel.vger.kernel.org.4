Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA56A665D73
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbjAKOO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbjAKOOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:14:17 -0500
X-Greylist: delayed 69345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Jan 2023 06:14:15 PST
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C702538B4;
        Wed, 11 Jan 2023 06:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673446452;
        bh=b9a3LhEMbFnd+KAhgHHyNrwITwW+QdtCP0kjQLG7k0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vBL84q+bPEpiY29Yc3X3QUCYgOOXeUyfdA/PUqSy3Qgtp3vRr1JJ3qQZW/sGw1YcU
         qWv4K7ylZ5tAE0Ex3j/35UWmfuHy8zW7vOvJKIKRjbIaQePZHzDaLSyJKtNtCpvhGr
         VKhd2G4J0Yt4XBJgfyaIX/jinh+JQnH15SHYxSDU=
Received: from localhost.localdomain ([111.60.247.106])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 37731CEB; Wed, 11 Jan 2023 22:13:55 +0800
X-QQ-mid: xmsmtpt1673446449t674cdp1r
Message-ID: <tencent_3880CBDD2FF871E636A391C2596AE7D11509@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8GVKSw+IBQP8hjCDv78STCdupGA9erFjoAv6nPOvl2bna0v2plt
         2hvkheg7mak7bLnWvYiGowqI0x3Sp43jX3m55/z/3psu6kt7GXq6OFMk2Z1g/B9YdnMYYr14l86t
         uHzC16gSxtH3QnUTz3WUDGvW8vw1akVOEwU6i03x1N5TrMQGNAJrMK4Ukcb4pyqO6ZDFkRk2we/H
         3uUoS8I0PvsfH7/K75BdUm6wLt7PGrl0HEH0iaZhOTkXG+lbcGmZmbcfIr76r85W+mgf2DjnVKZU
         3HO4vGjuCp+ePnwVzubcr+E0Y8+7/lxo6xEDXQaLZ07d1/pSKrvdzFlIiFshgU2CmABdVSLPYbNH
         bb5gpKSgmMRhPF9bp8K2Mq1Fud5iquKdTOm/4ZTcpfYiHEvbbo4FUAMcMtluseWuLJmvfsLjyv7g
         gsiyrkxEo+FYWeTXHd6nlvJeUXEvMuv5ZsBckY4/ez+or6SR5CdE8U1N0+1m9G1S4EjhIE3zqRMy
         p5p9IgqRrhUj779D4bEs67bkB0y5c1ufZPsh291MTieYxk23qjael0xtvc6DILCmU6xmspgv+dkr
         8Ks1NlepkRtq3xRWHV4F2LLbTIFyN2FEcI9Gnn5wRm0nBKpKJhWj8fymmARafC5eDDjUMKmQ0d9A
         JCxbMznrvFyeJzN9zCzROTrWasPBfLloVOz30HUyf32dZQ6zluRm+4Tuvw/d3Yo/2IQp00D84FZR
         JKpvXnJBGArS+42anQhdtT2RJ/jUiTCEOyGsBWQvk+oZvUba/YWxL84im8ZkLIKAvqpkdIPQyROH
         tbL7UZ7kcanoXVjkW5kHcFTlHeS8PKSXpqC9x6Xa+OCVDGGQa270QufD5uieY+kDPPTWUBKQ9rAv
         fefOMHS1pa+TqSa0lGXK0G5CxqbyzrGMV1B9y3zA4wVkKTvTcQ01E0lGC4df6JKl015HISKpyfu0
         H6B6Vv/dCCbtkZyXMnYOYU10J41MxhFC0U+DU72SlmN3dC+ET0vOjCSU6OdMvkUuiUWyDR71E6uP
         VWP5L++g==
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Yang Xiwen <forbidden405@foxmail.com>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add thwc
Date:   Wed, 11 Jan 2023 22:13:09 +0800
X-OQ-MSGID: <20230111141311.14682-2-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111141311.14682-1-forbidden405@foxmail.com>
References: <20230111141311.14682-1-forbidden405@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen Tong Heng Wei Chuang Technology Co., Ltd. (hereinafter referred
to as "Tong Heng Wei Chuang") is a focus on wireless communications
equipment brand manufacturers.

Link: http://www.szthwc.com/en/about.html
Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 3893c45963a26..8d4c1e5c0d21a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1335,6 +1335,8 @@ patternProperties:
     description: Tecon Microprocessor Technologies, LLC.
   "^topeet,.*":
     description: Topeet
+  "^thwc,.*":
+    description: Shenzhen Tong Heng Wei Chuang Technology Co., Ltd.
   "^topic,.*":
     description: Topic Embedded Systems
   "^toppoly,.*":
-- 
2.39.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4799B6F874D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjEERNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjEERNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:13:25 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A39A1A1CD;
        Fri,  5 May 2023 10:13:24 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4QCchg6qGzz9sW1;
        Fri,  5 May 2023 17:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1683306804; bh=DMEAUb6Y4XfHvl/aZCH2QTrE3Fn84F08j//FajEqxWc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=mm4KyeisDmavbiLRoI8XEd7FbbN8bZWhPdeKFCdAcziLTzZuenMRsLPn5P2i/hPPq
         +oNSAP95rzrUDTRIFFurMtGrAJXXbppTSvYqMh8JnzkGSWjy7yZehlVhEKQu4b5qjD
         jP5C9ulbm7XhXCSPODAsHU0HlRwUPW+9bn4pahK0=
X-Riseup-User-ID: BB8F600E5D2614178A591C43FB16BBDB833103D968574BBAC904A59DA894DAFC
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4QCchd4BStzJn8c;
        Fri,  5 May 2023 17:13:21 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
Date:   Sat, 06 May 2023 00:12:59 +0700
Subject: [PATCH v2 2/2] dt-bindings: arm: qcom: Add Fxtec Pro1X
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230505-fxtec-pro1x-support-v2-2-0ea2378ba9ae@riseup.net>
References: <20230505-fxtec-pro1x-support-v2-0-0ea2378ba9ae@riseup.net>
In-Reply-To: <20230505-fxtec-pro1x-support-v2-0-0ea2378ba9ae@riseup.net>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dang Huynh <danct12@riseup.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=669; i=danct12@riseup.net;
 h=from:subject:message-id; bh=DMEAUb6Y4XfHvl/aZCH2QTrE3Fn84F08j//FajEqxWc=;
 b=owEBbQKS/ZANAwAIAWbKt+qkXdeBAcsmYgBkVTkrUOVYtzHDKbZY+SnmOXBVqc6AptkaBpUaZ
 gy/MEPUhaSJAjMEAAEIAB0WIQTwmpM8D+AzHlWMpOFmyrfqpF3XgQUCZFU5KwAKCRBmyrfqpF3X
 gcOYEACc5689pi6YraJq94Gk8xfQv7WT3EDVmfp0xD3UznQx08HhhI4dbYRzv7wHplf/l3rGRxg
 BmjKC+9sGfOCLvZ/bTXkg2vnmcCMyWCexAOAb31sHaGIXHkOcE42S+RDFi79GjaVXbvsZSqzCER
 pvo0UXt91JkL2RMmC+bKzLF0MHSOqIipM9pSVSeXYrVYomfJttHV5fhwW0Tx0fPHs6M013o3HEI
 twOCJ1b6c2pp5mGHYnrxTheh+5q5h4DNyrhlpTbqTakBxqnJCw+jA6VkRx4PKr/klSvkizUQ3Z3
 pHUQTwzNYVTjWdJNDFCYcDYIFwUZw9EhcsdU5+xVsT9jTMDOraSZ0A6UcN46IkiRhcOd2LJEHzJ
 4GMJYMMvXTBgtcFfRYJqaTAB2ucugxfnPXZ1l84J4qKGT59xLefE5MkDlJleQyd8sjlScaFcE9r
 tIMXCUo2001orrZe+UQ0xenRPuDoQmqiwiYWkK0P67UEFLnFTyPQBnpXZ/FR3zU2FFw5dtx4qK2
 xnO8QsixcLgnuloSppuoR+2jySez+R5FUX8WtPowhlKthsjVgZErKGp4PHV7eTRKuIVpJnnOUDh
 OFSx+rj1mqRhpiiSJeSzPUDphOMgN+XNM/F7Eoj2w4i0zIx2IbiqQ+PbW1KuMMNPNVFZMSp1GPw
 6qWAVTP47uTikIA==
X-Developer-Key: i=danct12@riseup.net; a=openpgp;
 fpr=F09A933C0FE0331E558CA4E166CAB7EAA45DD781
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document F(x)tec Pro1X as a SM6115 device.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d9dd25695c3d..49df4fbf920d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -884,6 +884,7 @@ properties:
 
       - items:
           - enum:
+              - fxtec,pro1x
               - lenovo,j606f
           - const: qcom,sm6115p
           - const: qcom,sm6115

-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E817666A9AE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 07:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjANGju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 01:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjANGjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 01:39:42 -0500
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F06B4ED4;
        Fri, 13 Jan 2023 22:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673678378;
        bh=QGjtU9eX9ghapQE0scu0DZg0ax2JdtUo5CHU7LQ9Wlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=xvWjDDvcW7XgsH3rvSRaj1RvM8IROKHmrxE/CnUnjVwM78Cr5NksiZPUaG5IDZyQj
         niZgVrqfcfrLAjacNWUZCb37XNiEflb49PVkNey4CxqGUm9BWyoDZ6WwmkBbRTEFgX
         d9kJDZOp/YVfMNDS9C76BkaHsUcCPDriltmjbtuE=
Received: from localhost.localdomain ([111.60.247.106])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 9D611E2E; Sat, 14 Jan 2023 14:39:22 +0800
X-QQ-mid: xmsmtpt1673678375tvdu02onz
Message-ID: <tencent_C5DA42F409E00AF7077E8E3982E89A708707@qq.com>
X-QQ-XMAILINFO: N+e2o5mO2SaeVdKNqmp66P/VHQlg2gIQmJcERwLqsNMqW2P2MyRRdOmYpyfHN6
         5/+7iRP6CBSnnkVfFaVSeK5uDSXdUe2j7V5+Xp+tdXlZlqb+UX+rfmMe0an3w90oxUdqtmUSTaSi
         5R87No3CKSd3C94vl0VEHmdSKJWNN/bTxxiKe0RZobk93zMm5PHqp9LOFkgORHzWcicQByqI1tUy
         Ec4FnvnR7QMVMDgvt8kZek4fY7A7LfSdEk5tsNM/HSQohU8kYD8FVDKMY4fYhN7SkHT5OC0TKYe1
         Xl6fYeOXrnjY+f/4IjY2HrgBH5qrCbf4YlDlpLC6rTp+3C3mrnvyv3cMjVErCHPF5a0FnUpqc9rj
         QjnxNT+S8jDp4hU5fVcznVdvmonDGOMzasauUMx3lTWyYFArAtjLKcQYBw4mTL+FGcqz2v1hwyfD
         6OauDrG4J7tf9iQwhQw95Z9fP7fmy5jH3HPjCQhS6ttQPMIPLi8UDqJNCiWK7McbJIWkYqiOkKrD
         6D5wiYV6/IgH86decul8EQpE5uCeOPVl73FC0Gf2tr1l6BQ4kxA3RGtbxTXqJeeutWtjM0DZYNfy
         ozbmToGpZRu/uFE59D6qUZIrwaasFSyWhxsfXkzuEyj5SDigOpFSWIch0HGXxd9CVX82AXzFNzet
         tLBw/1YJhoe6+D1jvdS/jhXxm9TwA9OdnM2m8LRC1ZzNJztMdItupi3l0MyIYEze9o6B2mU6hcOd
         NntJRZgzljyT+GmqdcW7cyPf3apzERaJZPJ3ogea126ciWaDkTLmYQnWKD20WktKR2lTYBIOx3TA
         vYlpv17YDMNzsQUytwHZiSkR14zYv8BsnqEYmxblBlsDsxGFT2tAw509hFV4I4IlGpmMg/+FxcDw
         k9aYAhO5dWkn7CJd/I2att9tolh5qKg4wRRzeyWqzkfnP6V74IUyzLRbnFqcaeF/CilCZw5CfqKW
         U/vDzmRQIqwIUesrVxe/YPAR2NTuwPDBH/hLyGDdd+L/p/aJTwMvekjXZmLcb4ft2QTA4rd+4=
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yang Xiwen <forbidden405@foxmail.com>,
        Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/3] dt-bindings: qcom: Document msm8916-thwc-uf896 and ufi001c
Date:   Sat, 14 Jan 2023 14:38:45 +0800
X-OQ-MSGID: <20230114063846.2633-3-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230114063846.2633-1-forbidden405@foxmail.com>
References: <20230114063846.2633-1-forbidden405@foxmail.com>
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

Document the new thwc,uf896/ufi001c device tree bindings used in their device
trees.

Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 47913a8e3eea3..976ec25c38fa0 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -211,6 +211,8 @@ properties:
               - samsung,grandmax
               - samsung,j5
               - samsung,serranove
+              - thwc,uf896
+              - thwc,ufi001c
               - wingtech,wt88047
           - const: qcom,msm8916
 
-- 
2.39.0


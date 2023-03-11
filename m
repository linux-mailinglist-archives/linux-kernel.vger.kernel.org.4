Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10F46B577F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjCKBWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCKBWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:22:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61F512EE66
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:58 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j11so8907713lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678497718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZUTIEQRJUGcBRJSKwMS6Yp89dYVCTLzQMZv5j/xIGg=;
        b=EzNEZwphrOIxM+eJPH15MFqoLn1x3SDgLc2mkMJxGRc+wR4oeYIs1QrTVc4G9B7/Ta
         MlSzzSdgk91o19Az+oFjWtAT/VRnoum0q7+nEFJBbM106q9kngljQTl0A8HATRNIK50p
         eRR5VkAmlbng1hS6ww3dqFMaRlVSiASPLQiycV06gK7OZQKB15cbbVG9qgi0kNyueNbd
         Y6OX82g358eLOxOAOL3GzrQqSCCT0M+K3Oa7lq6fI88qWQn9pUN6ih9B5wymT2n2W19R
         bZDBrmRKeylgbCEaZGi1WoVhlXFJW2qrM18vfz8K7UeQ2RQuIvbg8nTwk4V7rBoJjHRp
         H6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZUTIEQRJUGcBRJSKwMS6Yp89dYVCTLzQMZv5j/xIGg=;
        b=vYUNgyKG+VQzcEb2cj9bsm+ut27/gLnbpV/uOjoZnqu9JDkuelYE0/Gov7YRgKcMnJ
         Amd/PfBB2FZgYJuLXXvhc35FXj4Kb8ZpSWlmo8SEhlxqkuAoKiLe5UFfngY6KkQpTlE4
         C6DH/EDx7JSHDsvIM5O1NlNkSS4HJ9jwnz2fkuDyZ18r42IMdlDBoWyJ2KXLPqn2fLhG
         KH/8q8CoiOFdzo9oSgMSdKP5MkRVslpG6RhAzMpVyuzhAgj97eXUjQ9/RNsWlUXqsN8v
         PVwgUjjCcOnXcoqTnvj577w2svB3RIIhyLgrRp5S0kX93TVtjZje5Z3q811a8gKI0RDu
         pkqg==
X-Gm-Message-State: AO0yUKWUb9x+sPo2k0fkvgFdXpWkEJcSEQbZUF3aVOdvwNj4s1ZFo+oS
        W0lEUX95iM9yfHUe1aR3dxfj6w==
X-Google-Smtp-Source: AK7set9SwUTaQFK/PiKlUhuTROcOCrdwb5nxRJkQ03j1UGrZag9W2Uxh2P4v8UESSefO+I7vyWvK/A==
X-Received: by 2002:ac2:5637:0:b0:4b6:e405:1027 with SMTP id b23-20020ac25637000000b004b6e4051027mr1254395lff.14.1678497718301;
        Fri, 10 Mar 2023 17:21:58 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004db25f2c103sm142318lfl.86.2023.03.10.17.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:21:57 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 11 Mar 2023 02:21:42 +0100
Subject: [PATCH RFC 12/15] arm64: dts: qcom: sm6375: Add simple-mfd to
 rpm_msg_ram
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230311-topic-msg_ram-v1-12-e9c2094daf09@linaro.org>
References: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
In-Reply-To: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678497700; l=692;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=naDVY1z5ZuvWeZk0oh4MyasoPcoq7yijlaiqjCEs9I0=;
 b=GpjELQpRQP0rJW7sBOR8yKQaPzakIpldJEKZOn5ETpi539xl1/IdxIQNvQNTOCFetWs8H2TRrJFJ
 vDVe52HGAbH4wZ6/7ypEwZfkgiWD7VU1iG6VSXl7FjfX1Qc8UxH7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing compatible to make the node compliant with the bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 068ee4f72485..7fb158cae948 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -714,7 +714,7 @@ spmi_bus: spmi@1c40000 {
 		};
 
 		rpm_msg_ram: sram@45f0000 {
-			compatible = "qcom,rpm-msg-ram";
+			compatible = "qcom,rpm-msg-ram", "simple-mfd";
 			reg = <0 0x045f0000 0 0x7000>;
 		};
 

-- 
2.39.2


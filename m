Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D5B73F72B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjF0I2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjF0I2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:28:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C53E1FE1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:28:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98df6bc0048so372786566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1687854488; x=1690446488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGkxfIlXXVd4eOlKO+oLehocpXpo7RbZWzh/FcRwcEo=;
        b=wSx/vsi+dSAGNtnIZJLOmr47YXVYrT+OIjNd17ObKEghBtToSaOOl6VScQmelJWiqF
         mbcZe+YIg65HLi6PlwhXcTD/QrA3pReuxqEyDXKPaDGuok4W/pV5cDaI8pIDm5eVxC+f
         6LURrDoL1qr0H7ZeajbHM/0XNgHhp7Ly4ZDDWyoaXCv5djF6CO3Z93EYlpFXDpWyHgDB
         6tTZGDi4QFNhmFxHQBzUqHBWo8jQOGNH5puvI+WMWC6I08a8IjYTFzTU8HjZVb+DCEHJ
         cSUV/pN408qlMSLyuysdXo0Fnp+23F2gao7+wTZp/+hXQg/cfij9h8mfq45TxJu4/YNh
         fFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687854488; x=1690446488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGkxfIlXXVd4eOlKO+oLehocpXpo7RbZWzh/FcRwcEo=;
        b=D5t7CVwS2K+PPS70fOjCaqCjpISWFiiAvDMRd553QnKliP+FinQrt96gIt5XOidob5
         ZaBD35LDCTYl/47IkEoGbMb41N9dtRsCaqWyhSJp1w0tg4FgslNG/wYuZ2Qxs78yGnmx
         FeHQUEUvOdwA9q2jzC4spSl97U3Y8QIP86Y/OKgfkHT4ujkcJa0CzKztwNRyMNs0odVO
         VtqSZPMFj1sVl1YDUqZUEeN3cyco2Ycf79BK1nIqEEmNSpsiBw0dmJZEIu1lOt5s7qLY
         5IFYRuxueStRIimkljFDz+eiziJECOqIwYmB6+kKyYgJAdZlgLFfFdfILX4LYkpm0J0O
         0ObA==
X-Gm-Message-State: AC+VfDx1V/s+n9eOmNxk09j+9lVaMBYaVlF29LUgL8ynZyPBA7EG2u//
        28NrY0Q0pxNWvQYOqOSyRuZ45g==
X-Google-Smtp-Source: ACHHUZ5o29H62hyx8EnN8GKeHWPpEAgm3+WVyEm9aHFVWmoQn3ipXBi17KXb4i8YtY364/aodDnhyg==
X-Received: by 2002:a17:907:25cc:b0:989:450:e57b with SMTP id ae12-20020a17090725cc00b009890450e57bmr18027423ejc.7.1687854487780;
        Tue, 27 Jun 2023 01:28:07 -0700 (PDT)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id kt19-20020a170906aad300b009894b476310sm4253038ejb.163.2023.06.27.01.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:28:07 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Tue, 27 Jun 2023 10:28:03 +0200
Subject: [PATCH v5 3/5] dt-bindings: ufs: qcom: Add ICE to sm8450 example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221209-dt-binding-ufs-v5-3-c9a58c0a53f5@fairphone.com>
References: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
In-Reply-To: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8450 actually supports ICE (Inline Crypto Engine) so adjust the
example to match.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 2b0831622cf0..462ead5a1cec 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -317,5 +317,6 @@ examples:
                             <0 0>,
                             <0 0>,
                             <0 0>;
+            qcom,ice = <&ice>;
         };
     };

-- 
2.41.0


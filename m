Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48049704D18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjEPLyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjEPLyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:54:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5296A49
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:54:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f2510b2b98so12064629e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684238044; x=1686830044;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gz5kKmiOfXAcKsAlxUYavA5LbDAi6qhoE5G5VoFPO9s=;
        b=h/1LSu/9s77FwMlN7hi6f2oUheCtw7s0IR1I0Qq0Y31lVxF6mCZbY7jebDyzY2ti/M
         Pz5ES0soZKO9B39n0sLH1wDmpjTdftTmYESn6tD7eQkYfYEeD/m0H37xoEIfKwoV9PEg
         1NTatl9/201TlPAEyMmVNezrqxPZxK/IyPgmX+9eLcMKTbmwc8fjkXtYNAb7dLJULktd
         4WDb+qScMcTM+luEeZehZoA9JuQHVCtqm/HaR9f9oqb0iMI8KvthX4rsXzOObo3L8Of0
         dAeyz1lKZtXltfKzq0QoDw5nSVAkBu4KSSjjwrxP7QCRqBaYpj0DpCMv4F0c1gpsmAuw
         4/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684238044; x=1686830044;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gz5kKmiOfXAcKsAlxUYavA5LbDAi6qhoE5G5VoFPO9s=;
        b=YPGvqwokO+r9uikfhRp6bW+Cdi/Ai3ahmemU1B1ogH5ZmHD9x57DvMkZDT4oVtgD4V
         +wLWDWBmfIpdLkmDgvBNd7CAfvUtmoeSR6r0qSwVddh0zSwApCu8RdEg1r4oWeCPHLNz
         OU5d2k8DXyh1uuG2dUr8OpPLdXkFyVcmXsw77/Epw9DVxrRYxLnNjijDgWyhTX9dAg+2
         AdV0Sk1qP9x1F3Q46srFYggCpFQzE2SVsI1rCUjljpSImxsPw2nwf7DAmJVAsjHrbI/a
         sG0PBaz74e5wXa3dJOmFjP4yJ1AlpnKvjim7po/sph1jj63Dz6pB9O8QVoircwBrL0j/
         FjoQ==
X-Gm-Message-State: AC+VfDwxmZ019VsTecrF+CFO2NuP9CS2CFbvnt5VaJ1Ft8deFsypa9op
        n/n2m6HBxIj/pV5ESGQ4LcwxJA==
X-Google-Smtp-Source: ACHHUZ6yGJievvZYzPFOsVMaPVCMKT+sajWSgiNdjAKea4aIlNrC6udu7OSL1RDb2+m0vP/WFw6X/A==
X-Received: by 2002:ac2:4948:0:b0:4f2:4d6c:b30b with SMTP id o8-20020ac24948000000b004f24d6cb30bmr6483164lfi.68.1684238044368;
        Tue, 16 May 2023 04:54:04 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id z13-20020a056512376d00b004f019d3eab4sm2951410lft.23.2023.05.16.04.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 04:54:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH RESEND 0/2] Lost tsens compatibles
Date:   Tue, 16 May 2023 13:53:57 +0200
Message-Id: <20230516-topic-lost_tsens_bindings-v1-0-99715746ddb1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVuY2QC/x2NywqDMBBFf0Vm3YBGamnXddtFu5QieYw6ECaSS
 aUg/ntDl+fCuWcHwUQocKt2SLiRUOQCzakCtxieUZEvDLrWbX1uOpXjSk6FKHnMgiyjJfbEsyh
 99Z3F1l8mbaD41ggqmwy7pTzwJ4Qyrgkn+v6DAzz7V/+4w/s4flR1y/2IAAAA
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684238042; l=721;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=n5yXbBFORwHOEllWFZQWAf441tVemcqAG65GCzT9zeA=;
 b=hNWgAGZcXD6QrWP/hlpl2bX8nqAXs8IgTBXAGf2E5JrxFc2E3mxL9NtBLd7oCTA3D1XQp7JiS
 CavjQCPmFJ7CUdRU7mufJMORQSrnxvheuAsTXv5bYMjpDrOzuy1ki24
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending what's been lost in the following series:

https://lore.kernel.org/linux-arm-msm/f7f38099-f183-d7b6-f542-1bdac6652a77@linaro.org/
https://lore.kernel.org/linux-arm-msm/20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: thermal: tsens: Add QCM2290
      dt-bindings: thermal: tsens: Add compatible for SM6375

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
 1 file changed, 2 insertions(+)
---
base-commit: 885df05bf634d589fbf030c3751614eaa453fb5d
change-id: 20230516-topic-lost_tsens_bindings-29d6be3d7f2a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


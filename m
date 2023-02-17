Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B6969A9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjBQLJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBQLIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:08:54 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8C366648
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:08:27 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x4so975136lfq.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wRR1n0XeDdy5V08KPVN+/glZnOr/Dk6nj2f2AocKRk8=;
        b=uzy95TUWPEQ/pFcFlGAABly8kMmtksc9oZs1YKejPXT5xMuVPYYjr79NWZ3GP0gd8q
         O/dA2yA9Ap6nN7V/5Uq6WELQwaxraX81jxNq8pQYiguqkm69K0q5Mj/6ugR/+YwbhC6z
         JuEt1jLxVPsnS2unp+4ltilcI41w6rwYz7rMBw5IoTyXWiSruFOqxYdRGkDMTD/jUBVq
         NdoKviCVOF9su3ND0/2GB+UFBsx0TZf0lAzlPn5WKA2DqbZJPjNcOkEm9FOeyhpj3vZD
         J9gJfE4Uu3A3OyuL/SCYv/n4S6To6QFecuE3gqE13S6AZpXE2Bsl+aa1knYMNLLfuOFy
         3CpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRR1n0XeDdy5V08KPVN+/glZnOr/Dk6nj2f2AocKRk8=;
        b=Az2PvEf8R9Xy0v7FJFvnI/pdum5AwWgykPJljQPoPJNo//thWKWmWD2x1vl3bUz8MY
         w5IvH99G4d0/j8wrzvnFAoe6DHVlra9r6ufH9XPAmquhkY8jT+Y/s3s6A9q9zyCtPpp3
         EamHG3gJjv+KjrhryshYHoR8pb/EsrnAF9EraXN5woTlJib4Jvszs6UIpJNkeCRWlVBI
         +s3t00455e/FD82JXupliV/FykYxhtVtEON7HB4s0Dki9JJYmoIuUr6IT41PzgEseMxk
         GiomLcoJAkqWctwfaI4VS6s93rn3UtqnkGRJM9baTpbXlSxREECHXpOVmR/yGLDtuZQR
         1feQ==
X-Gm-Message-State: AO0yUKXCiZSQ+M4Nmgx0+iHqsud390O7A5ciSdpjsLTD55rFPKmBnIkm
        w+EQcyamP8MWL55jQTaqv7Py0A==
X-Google-Smtp-Source: AK7set+n0zZzJXjwg7j/nMo5ecWppmtiOhjXh6RvXkVirG7sINiiMQQG/m1uNXsctXHhLvEgMt30eg==
X-Received: by 2002:a19:5208:0:b0:4db:4bd0:428c with SMTP id m8-20020a195208000000b004db4bd0428cmr67985lfb.37.1676632105941;
        Fri, 17 Feb 2023 03:08:25 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512020c00b004b57162edfasm640162lfo.117.2023.02.17.03.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:08:25 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v10 0/6] Add support for Core Power Reduction v3, v4 and
 Hardened
Date:   Fri, 17 Feb 2023 12:08:23 +0100
Message-Id: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACdg72MC/x2N0QqDMAwAf0XyvEBNB4K/MvbQxmgDUku6jYH47
 wt7vIPjTuhiKh3m4QSTj3Y9qsMYbgNwSXUT1MUFUKAYaJzwdTRl5Gax4CIUKa/5PgmDFzl1wWy
 pcvGmvvfdZTNZ9ft/PJ7X9QNdHfnFcwAAAA==
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676632104; l=6741;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=h0l1hgNgeqLh7FuJm9g71PZWisSbTarsphtDHkQiqTI=;
 b=FIQ5jVSRBkH6sUcP2mOOxVt5GaPpJF2muKtsNSPnM2uzdnqPtrNZV4H5WQFTpqXo+YMK443Q2jdW
 btynX9JjCVUO+mo5HoAUZ2hjBArV9kNSjMoBWoQ7S1Uz6hKnNvIF
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v10:
- Skip "Let qcom,opp-fuse-level be a 2-long array" (Applied by Viresh)
- Use b4 (it may be the first time you're receiving this if git send-email
  omitted you before..)
- +Cc Robert Marko (expressed interest in previous revisions)
- Add "Document CPR3 open/closed loop volt adjustment"
CPR:
- %hhu -> %u (checkpatch)
CPR BINDINGS:
- Drop QCS404 fuse set (it doesn't use this driver, what did I even think..)
  but leave the allOf:if: block for expansion (sdm660, msm8996, ipqABCD should
  follow soon..)
- Drop Rob's R-b (as things changed *again*, please take one more look to make
  sure you're okay with this file, Rob..)

Link to v9:
https://lore.kernel.org/linux-arm-msm/20230116093845.72621-1-konrad.dybcio@linaro.org/

Changes in v9:
- Restore forgotten MAINTAINERS patch (oops)
CPR:
- Include the missing header (big oops!)
- Fix kconfig dependencies
CPR bindings:
- Fix cpu reg in example (why didn't dt_binding_check scream at that)
- Add newlines between nodes in example
- Change opp table node names to opp-table-cpu[04]
- Change opp table labels to cpu[04]_opp_table
- Change CPRh opp subnode names to opp-N from oppN
- Remove some stray newlines
- Bring back nvmem-cell-names and add the 8998's set
- Allow power-domains for VDDCX_AO voting
- Remove Rob's r-b, there's been quite a bit of changes..
CPR DT:
- Send the correct revision of the patch this time around..
OPP bindings:
- Add Rob's ack

Link to v8:
https://lore.kernel.org/linux-arm-msm/20230110175605.1240188-1-konrad.dybcio@linaro.org/

Changes in v8:
- Overtake this series from AGdR
- Apply all review comments from v7 except Vladimir's request to
  not create the include/ header; it will be strictly necessary for
  OSM-aware cpufreq_hw programming, which this series was more or
  less created just for..
- Drop QCS404 dtsi change, account for not breaking backwards compat
  in [3/5]
- Add type phandle type reference to acc-syscon in [1/5]
- Update AGdR's email addresses for maintainer entries
- Add [2/5] to make dt_binding_check happy
- Separate the CPRh DT addition from cpufreq_hw addition, sort and
  properly indent new nodes
- Drop CPR yaml conversion, that happened in meantime
- Reorder the patches to make a bit more sense
- Tested again on MSM8998 Xperia XZ Premium (Maple)
- I take no responsibility for AGdR's cheeky jokes, only the code!

Link to v7:
https://lore.kernel.org/lkml/20210901155735.629282-1-angelogioacchino.delregno@somainline.org/

Changes in v7:
- Rebased on linux-next as of 210901
- Changed cpr_read_efuse calls to nvmem_cell_read_variable_le_u32,
  following what was done in commit c77634b9d916

Changes in v6:
- Fixes from Bjorn's review
- After a conversation with Viresh, it turned out I was abusing the
  OPP API to pass the APM and MEM-ACC thresholds to qcom-cpufreq-hw,
  so now the driver is using the genpd created virtual device and
  passing drvdata instead to stop the abuse
- Since the CPR commonization was ignored for more than 6 months,
  it is now included in the CPRv3/4/h series, as there is no point
  in commonizing without having this driver
- Rebased on v5.13

Changes in v5:
- Fixed getting OPP table when not yet installed by the caller
  of power domain attachment

Changes in v4:
- Huge patch series has been split for better reviewability,
  as suggested by Bjorn

Changes in v3:
- Fixed YAML doc issues
- Removed unused variables and redundant if branch

Changes in v2:
- Implemented dynamic Memory Accelerator corners support, needed
  by MSM8998
- Added MSM8998 Silver/Gold parameters

This commit introduces a new driver, based on the one for cpr v1,
to enable support for the newer Qualcomm Core Power Reduction
hardware, known downstream as CPR3, CPR4 and CPRh, and support
for MSM8998 and SDM630 CPU power reduction.

In these new versions of the hardware, support for various new
features was introduced, including voltage reduction for the GPU,
security hardening and a new way of controlling CPU DVFS,
consisting in internal communication between microcontrollers,
specifically the CPR-Hardened and the Operating State Manager.

The CPR v3, v4 and CPRh are present in a broad range of SoCs,
from the mid-range to the high end ones including, but not limited
to, MSM8953/8996/8998, SDM630/636/660/845.

As to clarify, SDM845 does the CPR/SAW/OSM setup in TZ firmware, but
this is limited to the CPU context; despite GPU CPR support being not
implemented in this series, it is planned for the future, and some
SDM845 need the CPR (in the context of GPU CPR) to be configured from
this driver.

It is also planned to add the CPR data for MSM8996, since this driver
does support the CPRv4 found on that SoC, but I currently have no time
to properly test that on a real device, so I prefer getting this big
implementation merged before adding more things on top.

As for MSM8953, we (read: nobody from SoMainline) have no device with
this chip: since we are unable to test the cpr data and the entire
driver on that one, we currently have no plans to do this addition
in the future. This is left to other nice developers: I'm sure that
somebody will come up with that, sooner or later

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
AngeloGioacchino Del Regno (5):
      MAINTAINERS: Add entry for Qualcomm CPRv3/v4/Hardened driver
      dt-bindings: soc: qcom: cpr3: Add bindings for CPR3 driver
      soc: qcom: cpr: Move common functions to new file
      soc: qcom: Add support for Core Power Reduction v3, v4 and Hardened
      arm64: dts: qcom: msm8998: Configure CPRh

Konrad Dybcio (1):
      dt-bindings: opp: v2-qcom-level: Document CPR3 open/closed loop volt adjustment

 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |   14 +
 .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    |  299 ++
 MAINTAINERS                                        |    6 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  873 ++++++
 drivers/soc/qcom/Kconfig                           |   22 +
 drivers/soc/qcom/Makefile                          |    2 +
 drivers/soc/qcom/cpr-common.c                      |  363 +++
 drivers/soc/qcom/cpr-common.h                      |  110 +
 drivers/soc/qcom/cpr.c                             |  386 +--
 drivers/soc/qcom/cpr3.c                            | 2923 ++++++++++++++++++++
 include/soc/qcom/cpr.h                             |   17 +
 11 files changed, 4651 insertions(+), 364 deletions(-)
---
base-commit: c068f40300a0eaa34f7105d137a5560b86951aa9
change-id: 20230217-topic-cpr3h-de232bfb47ec

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


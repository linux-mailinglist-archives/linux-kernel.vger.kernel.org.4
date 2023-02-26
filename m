Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574A76A331C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBZRMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjBZRMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:12:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310231284E;
        Sun, 26 Feb 2023 09:12:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D72C5B80C67;
        Sun, 26 Feb 2023 17:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E12C433EF;
        Sun, 26 Feb 2023 17:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677431520;
        bh=PDBuNr2jmq2LcTR34z1CwKfI9Lc3887VW6Mh5ssDvus=;
        h=From:To:Cc:Subject:Date:From;
        b=fUvTXbPep7ou3J2R+jyrnuFDSoRfEOI2DshkXcuByMT2MjoNMTQFYnPTaIV6WrbGM
         zS+Kw2FaFiNKIQV0/Si3LKJzQouwJLFXWsAVz1rnq2UBpBHVfdnLsUo3woRJqm4IHO
         Bu8O5RHaMV3W5yGFYOuT6VuKp+WsigL0pgieVDbNZ3U1lK9Bc/nBPU+TugWaOnQLm9
         3RpWxFKGdTmG/cAqclMZecbQwdkYjnJ6btaa7qg+WXQqDd+iWgJRmdnlh5pnsCV58W
         elTpVRzCCdljQ8KsGVLMCK8GSxMu837ewrn7KM5mjDICBrsMEtQe/WxFOoU8V5OJoK
         eZHUpOZR8YSrw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Suman Anna <s-anna@ti.com>, Abel Vesa <abel.vesa@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        Hari Nagalla <hnagalla@ti.com>, Jai Luthra <j-luthra@ti.com>,
        Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yogesh Lal <quic_ylal@quicinc.com>
Subject: [GIT PULL] remoteproc updates for v6.3
Date:   Sun, 26 Feb 2023 09:15:22 -0800
Message-Id: <20230226171522.299057-1-andersson@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.3

for you to fetch changes up to 7c855ef7137a67bcff0e039691b969428dd8ef6a:

  dt-bindings: mailbox: qcom,apcs-kpss-global: drop mbox-names from example (2023-02-15 11:19:12 -0800)

----------------------------------------------------------------
remoteproc updates for v6.3

Support for PRU clients to acquire a control reference to the PRU
instances is introduced, and the PRU now allows specifying firmware-name
in Devicetree.  sysfs is requested to be read-only when the remoteproc
instance is consumed by another kernel driver.

Support for the C7xv DSP on AM62A SoC is introduced.

The Devicetree binding for the Qualcomm PAS devices are split up in
multiple files, to better account for the differences in resources
between them. A number of missing Devicetree bindings are added, and the
Qualcomm WCNSS binding is converted to YAML.

A few cleanups are introduced for the Mediatek SCP driver. And a sanity
check of the firmware image is introduced in the Mediatek driver.

For Qualcomm SC7280 ADSP support is added, MSM8953 gains ADSP and modem
support, SM6115 and SM8550 gains ADSP, CDSP and modem support, and
support for pronto v3 support (used on e.g. MSM8953) is added.

The Qualcomm modem remoteproc driver is modified to use a no-map
reserved-memory region for it's authentication metadata, in order to
avoid fatal security violations caused by accesses from Linux during
the authentication process.

Support for separate loading of a Devicetree blob is added to the PAS
driver, and support for the PAS driver to carve out DSM memory for the
modem is added as well.

The Qualcomm ADSP remoteproc driver gains support for mapping memory
into specific range using the IOMMU. The sysmon driver is transitioned
to strlcpy()

----------------------------------------------------------------
Abel Vesa (1):
      remoteproc: qcom: q6v5: Use _clk_get_optional for aggre2_clk

AngeloGioacchino Del Regno (2):
      remoteproc/mtk_scp: Use readl_poll_timeout_atomic() for polling
      remoteproc/mtk_scp: Remove timeout variable from scp_ipi_send()

Bhupesh Sharma (2):
      remoteproc: qcom: pas: Add sm6115 remoteprocs
      dt-bindings: remoteproc: qcom: Add sm6115 pas yaml file

Chen-Yu Tsai (1):
      remoteproc/mtk_scp: Move clk ops outside send_lock

Christoph Hellwig (1):
      Revert "remoteproc: qcom_q6v5_mss: map/unmap metadata region before/after use"

Gaosheng Cui (1):
      remoteproc: qcom: wcnss: remove unused qcom_iris_driver declaration

Gokul krishna Krishnakumar (1):
      remoteproc: qcom: q6v5: Avoid setting smem bit in case of crash shutdown

Hari Nagalla (1):
      dt-bindings: remoteproc: k3-dsp: Update bindings for AM62A SoCs

Jai Luthra (1):
      remoteproc: k3-c7x: Add support for C7xv DSP on AM62A SoC

Krzysztof Kozlowski (15):
      dt-bindings: remoteproc: qcom,adsp: drop resets and qcom,halt-regs
      dt-bindings: remoteproc: qcom,adsp: split common part
      dt-bindings: remoteproc: qcom,sm8350-pas: split into separate file
      dt-bindings: remoteproc: qcom,sm8150-pas: split into separate file
      dt-bindings: remoteproc: qcom,sm6350-pas: split into separate file
      dt-bindings: remoteproc: qcom,sc8280xp-pas: split into separate file
      dt-bindings: remoteproc: qcom,sc8180x-pas: split into separate file
      dt-bindings: remoteproc: qcom,sdx55-pas: split into separate file
      dt-bindings: remoteproc: qcom,qcs404-pas: split into separate file
      dt-bindings: remoteproc: qcom,sc7180-pas: split into separate file
      dt-bindings: remoteproc: qcom,adsp: correct msm8996-slpi-pil clocks
      dt-bindings: remoteproc: qcom,sm8550-pas: correct power domains
      dt-bindings: remoteproc: qcom,glink-rpm-edge: convert to DT schema
      dt-bindings: remoteproc: qcom,glink-edge: correct label description
      dt-bindings: mailbox: qcom,apcs-kpss-global: drop mbox-names from example

MD Danish Anwar (2):
      remoteproc: pru: Add enum for PRU Core Identifiers.
      remoteproc: pru: Add APIs to get and put the PRU cores

Mukesh Ojha (3):
      remoteproc: qcom: pas: Fix subdevice add order
      remoteproc: qcom: replace kstrdup with kstrndup
      remoteproc: qcom: fix sparse warnings

Neil Armstrong (6):
      dt-bindings: remoteproc: qcom: adsp: move memory-region and firmware-name out of pas-common
      dt-bindings: remoteproc: qcom: adsp: document sm8550 adsp, cdsp & mpss compatible
      remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading
      remoteproc: qcom_q6v5_pas: add support for assigning memory to firmware
      remoteproc: qcom_q6v5_pas: add sm8550 adsp, cdsp & mpss compatible & data
      remoteproc: qcom_q6v5_pas: enable sm8550 adsp & cdsp autoboot

Roger Quadros (1):
      remoteproc: pru: Add pru_rproc_set_ctable() function

Sibi Sankar (5):
      dt-bindings: remoteproc: qcom,q6v5: Move MSM8996 to schema
      dt-bindings: remoteproc: qcom,msm8996-mss-pil: Update memory region
      dt-bindings: remoteproc: qcom,sc7180-mss-pil: Update memory-region
      dt-bindings: remoteproc: qcom,sc7280-mss-pil: Update memory-region
      remoteproc: qcom_q6v5_mss: Use a carveout to authenticate modem headers

Sireesh Kodali (7):
      remoteproc: qcom: q6v5-mss: Add modem support on MSM8953
      dt-bindings: remoteproc: qcom: Convert wcnss documentation to YAML
      dt-bindings: remoteproc: qcom: wcnss: Add qcom,pronto compatible
      dt-bindings: remoteproc: qcom: wcnss: Add compatible for pronto v3
      dt-bindings: remoteproc: wcnss-pil: Make supplies optionally required
      remoteproc: qcom: pas: Add MSM8953 ADSP PIL support
      dt-bindings: remoteproc: qcom: adsp: Add ADSP on MSM8953

Srinivasa Rao Mandadapu (7):
      dt-bindings: remoteproc: qcom: Add SC7280 ADSP support
      remoteproc: qcom: Add flag in adsp private data structure
      remoteproc: qcom: Add compatible name for SC7280 ADSP
      remoteproc: qcom: Update rproc parse firmware callback
      remoteproc: qcom: Replace hard coded values with macros
      remoteproc: qcom: Add efuse evb selection control
      remoteproc: qcom: Add support for memory sandbox

Stephan Gerhold (5):
      dt-bindings: remoteproc: qcom,q6v5: Move MSM8916 to schema
      dt-bindings: remoteproc: qcom,msm8916-mss-pil: Add MSM8974
      dt-bindings: remoteproc: qcom,msm8916-mss-pil: Add MSM8909
      remoteproc: qcom: q6v5-mss: Add support for MSM8909
      dt-bindings: remoteproc: qcom,msm8916-mss-pil: Add MSM8953

Suman Anna (2):
      dt-bindings: remoteproc: Add PRU consumer bindings
      remoteproc: pru: Make sysfs entries read-only for PRU client driven boots

Tero Kristo (1):
      remoteproc: pru: Configure firmware based on client setup

Tinghan Shen (1):
      remoteproc: mediatek: Check the SCP image format

Vladimir Lypak (1):
      remoteproc: qcom: qcom_wcnss: Add support for pronto-v3

Wolfram Sang (1):
      remoteproc: move from strlcpy with unused retval to strscpy

Yogesh Lal (1):
      remoteproc: qcom: pas: Adjust the phys addr wrt the mem region

 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |   1 -
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  | 421 +--------------------
 .../bindings/remoteproc/qcom,glink-edge.yaml       |   4 +-
 .../bindings/remoteproc/qcom,glink-rpm-edge.yaml   |  99 +++++
 .../bindings/remoteproc/qcom,msm8916-mss-pil.yaml  | 289 ++++++++++++++
 .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml  | 393 +++++++++++++++++++
 .../bindings/remoteproc/qcom,pas-common.yaml       |  89 +++++
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   | 172 +--------
 .../bindings/remoteproc/qcom,qcs404-pas.yaml       |  94 +++++
 .../bindings/remoteproc/qcom,sc7180-mss-pil.yaml   |   3 +-
 .../bindings/remoteproc/qcom,sc7180-pas.yaml       | 133 +++++++
 .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 195 ++++++++++
 .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   |   3 +-
 .../bindings/remoteproc/qcom,sc8180x-pas.yaml      |  95 +++++
 .../bindings/remoteproc/qcom,sc8280xp-pas.yaml     | 147 +++++++
 .../bindings/remoteproc/qcom,sdx55-pas.yaml        | 109 ++++++
 .../bindings/remoteproc/qcom,sm6115-pas.yaml       | 143 +++++++
 .../bindings/remoteproc/qcom,sm6350-pas.yaml       | 167 ++++++++
 .../bindings/remoteproc/qcom,sm8150-pas.yaml       | 174 +++++++++
 .../bindings/remoteproc/qcom,sm8350-pas.yaml       | 182 +++++++++
 .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 178 +++++++++
 .../bindings/remoteproc/qcom,wcnss-pil.txt         | 177 ---------
 .../bindings/remoteproc/qcom,wcnss-pil.yaml        | 294 ++++++++++++++
 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml       |   3 +
 .../bindings/remoteproc/ti,pru-consumer.yaml       |  60 +++
 .../devicetree/bindings/soc/qcom/qcom,glink.txt    |  94 -----
 drivers/remoteproc/mtk_scp.c                       |   1 +
 drivers/remoteproc/mtk_scp_ipi.c                   |  32 +-
 drivers/remoteproc/pru_rproc.c                     | 230 ++++++++++-
 drivers/remoteproc/qcom_common.c                   |  19 +-
 drivers/remoteproc/qcom_common.h                   |   5 +-
 drivers/remoteproc/qcom_q6v5.c                     |   4 +-
 drivers/remoteproc/qcom_q6v5_adsp.c                | 124 +++++-
 drivers/remoteproc/qcom_q6v5_mss.c                 | 261 +++++++++----
 drivers/remoteproc/qcom_q6v5_pas.c                 | 336 +++++++++++++---
 drivers/remoteproc/qcom_sysmon.c                   |   2 +-
 drivers/remoteproc/qcom_wcnss.c                    |  12 +
 drivers/remoteproc/qcom_wcnss.h                    |   2 -
 drivers/remoteproc/ti_k3_dsp_remoteproc.c          |  12 +
 include/linux/remoteproc/pruss.h                   |  83 ++++
 40 files changed, 3836 insertions(+), 1006 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
 create mode 100644 include/linux/remoteproc/pruss.h

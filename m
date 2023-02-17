Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4158169A93B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjBQKqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBQKqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:46:35 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F1C5FBF2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:34 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id t8so832910lft.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k3E2I5amuYpmbn7GqC3s4tKWM0e4MCPi7HSNa94p76g=;
        b=K3nXPFF+JBVDHNHid0HlUmUUyZczSKIcKx5a6xwK0RZCpBNQ5nRwdfM+TscoTnzx/U
         G+MXNTt9Gc0RTzQhcsmR2Ja/m4u7NTTf9ldnDNsD/dHxfRSSjBz0OU1A/AfCPYJTAeZJ
         8d+bMEYVMdL3RdQtfCySnpOzmzp+35PdPtU67vN3wRM0hiRYCd5/2ZzQ8ZtLmEyJMWio
         vj4cyOJuq6ZJx/UxWJ9p/xjwsckOIkf0I6w2AzNa5+ljM/7hQJtxUiwS/4dkp5r3Bg24
         Z6fMFp8H+JLLjJrxnohXfzUDd2OaqYaDvOzjHsp+UBzIWLu1q2YJ1rGK/yDbgoh7QiM5
         PsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3E2I5amuYpmbn7GqC3s4tKWM0e4MCPi7HSNa94p76g=;
        b=8CKZ0MjgYYD89Rq3m1TR1uWMnZcUp2+3yG85kXdvmaZgeo+XBD7X0rKJovVMzE1HlS
         EX6E4/SwARXpmcxRzfnKKz2bWEH9L+Rc74Oh0G2QgX7j2TbeGT/4fqgTtkPzwv7JYVxX
         Ga1MO8gvRoZRLQfxFZD/2y65PnwJnlfVGwU7TYIFeYt4OVRcMKj7yNIlnC80Y6lZSLBw
         UuzgeYVX4qshirHyYP41bZQJTEVsDVojpBPRznsGwg3XaMTPznSxi3C2UeNzhFqc710b
         i0z0ZVpNnmsF4vqDhOcEzb3hTSftGFmmgd7xzb1012RYmYNmTuW/YcPlGXv0xEa+GJ3n
         +Rdw==
X-Gm-Message-State: AO0yUKXMx3hP/MPh/rtOrE2TNCV/CeQ208XC6OhFrU9hZ6t54L2CI3CP
        5t8xiBHgCriKRtVpurxxDgyz/YtYWzhhlzmm
X-Google-Smtp-Source: AK7set/6FMN8mcCltTwttvlmxWgY18xQzikxZLSNic4KZkZ3FS2jVKeDABFYIdeMrh5xJpMWn4DhJw==
X-Received: by 2002:a19:750f:0:b0:4db:2c52:349b with SMTP id y15-20020a19750f000000b004db2c52349bmr2886984lfe.21.1676630792605;
        Fri, 17 Feb 2023 02:46:32 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id c13-20020a05651221ad00b004b53eb60e3csm645940lft.256.2023.02.17.02.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:46:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v5 00/10] The great interconnecification fixation
Date:   Fri, 17 Feb 2023 11:46:21 +0100
Message-Id: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP1a72MC/x3LWwrCQAxG4a2UPBuoo+NtK+LDTPrXBsq0TGoRS
 vdu8PEc+DYyVIXRo9moYlXTqXjEQ0MypPIGa+dNoQ2nNhyvvEyzCqsI9/qF8Ro59jnjfBN0lzs
 5zMnAuaYig9PyGUefc8Uf+Hm+9v0HdSWuRXkAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676630791; l=6776;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Eqr0VMluD6t9ndB/VWgqK7mWkA4q5aEQUvipGs1CtGc=;
 b=dqE9NdPmWROlmzwHNdvZs1sAHy6uVTicHN65+u4k/z65d+LxnffY2dKwCMviItezYmJCoMb/2IGJ
 OehVczLfBoJY/BoCBvco4SLF/sBDoEsAYeVZ449Ne98c5mhU00ee
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

Hi!

v4 -> v5 changelog:
- Previously the "Always set QoS params on QNoC" contained part of what
  should have been included in "make QoS INVALID default".. (very bad)
  Fix it!

- Drop negative offset and keep_alive, they will be resubmitted with new
  icc driver submissions

- use b4 this time.. hopefully the series gets to everybody now

Link to v4: https://lore.kernel.org/linux-arm-msm/20230214143720.2416762-1-konrad.dybcio@linaro.org/

v3 -> v4 changelog:
- Drop "Always set QoS params on QNoC", it only causes issues.. this
  can be investigated another day, as it's not necessary for operation

- Drop "Add a way to always set QoS registers", same as /\

- Add a way (and use it) to have no bus_clocks (the ones we set rate on),
  as at least msm8996 has a bus (A0NoC) that doesn't have any and does
  all the scaling through RPM requests

- Promote 8996 icc to core_initcall

- Introduce keep_alive (see patch [11/12]) (important!, will be used by at least 6375)

- Allow negative QoS offsets in preparation for introducing 8998 icc [12/12]

Link to v3: https://lore.kernel.org/linux-arm-msm/20230116132152.405535-1-konrad.dybcio@linaro.org/

v2 -> v3 changelog:
- Drop "Don't set QoS params before non-zero bw is requested"

- Rebase on next

- [1/9] ("..make QoS INVALID default.."): remove unused define for
  MODE_INVALID_VAL

- Pick up tags

v1 -> v2 changelog:
- reorder "make QoS INVALID default", makes more sense to have it
  before "Always set QoS params on QNoC"

- Limit ap_owned-independent QoS setting to QNoC only

- Add new patches for handling the 8996-and-friends clocks situation
  and optional BIMC regardless-of-ap_owned QoS programming

[1] https://lore.kernel.org/linux-arm-msm/14e06574-f95e-8960-0243-8c95a1c294e9@linaro.org/T/#m056692bea71d4c272968d5e07afbd9eb07a88123
[2] https://lore.kernel.org/linux-arm-msm/20230110132202.956619-1-konrad.dybcio@linaro.org/

This series grew quite a bit bigger than the previous [1] attempt, so
I decided to also add a cover letter.

Link to v2: [2]

It addresses a few things that were not quite right:

- Setting QoS params before a "real" (non-zero) bandwidth request
  makes little sense (since there's no data supposed to flow through
  the bus, why would the QoS matter) and (at least newer) downstream
  prevents that from happening. Do the same in Patch 1.

- QNoC type buses expect to always have their QoS registers set as long
  as there's a non-INVALID QoS mode set; ap_owned is not really a thing
  on these anymore, Patch 3 handles that.

- The recent MSM8996 boot fix was done quickly and not quite properly,
  leading to possibly setting the aggregate bus rate on "normal"
  hardware interface clocks; this series handles that by limiting the
  number of bus_clocks to 2 (which is the maximum that makes sense,
  anyway) and handling the rest as "intf_clocks", which are required
  to access the   hardware at the other end. Patches 5-8 take care of
  that and Patch 10 reverts the _optional moniker in clk_get_ to make
  sure we always have the bus scaling clocks, as they're well, kind
  of important 😉

- Similarly to QNoC, BIMC on "newer" (which can be loosely approximated
  by "new enough" == "has only BIMC and QNoC hosts") SoCs expects to
  always receive QoS programming, whereas BIMC on "older" SoCs cries
  like a wild boar and crashes the platform when trying to do so
  unconditionally. Patch 9 adds a way to take care of that for newer
  SoCs (like SM6375)

- QoS mode INVALID was assumed by developers before to be the default
  ("I didn't specify any QoS settings, so the driver can't assume I
  did.. right? right!?" - wrong, partial struct initialization led to
  0 being set and 0 corresponded to QoS mode FIXED). Make it so, as
  that's the logical choice. This allows the "Always set QoS params
  on QNoC" patch to work without setting tons of what-should-
  -obviously-be-the-default values everywhere, as well as fixes older
  drivers that set ap_owned = true but left the QoS mode field unset.
  Patch 2 cleans that up.

- Some nodes are physically connected over more than one channel
  (usually DDR or other high-throughput paths). Patch 4 allows that
  to be reflected in calculations. This will be required for at least
  MSM8998 and SM6375 (which will be submitted soon after this lands)

Konrad Dybcio (12):
  interconnect: qcom: rpm: make QoS INVALID default, separate out driver
    data
  interconnect: qcom: rpm: Add support for specifying channel num
  interconnect: qcom: Sort kerneldoc entries
  interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
  interconnect: qcom: rpm: Rename icc provider num_clocks to
    num_bus_clocks
  interconnect: qcom: rpm: Handle interface clocks
  interconnect: qcom: icc-rpm: Allow negative num_bus_clocks
  interconnect: qcom: msm8996: Specify no bus clock scaling on A0NoC
  interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks
    anymore
  interconnect: qcom: msm8996: Promote to core_initcall
  interconnect: qcom: icc-rpm: Introduce keep_alive
  interconnect: qcom: icc-rpm: Allow negative QoS offset

 drivers/interconnect/qcom/icc-rpm.c | 101 ++++++++++++++++++++--------
 drivers/interconnect/qcom/icc-rpm.h |  41 +++++++----
 drivers/interconnect/qcom/msm8996.c |  35 ++++++----
 drivers/interconnect/qcom/sdm660.c  |  16 ++---
 4 files changed, 126 insertions(+), 67 deletions(-)

--
2.39.1

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (10):
      interconnect: qcom: rpm: make QoS INVALID default, separate out driver data
      interconnect: qcom: rpm: Add support for specifying channel num
      interconnect: qcom: Sort kerneldoc entries
      interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
      interconnect: qcom: rpm: Rename icc provider num_clocks to num_bus_clocks
      interconnect: qcom: rpm: Handle interface clocks
      interconnect: qcom: icc-rpm: Allow negative num_bus_clocks
      interconnect: qcom: msm8996: Specify no bus clock scaling on A0NoC
      interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks anymore
      interconnect: qcom: msm8996: Promote to core_initcall

 drivers/interconnect/qcom/icc-rpm.c | 93 +++++++++++++++++++++++++------------
 drivers/interconnect/qcom/icc-rpm.h | 34 +++++++++-----
 drivers/interconnect/qcom/msm8996.c | 35 ++++++++------
 drivers/interconnect/qcom/sdm660.c  | 16 +++----
 4 files changed, 112 insertions(+), 66 deletions(-)
---
base-commit: c068f40300a0eaa34f7105d137a5560b86951aa9
change-id: 20230217-topic-icc-fixes-v5-5fbbe48ced69

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


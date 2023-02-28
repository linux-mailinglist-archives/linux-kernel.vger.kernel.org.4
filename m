Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE026A5A23
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjB1No1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1No0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:44:26 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB142B624
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:24 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z5so10278303ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677591862;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=livAJ6GGfJ6Yo5cEGXwtOwLMX6hnHXxiMTTXO2jFdVs=;
        b=z3jaSsasOAIikO5Hh7k77PFLaPQashXi4aKfFyM4Cbw3FBvpr6HWNFecxRy4ohUBpB
         sMHKf2vqg/esSUqC2oS1xZGNcjEvxK60M6+pX49wmKP4J78+LLvHIMxQZyTMACPRkbQS
         y2lT8HFWBeHeXqXmIR2drZaqxYSY0tO2VY/QUFo6yCiCqYMQqUgDILsWRdYWQDnFoloO
         NEH5wQq1UDDVn0RWEWlPPICFYiZ/iXFwUfGYS7620HdwhGq8B/djGaT4AsjXlb/YYi4x
         syDiG5WixlrCjqJy04omFRDZexKdBD8KFjakTvEudtSJ4x2b/PwPQIeXwtUUYBcaavpF
         dlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677591862;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=livAJ6GGfJ6Yo5cEGXwtOwLMX6hnHXxiMTTXO2jFdVs=;
        b=KoqkdQziS9Czo1usi0IjkjUsUXnPbxdkTNotN8oaQ3Xlqzowkxa/cKPqIxDtHQwcDL
         /v15gbQ4fpWxYVC36ac1ougqqiAjuo753l52AvrSLrsMVUi4ZW7ebaCiZi9FhGne2wYP
         49I0CU3BGUjSpTF8eTmZhftRqFQxSSPKcv9LtsP1RZs8C776t6ldw9YDNkuG/tPvjCu4
         Q77SA3NIuApIGf5WdBSAe8PirExyQe4fLTbtQHaMYPSTFH2AFL90SZhlSJOjlm0oVguG
         EzAhZbVHV36tSHDgmqW0Vj4kWxeHMF1J4y7DrAUbe0/KRTryN7BfPeKxRLem4m6pNe1e
         9/gg==
X-Gm-Message-State: AO0yUKWbef6a1thuYd6soiMujz38nV6GgM0iuU98q1F+sFDorKRfRRHn
        P9Y7whSg8J58j/KpPGZkPe3B+A==
X-Google-Smtp-Source: AK7set8hFpxLuUgdrVruez1s9H5DZshtbOi559zF7oSN13kteXR59EYavpga8mQRu+ec6DOwmJvNhw==
X-Received: by 2002:a2e:a544:0:b0:295:9517:b98f with SMTP id e4-20020a2ea544000000b002959517b98fmr3697534ljn.15.1677591862530;
        Tue, 28 Feb 2023 05:44:22 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e3c14000000b00295a583a20bsm1203975lja.74.2023.02.28.05.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 05:44:22 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v6 0/9] The great interconnecification fixation
Date:   Tue, 28 Feb 2023 14:43:57 +0100
Message-Id: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB0F/mMC/x2N0QqDMAxFf0XyvIBUHdVfGXtoY5wBaV2ziSD+u
 8HHczmXc4ByEVYYqgMKb6KSk8HzUQHNIX0YZTQGV7umds7jL69C+M2KXdt0FMj70fdgfgzKGEt
 INNsj/ZfFxrXwJPsdeL3P8wKa5SGocAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677591861; l=6806;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=wExNDR7+0rE75/CJ66KXmYxMQAnJVJqPhLy0GyiD2C8=;
 b=f04Z83CivUuXBPWMxjSQTWwGgy9jZWJW/oBqwv4yaraRbUAVVgntM8s91HEThkOwONKaAAvy1n41
 MzdJwL49C4CVMPTGdEbExG2nLVFgUihk1smI6sRmwoNRcPaou4rc
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

v5 -> v6 changelog:
- Completely rewrite the commit message of [1/9], I realized that there
  was actually no issue with the present upstream setups and the only
  drivers suffering from ghost votes were.. my own OOT drivers..
  As a consequence of that, all fixes tags were dropped and the patch
  has been kept, since it was deemed useful for newer SoCs that don't
  distinguish ap_owned nodes.

- Change the number of allowed bus_clocks from (0-2 in the previous
  revision, 0-inf in the current upstream state) to {0, 2}. Scaling is
  only possible with a pair of wake-sleep clocks, but some providers
  don't do scaling at all (see 8996 A0NoC, 660 GNoC). Drop the cheeky
  -1 / 0 / >0 checks from the previous revision. [7/9]

- bus_clocks are now forced to be named "bus", "bus_a", as there is no
  need for variance here - we don't do scaling on non-SMD RPM bus clocks.
  [7/9]

- The interface clocks are now only turned on when the associated bus
  is running at a non-zero frequency [6/9] instead of being always on
  and leaking power

Tested on MSM8996 Kagura, SM6375 PDX225 (OOT), MSM8998 Maple (OOT)

Link to v5: https://lore.kernel.org/linux-arm-msm/20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org/

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
  of important ;)

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

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (9):
      interconnect: qcom: rpm: make QoS INVALID default
      interconnect: qcom: rpm: Add support for specifying channel num
      interconnect: qcom: Sort kerneldoc entries
      interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
      interconnect: qcom: rpm: Rename icc provider num_clocks to num_bus_clocks
      interconnect: qcom: rpm: Handle interface clocks
      interconnect: qcom: icc-rpm: Enforce 2 or 0 bus clocks
      interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks anymore
      interconnect: qcom: msm8996: Promote to core_initcall

 drivers/interconnect/qcom/icc-rpm.c | 91 +++++++++++++++++++++++++------------
 drivers/interconnect/qcom/icc-rpm.h | 38 +++++++++++-----
 drivers/interconnect/qcom/msm8996.c | 35 ++++++++------
 drivers/interconnect/qcom/sdm660.c  | 17 +++----
 4 files changed, 116 insertions(+), 65 deletions(-)
---
base-commit: 058f4df42121baadbb8a980c06011e912784dbd2
change-id: 20230228-topic-qos-5435cac88d89

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


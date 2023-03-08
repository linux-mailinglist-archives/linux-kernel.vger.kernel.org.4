Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA5A6B144B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCHVlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCHVlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:41:14 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1102278E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:40:45 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id by8so18035351ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311611;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4y67UnJn1EP8QhERguzs/XDYl9emopnZBVkwzFsu1s=;
        b=AlM16nEmeLLOP5B4C/LwHMaZhpMWyWaz5qKWfVC972U+f05o+UYPCU16Gm+GGaYF6J
         ydXAP4XQivpQDw09MbSlE5n3et5qz8VVhL9uEhkjNyRcIdC7WnzAlte1OQrvevmp9JiC
         3PtkA/qZ5ZZ2GjrYsbgxWfeSYsKjWa96duDdFW8Ik5CAYhmb+7jS2Hd3A8iBW+r4xf3z
         8ABFb+byUBxK4RgmqBWg0/ewvGdUoOUHjUNGoIOzSFfQYsqUmNgRaQC6ijkHAiMkZ70A
         6KpRCqr67BjD993h4ryUfSUYLaYPtKBygbGQkz22P3eUaadJfrNGzPfSL7F7D/4Q/hHy
         09Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311611;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4y67UnJn1EP8QhERguzs/XDYl9emopnZBVkwzFsu1s=;
        b=EpRf0jN5diwky07AxhUErBwLpz0bFctcFcYYDMRjzt5P9cF8/2qhPdgalViDT2OFON
         vUsyk/dLIXJuvnoCzgws4Gc9I4jGMDshBx8xpb9i8mWMe9p7w1gwHFxRzj0uBkyV4tub
         xyX0VmET11rf1DCbh6YbMRwnZnH7li02rCfCvfSY7wmHPsH5MnCJ9r8JkT7j/p79VHYn
         osxfQwJUve1rmnkVqvXrL7//agW6KOEpRvY2FPFhlgpzgR3pTVbKbwmIo7DlgAEizKSG
         UXhHP83m0i8JfKM4zmfIjky+ZhFIqsp+hMv/D4wTcnf65IuBgPUR4JM0+Xl+gObBAfW1
         jq2A==
X-Gm-Message-State: AO0yUKUccyVggpgoaMdkcoe8gDNSnpMajxcldis/c+nD1lybCt2P52gb
        y8rMFD0iFtZ9mX2GT9Ac28FuoRI0mbAgi1+UulI=
X-Google-Smtp-Source: AK7set+7a9irLnaTluhwl5v+ckXaUZ/qbcnC+lICCmRfPwAj2U9FypC0dFez1472w6xRWQTH+f5eMQ==
X-Received: by 2002:a2e:87d6:0:b0:293:4ff3:7f98 with SMTP id v22-20020a2e87d6000000b002934ff37f98mr5760129ljj.15.1678311610743;
        Wed, 08 Mar 2023 13:40:10 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a6-20020a2e8606000000b00295a2a608e9sm2688844lji.111.2023.03.08.13.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:40:10 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v7 0/9] The great interconnecification fixation
Date:   Wed, 08 Mar 2023 22:40:06 +0100
Message-Id: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYACWQC/22NTQ6DIBBGr2Jm3WkMCGJXvUfjAhF1EgN2sKaN8
 e6lrrt8L9/PDskz+QS3Ygf2GyWKIUN9KcBNNoweqc8MohSyFMLgGhdy+IwJVSWVs86Y3jSQ851
 NHju2wU25EV7znOXCfqD3efBoM0+U1sif82/TP/tvetNYonSytrJqtNLDfaZgOV4jj9Aex/EFt
 H0SorgAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311609; l=6955;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=iOM21V8TjrP4sjARaIEDydlJTEpBK3MvpM+HE3MZ+8U=;
 b=/ERD+ya3LSUsGB5xuPWvjNLybxnPQUVCYlzb9GzdcLn9k8DXpJnx5L3d85ISn1z7kjdDG4tv6VZi
 WI0bcIZKD/DNPtCqWZfvT1QpPoi9fymqZNoMcWtVQTmLzI3TOlpD
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

Hi!

v6 -> v7 changelog:
- Rebase on Johan's recent patches

Link to v6: https://lore.kernel.org/r/20230228-topic-qos-v6-0-3c37a349656f@linaro.org

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

 drivers/interconnect/qcom/icc-rpm.c | 89 +++++++++++++++++++++++++------------
 drivers/interconnect/qcom/icc-rpm.h | 38 +++++++++++-----
 drivers/interconnect/qcom/msm8996.c | 35 +++++++++------
 drivers/interconnect/qcom/sdm660.c  | 17 +++----
 4 files changed, 115 insertions(+), 64 deletions(-)
---
base-commit: fc31900c948610e7b5c2f15fb7795832c8325327
change-id: 20230228-topic-qos-5435cac88d89

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


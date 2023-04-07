Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762F26DB4FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDGUOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjDGUOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:14:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794917ABF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:14:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x17so55764066lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680898485;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z7SCtmUuova08XpClOEdES1aqS5+J17wNI7gmcPyoK4=;
        b=Eji6ey0ZaDelp1+GovgfomlMdK11YFcyFUBAqkInWvFRhkqsLWCuy6LHnPZ/lzJ/V3
         G5QTP8M3pSt7gZnRcXDfq94QfjYxHmkuaBReZtJVZfvyD1kvryQwPikZV1th6oj23Eg+
         gdmUU1FxguUECoRAVfY4DuvaIg7s3iq+hoMeWs4rDwTu3N6LoOhxlI8Y/SxOKLwkgASV
         2kaD3ePEIe0+fySaEgKln6hnvMM2GEn8Mdo9dHChEalhMNoiYpzgDF6w8QilisoCTGns
         9vM4Mp+mFUWfZxE8zSPHJ5dUTlTIbHSpA8C5eiKhpqPCOHyiYpPV77SCnQwVG8AgD5H5
         UhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680898485;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7SCtmUuova08XpClOEdES1aqS5+J17wNI7gmcPyoK4=;
        b=yEmX6z7hfXKuizF5xC6wNcI46yPF58SkO3Mq+U+A1varJjDtfwlBUXBqoeVJHkrJHK
         hmOi8KZrBTxjRiX8jxgpHOD7+Yd+P+E+ANtuCVHIf/+F+ODWrsgroNmvbyKfI+gTBIPa
         ZxUUSZkktTqO3etC/kIi6fBLiOHSUja8AMcP3QJly7j4yySjS1a1Nkl2ynlQafDxfcWZ
         dckveN3Y4GOChI3j68EIqzjkC9PZalhjWuygP/lRZu6F86uOVX8Tuim5DgVdpMyQn89l
         ckntZz7WV9RsiwLX6Tq6LMbFrrizgKQwndZhk9q3K1BxdJlsgWI36FMlqcZOOhYTft79
         t7gQ==
X-Gm-Message-State: AAQBX9d8Kj9tS/GnRIqXVWrPspN/k3gmD12CZMN2WNEkIxvqfyxq8XFu
        02ef7V0s3XLaXzggWq12Wxrhdg==
X-Google-Smtp-Source: AKy350bTm58oK1v8nkBUE6MQuzF7QH1hQOOVp3LZ/OLYjhvlRZjViNAJISX5dLBeqzMLn22wyeEHFg==
X-Received: by 2002:ac2:4d12:0:b0:4e9:aeaa:ddb5 with SMTP id r18-20020ac24d12000000b004e9aeaaddb5mr1030468lfi.14.1680898485587;
        Fri, 07 Apr 2023 13:14:45 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u3-20020ac243c3000000b004eaf6181a32sm842436lfl.75.2023.04.07.13.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 13:14:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v8 0/8] The great interconnecification fixation
Date:   Fri, 07 Apr 2023 22:14:42 +0200
Message-Id: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJ5MGQC/3WNQQ7CIBREr2JYi0EolLryHsYFpdD+pIEKlWia3
 t3f7kx0+SbzZhaSXQKXyeWwkOQKZIgBQR8PxA4m9I5Ch0w444JxrukcJ7D0ETOVlZDWWK073RD
 styY72iYT7IBGeI4jhlNyHl77we2OPECeY3rvf0Vt6a/poiijworaiKpRUvnrCMGkeIqpJ9tMq
 f+qNar6LBVTrOHef6vrun4ANZpEI/MAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680898484; l=7539;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5+j0cKlSPZp/u3NMkZFp8pneHWZWJU/rjl7JwRNXyKA=;
 b=z+42L+x1rph1X3uZrRXHqjnce6IJwJ3dzTMGs41rwbNrBldbXt83hwPctY+nf++8h93/9rbGEF6l
 f4KbTEd1D3t2Y/VOxFIrTGaWmiSmOfg4agAk4s3ZelT0MPI6dZ/L
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

v7 -> v8:
- Rebase (dropping has_bus_pd, picked patches from v7)

- Clean up the QoS-setting functions [3/8]

- Only set the QoS registers once [4/8] - Georgi talked to some
  Qualcomm folks and we concluded that it's "good enough" as they
  should:tm: persist until a full reboot on "almost all" platforms

- Move the intf clock enabling/disabling to correspond with /\ [5/8]

- DO NOT switch to associating an interface clock with a given node
  (instead of a provider), as it makes little sense with the changes
  with [4/8] and the new iteration of [5/8]

v7: https://lore.kernel.org/r/20230228-topic-qos-v7-0-815606092fff@linaro.org

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
Konrad Dybcio (8):
      interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
      interconnect: qcom: rpm: Rename icc provider num_clocks to num_bus_clocks
      interconnect: qcom: rpm: Drop unused parameters
      interconnect: qcom: rpm: Set QoS registers only once
      interconnect: qcom: rpm: Handle interface clocks
      interconnect: qcom: icc-rpm: Enforce 2 or 0 bus clocks
      interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks anymore
      interconnect: qcom: msm8996: Promote to core_initcall

 drivers/interconnect/qcom/icc-rpm.c | 110 +++++++++++++++++++-----------------
 drivers/interconnect/qcom/icc-rpm.h |  22 ++++++--
 drivers/interconnect/qcom/msm8996.c |  35 +++++++-----
 drivers/interconnect/qcom/sdm660.c  |  17 +++---
 4 files changed, 102 insertions(+), 82 deletions(-)
---
base-commit: e134c93f788fb93fd6a3ec3af9af850a2048c7e6
change-id: 20230228-topic-qos-5435cac88d89

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


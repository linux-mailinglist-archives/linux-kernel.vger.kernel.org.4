Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155035EC5CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiI0OTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiI0OTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:19:31 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221E41BCAFC;
        Tue, 27 Sep 2022 07:19:27 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RCdWxj016547;
        Tue, 27 Sep 2022 10:19:18 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jsxt7c178-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 10:19:18 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 28REJHle010504
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Sep 2022 10:19:17 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 27 Sep 2022 10:19:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 27 Sep 2022 10:19:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 27 Sep 2022 10:19:15 -0400
Received: from IST-LT-39247.ad.analog.com (IST-LT-39247.ad.analog.com [10.25.16.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28REJ322020436;
        Tue, 27 Sep 2022 10:19:06 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jic23@kernel.org>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/3] iio: adc: add max11410 adc driver
Date:   Tue, 27 Sep 2022 17:18:48 +0300
Message-ID: <20220927141851.279-1-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: mzf2NcJ8VM7nDKtRJ0HkL6cJd8wB6Mln
X-Proofpoint-GUID: mzf2NcJ8VM7nDKtRJ0HkL6cJd8wB6Mln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_05,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270088
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello devicetree maintainers,

We had a discussion regarding the reg propert of adc channel nodes:
The adc.yaml binding requires the @X number to match with reg. Reg specifies
the channel index but channels are specified with "diff-channels" property
when the channel is differential.

Our driver supports mixing single ended and differential channels and the reg
property is not used in differential mode.
We want to constrain reg between 0 and 9 since ADC only has 10 channels.
That means we also need to constrain @address of channel but that wouldn't allow
us to define more than 10 channels which users might need to do. How should we
specify the @address and reg property in this case for differential channels?

Please refer to the discussions below:
https://marc.info/?l=linux-iio&m=166402759331673&w=2
https://marc.info/?l=linux-iio&m=166402779031712&w=2

Hi Jonathan,

I removed the check for "avdd-supply" at probe time and treated it as a regular vref.
No other change is made to the driver.

Best regards,
Ibrahim Tilki

Note: No sign-off tag for David as he was unreachable when the initial patch was sent.

Changelog:
since v6:
  - don't require avdd supply if not needed

since v5:
  - allow user to specify both interrupt pins
  - keep irq info in max11410_state struct and use irq by name
  - get irqs by fwnode_get_irq_byname
  - don't allocate trigger when no irq supplied
  - fix deadlock condition in write_raw
  - minor style fixes
  - fix devicetree binding errors reported by dt_binding_check
  - convert module license to GPL as suggested by checkpatch

since v4:
  - add in_voltage_filter2_notch_{center,en} attrs for sinc4 filter
  - add ABI documentation for filter sysfs
  - check interrupt-names property for configuring gpio of max11410
  - remove hardwaregain property
  - add scale_available property for channes using PGA
  - separate vref regulator error -ENODEV from other errors
  - don't register trigger if no irq specified
  - style fixes

since v3:
  - prefix defines with MAX11410_
  - group vref regulators
  - use builtin iio_validate_scan_mask_onehot
  - validate iio trigger
  - move scan data into state struct
  - require vrefn regulator in DT if used by any channel
  - don't require irq for triggered buffer
  - remove filter sysfs attr and ABI documentation
  - add in_voltage_filter[0-1]_notch_{center,en} attrs

since v2:
  - remove bit position shifting, use field_prep instead
  - reduce the amount of reg writes in max11410_configure_channel
  - add error checking in max11410_parse_channels
  - remove some unneeded blank lines and minor style fixes
  - remove scan data assignment in max11410_trigger_handler


Ibrahim Tilki (3):
  iio: adc: add max11410 adc driver
  dt-bindings: iio: adc: add adi,max11410.yaml
  Documentation: ABI: testing: add max11410 doc

 .../ABI/testing/sysfs-bus-iio-adc-max11410    |   13 +
 .../bindings/iio/adc/adi,max11410.yaml        |  176 +++
 .../devicetree/bindings/rtc/adi,max313xx.yaml |  195 +++
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/max11410.c                    | 1049 +++++++++++++++++
 6 files changed, 1447 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
 create mode 100644 drivers/iio/adc/max11410.c

-- 
2.25.1


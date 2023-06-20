Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33B5736E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjFTONG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjFTONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:13:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB2010D0;
        Tue, 20 Jun 2023 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687270381; x=1718806381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDDWfHodXFEZSxBoA5mHInHaQeO/xUGudLn/wW1t3hA=;
  b=XCkTEr332jDOAaMxgA3siTRbd/OwQUybrHuG7L8A0IDgtpB5ROS3OhZe
   QyibxThpBYhzIk+pUKNNLO9C1IdOanF263azvzpNCvhIeqt3N5foSVjAY
   LFR8xyQD9EWiFPHrthATGHQjhgzXejSCkJihOQxlQECGWHtkZONrox+lL
   HYpIo1WZgh+PpOvANXxzhctSYlW2y6K+ZnBJDk9Fp9yJFaVE8S9scG1qu
   C80XQSxj3CfUo81mVzxohSZkt8g6PpWCKTDzqWcN7hQUuGzJg/P4FSTLX
   Jsq8jKQVPC1z6syA7j9yLvUntjRHh7sThRXXbXXkY9doUtQupmzy8MoFj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="362409617"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="362409617"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 07:13:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="779439360"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="779439360"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2023 07:12:56 -0700
From:   niravkumar.l.rabara@intel.com
To:     krzysztof.kozlowski@linaro.org
Cc:     adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        netdev@vger.kernel.org, niravkumar.l.rabara@intel.com,
        p.zabel@pengutronix.de, richardcochran@gmail.com,
        robh+dt@kernel.org, sboyd@kernel.org, wen.ping.teh@intel.com
Subject: Re: [PATCH 1/4] dt-bindings: intel: Add Intel Agilex5 compatible
Date:   Tue, 20 Jun 2023 22:12:12 +0800
Message-Id: <20230620141212.2469148-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <254978f3-3bf3-7cf5-e2b7-69d413acf092@linaro.org>
References: <254978f3-3bf3-7cf5-e2b7-69d413acf092@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml 
>> b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>> index 4b4dcf551eb6..28849c720314 100644
>> --- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>> +++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>> @@ -20,6 +20,7 @@ properties:
>>                - intel,n5x-socdk
>>                - intel,socfpga-agilex-n6000
>>                - intel,socfpga-agilex-socdk
>> +              - intel,socfpga-agilex5-socdk
>>            - const: intel,socfpga-agilex
>
>This is agilex5, not agilex. Why are you using the same SoC compatible?
>You have entire commit msg to explain your hardware and avoid such questions...

Yes, better to use different SoC compatible for Agilex5,
will add new description and item for Agilex5 board in v2 patch.

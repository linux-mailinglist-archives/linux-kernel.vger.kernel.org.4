Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362D261070A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiJ1BEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiJ1BEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:04:12 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710F1696C9;
        Thu, 27 Oct 2022 18:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666919051; x=1698455051;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HfHar3IQc08juv9uc+HZ9315nieVcoIDk7moJyaZk6w=;
  b=M67oyDWm/D/XwpX4JGNnzHule53uGGU4KSNuTx3kXDG6UAwi8WZLd2AK
   2apu6RbYkKL5nH9+2zV/E43Ez1OfwOOpiyHGkviTZbyYEIDDjTmOWhZJw
   nKyyGYpajCmrwGql46H9/0O17as4AwA29dLE9/GVGvAly4mZtZ7pjbIXo
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Oct 2022 18:04:10 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 18:04:10 -0700
Received: from [10.110.41.43] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 27 Oct
 2022 18:04:09 -0700
Message-ID: <52cf61ed-88bd-b04e-1596-15013d613c4c@quicinc.com>
Date:   Thu, 27 Oct 2022 18:04:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/5] dt-bindings: clock: Add RPMHCC bindings for
 QDU1000 and QRU1000
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221026190441.4002212-1-quic_molvera@quicinc.com>
 <20221026190441.4002212-3-quic_molvera@quicinc.com>
 <de2cd5c0-1c3d-5d47-4896-82e32f3c0d88@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <de2cd5c0-1c3d-5d47-4896-82e32f3c0d88@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2022 8:57 AM, Krzysztof Kozlowski wrote:
> On 26/10/2022 15:04, Melody Olvera wrote:
>> Add compatible strings for RPMHCC for QDU1000 and QRU1000.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
> This looks correct except:
> 1. redundant bindings in subject
> 2. not cc-ing all maintainers
>
> so still not tag.
>
>
Not sure what you mean by redundant bindings; should I remove
"QRU1000"? "Compatible strings"? Please advise.

Also, I got maintainers from running get_maintainers.pl on
linux-next/master; is this wrong? Not sure what I'm missing here.

Thanks,
Melody

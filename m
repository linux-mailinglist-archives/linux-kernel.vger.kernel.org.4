Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C9E7355A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjFSLX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFSLXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:23:54 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD2BB1;
        Mon, 19 Jun 2023 04:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1687173832;
  x=1718709832;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=OewUY+h+NqSunDCbp/3i5bjZFxCaSZWPGqN3nwT0Q/g=;
  b=cR+uB2fvb/Kezbw6T2inPYB3A6Qa+dyTWOgiDqgFGz4pd5NNMfB6Or3s
   /u6nXsSveoFZf9i6efS0cU8fEvR06AcrULWKW23K/swW+BZZmVe3zi5Pp
   UWwT70l0KpwggSEAA2+N5eayfCe7v5vXqKYyZBU3Wuz2ibYFa4zOv0+p7
   CezQbUGaUXesdZGzAKW9z8jLesOTkkTIfvJdR5v3zHGmsE5gIfe3o4a5b
   Pw2MVbrrk1GUEwETQfu0tlTUfe/D7BEH77V8w1hrYcn/R1PjCI9DF2+HQ
   Kx1NM0KdPmERdaMMPmuibePtJictxE37KU+HA8eTbUt9mbukXkelSwZzp
   g==;
References: <cover.1686926857.git.waqarh@axis.com>
 <9487391b0565434761055b39ba04900bd839580a.1686926857.git.waqarh@axis.com>
 <07a6766e-7e2b-22fa-6f20-3a8ab7019635@linaro.org>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: proximity: Add bindings for
 Murata IRS-D200
Date:   Mon, 19 Jun 2023 12:40:39 +0200
In-Reply-To: <07a6766e-7e2b-22fa-6f20-3a8ab7019635@linaro.org>
Message-ID: <pnd1qi73dbu.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 10:55 +0200 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/06/2023 17:10, Waqar Hameed wrote:
>> Murata IRS-D200 is a PIR sensor for human detection. It uses the I2C bus
>> for communication with interrupt support. Add devicetree bindings
>> requiring the compatible string, I2C slave address (reg) and interrupts.
>
> Thank you for your patch. There is something to discuss/improve. I have
> actually only remark about DTS example, but since I expect resend two
> more nits as well.
>
>
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.

Alright, will change to "dt-bindings: iio: proximity: Add Murata
IRS-D200".

[...]

>> +maintainers:
>> +  - Waqar Hameed <waqar.hameed@axis.com>
>> +
>> +description: |
>
> Nit, do not need '|' unless you need to preserve formatting.

Yes, will remove (a remnant from previous version that had multiple
lines... Sorry!).

[...]

>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        pir@48 {
>
> Node names should be generic. See also explanation and list of examples
> in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> so I guess: proximity@?

On that list there is "temperature-sensor". Would it make sense then to
call it "proximity-sensor"?

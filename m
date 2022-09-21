Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952A25BF87B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiIUIAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIUIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:00:49 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBEA82847;
        Wed, 21 Sep 2022 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663747248;
  x=1695283248;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eQ9kdscepu/ZIW6IjLVX0T4gfipwtAWzN3YK8J7p8n0=;
  b=M+cg4qgWqPFV4RKgFypIbCwauKoUkBAJOprRwFSltLmN2QCXKE3VpKPq
   CO2S5JUtp3g2Sg214c9IcZ3k8OKXHbCdT+yFUec3SrfpVHP+u2SRyE+mD
   Qvc/xpL2qtd6sWcJv13NggC1UMkcDa3f3G3ohxjc6LiIn3z//XzPai7/D
   V5HcL2HPk+/PkWTQ5CDWRFSzDAF3JF01lJ6TXABNTbpk6zUfNbx1i0d8o
   bxEaIZGFptlmnJ8a2jyWUniDtS/lShuGCDXWqg5UAehSOvzCcgLNbhwCy
   oRMxq+9ne0GsL8U7CjKZTbCYYhWJTfaaaA8L44QEQtpeWKHc6s9SNj3kk
   Q==;
Message-ID: <9074bb0e-5490-ebe4-6518-1efd7416aa5c@axis.com>
Date:   Wed, 21 Sep 2022 10:00:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 2/3] dt-bindings: sound: ti,s3a227e: add control of
 debounce
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Astrid Rost <Astrid.Rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
CC:     kernel <kernel@axis.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220919111258.3774-1-astrid.rost@axis.com>
 <20220919111258.3774-3-astrid.rost@axis.com>
 <79658ad6-fd1c-68aa-88e0-6ad5274bea9d@linaro.org>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <79658ad6-fd1c-68aa-88e0-6ad5274bea9d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail06w.axis.com (10.20.40.12) To se-mail05w.axis.com
 (10.20.40.11)
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +  ti,debounce-release-ms:
>> +    description: key release debounce time in ms (datasheet section 9.6.7).
>> +    enum:
>> +      - 0  #  0 ms
>> +      - 20 # 20 ms
> 
> I don't see any improvements here.

Sorry, I miss understood. I have now just kept the enum values.

Astrid

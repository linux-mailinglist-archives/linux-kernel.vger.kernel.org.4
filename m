Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAAE5B2F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIIHQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiIIHQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:16:54 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B359CB69E4;
        Fri,  9 Sep 2022 00:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662707812;
  x=1694243812;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DsDCmJm5QnmY/iwJKHdd96PQQQIC67/EgZ6usBBX7d8=;
  b=FLKN6r+4gHYUDjaDFoK97ZUZuYUpOiZtuucN7p+o+MtwzigtMNIAor0H
   444Exip80DQZZObafdi3we8vv6A05/5kfnMUQVHzgQqsDP+wueV0iO1AP
   Y40UPbBtA36VCcfzs0k0Q1xssyA2yYauiWhbNCFM0OE+zopQdJNYV7uLh
   S8Wn9adU7bd9pSA3xMdIUVdW1QnFboH0EMP79jikYI4dA+T5PnMXiymgq
   4HSyng/O7Bk/Bq+mQ7zE7AWgx6L/sONuvhVT765wcP/Aoq7cXZDsKN+H9
   x1skOH4MhQu+4VulDn1E7OQsqULgBuhoXNORBqM+7ZNHe57fQ5mTHqWej
   g==;
Message-ID: <b42e7fe4-9e1b-fdda-44f2-aa87b06425c8@axis.com>
Date:   Fri, 9 Sep 2022 09:16:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: sound: ts3a227e: add control of debounce
 times
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Astrid Rost <astrid.rost@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <kernel@axis.com>,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220907135827.16209-1-astrid.rost@axis.com>
 <2b81d814-f47a-e548-83dc-b1e38857e8ce@linaro.org>
 <Yxn9o1MVMPnFO3PM@sirena.org.uk>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <Yxn9o1MVMPnFO3PM@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail05w.axis.com
 (10.20.40.11)
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 > Use standard property units "-ms".

I made it in exactly the same way as it is done for the "ti,micbias:".

- ti,micbias:   Intended MICBIAS voltage (datasheet section 9.6.7).
       Select 0/1/2/3/4/5/6/7 to specify MICBIAS voltage
       2.1V/2.2V/2.3V/2.4V/2.5V/2.6V/2.7V/2.8V
       Default value is "1" (2.2V).


?> Anyway new properties cannot be accepted. This has to be converted to DT
?> schema (YAML).

 > Doing a whole binding conversion feels like a bit of a steep requirement
 > when people are just adding a simple property, it's a lot of stop energy
 > to figure out the tooling, do the conversion and deal with all the
 > bikeshedding that the tools don't catch.  It's definitely nice if people
 > want to look at that, for more complex binding changes it gets more
 > reasonable but for trivial properties it's disproportionate.

Thanks, I am not really sure how yaml works. But I can have a look.


Astrid

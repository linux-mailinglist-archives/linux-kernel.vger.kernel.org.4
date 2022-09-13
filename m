Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A4A5B6875
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiIMHQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiIMHQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:16:29 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0762DAA0;
        Tue, 13 Sep 2022 00:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663053388;
  x=1694589388;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DG0FkOWLkuAWJO6aMBVGUAyCUusmS8pp7VWMlNga8H4=;
  b=jG61ogHFuJeaWMgpZK68tAR6beEOmun0Fy3JQANFk5v8FnWpimLPnt/N
   cJult+ARBpvinjkwEDNtIzu1F28nYv4/ZdvJ6meKvt3wEEWdbxghA96Ns
   beevI0BNajoKykAB7z7J3ipKNp2HzDitFPSZAm8NNlhz2Bcc4bDH/7tRW
   UmWxNuOEVmm2gUtzgLU/IYA95W4FBaKF+WJYslU4cZtFhgfuvHAHH5zas
   qkIs6zzVeMCQ05KyDTngjZSOZciSlKbUCoV4bFr/3tSmS5iIiaVJ/GMN1
   Pe3L24BQ1wDt7kVmVLOxSe+J6/DSHFlAqwS5dfFzWYNcVEZMAgnaCtZ1n
   w==;
Message-ID: <bdfa3f29-f63d-1fb7-f37b-0b4a1f6374b3@axis.com>
Date:   Tue, 13 Sep 2022 09:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: sound: ts3a227e: add control of debounce
 times
Content-Language: en-US
To:     Astrid Rost <Astrid.Rost@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel <kernel@axis.com>,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220907135827.16209-1-astrid.rost@axis.com>
 <2b81d814-f47a-e548-83dc-b1e38857e8ce@linaro.org>
 <Yxn9o1MVMPnFO3PM@sirena.org.uk>
 <ac2bcca1-6997-2d17-b1d6-a5e81ced2613@linaro.org>
 <9a72bd22-9298-65ce-a894-540f98745a7e@linaro.org>
 <d521d40e-c79d-b044-44b7-6f10845f4268@axis.com>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <d521d40e-c79d-b044-44b7-6f10845f4268@axis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail05w.axis.com
 (10.20.40.11)
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I did the conversion from txt to YAML.
It requests me to add as a maintainer?

Dylan was the original Author.

Astrid

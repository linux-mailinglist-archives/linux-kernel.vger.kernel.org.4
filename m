Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE0E5B5554
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiILH00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiILH0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:26:22 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB68DF0A;
        Mon, 12 Sep 2022 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662967582;
  x=1694503582;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=05diJUZu/cyIOJ1zFesddsZ3mo/aGhYsxj011+saq28=;
  b=Mz09qrGO+EY9FNSVyEief9x+TdMPqG1YUJ7D2J4FgGVxLV5heeVUJGnx
   tCOy/t+MwPJnDCRFzqH5ogrtyW5nt8S7C9BZQZn8FYVw2VeQ1u473saFV
   YqrwqhRxFce5191h5HnFT66NIOcg9xFDXRFDatdZ7ljxPO3pJ93zAPHkr
   aCdSbcMWv6Z2lyyhcY7PcYxBy+ZLHBoyAWWc5OVStH6Hm3K4BbPRLxPqz
   3WzdTFkiWX8mlbsgdhfl2hvMzFdTyLQOBUlg0j7Zj/wCN69Mql+yKe2sw
   iEi630pUcxkH18EHezFixWpH862XRQ1oKwSLV+eatRPzqPvdrVdGPfagV
   g==;
Message-ID: <d521d40e-c79d-b044-44b7-6f10845f4268@axis.com>
Date:   Mon, 12 Sep 2022 09:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: sound: ts3a227e: add control of debounce
 times
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     Astrid Rost <Astrid.Rost@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
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
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <9a72bd22-9298-65ce-a894-540f98745a7e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail04w.axis.com (10.20.40.10) To se-mail05w.axis.com
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
> 
> It's more than one property and many other patch submitters were using
> this reason as well. As a result, few TXT bindings grew from 5 to 10
> properties within one year and there was still no conversion to YAML.

> 
> I understand your concerns however I have stronger motivation to do the
> conversion, than for accepting new features.

I agree, I will do the conversion.

Astrid

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF67132D2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 08:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjE0Gby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 02:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0Gbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 02:31:52 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D80B6;
        Fri, 26 May 2023 23:31:51 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34R6VWDo086599;
        Sat, 27 May 2023 01:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685169093;
        bh=IOYx4mw7zintF8nEN+qfM8Dxs9EsGfWFPruAo4hnbd4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ZrDENuQqM9yy2kK3UFZH+PX9xh9uS+/PTKZ1GiFKu0ESzD5KMWNNZgBI5t55WbjS7
         OaIRg/tBOm+UETYY7HBOWaxcF73ZWefeGLcaghwFjj6YgFsy06RQqvlWdO5Zi5pakf
         yHArV575yVA5Mgoez2RLBzA8wkV1pwjfhtgbyvcY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34R6VWMt026114
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 27 May 2023 01:31:32 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 27
 May 2023 01:31:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 27 May 2023 01:31:32 -0500
Received: from [10.249.138.166] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34R6VSNu031014;
        Sat, 27 May 2023 01:31:29 -0500
Message-ID: <d030a431-933d-4f54-ba6a-f7bc5a12f843@ti.com>
Date:   Sat, 27 May 2023 12:01:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Remove power-domains from
 crypto node
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>, <kamlesh@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230417133308.1990057-1-kamlesh@ti.com>
 <20230417134241.oj5cmrqjeoxj2sb2@power>
 <ZG90RS4KYo0bCwF7@francesco-nb.int.toradex.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <ZG90RS4KYo0bCwF7@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/05/23 8:14 pm, Francesco Dolcini wrote:
> On Mon, Apr 17, 2023 at 08:42:41AM -0500, Nishanth Menon wrote:
>> On 19:03-20230417, kamlesh@ti.com wrote:
>>> From: Kamlesh Gurudasani <kamlesh@ti.com>
>>>
>>> With latest firmware update, we can no longer control power of SA3UL from
>>> main domain.
>>
>> How is this backward compatible?
> 
> I just stumbled across this commit since I had an issue with crypto@40900000
> not being probed on Verdin AM62.
> 
> Not sure how this is supposed to work about backward/forward
> compatibility, however this is needed for having it working with the
> latest firmware.
> 

From what I understand, newer firmware seems to hate SA3UL PD control
requests. But older firmwares just ignored the call as the SA3UL PD is
on by default. So as such, this DT patch alone wont break
forward/backward compatibility.

It looks like newer firmware is broken wrt older kernel which is
unfortunate.

Kamlesh: can you resubmit this patch with appropriate "Fixes" tag so
that it gets backported to stable kernels?

> And if there is a proper way that take care of this, it should be
> backported IMO.
> 
> Francesco
> 

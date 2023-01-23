Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9005F678C55
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjAWX5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjAWX5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:57:18 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E4F32E5F;
        Mon, 23 Jan 2023 15:57:13 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30NNupV8121145;
        Mon, 23 Jan 2023 17:56:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674518211;
        bh=J7S8O+tr8YgcZTPAhy9/Ov9M3Fj8mXK6ENoxxcWvGzY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=HNqu21Bea2kz34pQ9KTbLgfWotZabcZHCSudTRrjvFoEwr71dQXKgyE+8XMOOByj4
         97KyTPFtUUddN1ZqB7YFG9iJbdWOSYNu872a0wTzGYuAYbX/QnkUjhqyoF74lGBDQu
         JSUDsHOg43czUXiIoQWkzHaS2g3XYBlQ0U2RruU8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30NNupdH086607
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jan 2023 17:56:51 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 23
 Jan 2023 17:56:50 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 23 Jan 2023 17:56:50 -0600
Received: from [10.250.32.60] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30NNunAF035440;
        Mon, 23 Jan 2023 17:56:50 -0600
Message-ID: <3ab320ef-dfbb-eee4-f895-6f1caa6cc66f@ti.com>
Date:   Mon, 23 Jan 2023 17:56:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/9] TI-Nspire cleanups
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230123214924.27476-1-afd@ti.com>
 <f8922fbc-13cc-4f08-a8e8-08d39ab7d63c@app.fastmail.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <f8922fbc-13cc-4f08-a8e8-08d39ab7d63c@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 3:57 PM, Arnd Bergmann wrote:
> On Mon, Jan 23, 2023, at 22:49, Andrew Davis wrote:
>> Hello all,
>>
>> This series is an extended version of the series started here[0]
>> and here[1].
>>
>> We break out what was the first patch into one for DTS change and
>> one for code changes as suggested by Krzysztof. Those are now patches
>> 2 and 8 of this series (I kept the ACKs, hope that is okay).
>>
>> As also pointed out by Krzysztof syscon nodes need a specific
>> compatible, add that as patch 1.
>>
>> While I was adding that, I noticed some other dtbs_check issues,
>> so while here fixed some of those up too (patches 3-6).
> 
> Looks all good to me, if there are no final comments within the
> next few days, can you send this all to:soc@kernel.org, either as
> separate patches or as two pull requests (dts and code) based
> on 6.2-rc-1?
> 

Sure thing.

> I think I previously commented on the lack of an entry in
> the MAINTAINERS. It would be nice to have one more patch to
> add this, whichever way you want to split this with Daniel,
> adding one or both of you as maintainer and/or reviewer.
> I'd keep that separate from this series though, to not hold
> it up any longer.
> 

Daniel,

Do you want to do this? If not I can add myself as a reviewer, the
point of this series is to boil down the support to just the DTS file,
at which point hopefully we won't need too much maintenance.

Andrew

>       Arnd

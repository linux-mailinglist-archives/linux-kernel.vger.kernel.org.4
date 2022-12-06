Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8330644FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLFXeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLFXeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:34:18 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBC132070
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670369658; x=1701905658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vxeY8mVIA7CHkny4Zx5b+MvreBwEym4XdXljNgjVfXE=;
  b=MqmLG0Yd0dYcDQTJt08PUc0EX/OT8LgbOw/ZYg3ng9wzMb896A3mxcp0
   zUhoPF0L/V8YNajfaxOJK4kpOthcWW4P+lcJQOfsjCnOapH6nAMRviz0A
   bGs4zjEKTYpef21Ljll3H2borGkcB8hF9E8uvEy0cjpX+XvrrXPZ+cyRh
   Yc+dY3x/LPLXgRu4r4vaf8gYlM13omElbMqTWHsqdlNPBPd83e+J91+ua
   cGbnCfj5Dd+qdQ7ZFrhBsMS1Na4MErB1p4ylMM/hUMN5VEl++Z51owbeb
   eTIgPiiPCbNoeKEn34MHDr916wNPvnJdFKWhEJlyM3nuJ7jBLeTNh/I6k
   w==;
X-IronPort-AV: E=Sophos;i="5.96,223,1665417600"; 
   d="scan'208";a="218314231"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 07:34:13 +0800
IronPort-SDR: Cs1qfrvX85TWqENPzVy32BvJsL8wIukVxxMagcY4yHeRGDjjjMf9/clgC4dPiddqbh2vdKGG0U
 gmUU+8M85WRotL13DpbuAni48XqxY4ajmJCGwN42j+8xhRkEttvNcQHDwrdbrommkvE8a14sbf
 SaT2djxtw4pw7aNv/8+UBZt/b4++/sw67xvQNPMRWwCT6F+RM5A7e5A8VE4+cfbnKmXmPBKOeX
 3w5qx1mE4eKXeGEuxeeNKcD78WIBOIUXUrRx1ZyQiwNu8Ur5eztLBU7qUpWHTC2qzccufgcrwV
 rac=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 14:46:59 -0800
IronPort-SDR: OWwyqE2wO0MiaMtSxAoLEe1lsv05ICyZVbkLnEMZkVB0a4betR2eC1tZ9ZddMTOnQL6bnV2Kte
 Wyf2b7IiGzPSoviqPUlhLLKHSdgllD3i3r9CJbIKr+2lJIOXD1EDsOHW3YVzxjFhqu8qnv2yp0
 owxUnho2hTXppjV0fjiRmLfOMV8azGV80tqAX2fzPEiwWaYwLA6ZCXEWI0ctug7M9kxou24MBz
 SmabLJ+tpNY++PQKdmeRy1OSG2j8RLgF9TyEzjHCG8sf4jnVwniC1+7zPawdwV359ZtstAtJO6
 zq8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 15:34:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NRcFK14dfz1Rwt8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:34:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670369652; x=1672961653; bh=vxeY8mVIA7CHkny4Zx5b+MvreBwEym4XdXl
        jNgjVfXE=; b=FZOhb9vAnwhL2D+zw1g+CqDzz/DngDTfZnyI0PyGuti2mbdaUO5
        1JEXCm/0VuplTOLTWgLbcC82yUL7iy7nRQOWMXEYi0BVIJGiKmynZ+Co+iTJ08zA
        gg3S73FqFv6UH+JU5CzTjaFpr33U87+x/U0OaCXu/AiiI89dRs6hC/Jk4JNnf9gv
        kg1LgB/wkK3GzpXD0W0xJ2QeidEC//Fw5YBAiuatJHhgvfOAXxAmkoVf4ccCsG2R
        2Q0Nek9WCSa82wbH75Dmhly4MQBIDB6d21aMBoRUIZLmANeZ7ZF5MBDljds/e9Za
        gcuGn0kwH/Qn8EdFnncpyA7+yaq5mCDUn9Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jRymy70OxJne for <linux-kernel@vger.kernel.org>;
        Tue,  6 Dec 2022 15:34:12 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NRcFH0B86z1RvLy;
        Tue,  6 Dec 2022 15:34:10 -0800 (PST)
Message-ID: <9eba7529-8879-fbba-4e17-f174ef401513@opensource.wdc.com>
Date:   Wed, 7 Dec 2022 08:34:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 6/8] block, bfq: retrieve independent access ranges
 from request queue
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Federico Gavioli <f.gavioli97@gmail.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-7-paolo.valente@linaro.org>
 <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
 <4C45BCC6-D9AB-4C70-92E2-1B54AB4A2090@linaro.org>
 <d27ca14b-e228-49b7-28a8-00ea67e8ea06@opensource.wdc.com>
 <76ADE275-1862-44F7-B9C4-4A08179A72E3@linaro.org>
 <6983f8b3-a320-ce32-ef0d-273d11dd8648@opensource.wdc.com>
 <518C279B-8896-470A-9D8C-974F3BB886DB@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <518C279B-8896-470A-9D8C-974F3BB886DB@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 00:43, Paolo Valente wrote:
>>>> In that case, bfq should process
>>>> all IOs using bfqd->ia_ranges[0]. The get range function will always
>>>> return that range. That makes the code clean and avoids different path for
>>>> nr_ranges == 1 and nr_ranges > 1. No ?
>>>
>>> Apart from the above point, for which maybe there is some other
>>> source of information for getting ranges, I see the following issue.
>>>
>>> What you propose is to save sector information and trigger the
>>> range-checking for loop also for the above single-actuator case.  Yet
>>> txecuting (one iteration of) that loop will will always result in
>>> getting a 0 as index.  So, what's the point is saving data and
>>> executing code on each IO, for getting a static result that we already
>>> know we will get?
>>
>> Surely, you can add an "if (bfqd->num_actuators ==1)" optimization in
>> strategic places to optimize for regular devices with a single actuator,
>> which bfqd->num_actuators == 1 *exactly* describes. Having
>> "bfqd->num_actuators = 0" makes no sense to me.
>>
> 
> Ok, I see your point at last, sorry.  I'll check the code, but I think
> that there is no problem in moving from 0 to 1 actuators for the case
> ia_ranges == NULL.  I meant to separate the case "single actuator with
> ia_ranges available" (num_actuators = 1), from the case "no ia_ranges
> available" (num_actuators = 0).  But evidently things don't work as I
> thought, and using the same value (1) is ok.

Any HDD always has at least 1 actuator. Per SCSI & ATA specs, ia_range
will be present only and only if the device has *more than one actuator*.
So the case "no ia_ranges available" means "num_actuator = 1" and the
implied access range is the entire device capacity.

> Just, let me avoid setting the fields bfqd->sector and
> bfqd->nr_sectors for a case where we don't use them.

Sure. But if you do not use them thanks to "if (num_actuators == 1)"
optimizations, it would still not hurt to set these fields. That actually
could be helpful for debugging.

Overall, I think that the code should not differ much for the
num_actuators == 1 case. Any actuator search loop would simply hit the
first and only entry on the first iteration, so should not add any nasty
overhead. Such single code path would likely greatly simplify the code.


-- 
Damien Le Moal
Western Digital Research


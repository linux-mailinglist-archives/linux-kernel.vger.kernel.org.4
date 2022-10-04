Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D70B5F4C0D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJDWkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiJDWke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:40:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2983DF22
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664923230; x=1696459230;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xo6PXsrm963aNNXHkP/RkFctw/Yh7d0/8hzr/zck+Lo=;
  b=g/uLtsoxHam96tMJnfn6Onm78vuZ6UnOqRwZ16MmDCQhwVVuT+RbF8WM
   ny0MfwW/hbp219iRi8cxGajRjsX7H3DjLcrZp1/xDdDx8F4rfgWQnMVzS
   1+xNvx/qhN7uhpxIem2bU0TIzt06pmZb0MkzRpULEUthn1FwpD35h/Pf6
   GlrSm9pVKmvBlnaKtiCGLmrW9yPGLaBfJzVAVbjHYWcuIVUJGo53W6FlV
   qxi0j6ajMQDFZR0QhekZ3xoEc0Yzt5VMR/4VKZfVrXV8ym/14CwUCcxEU
   QSxPx4+dH7cz79WdLQOSzgRGoUDa4on1PNZ1drrqx3xqfk4eb1AZeH0PG
   w==;
X-IronPort-AV: E=Sophos;i="5.95,158,1661788800"; 
   d="scan'208";a="212994334"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 06:40:28 +0800
IronPort-SDR: ZAPVf8n9ojwmaaC8dJa6Bg61J8HW46qRJ/q69BzhSJkR0kYZeTk/EaVai3z5729YajE0tMzGX9
 3RREjSVPcPO+G36GLOwf/wrt7c8yYGFF+gkMGC+k29WbnCS5L2pamTDan5KdocfvBLClxZquyD
 D+ZU9LTezxaHEqRMxjIw4DwMVSTT+LrLo0kmn/P+fzo0mT6gvxt63sTzbwfuKXVKdtOWPEtAox
 tYVjDbraJ205cE2axf36iOlUnRwlnO0WMV3tWf3YBcJ0RwVdSwCYX6Ia9i7RNRIND+ryzNzvrU
 nOs91LB30xCILSCrih5S/SSn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 14:54:42 -0700
IronPort-SDR: 9AQ+rtDZXWcFYYMVlqrYIzMesPrcPTR74zyUrEk1Z1xmrqks9aoGdj9S5DVSum73C/kFxUxP8I
 EFi39WNYI4E2b5qb8bYxYuWaBvob3UqsFAOOSGMzJkovED3qusr/cSj79VjdtAcp7BAMlsDAZt
 3G2W/aEIr0mWM/TgOPHTzprgxvFdMboHXjMZiN/2UkbthcHvq3pmUq7kW8WMPW89MJiqYu9+2u
 9gvZRs1thxpp/tQAqZlI/xrOm6JAb3MlvAXqt9iNZ7dw7p1OJso0CKR1MhGigpitwWGFa2WeCV
 qs4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 15:40:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mht2N60SKz1RvTr
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:40:28 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664923228; x=1667515229; bh=xo6PXsrm963aNNXHkP/RkFctw/Yh7d0/8hz
        r/zck+Lo=; b=mo51zzHaiGoIODP83ULRJiipIc8J8krv/YhF2eKwOnd6VZFcxAU
        NBsrHzBF6myQDWPVNv+0yWde9qfYF5tFsCP+AJPSerNE4NRbPx7i26835CiV4ju4
        X2XvhkIlzBdjVz+kXdPEa7ngN+EhCMSPi/zGupJimah1C8E0S43ZpX6zp9dlX74y
        dj3XQq4TunTKhxWZ1WDpStZzBh8Iid1UjVNknpZHpdHcBttZw2myLdKe4nQskz8C
        kpUppfXwJMhsemjsyJvk9UgtUC3YuLxbYHtm6Q86rXIpFXo29fhFnOuRtm7WphFv
        VkxHA1V5s+GdcsZelq2M566BTMo7clOez5g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id et7i_PnCWcxC for <linux-kernel@vger.kernel.org>;
        Tue,  4 Oct 2022 15:40:28 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mht2M5VC4z1RvLy;
        Tue,  4 Oct 2022 15:40:27 -0700 (PDT)
Message-ID: <7e3a521e-acf7-c3a8-a29b-c51874862344@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 07:40:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] block: allow specifying default iosched in config
Content-Language: en-US
To:     Khazhy Kumykov <khazhy@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220926220134.2633692-1-khazhy@google.com>
 <fff022da-72f2-0fdb-e792-8d75069441cc@opensource.wdc.com>
 <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 03:33, Khazhy Kumykov wrote:
> On Mon, Oct 3, 2022 at 11:12 PM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> This will allow a configuration to specify bfq or kyber for all single queue
>> devices
> That's the idea
>> , which include SMR HDDs. Since these can only use mq-deadline (or none
>> if the user like living dangerously), this default config-based solution is not
>> OK in my opinion.
> I don't think this is true - elevator_init_mq will call
> elevator_get_by_features, not elevator_get_default for SMR hdds (and
> other zoned devices), as it sets required_elevator_features.

OK, but my point remains: why not use a udev rule ? Why add a config
option to hardcode the default scheduler ? Most average users will have no
idea which one to choose...

>>
>> What is wrong with using a udev rule to set the default disk scheduler ? Most
>> distros do that already anyway, so this config may not even be that useful in
>> practice. What is the use case here ?
>>
>>
>> --
>> Damien Le Moal
>> Western Digital Research
>>

-- 
Damien Le Moal
Western Digital Research


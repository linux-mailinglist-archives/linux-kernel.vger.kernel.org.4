Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B205626633
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 02:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiKLBkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 20:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLBko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 20:40:44 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1BA657E6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 17:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668217243; x=1699753243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A5lA+wUZxWcJcSuslJANirjjEAuPkoqkzELGkHMOFDE=;
  b=NGtJMq8ZiBvUPLc+VR27uUlbvVCv+RWu+4KHsg2LNvI6HxpbSS0AgB1D
   o9CIDgZSOETtOfZaCRUNKXO7uQMs77qzh1xIHEHPlBTUku8n4jMekVMnn
   qiI/u614oPEE5KAVZWgHQTz4x9frrc422fVToE1ArCg5e1qA11UEck4vp
   8eSKML/xe5dI1Rg9cMCBOB84/mqAEYawz2+qonLv0O/EGI/5i/hLgPapr
   WmOY95fZtGb8FsCImhNkWc8ZyugxNMJWKYtU4egW9Sg/Z4a9ekCqd0lZd
   g5ZWSG009RsUEHpivsR1ApQixmh1pRVNwROLO57ZU1WNsGcpaRTyZrWOg
   g==;
X-IronPort-AV: E=Sophos;i="5.96,158,1665417600"; 
   d="scan'208";a="216423425"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2022 09:40:42 +0800
IronPort-SDR: Txs/7jWesnXNsozgkLkbXArzOOSFPBa14lKvHV9CsaFC04Qkntlx/XK/+cQjh7Ulja8m0R9J33
 AkkaxD+ATKt5YNvLZfIpk8lcd4yWr/NV5cupOJfzRNNhxtx8iZvhDeITTXtqDAjAC62QxTXa//
 B0yIpjsFpZPgNKZdQfFWCt1zmiUzcQ84PSBYNZcjLG3FOof+5ZFWLxGt/DP3alp6+fArT3pvR+
 V9yBLKNNPmyem8h2ShOYmVbKi62HKGmbWyMoTTnRMaGXV/6VzZ4XpMaO/lgM75htAzJN1lQoy3
 n90=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 16:59:43 -0800
IronPort-SDR: 8c630MSr/bg8HGMLIG3xUH6uKA4cIZzUKNRXCRqIvSAi8exlSOwkXquWkJE3YvJBRQ5GePfxUE
 KaUuM8sCwNjs0R8E1LrZ/uj9fjJs13Sf24DlzsyQHot+xj1lGwwzziAnXX9NliNA61MFH2vqyY
 zmsP1pi9ggzt6JgtDGtwSDweicMsi/dixncJLL9+jUgsb9sPx9gcqBlNst4YTTh4JuJk7fYKUG
 vb1FF6hcuFWl/nGtSr7NVyAKn5kRRQjnpdY2BipJwmib9s9F1HSXXAihq0CharUHZLiR1polsD
 fps=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 17:40:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N8JDn4TLPz1Rwtm
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 17:40:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668217240; x=1670809241; bh=A5lA+wUZxWcJcSuslJANirjjEAuPkoqkzEL
        GkHMOFDE=; b=U7BOl34na7pMHLoUJA+5m3OJDF660WQzHJa6ZtV/Gb5uPAQGqiL
        N0mp4sLETDHvxu2gr3fw3mAjSn+mN1Kqd2sBJQrALnKnkPLrkkFuflYP0oWzF3pk
        YcgW8PnCV4nsTQcp90Z+d3R/j3rK+datfY18851TMfltlOpqekWKpDWk0gTy/v8S
        c0toPCp8CcBFYwCe6Glr0zp4u8mFu1+c2v/C6Vgaydbhi374f79refOJMoU6wTmU
        CgTiNX3irYVD+aZ8HqHLDLA624hRtvZz0jrPDMVyXPtY+Gdu84GXePV4XNreE+Tb
        rL5M47wsGd04uJTYIXECRPVPjWczvcOfM8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Lpz81LzOGUVM for <linux-kernel@vger.kernel.org>;
        Fri, 11 Nov 2022 17:40:40 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N8JDk16DHz1RvLy;
        Fri, 11 Nov 2022 17:40:37 -0800 (PST)
Message-ID: <ba1d4796-b0ce-1a63-5f9d-c9da7392167d@opensource.wdc.com>
Date:   Sat, 12 Nov 2022 10:40:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, Conor.Dooley@microchip.com
Cc:     cl@linux.com, rientjes@google.com, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, 42.hyeyoo@gmail.com, willy@infradead.org,
        roman.gushchin@linux.dev, pasha.tatashin@soleen.com,
        torvalds@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        rkovhaev@gmail.com, akpm@linux-foundation.org
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <efa623fb-686f-072e-df0d-9f5727ae1b1f@microchip.com>
 <a0201035-8cd3-f8bc-7db3-4d011cd2c35c@opensource.wdc.com>
 <5a902810-2e72-9021-e189-a1cd2aa6f77f@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <5a902810-2e72-9021-e189-a1cd2aa6f77f@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/22 19:25, Vlastimil Babka wrote:
> On 11/10/22 00:00, Damien Le Moal wrote:
>> On 11/10/22 02:57, Conor.Dooley@microchip.com wrote:
>>> +CC Damien
>>>
>>>> There are some devices with configs where SLOB is enabled by default.
>>>> Perhaps, the owners/maintainers of those devices/configs should be
>>>> included into this thread:
>>>>
>>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
>>>
>>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
>>>
>>> Saw you were not added to the CC Damien & I know you don't want your
>>> baby broken!
>>
>> :)
>>
>> I set SLOB=y for the K210 as the config help mentions it is a bit more
>> efficient in low memory cases. I did run a few times with SLAB and it
>> was OK, so removing slob should not be a problem. Can check again.
> 
> Thanks, but please check with SLUB, not SLAB, if possible.
> Disable SLUB_CPU_PARTIAL (default y on SMP) if you want to minimize the
> memory usage.

Thanks for the hint. Will try that.

-- 
Damien Le Moal
Western Digital Research


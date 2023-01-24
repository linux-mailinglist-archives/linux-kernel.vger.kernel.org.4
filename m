Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E61767934A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjAXIlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:41:14 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822A63A84E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674549670; x=1706085670;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UUb0frJwgSxSvNq2xdQNPHmq/M6CyA/nnqq7BHMOPKw=;
  b=XMSTb7wzaaARkAd8LbyVuToZdz3UKe3suwl6/J/aAewGhDZ3/+Wpvbj+
   JXPHQ4f7z5km/mrTcVCRpUK1ow+efc6Ul/kN6VP2Jbx/UsRXW+LUiehYr
   cCAMcoKxbVMVhKHeIRKYrp0URBSNsM3qU1eQt7LUwkVLApEb7u5PLrEqg
   5NtwdPNyC0ZLKOCbqVHycYdl3AeDrHULqBC6UsQbnt5Jd9EEXCdaeUYLK
   pY7uyIDiU50QTV/qh1/gNC5XPWOkywYCc8YkbTAymUHXAMbcjPbRSZpYY
   eL0E7v02FHeneE+8ZeSxY/YhGggNQH8NZlXoK13sKmT+wWvtvfkJSXd1p
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,241,1669046400"; 
   d="scan'208";a="226602547"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 16:41:08 +0800
IronPort-SDR: KaMLN4Q/hDrQpEX9RIIBsss5qHLFVCskBtlyd3veRbl0MQLFnIwJG1exfsOS933vcei/eLtFXx
 wyPHjxJa3S6D4Iq1ypV0LVp2/67vFRf3gOAn0KBfLlpcXMafk5RL13Pll7jcCcBifk4aFuoj4m
 2aRdMQm2+8fPShzY59xINo+qQ0aTih9mg4ebZnA9FoLS/vQmHY3CwLgASpMsdXGTvSm7qju59g
 +X0TO1h1lCvzkHiqrf4oEXs36tDA1/ft/TwbSiAB2xaa2HcBVbDx0yqgL8aX9TYJKW0oaGno8d
 WW8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2023 23:52:57 -0800
IronPort-SDR: SzNb9rhXXtSvRzzZHTjbI5IJEwQAJptPReVOeaT0GQMUisy9WQ+tFstXchRXibsD7K/6Uvafkx
 aJX+qWP7au4V1xYbtGAgUwSQaC8HICv5sm0SyBj5y1lMwQJYBdfWPCUR7zEz9Pir3gfwlrLMjD
 QfLj8t+A9p8vL5KELHwZD8pFwVeAsWGX62SeqszWlfICt5+VCNemhZovqEqqM1WEJaVDPp4Xs1
 jfwg+EbXsy65FUgke7jVaJX7LOIirAorS0K8qU4z15zvdGEbN8Imjzgys42R7twGfULbGMsSC+
 Ccc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 00:41:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P1L6D5cgYz1RvTp
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:41:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674549664; x=1677141665; bh=UUb0frJwgSxSvNq2xdQNPHmq/M6CyA/nnqq
        7BHMOPKw=; b=r6kCwzyWrUWkDh7QAX8bRZhUGcCwhGIC4847W2CgymFqmXBp605
        VlPj4sixdbOQ8u5YvmVRqLA1vlTi1gXE+9TXpOE045Wl1dZ0XKbgQ6eeBZHihqE1
        xDc9q1s8NXCSiItw+f4Wgn81NeWyHHZ8kLBmmS5LsBG9W7MA7t4s1d3Zp2XD4J+9
        6++raAWYQ/zzYdD/NB8hCSWGm3kbFg1ueyNvFdB8KQM4aGnda3eHm9MSiGZcPWP6
        wXjil5ugXYSzJPO468HKf3Yfap4ryYEejehZgifukOiGURFGGavmiiO2YSovqlvW
        sT8owyxsxYc7FTrW3oaQDyK2qLEMDu5eEtA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UEcddrtpbPYE for <linux-kernel@vger.kernel.org>;
        Tue, 24 Jan 2023 00:41:04 -0800 (PST)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P1L672v9Jz1RvLy;
        Tue, 24 Jan 2023 00:41:03 -0800 (PST)
Message-ID: <6073061b-138b-499c-6de1-5196f191b176@opensource.wdc.com>
Date:   Tue, 24 Jan 2023 17:41:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: manual merge of the zonefs tree with the
 vfs-idmapping tree
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230124085951.59eb8da3@canb.auug.org.au>
 <1631b427-9efd-cd26-5dbc-0143097f859b@opensource.wdc.com>
 <20230124102535.1e21a533@canb.auug.org.au>
 <87958074-baa4-b6c9-da0c-d654e4009611@opensource.wdc.com>
 <20230124110745.5c9b78b0@oak.ozlabs.ibm.com>
 <8871d62a-b87f-75d6-fb5d-d9811a3e5dae@opensource.wdc.com>
 <20230124083235.6fhvnjgl4bzuzwuq@wittgenstein>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230124083235.6fhvnjgl4bzuzwuq@wittgenstein>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 17:32, Christian Brauner wrote:
> On Tue, Jan 24, 2023 at 09:11:47AM +0900, Damien Le Moal wrote:
>> On 1/24/23 09:07, Stephen Rothwell wrote:
>>> Hi Damien,
>>>
>>> On Tue, 24 Jan 2023 08:30:29 +0900 Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
>>>>
>>>> OK. I think I will merge the 3 patches that create the conflict and rebase
>>>> the patches. I need that for retesting at least. But given the size of the
>>>> conflict resolution, I may push that as an update to my for-6.3/for-next
>>>> branch. Let me see...
>>>>
>>>>> Alternatively, just leave the fix up to Linus (but mention it to him
>>>>> when you send your pull requests).  
>>>>
>>>> Understood. Let me retest first :)
>>>
>>> When I said "merge", I meant literally "git merge <some stable branch
>>> from the vfs-mapping tree that contains the conflicting commit>" not
>>> cherry pick the commits i.e. you would need to coordinate with
>>> Christian about having a common branch (or making sure that the part of
>>> his tree you pull in is immutable).
>>
>> Yep, cherry picking did not work :)
>> I did a merge test and came up with the same resolution as you did. It
>> looks good. It looks big but is in fact fairly simple. I will keep it as
>> is and signal it to Linus when I send my PR.
> 
> I don't rebase branches after they're in -next as soon as someone
> wants to depend on them.

I understand that. Nobody does.

> 
>>
>> But retesting everything to be sure there are no issues.
>>
>> Christian,
>>
>> Next time, when you touch an fs, please cc the maintainer for acks. I had
>> that zonefs series ready for a while and we could have coordinated for the
>> conflict...
> 
> I understand merge conflicts aren't pleasant as I'm dealing with them on
> a regular basis myself and I'm sorry that this is causing churn for you.

The conflict is fine, I can handle. I was more surprised that patches
touching zonefs were applied without acks from me.

> 
> Similar to other large branches such as the initial folio conversion
> that affected a lot of filesystems and other branches of mine it simply
> becomes impractical to generate a massive recipients list.

Fair enough.

> All filesystems were touched in non-semantical ways and simply replace a
> vfs type.

That I saw :)

> 
> One of linux-next's tasks is to find generated merge conflicts so that
> we can coordinate. As usual, I will send a list of merge conflicts
> caused by one of our branches to Linus and point him to the relevant
> threads that Steven reported with proposed resolutions as he prefers to
> fix them up himself.
> 
> Sorry for the inconvenience.

All solved now. My morning was only a little more busy than expected
dealing with this :)
Thanks.

-- 
Damien Le Moal
Western Digital Research


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819BD68CAEB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 01:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBGACj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 19:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBGACh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 19:02:37 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A23417140
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 16:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675728156; x=1707264156;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yIILzYCcjLp2tVEtzbfoT4seV8GM2Y4g3HEmolE1Uuc=;
  b=gPBaPSMr3o3fglHDqgxokpNpTm8Tsq++rW5AYMvKfSiOf8BaxoaR+Wml
   cxhLXQhSLZ8CSdWoAgE/hFQCHzfhUNaEhj8htgI4z5R9KxA4G56UoZOfu
   j86RYN7U6hFU/Oc4LuLcnwWT4X0U5biDXMEXaAlExSZnSLkZRHIPhrC3E
   txl0alLP4H3RTuTr825N+q0tBAwzoa7Mdq/XaA13P/euOKsjphY1dokkt
   Ve34UtFZcANoq+5/MHVJPRkof0St3WWI2Mkl8Nth64hZ+IGFkfnSvrqVH
   +2j/tZLCJ9svw5xC5vvmyUrUMxpmWMM8WU29dX1DBE9Imb7kRBdxa1sBJ
   g==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669046400"; 
   d="scan'208";a="220974929"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2023 08:02:34 +0800
IronPort-SDR: coW0NJ/+AAVlNg5CbdZAILsxeyCAOpiXZuZqX+ENjMpRnX65nouT/Rs6CouuHjOfdqD4fOI/eX
 A2sUeZINaKpEShCEY8pi8rI3QqwOnekyP2i3YVNlmnjiGwp3WBxJ9ZT/8OFp3C8UTC2bo3FZPA
 iTain4sTyMt+QJozcdIK5q6FuBMs5xCj+0H8FCdJBegH5s20MfGgHXHXvMsy8sxXqUtjP6iRAD
 2FXMHCSpQKYmGQOMZD2PPJtzyei5jnErAz9xNLfzqzTRjcg3pd4ABGWeh/PXQtxlqFrG5lySkr
 Nkc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2023 15:19:51 -0800
IronPort-SDR: 0urPiEdZQqAVE7rczdVeYjMN91JYkQtHYKx84PklOEH80lWRvm5/E3cPzA3FAzYsERflB8/38L
 Vdxt+RNb3icMFw/02m6+YSKZ6C17cN26YKCDDaZaXFfDK8dvbDApl2b58jkS+6j7LPL6+eTNL+
 XyzsdU4sp6u9LZiyiV4mplGIDLZelgUdrRCXd9hdx95crZCJUCNnkj7kbgq1+77AHU9433l02I
 eOXF4DeuAntaEgUZ9hvY0vS+4y67gLHoFRUBxpWEqyS0j3PWvpDdnBQ9qM81C2yM+AFTWc4Jg5
 twk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2023 16:02:34 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P9jxP6vRrz1RwtC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 16:02:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675728153; x=1678320154; bh=yIILzYCcjLp2tVEtzbfoT4seV8GM2Y4g3HE
        molE1Uuc=; b=HqIYs8r/GoSN6NzdbYUtYnRT7iAsoYp1CdgEooJ9d2YCrVFLfzb
        rjEttICX1G/oxDPb6AwDU7V2TQJB+HfJaf1M88xEH1vsUFzhMYbRnHaptWM7l3y+
        0N/93UZf3/zIpKVs1GgeYskEr8olM7rJ3MTh1mJzLj57GqlNjpfQF0p5wYlWq0S2
        Na4PZ8u2htHUX8QXv1HmrZ8E3zqd2Gmq/NnVSby3EuLZr2E6J1MHcfVAe7i4gJW1
        70gb/GfBIdcQvJCl82dQ2P89ZcTAUaYyEBY7mSFZSS0GMZKDQADgu59DkEkmqfXS
        7WQ6T4EXJatWSwa5lc9VZYa5cr6xtn4mFmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mn3pEenXsnYJ for <linux-kernel@vger.kernel.org>;
        Mon,  6 Feb 2023 16:02:33 -0800 (PST)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P9jxM5t2Mz1RvLy;
        Mon,  6 Feb 2023 16:02:31 -0800 (PST)
Message-ID: <605df8c8-ee93-9411-f90b-5b80102b8f79@opensource.wdc.com>
Date:   Tue, 7 Feb 2023 09:02:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] pata_parport: Fix ida_alloc return value error check
To:     Ondrej Zary <linux@zary.sk>
Cc:     Dan Carpenter <error27@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y9uwqRothHhaOeDO@kili> <20230204205527.16716-1-linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230204205527.16716-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/23 05:55, Ondrej Zary wrote:
> pi->dev.id is unsigned so error checking of ida_alloc return value does
> not work. Fix it.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Applied. Thanks !

-- 
Damien Le Moal
Western Digital Research


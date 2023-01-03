Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ABE65B967
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 03:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjACCd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 21:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACCdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 21:33:53 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF3CFCA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672713232; x=1704249232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m7CZUEu0rfN0SOVohyMC53s9FO7RSU1uMypinK6ksRk=;
  b=MkmcFfyh349uaZxQYuHmu39fd1XFfuZzep+UsKgCKOqog45ibhmwobyY
   5QVX96SqTL5tlSQBNFn3q+SgHGfeMKE6zz+ycPQym/aLT0FMS28LPUVwv
   8cNoxtozNvgIP0sfDSKMBDH41HNd7hVyOKVTjlpvoaGOFcnnWd0WsmeOe
   vwIB47k4tEbmGiPWFOW5zLCxQjgJ+dETaWjXn69Nj6cW5SoQsHqAX8zja
   hdQVTD3YLlcr+KcYi0i1YKrdyDlQQSwJGuEuAT4JjLFrXtUpSAP9bo3BQ
   Rim9M0iqRBYpCha+c0qlGhpweJx85Jb6+gDoLNx+Jjz0VJ708yyuglnga
   w==;
X-IronPort-AV: E=Sophos;i="5.96,295,1665417600"; 
   d="scan'208";a="224959415"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 10:33:52 +0800
IronPort-SDR: OSy61GTZd4VWxIi8+RWw2gg+/bdXh93jY2q750sPvkfMvI1s59ktdtzpafcfskZEtBq9fSrYkm
 kwJeKfgl4JJ8S6LK31XJUD5q7tB3RExU5KSstf7VOl3oHpj/3zXMLtIENbTJmjlXl8FF5DO5PD
 +ifW9yP8R9mS8IRNgY63jLT9e0W4AGYtNJjoneBGguOGSquRsQEs/68c8ttFn2hB2Zp/GSZiTs
 KtAmgdsbE059OLiQmmoLnmbE9KnVS1iiH6VeW3mB54kHeXlvdMDUOOlVfDGzBW+fO1ZLuEPxfr
 2XA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 17:46:06 -0800
IronPort-SDR: TGiT+cDuhoqcGrlvqC2VOlZgyRccDE0oEujwjQAM37e9X2vOPBbXI8TKO7IKx/3Q1rvUg9GDjc
 g8gR+0FNvdrm5od1uzncdZs6c715qcmmW7s4GbA5BVHDBCeBySVy5fxOPWY61CD3GEd5uX/D1+
 cyaSwDf3FZwcxhHEN3bsr88uVw6iozjq1Yrt68ayUW3strrJhFOklDW8w3yc94q8baqxTS73oh
 kCwAe6O9EoKypgopexD1ZCa1nVK7kgfEYSI+Fqk+dizm3uqzoE2rYxs9wU759wUBrlwGP3TnKc
 8rA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 18:33:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmGy80Ps2z1Rwrq
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:33:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672713231; x=1675305232; bh=m7CZUEu0rfN0SOVohyMC53s9FO7RSU1uMyp
        inK6ksRk=; b=G9qql6fVwHBAZmPI0LXOsmy3znq7MttXL2EiNnxJznnZ8/kwDwe
        n8EK9lPE1E7TkhzwL7jOPLxJcTiYR2ohTP5I/IPtyllCTwL5Rc6jgHysimGcaNJ6
        wtFYx3UmWTyukd8McTe0nwXKj3oarUaYIIENk5TOID0bsk6BnxcoAmTv2ZD+eEsr
        CgND+8KnNLHOZp+1OmvI3pYVm+puTu3iimRmloL/awchHfahFpEXoIBhUqVgCbyE
        tLRVDGbgSGC2XHcA0Z+dQIbHnXzExUcIDpbuN4O2+NXqU6S+ULEc3imB0Sq7Wdi6
        k4fdythtP+euHvI8yv0hFnn0kv8NVdHV7GA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yz8qOW8R0cD8 for <linux-kernel@vger.kernel.org>;
        Mon,  2 Jan 2023 18:33:51 -0800 (PST)
Received: from [10.225.163.3] (unknown [10.225.163.3])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmGy62mDSz1RvLy;
        Mon,  2 Jan 2023 18:33:50 -0800 (PST)
Message-ID: <d4613092-e29d-574e-9d1e-4f5a3eca8b56@opensource.wdc.com>
Date:   Tue, 3 Jan 2023 11:33:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 7/8] block, bfq: remove unnecessary goto tag in
 bfq_dispatch_rq_from_bfqq
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, jack@suse.com,
        paolo.valente@linaro.org, axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103095303.2223546-1-shikemeng@huaweicloud.com>
 <20230103095303.2223546-8-shikemeng@huaweicloud.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230103095303.2223546-8-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/23 18:53, Kemeng Shi wrote:
> We jump to tag only for returning current rq. Return directly to
> remove this tag.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  block/bfq-iosched.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 9ff424c78e9b..a11be312ac77 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4966,7 +4966,7 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
>  	bfq_dispatch_remove(bfqd->queue, rq);
>  
>  	if (bfqq != bfqd->in_service_queue)
> -		goto return_rq;
> +		return rq;
>  
>  	/*
>  	 * If weight raising has to terminate for bfqq, then next
> @@ -4986,12 +4986,9 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
>  	 * belongs to CLASS_IDLE and other queues are waiting for
>  	 * service.
>  	 */
> -	if (!(bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
> -		goto return_rq;
> +	if (bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq))
> +		bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
>  
> -	bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
> -
> -return_rq:
>  	return rq;
>  }
>  

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research


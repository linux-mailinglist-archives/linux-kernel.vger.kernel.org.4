Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0830F647B92
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiLIBqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLIBqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:46:09 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C385179CAC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670550367; x=1702086367;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XTiN2sIKIG3nGeB11c5KGlQQNx+mIfr34pi/QYArEGQ=;
  b=V6xfG+0kTXfSr0xVXLfMVqNUiqz5LiKQ3EJ3nan9/1ygY3Dbyg21ifI9
   iBFNTK1FSK6ceHMADobB1vjUhrN72QHlb1dODvf5kL1ZFVE6RvYEsOKNL
   ANxOUvRtdeOZa+MwsMZGiiPLVI0vrHnxQf9c5FG1D16K54iaiYIQhdEG4
   kf0fZeDpJvQmdRqu+5vsMRwDZUv80WTlOUk/R7Hf+5vde3+xSM0vgV4MR
   dbf780nuYJTyVvsgO+va0kZGwRw36Ks/zoNYBIzclPW7zZs2D86GRdCEp
   01kyP+RhLPwM/25A3MQwB/noCTbDR78n9Q/AcQhmSlq0ezOTfdyvyB2lt
   w==;
X-IronPort-AV: E=Sophos;i="5.96,228,1665417600"; 
   d="scan'208";a="322601496"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 09:46:07 +0800
IronPort-SDR: IAoKAfUAKd39lGvBKV33jLxBBh8a5cr2MxTSw0onXvT3/98UJZ7sMqkYU9Ng1Nr74MFV7Gb3BH
 VRFv50/7GPrOT3bOgrHI4eA+GljrXhLCNUOTbA3VkvSj1YypjcVHIc6Ui9ptSlRiiKCJxfFI9z
 gFG7Kj8EelpW/RhBtTSBk9AxhwKOdYPxv/X8lGvIb590IGi4QfdH/fCOj/M5Ta/UzAriuv848G
 vebRTa5zLBRnUy9UOpM1eZ3vlxRpp1NCJn40GW6ZlgctYB1eGIz+PaP2J7BI30r0jerM1/cyRg
 0Ec=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 17:04:36 -0800
IronPort-SDR: QtiQPoony2+Fsv9IGo0LvEUAZpD+xpSoV/0ttguvRZ8DfB7hLaxRMKVtTq/xSXybbbe/JFqomf
 mNCApsiKxA8t3+cW7YDGvAyyoLsY++Zh9dlnLl0J5umkZgv99YnMYax23qFCDU4eP0BlpPVfx4
 CsH8ZijpEae/8fmYyhZb/a5XxQ57+NM9qEthUrhEokmBbYr46OQvJl4EMDx+oZVYnmzsAbb6ok
 LylygTfBHX8FcYJ5Ug09V0t4LW5A/dmPcZMIdQjS5jo0jS1493I4/nSwaTAlDhZUTA8IctlLdH
 tKY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 17:46:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NSv4Z5NZ8z1RvTr
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:46:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670550365; x=1673142366; bh=XTiN2sIKIG3nGeB11c5KGlQQNx+mIfr34pi
        /QYArEGQ=; b=Tstr7M50L/ynXzMXY0G+asPqEABEV61zYPWXH+Y2MqEcLtAtxdA
        iwk9+i4zVTZ/++69FqszRKzJ9/vTqI5Tr2vfx7/r23I73CAkW/4QnMuLWG5DHqEB
        Eo7ZCkxELrzWgi8D2r4zA7tBR7417fv5Uq7CK0Mc4vTqbpx3lS95/yFEdrdBo32X
        FMHBF0dB7RzENSLql8OiiVoGELNA/yrEhGtgmO9gLe7HaYazh/Ml8Mtxa6Ewk1fL
        MOW1BSsck6nK7dJiudjPSlltdFh/urZhsP6LNwam4C6CKydQ4uI9Zx1YlAEvlu7k
        7Q6IJH7mPzi1RpMOH2zEXSmW/TbOy4VBkGQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rp1jokFzgLJ9 for <linux-kernel@vger.kernel.org>;
        Thu,  8 Dec 2022 17:46:05 -0800 (PST)
Received: from [10.225.163.85] (unknown [10.225.163.85])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NSv4X4gpYz1RvLy;
        Thu,  8 Dec 2022 17:46:04 -0800 (PST)
Message-ID: <2678a347-188a-1f2a-27ec-67e7caa38175@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 10:46:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V9 7/8] block, bfq: inject I/O to underutilized actuators
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Davide Zini <davidezini2@gmail.com>
References: <20221208104351.35038-1-paolo.valente@linaro.org>
 <20221208104351.35038-8-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221208104351.35038-8-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 19:43, Paolo Valente wrote:
> From: Davide Zini <davidezini2@gmail.com>
> 
> The main service scheme of BFQ for sync I/O is serving one sync
> bfq_queue at a time, for a while. In particular, BFQ enforces this
> scheme when it deems the latter necessary to boost throughput or
> to preserve service guarantees. Unfortunately, when BFQ enforces
> this policy, only one actuator at a time gets served for a while,
> because each bfq_queue contains I/O only for one actuator. The
> other actuators may remain underutilized.
> 
> Actually, BFQ may serve (inject) extra I/O, taken from other
> bfq_queues, in parallel with that of the in-service queue. This
> injection mechanism may provide the ground for dealing also with
> the above actuator-underutilization problem. Yet BFQ does not take
> the actuator load into account when choosing which queue to pick
> extra I/O from. In addition, BFQ may happen to inject extra I/O
> only when the in-service queue is temporarily empty.
> 
> In view of these facts, this commit extends the
> injection mechanism in such a way that the latter:
> (1) takes into account also the actuator load;
> (2) checks such a load on each dispatch, and injects I/O for an
>     underutilized actuator, if there is one and there is I/O for it.
> 
> To perform the check in (2), this commit introduces a load
> threshold, currently set to 4.  A linear scan of each actuator is
> performed, until an actuator is found for which the following two
> conditions hold: the load of the actuator is below the threshold,
> and there is at least one non-in-service queue that contains I/O
> for that actuator. If such a pair (actuator, queue) is found, then
> the head request of that queue is returned for dispatch, instead
> of the head request of the in-service queue.
> 
> We have set the threshold, empirically, to the minimum possible
> value for which an actuator is fully utilized, or close to be
> fully utilized. By doing so, injected I/O 'steals' as few
> drive-queue slots as possibile to the in-service queue. This
> reduces as much as possible the probability that the service of
> I/O from the in-service bfq_queue gets delayed because of slot
> exhaustion, i.e., because all the slots of the drive queue are
> filled with I/O injected from other queues (NCQ provides for 32
> slots).
> 
> This new mechanism also counters actuator underutilization in the
> case of asymmetric configurations of bfq_queues. Namely if there
> are few bfq_queues containing I/O for some actuators and many
> bfq_queues containing I/O for other actuators. Or if the
> bfq_queues containing I/O for some actuators have lower weights
> than the other bfq_queues.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Davide Zini <davidezini2@gmail.com>

[...]

> @@ -4792,22 +4799,69 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
>  			else
>  				limit = in_serv_bfqq->inject_limit;
>  
> -			if (bfqd->rq_in_driver < limit) {
> +			if (bfqd->tot_rq_in_driver < limit) {
>  				bfqd->rqs_injected = true;
>  				return bfqq;
>  			}
>  		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct bfq_queue *
> +bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
> +{
> +	struct bfq_queue *bfqq = NULL;

I do not think that you need the NULL initialization here.

> +
> +	if (bfqd->in_service_queue &&
> +	    bfqd->in_service_queue->actuator_idx == idx)
> +		return bfqd->in_service_queue;
> +
> +	list_for_each_entry(bfqq, &bfqd->active_list[idx], bfqq_list) {
> +		if (!RB_EMPTY_ROOT(&bfqq->sort_list) &&
> +			bfq_serv_to_charge(bfqq->next_rq, bfqq) <=
> +				bfq_bfqq_budget_left(bfqq)) {
> +			return bfqq;
> +		}
> +	}
>  
>  	return NULL;
>  }

Otherwise looks OK.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research


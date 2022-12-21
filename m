Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D75E652AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiLUAur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLUAuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:50:44 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC6DEAC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671583843; x=1703119843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mgy4QsxpsG/BZ8QSqbrCL7R/weUFusCtMwcZ/VyWzwI=;
  b=remtmQtevh1ZKwTsxeMN0kwJI8p5u7pmcsPFfwWPqOTgFJYBLJRLg4jZ
   cojeCkr5ra1F+OmkFYyAfrg+NS4awQNhYfxkniC9BFd85GPfwscc2DIyb
   p1Q4BjH/86TuASHxQLbpyUA1wPg6D8y4P7mmQKLteq93j/9JYVFJeqQ3C
   n1Ai97Jla3KGVhJy2KeI9CcNh4Stg1t8nK++9G7p95/+oyWTtZuEvpWcv
   Hua1Cij2IXXndSSTIx/jZOLVP5Z/LfCocur+0nUsLouMV5o4BEeGrNVXr
   P6htnyCgyqfugIgErt0W2JQanj2R72d+v7p1kgDyC/utZVw6C/WvB+rPy
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,261,1665417600"; 
   d="scan'208";a="219336234"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2022 08:50:41 +0800
IronPort-SDR: s/Dixj2h4cU9ZZqhMUwL3bKObAI0bTLDhX27O94doz8T/+KRDlJROjYVXwQbYmyeG3umX2N1w0
 pr2lPNqmdsQtiJuWKSz8mpG5pzL7YmO/hK0IcnS+0ZUM0oop6DoS/8g4o9t5Kpw8hWVIc/ZCSo
 oRe3FkWzNlJdjoJxt1seDwqGIgR41FDXOR+9ddZPHMvi813jNC+33Nc9WOUyqPeLL6BW8Ip/Ay
 tLruYJhEm0oeNv30GAEz8H3ux9hcbZCQV/kxg85BT4IiUkPWrbnpWm6pVKgBkmsudFG9X8hSYe
 YDE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2022 16:08:56 -0800
IronPort-SDR: C7ttfXAjIYrLvzclU+swGgL4Qu3XYAlxcTnkTMcOk2xoPXYkqErC2++G7J7MP58U+rTKx/G2iJ
 BIW/KzK7KssSis5gmQqFCAr9/VKIzsSx0iM1/D2Dj/EGparkikSmwdN9o/+j8ANFFPf0cQVJ8u
 Mny+X4oTkX0Go2CketGcPEsG1OtsWbOejStc1itsdey0DSkmwEQ8hxs/6sysQ20LYrXT4esof5
 GT2SMkTaGOYx9HubfPTDQMel9apBAR2/oUhe7yBkvZFQ5kZAwWK54Xi/rI6UXaXbs3OrosbSNM
 FsI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2022 16:50:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NcFH50wcrz1RwvL
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:50:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671583840; x=1674175841; bh=Mgy4QsxpsG/BZ8QSqbrCL7R/weUFusCtMwc
        Z/VyWzwI=; b=SIsjgvseVLqJLxGdAr1X09eS9g9tD9cXJSa9Ny1lGW9cxwrMP7V
        094e1HPfMPY3+vtMZpFZjPO0u+e/z3LOHA+YaFEl61s6wkZXIxDt31IgqTXSPnqV
        pGh7qCfHr/pcN0QZ362ts+grXogGyIrcqF3DFcPq9TKzHrIl+Bkmt90NXoYfMdAm
        lL5CJWPwMD2nrqvfNeGsuE0m9DAOYLAxsDfSV8uhKS5gN99pwTnIaTIzTigby6fS
        0whQp6bnn/PqTIU+QDlfqpLSRq+duyyXlfl6Yl53LaMEPFYfs9JtRXNhfonJlDvW
        W4JnctW0+oclxmz+odFF0cEW2pD9+ghS/Zw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6oQQZMFspf2r for <linux-kernel@vger.kernel.org>;
        Tue, 20 Dec 2022 16:50:40 -0800 (PST)
Received: from [10.89.80.120] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.120])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NcFH30Y8wz1RvLy;
        Tue, 20 Dec 2022 16:50:38 -0800 (PST)
Message-ID: <eb58939f-567e-c0c1-bafb-383f18f3d58e@opensource.wdc.com>
Date:   Wed, 21 Dec 2022 09:50:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH V10 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
 <20221209094442.36896-2-paolo.valente@linaro.org>
 <cd41583b-ef11-a3b7-1e39-c4a224050c7d@opensource.wdc.com>
 <60582F89-8020-4468-80FE-BC52202D1129@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <60582F89-8020-4468-80FE-BC52202D1129@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/20 22:10, Paolo Valente wrote:
>>> -	/*
>>> -	 * Does queue (or any parent entity) exceed number of requests that
>>> -	 * should be available to it? Heavily limit depth so that it cannot
>>> -	 * consume more available requests and thus starve other entities.
>>> -	 */
>>> -	if (bfqq && bfqq_request_over_limit(bfqq, limit))
>>> -		depth = 1;
>>> +	for (act_idx = 0; act_idx < bfqd->num_actuators; act_idx++) {
>>> +		struct bfq_queue *bfqq =
>>> +			bic ? bic_to_bfqq(bic, op_is_sync(opf), act_idx) : NULL;
>>
>> Commented already: why not add a "if (!bfqq) return NULL;" in
>> bic_to_bfqq() ?
> 
> You have probably missed my reply on this.  The problem is that your
> proposal would improve code (only) here, but it would entail the above
> control for all the other invocations, for which it is useless :(

But then you have *a lot* of "if (bfqd)" tests that are useless elsewhere since
bic_to_bfqq() never returns NULL.

And for this line, I personally would prefer seeing something like:

		struct bfq_queue *bfqq;


		if (bic)
			bfqd = bic_to_bfqq(bic, op_is_sync(opf), act_idx)
		else
			bfqd = NULL;

Which is a lot simpler to read.


-- 
Damien Le Moal
Western Digital Research


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF5C5F60C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiJFFqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJFFqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:46:17 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B1489CF4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 22:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665035171; x=1696571171;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yp/8wvTHZ3BOX6ZZhXm6bW9O1sqoUyHC8hQp3/BcelI=;
  b=SZ8Z+05t1I7QaM/8cBZcbnMRqd5VzaK32yVyDPriWnL6b17YfHwpmIvc
   deADxQdSZbJgh2kFxsBOdZ7jGe1q5MfR3pgH7dbwxEf2v+Cj9qVImyfWL
   /o9k3cWC1cjdtWu9lH/R8c2szm1aLbAFXt4w41jGC/a8G+Vzoc8Z/6pWg
   982AV2NMMxWhxGRLUwb2gXl/MZ3zXTUIPM3Ba5QiW4ytjY0mq9z5AzNsg
   T2urby0z+Ywpw7AdlSwBmpe20j2DsOr+rNPbKy5dg6c1thX7JE56vgW5b
   85qejpKGyM/MuVHC20ucSmaB6QCMB3QkuEendnULuaPEVYarbFOHt1liH
   A==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661788800"; 
   d="scan'208";a="213109327"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 13:46:04 +0800
IronPort-SDR: 66vzhfAK91bAwIK1s/l6SX6WXd9uoqIcs+zu3/tA5OGRK4lwHe/hOStxt9GN7qGbFo+dwDqSDF
 knGMUedWtS7eQIGEHul8LL29OuwDCZX1gqMdiWb1wwM0v6mlqiRq/0xi1Vb91hoWllQOwssgUk
 HfhfxcI7yWdGOyiQDoLBkEm5XuQ67UJfa5MTwdK5zyvbiT5iMRE/Wq/jz+w1thUh4MOaOVj/nT
 sI3gs1EnJNt+VU5ta84ZDUxk3kuPHUicVyCx4u/kVucdYAiMA7Ah1zrTCfb3wJUH9suRRl4a9i
 APXjGPO533jNpHq4vQT5YblO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 22:00:15 -0700
IronPort-SDR: vlAJfu4bLGMwo+Oin2sOWZR+GRkJWfrHRmul5FoIjiC+X90zWP55Mo3L5f1+XFjgbhwgtawivT
 saERO0Fop1iMBDuESI3wbnyZZu/FbNGaW39kp7m0ZhnaxbSagrRoXFtADuuryUDd+Wi+ObmCpu
 sKRfdDF+2s4yNqu4z+hbA+H+gP6h/if0VFtf9poGezzJ64XsLkYQ3B9K2V3p/3LaEfOO1y7ezO
 5Q3IxZ+u6nhFwMgB5iOrT7A48A3s0+zVWq6AAiow3ISmIHYimGXmGjEslnhVIHPYTkmLqINDZL
 eXg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 22:46:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MjgQz51YXz1RwqL
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 22:46:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665035161; x=1667627162; bh=Yp/8wvTHZ3BOX6ZZhXm6bW9O1sqoUyHC8hQ
        p3/BcelI=; b=PDlEqQ/zg58P2ppafOSiKOdt3GeaV+8AQav+TQOIvA8qmPLH01x
        bRXx8tFsg7uOhKGYyMdn9RS8yr3WRgmqvhmvL/tFhNsvFd1w2JNxAA1hGth1my2C
        +si4Lvbu2zHlvNNGgvvJjwgynSDr+82hLvoToOS/E4fBuEFXNgJzWQEnRR/afJfL
        R+IEzd4/CSdA1z5FSs2GLAzKLkCK9w2dqx2GVmxsLrI0cDuBGu01Gv0INgslvlM3
        3dOU2Od6PfJo8LI4i5uTirV1eRlU4/UfbcmbVu2La+iuer6lgyP/1+d5VnswdhZu
        3WYnwv4WZIXM6KXLSREaSaTFoIDjW3yIKgg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k29wfk365GFX for <linux-kernel@vger.kernel.org>;
        Wed,  5 Oct 2022 22:46:01 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MjgQx0G3bz1RvLy;
        Wed,  5 Oct 2022 22:46:00 -0700 (PDT)
Message-ID: <60557988-a5e5-8c81-72f9-c0f3ab9ed573@opensource.wdc.com>
Date:   Thu, 6 Oct 2022 14:45:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ata: pata_mpc52xx: Replace NO_IRQ by 0
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 14:17, Christophe Leroy wrote:
> NO_IRQ is used to check the return of irq_of_parse_and_map().
> 
> On some architecture NO_IRQ is 0, on other architectures it is -1.
> 
> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
> 
> So use 0 instead of using NO_IRQ.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Doesn't this need fixes and cc:stable tags ?

> ---
>  drivers/ata/pata_mpc52xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 6559b606736d..3ebd6522a1fd 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -731,7 +731,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
>  		udma_mask = ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
>  
>  	ata_irq = irq_of_parse_and_map(op->dev.of_node, 0);
> -	if (ata_irq == NO_IRQ) {
> +	if (!ata_irq) {
>  		dev_err(&op->dev, "error mapping irq\n");
>  		return -EINVAL;
>  	}

-- 
Damien Le Moal
Western Digital Research


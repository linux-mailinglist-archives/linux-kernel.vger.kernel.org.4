Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4B26EA225
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 05:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjDUDHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 23:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjDUDHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:07:34 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCDD2107
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 20:07:31 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230421030729epoutp01baad2f104c4b29200e5f7d6b9b4bd61c~X1FVoahvM1084810848epoutp01Z
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:07:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230421030729epoutp01baad2f104c4b29200e5f7d6b9b4bd61c~X1FVoahvM1084810848epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682046449;
        bh=X+bhPKiSqZ2PbzUK+9dLl8uebmQ+EJeJ90IvpgxnwiU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=uGYqrAlZkr78wv5y0jS1PcZJ/EjwcqfCOMFt6S/uWmti36pPAmJqm1SuQWT6J1+gD
         jbFgA5mmexziJTKs+o9GVjarTBwTqPYiZBwDL5DN4NZs2nNwdD4P3NugqFuv8a8XXS
         BE9PnhyYAvCBmkV2KmGjXCkmzAqpGFDlAw+AJa3c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230421030728epcas2p31807caa1174afdbc8ef1ddf8ccf49c87~X1FU-KkYc2330723307epcas2p3N;
        Fri, 21 Apr 2023 03:07:28 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q2fb40FG9z4x9Pw; Fri, 21 Apr
        2023 03:07:28 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.94.09650.FEDF1446; Fri, 21 Apr 2023 12:07:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230421030727epcas2p3c86b00c0f4c1c47dc22f5b926077e93b~X1FUJiqs22330723307epcas2p3K;
        Fri, 21 Apr 2023 03:07:27 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230421030727epsmtrp256f48206a6ac3c2884d2d6afb59a2bf7~X1FUI3l5X2523825238epsmtrp24;
        Fri, 21 Apr 2023 03:07:27 +0000 (GMT)
X-AuditID: b6c32a48-dc7ff700000025b2-0b-6441fdef17ee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.E2.08609.FEDF1446; Fri, 21 Apr 2023 12:07:27 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230421030727epsmtip2c97dc43c27e6670c53a6e5c72d53cf17~X1FT5uKtO3018630186epsmtip2b;
        Fri, 21 Apr 2023 03:07:27 +0000 (GMT)
Message-ID: <eb08398b-8a58-1138-cd2e-be5dba613cc6@samsung.com>
Date:   Fri, 21 Apr 2023 12:05:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/4] spi: s3c64xx: support interrupt based pio mode
Content-Language: en-US
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <20230419160320.ydgqqftsfn3y33p4@intel.intel>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmhe77v44pBo1vLC0ezNvGZnH/awej
        xeIfz5kspj58wmZxeb+2xd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpa
        mCsp5CXmptoqufgE6Lpl5gAdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/Q
        K07MLS7NS9fLSy2xMjQwMDIFKkzIzui5doe1oE2p4sfyX6wNjGuluhg5OSQETCRefHnD0sXI
        xSEksINR4uuBNawgCSGBT4wSn97pQCQ+M0qc/b2PHabj+II/UB27GCUWNL5jhnBeM0pc+jOT
        CaSKV8BO4tSN98wgNouAqsTppz3MEHFBiZMzn7CA2KIC0RKL900Bs4UFvCTeHnwF1sssIC5x
        68l8MFtEQE3i9eJPTCALmAUuMUlsa/0PdgabgLbE9/WLwW7lFLCS2D57PgtEs7zE9rdzwC6S
        EFjKIXGw5yMbxN0uEj97NjBD2MISr45vgfpHSuLzu71QNdkS7dP/sELYFRIXN8yGihtLzHrW
        ztjFyAG0QFNi/S59EFNCQFniyC2otXwSHYf/skOEeSU62oQgGtUk7k89BzVERmLSkZVMELaH
        xPKtX5knMCrOQgqVWUi+n4XkmVkIexcwsqxiFEstKM5NTy02KjCBR3Zyfu4mRnCa1fLYwTj7
        7Qe9Q4xMHIyHGCU4mJVEeM+4WqUI8aYkVlalFuXHF5XmpBYfYjQFxs1EZinR5Hxgos8riTc0
        sTQwMTMzNDcyNTBXEuf92KGcIiSQnliSmp2aWpBaBNPHxMEp1cA0RWljRcOaIz41O4RYt3RF
        KryVv7/r1K6ew1UJjfHvpy5YYWb9u+pltfLceTMtux9rnZj843iAS0fs2iVJjFxJZRKtT77u
        6lKSu2hWudhDhL/e5d3UqZJdGr0Bx3sX8W50vDaz+ezeyXqLYm8bqc6ekqsQ+fTfRgXNnK3b
        VimfsrF5aMFvVFT6c2Jhb6DtLb3KG8UmHx7v2eiy6N2Jx10SLT05Ntfev9bxsjPbudNB39Rv
        tqOFcIXSVL6wC6Xnv5/crHPe7wJrfU/Tke7b+tItDI6bTuWd0WjZeNHntaFk0nuupKLAh7/j
        Isx+Plki+PKE5xunq9ZzxXK5lyoLhkfKsvvtfLz22suyrcvEry9UYinOSDTUYi4qTgQASeem
        UDwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXvf9X8cUgzfrJS0ezNvGZnH/awej
        xeIfz5kspj58wmZxeb+2xd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBl9Fy7w1rQplTxY/kv1gbGtVJd
        jJwcEgImEscX/GHpYuTiEBLYwSjxbtlKdoiEjMTyZ31sELawxP2WI6wQRS8ZJSafvQVWxCtg
        J3HqxntmEJtFQFXi9NMeZoi4oMTJmU9YQGxRgWiJG8u/MYHYwgJeEm8PvgKzmQXEJW49mQ9m
        iwioSbxe/IkJZAGzwBUmiScXe6BO+soosfnEDbBJbALaEt/XL2YFsTkFrCS2z57PAjHJTKJr
        axcjhC0vsf3tHOYJjEKzkBwyC8nCWUhaZiFpWcDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQv
        XS85P3cTIzi+tLR2MO5Z9UHvECMTB+MhRgkOZiUR3jOuVilCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MCnk6v29+qd7d76x9sE0ngB55XURmn7/rkzl
        8mR5JvEzfiK7/rRPM448ec102f/Tx785HDd/tGxdVlDmnLq4P8WyaJ7+XKcdjhOaHdWPvj4m
        qbhMPXmb3n0P1q87P79WL39ZX8xqYprPtZ+przfpFm/9m1I7AdvqRon5rRV5T28n7stzPR+h
        Z3Ot0VHn2wzt0kKLmvDVjdVzr876sfm8waw5F+dJrirlnNotrTiRc0lr0uJvWiXtSzZJZ/LO
        X7dbXPlBq4sSL5/yrk9dhQeW9DVJfFq+b93qXWr25lKpO2OfPLCSurZb7WnzHJf+x2r9f48+
        zb2i/EbLhDN/7YQ9qZv+qH6wiD0yV9tb4NuxBUosxRmJhlrMRcWJAIA/K8UeAwAA
X-CMS-MailID: 20230421030727epcas2p3c86b00c0f4c1c47dc22f5b926077e93b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419062755epcas2p43a1127f4bb28cf1cf3f42e5d3cc597cd
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
        <CGME20230419062755epcas2p43a1127f4bb28cf1cf3f42e5d3cc597cd@epcas2p4.samsung.com>
        <20230419060639.38853-5-jaewon02.kim@samsung.com>
        <20230419160320.ydgqqftsfn3y33p4@intel.intel>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,


On 23. 4. 20. 01:03, Andi Shyti wrote:
> Hi Jaewon,
>
> On Wed, Apr 19, 2023 at 03:06:39PM +0900, Jaewon Kim wrote:
>> Interrupt based pio mode is supported to reduce CPU load.
>> If transfer size is larger than 32 byte, it is processed using interrupt.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   drivers/spi/spi-s3c64xx.c | 82 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 67 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index cf3060b2639b..ce1afb9a4ed4 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -58,6 +58,8 @@
>>   #define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD	(1<<17)
>>   #define S3C64XX_SPI_MODE_BUS_TSZ_WORD		(2<<17)
>>   #define S3C64XX_SPI_MODE_BUS_TSZ_MASK		(3<<17)
>> +#define S3C64XX_SPI_MODE_RX_RDY_LVL		GENMASK(16, 11)
>> +#define S3C64XX_SPI_MODE_RX_RDY_LVL_SHIFT	11
>>   #define S3C64XX_SPI_MODE_SELF_LOOPBACK		(1<<3)
>>   #define S3C64XX_SPI_MODE_RXDMA_ON		(1<<2)
>>   #define S3C64XX_SPI_MODE_TXDMA_ON		(1<<1)
>> @@ -114,6 +116,8 @@
>>   
>>   #define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
>>   
>> +#define S3C64XX_SPI_POLLING_SIZE	32
>> +
>>   #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
>>   #define is_polling(x)	(x->cntrlr_info->polling)
>>   
>> @@ -552,10 +556,11 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
>>   }
>>   
>>   static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>> -				struct spi_transfer *xfer)
>> +				struct spi_transfer *xfer, int use_irq)
> bool use_irq

Okay, I will change it to bool.

>
>>   {
>>   	void __iomem *regs = sdd->regs;
>>   	unsigned long val;
>> +	unsigned long time;
> this time is used only in "if (use_irq)" can you move its
> declaration under the if?
>
>>   	u32 status;
>>   	int loops;
>>   	u32 cpy_len;
>> @@ -563,17 +568,24 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>>   	int ms;
>>   	u32 tx_time;
>>   
>> -	/* sleep during signal transfer time */
>> -	status = readl(regs + S3C64XX_SPI_STATUS);
>> -	if (RX_FIFO_LVL(status, sdd) < xfer->len) {
>> -		tx_time = (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
>> -		usleep_range(tx_time / 2, tx_time);
>> -	}
>> -
>>   	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
>>   	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
>>   	ms += 10; /* some tolerance */
>>   
>> +	if (use_irq) {
>> +		val = msecs_to_jiffies(ms);
>> +		time = wait_for_completion_timeout(&sdd->xfer_completion, val);
>> +		if (!time)
>> +			return -EIO;
>> +	} else {
>> +		/* sleep during signal transfer time */
>> +		status = readl(regs + S3C64XX_SPI_STATUS);
>> +		if (RX_FIFO_LVL(status, sdd) < xfer->len) {
>> +			tx_time = (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
>> +			usleep_range(tx_time / 2, tx_time);
> yeah... just use 'ms'.
As I mentioned in the previous mail, the unit of tx_time is us.
>
>> +		}
>> +	}
>> +
>>   	val = msecs_to_loops(ms);
>>   	do {
>>   		cpu_relax();
>> @@ -737,10 +749,13 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
>>   	void *rx_buf = NULL;
>>   	int target_len = 0, origin_len = 0;
>>   	int use_dma = 0;
>> +	int use_irq = 0;
>>   	int status;
>>   	u32 speed;
>>   	u8 bpw;
>>   	unsigned long flags;
>> +	u32 rdy_lv;
>> +	u32 val;
>>   
>>   	reinit_completion(&sdd->xfer_completion);
>>   
>> @@ -761,17 +776,46 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
>>   	    sdd->rx_dma.ch && sdd->tx_dma.ch) {
>>   		use_dma = 1;
>>   
>> -	} else if (xfer->len > fifo_len) {
>> +	} else if (xfer->len >= fifo_len) {
>>   		tx_buf = xfer->tx_buf;
>>   		rx_buf = xfer->rx_buf;
>>   		origin_len = xfer->len;
>> -
>>   		target_len = xfer->len;
>> -		if (xfer->len > fifo_len)
>> -			xfer->len = fifo_len;
>> +		xfer->len = fifo_len - 1;
>>   	}
> Is this change related to this patch?

Yes, it is related to this patch.

If data is filled as much as the size of FIFO, underrun/overrun IRQ occurs.

In CPU polling mode, it did not occur because the FIFO was read before 
the IRQ was set.

So, I set xfer->len to fifo_len-1.

>
> The rest looks good.
>
> Andi


Thanks

Jaewon Kim


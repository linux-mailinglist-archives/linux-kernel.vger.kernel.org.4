Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7E36E76A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjDSJrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjDSJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:47:40 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912055AC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:47:38 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230419094734epoutp031f5758b2725b34b06160f0f0dc27439a~XTQF6mO5w0649206492epoutp03L
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:47:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230419094734epoutp031f5758b2725b34b06160f0f0dc27439a~XTQF6mO5w0649206492epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681897654;
        bh=TQgUzzFFttsU0U0WH50ZEOp7y6GtQknqfcN2eXAxO0I=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=TlL8iAn0j7C3I4HJ4bp29fBLBhTAvmmIpOgpRwZFhF6Evc4t9rf94iP0BrrGBmWxM
         MSAJYXB4lAov5PlYa1tUGYJNn01ceESRemI16XAbS9oh+EcuUjJCxPnbjzXBbTzGRl
         2D16quBNVD5VJSxCNyWQApNU/+GOcJph9n0xrwDA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230419094734epcas2p23b7becb2665b6fa243d2262eab2b2724~XTQFioHZf1376113761epcas2p2O;
        Wed, 19 Apr 2023 09:47:34 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q1bYd5t5Bz4x9Q7; Wed, 19 Apr
        2023 09:47:33 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.C5.09938.5B8BF346; Wed, 19 Apr 2023 18:47:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230419094733epcas2p13688d0f9e6fcd935df4c80c9fe75b01f~XTQEho9zV1826618266epcas2p1a;
        Wed, 19 Apr 2023 09:47:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230419094733epsmtrp2369b2a521630a21c988e0ce6f2d64c3a~XTQEgx5mE2196821968epsmtrp2k;
        Wed, 19 Apr 2023 09:47:33 +0000 (GMT)
X-AuditID: b6c32a47-a39ff700000026d2-83-643fb8b58490
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.3F.08279.4B8BF346; Wed, 19 Apr 2023 18:47:32 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230419094732epsmtip1d06255b7dcf03e4f9c51b732e4d0e33f~XTQEQkH2b1590715907epsmtip1w;
        Wed, 19 Apr 2023 09:47:32 +0000 (GMT)
Message-ID: <af95919d-f422-feec-b58d-a9b8c54af6d8@samsung.com>
Date:   Wed, 19 Apr 2023 18:45:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/4] spi: s3c64xx: support interrupt based pio mode
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <88e74f8f-feee-159a-3048-736a5ffc13cd@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmme7WHfYpBhte6Fk8mLeNzWLxj+dM
        FlMfPmGzuLxf22Lv663sFpseX2O1uLxrDpvFjPP7mCwaP95kd+D0uL7kE7PHplWdbB53ru1h
        89i8pN6jb8sqRo/Pm+QC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPIS
        c1NtlVx8AnTdMnOAblJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX
        5qXr5aWWWBkaGBiZAhUmZGec2PCdqeCiRMW6q9dZGhg3iHQxcnJICJhILLn/iaWLkYtDSGAH
        o8Tatx9ZQRJCAp8YJTpmG0MkvjFK/F/1lbGLkQOsY9XUJIj4XkaJl50rGSGc14wSOz9OZgLp
        5hWwk7h89CsziM0ioCrRtGQ5G0RcUOLkzCcsILaoQLTE4n1TwGxhAS+JtwdfgfUyC4hL3Hoy
        nwlkqIjAYkaJvsef2EAcZoGNjBKbm6ayg1SxCWhLfF+/GOxWTqBtt3ctYIbolpdo3jqbGaRB
        QmAph8Sd/3/ZIO52kXj+IBbiaWGJV8e3sEPYUhKf3+1lg7CzJdqn/2GFsCskLm6YDRU3lpj1
        rB3sfWYBTYn1u/QhJipLHLnFArGVT6Lj8F92iDCvREebEESjmsT9qeeghshITDqykgnC9pBY
        vvUr8wRGxVlIoTILyfezkPwyC2HvAkaWVYxiqQXFuempxUYFxvC4Ts7P3cQITq1a7jsYZ7z9
        oHeIkYmD8RCjBAezkgjvGVerFCHelMTKqtSi/Pii0pzU4kOMpsC4mcgsJZqcD0zueSXxhiaW
        BiZmZobmRqYG5krivNK2J5OFBNITS1KzU1MLUotg+pg4OKUamJRF3Ke++dXisC6ZsXqOqFAs
        zyKPBNk16e0zbrz9dmXb1CiHzDu6iw9xaisX8XcuzvjWeUjY4YFscebTjdo2s45EqSdevLf4
        /5/H3qURB+WZ1xxZqB2S9nbq25ubEh0ezNn0QZMpaP5UL54P2Zs2Pdy/KWCTxrvsDkmPuYXs
        kWflF5emrlDecswg53Vt0/5TJ9+JpD3x2rVH+8umyAndBy5uU7l/LiHk0LRXtys0/7OGGQtV
        G5rc2XupuOnh84trZ3g3vO9Rkj63jOmmajDn04sJ/p2e9qU92sYna3Wjpq3cbcTcdUuc51bu
        J7UbT/9LTnHYFvJ49UWmshN5/QH/BNddZfx++V28QWdnZ8C2rjVKLMUZiYZazEXFiQDSvzXe
        NgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTnfLDvsUg9WvrSwezNvGZrH4x3Mm
        i6kPn7BZXN6vbbH39VZ2i02Pr7FaXN41h81ixvl9TBaNH2+yO3B6XF/yidlj06pONo871/aw
        eWxeUu/Rt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGSc2fGcquChRse7qdZYGxg0iXYwcHBIC
        JhKrpiZ1MXJxCAnsZpQ4eHcuSxcjJ1BcRmL5sz42CFtY4n7LEVaIopeMErf/f2IGSfAK2Elc
        PvoVzGYRUJVoWrKcDSIuKHFy5hOwQaIC0RI3ln9jArGFBbwk3h58BWYzC4hL3HoynwlkqIjA
        YkaJjktv2UEcZoGNjBIrr69nhlj3k1Hi0ZbbYGPZBLQlvq9fzApicwKtvr1rATPEKDOJrq1d
        jBC2vETz1tnMExiFZiG5ZBaSjbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpe
        cn7uJkZwVGlp7mDcvuqD3iFGJg7GQ4wSHMxKIrxnXK1ShHhTEiurUovy44tKc1KLDzFKc7Ao
        ifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDqkXmUdSTE6HjEklSRvhP9FTNiDlyMTkyd0Hb5
        d3ph+Ow/7vLus7Ml5gZtMfJM0Y/+9TGh60r/Jjmtcyopqmcvaofm7X928b5lSPENkxVcEYdi
        V95Y4nrKZP6bp2m/AjexHjz6as7DQ2kMyWm+mzQ2X4up9DbnYy581fc+6aDm/E6nOu+XGteK
        7Iv/P/rpM0UnSfxXuNmpv4eThK6WLK4P2XZL8RUH2we1kPMMEd/9TukePNz3fNK288zSTy0n
        3t38fLuH8wPxH+ddk7wyvmhHJRRuZJLK+mxem1rx9Uh2k23s9n1fPNfetebe+kHvTecTs9Q3
        2pejjteblhhOFtRztSq5XJG/Kf+Vyub/jc5KLMUZiYZazEXFiQB7KksvGQMAAA==
X-CMS-MailID: 20230419094733epcas2p13688d0f9e6fcd935df4c80c9fe75b01f
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
        <88e74f8f-feee-159a-3048-736a5ffc13cd@linaro.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 4. 19. 17:21, Krzysztof Kozlowski wrote:
> On 19/04/2023 08:06, Jaewon Kim wrote:
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
>>   {
>>   	void __iomem *regs = sdd->regs;
>>   	unsigned long val;
>> +	unsigned long time;
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
> You just added this code. Adding and immediately removing it, suggests
> this should be one patch.
>
This code has been moved, not removed.


+       if (use_irq) {
+               val = msecs_to_jiffies(ms);
+               time = 
wait_for_completion_timeout(&sdd->xfer_completion, val);
+               if (!time)
+                       return -EIO;
+       } else {
+               /* sleep during signal transfer time */
+               status = readl(regs + S3C64XX_SPI_STATUS);
+               if (RX_FIFO_LVL(status, sdd) < xfer->len) {
+                       tx_time = (xfer->len * 8 * 1000 * 1000) / 
sdd->cur_speed;
+                       usleep_range(tx_time / 2, tx_time);
+               }
+       }
+


> Best regards,
> Krzysztof
>
>

Thanks

Jaewon Kim


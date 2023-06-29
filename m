Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5CA742044
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjF2GTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 02:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjF2GTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:19:40 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E891310B;
        Wed, 28 Jun 2023 23:19:38 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 2908D60562F6B;
        Thu, 29 Jun 2023 14:19:34 +0800 (CST)
Message-ID: <05d56f16-a4fd-10ca-22af-3bc1c6395335@nfschina.com>
Date:   Thu, 29 Jun 2023 14:19:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next 08/10] net: mdio: Remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
In-Reply-To: <3fda1d81-e350-42e9-8fec-6f107ae75932@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/29 13:50, Dan Carpenter wrote:
> On Thu, Jun 29, 2023 at 09:59:56AM +0800, yunchuan wrote:
>> On 2023/6/28 17:50, Russell King (Oracle) wrote:
>>> On Wed, Jun 28, 2023 at 10:45:17AM +0800, wuych wrote:
>>>> @@ -211,7 +211,7 @@ static void xgene_enet_wr_mdio_csr(void __iomem *base_addr,
>>>>    static int xgene_xfi_mdio_write(struct mii_bus *bus, int phy_id,
>>>>    				int reg, u16 data)
>>>>    {
>>>> -	void __iomem *addr = (void __iomem *)bus->priv;
>>>> +	void __iomem *addr = bus->priv;
>>>>    	int timeout = 100;
>>>>    	u32 status, val;
>>>> @@ -234,7 +234,7 @@ static int xgene_xfi_mdio_write(struct mii_bus *bus, int phy_id,
>>>>    static int xgene_xfi_mdio_read(struct mii_bus *bus, int phy_id, int reg)
>>>>    {
>>>> -	void __iomem *addr = (void __iomem *)bus->priv;
>>>> +	void __iomem *addr = bus->priv;
>>>>    	u32 data, status, val;
>>>>    	int timeout = 100;
>>> These probably cause Sparse to warn whether or not the cast is there.
>> Hi, Russell King,
>>
>> I didn't notice this Sparse warning.
>> Should I remove this cast although it cause Sparse warning?
> No.  Don't introduce new Sparse warnings.

Got it, thanks for your answer!

wuych

>
> regards,
> dan carpenter
>

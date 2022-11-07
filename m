Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E6F61FD6B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiKGSXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiKGSW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:22:56 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBCCBC2A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:22:54 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 72805341;
        Mon,  7 Nov 2022 19:22:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1667845371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i66Bm0EZDr45BT3ymGVEXCMJcddpq0EAsVqoE2IhkH0=;
        b=bF9wy7/3AMbvbZ/I/qwQgwklcwO/HJZ6Y2p0Srmc2Rcdncz/0ZWSETGs1INfRJDU0YCurR
        NlyktDRNPvRmduTi9RuOuQXgJfjmrYjB+a6ThiUrkpD4s6z4EM4ssKWfVspyZRQTPZI+ch
        ixDKhVAQRY72zvKWpgujsvuU5sHUi9OMF1cbjS+ONYBZU1Mo7A7yO5eZy9WT1jAn6PplyZ
        Gq35WzUoDJtNiTx3FHRej/na77owZvcTBL4oijAcKoqdiNge7lRapuCA/YonmHa9gVgytM
        v1UNq/Jvm/LmCwW/Pv0S6pYoCN4M3EofdRX7stOJCDOfWWMTapTQXYm+UY8+Bw==
MIME-Version: 1.0
Date:   Mon, 07 Nov 2022 19:22:51 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Takahiro.Kuwano@infineon.com
Subject: Re: [PATCH v2 6/7] mtd: spi-nor: add generic flash driver
In-Reply-To: <848f22da-7f1b-ae93-99d3-65a5f31cb122@microchip.com>
References: <20220810220654.1297699-1-michael@walle.cc>
 <20220810220654.1297699-7-michael@walle.cc>
 <848f22da-7f1b-ae93-99d3-65a5f31cb122@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2b56d38b76660692117103c9de213cdc@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-11-01 09:46, schrieb Tudor.Ambarus@microchip.com:
> On 8/11/22 01:06, Michael Walle wrote:
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -1632,6 +1632,16 @@ static const struct spi_nor_manufacturer 
>> *manufacturers[] = {
>>         &spi_nor_xmc,
>>  };
>> 
>> +static const struct flash_info spi_nor_generic_flash = {
>> +       .name = "spi-nor-generic",
> 
> How about "jedec,spi-nor" instead? The series looks good, I intend to 
> test it
> and apply it soon.

I had that string before actually but decided against it because it
looks like "jedec" is the vendor, which is (a) not true for any flash
and (b) if it would be a vendor, it should go into the manufacturer
property, which isn't supported at the moment.

That being said, I don't care too much. After all, it's just a name.

(and yes, I'm on vacation till next week ;)

-michael

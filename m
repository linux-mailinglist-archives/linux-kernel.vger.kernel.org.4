Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC1772B38A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 21:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjFKTNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 15:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjFKTNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 15:13:38 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F6E42
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 12:13:37 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 8QVJqgYTgW2Gf8QVJqB8l3; Sun, 11 Jun 2023 21:13:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686510815;
        bh=NLTw50Pn4eT2DY2L6hTAarrtdXqxHwq7g+N+LBxyYtc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TeGZr7jAtdK7gqHvAhiQjrhvp/T/8uvQUb+4u9f1FwbIxAk37RtmHhsH6kYNi31Xm
         ErgYLXOxy6xy6fFDAjOYN5HcpR6HNFoF2gnJDUD3Y4jXkfFliL0PHUst53UmJWZsS3
         0T6KQtE/WjQpPY3ZglloXWPn89s2gXDA76OqFXiM1QuvGE1giDf97qm9+SeIPmRvLO
         JGEYS1HUdWFLjf0+1P26WA7Ghe/PoRD2i0TiTvdYm/qUL2mObdBD7921yqOpltcBYU
         eLVlqj5Klrv8HGUucMcqojrswD5hS0HhmVSp7k9y2tK5PBMJjgMpDq2bYOMGjNAr+5
         5hn7j8h4YRWVA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Jun 2023 21:13:34 +0200
X-ME-IP: 86.243.2.178
Message-ID: <8a52595f-085b-3b68-0082-e9f9487dd331@wanadoo.fr>
Date:   Sun, 11 Jun 2023 21:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] hid-mcp2200 - updated hid-id.h
Content-Language: fr, en-US
To:     Johannes Roith <johannes@gnu-linux.rocks>, jikos@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230611164811.1388-1-johannes@gnu-linux.rocks>
 <20230611164811.1388-2-johannes@gnu-linux.rocks>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230611164811.1388-2-johannes@gnu-linux.rocks>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/06/2023 à 18:48, Johannes Roith a écrit :
> Added Product ID for Microchip MCP2200 so the module can be compiled
> correctly.
> 
> Signed-off-by: Johannes Roith <johannes@gnu-linux.rocks>
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 5d29abac2300..b48cb8224e0d 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -912,6 +912,7 @@
>   #define USB_DEVICE_ID_PICK16F1454_V2	0xf2f7
>   #define USB_DEVICE_ID_LUXAFOR		0xf372
>   #define USB_DEVICE_ID_MCP2221		0x00dd
> +#define USB_DEVICE_ID_MCP2221		0x00df

2 times USB_DEVICE_ID_MCP2221 with different values?
USB_DEVICE_ID_MCP2200?

Also this one should be merged with patch 1/2 or sent before the other 
one, otherwise  1/2 can't compile.

CJ

>   
>   #define USB_VENDOR_ID_MICROSOFT		0x045e
>   #define USB_DEVICE_ID_SIDEWINDER_GV	0x003b


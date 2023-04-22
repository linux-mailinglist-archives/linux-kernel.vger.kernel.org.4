Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF816EBA53
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 18:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDVQ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDVQ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 12:27:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E3D1FD8;
        Sat, 22 Apr 2023 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=WYJjJ0ufD3sIHjK1nesBtmpTeSxxm3POed2ryYQ19Zc=; b=f15dHkm9IQt9dUpahuBub2J8P6
        2SZj3gbBWzih+AA4Kx6HSeO7Uq43V6cGz3WOPmiLZOcpJOMNiTO7vH4LRtrZ53l7WG4fM6lxa82/y
        rWY7hfQhT3DRhp2m/ssy2TkvRM0t26P4g+8KG0ek5lLSvVAuorq0rQJH4zScNPolqAR0YAV8Ncyd7
        McptYZdlpoDB6Ze6sVtqEYqyhwEYhPcQe/+dfQLHlvJEhy6orqGTZ3/XJ3XMUEiPna0Xy+UcFg99F
        6hl22NAv6IwzTNTjPP8z2jHzRPeYD5nlKVuvgqQMfOn90tDscKdqUhM214RqjckLsCaiSNI9qaSKL
        Hnc4sgVg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqG4g-00D6up-0P;
        Sat, 22 Apr 2023 16:26:58 +0000
Message-ID: <526e0474-7775-ed17-40a8-48ce95966c0a@infradead.org>
Date:   Sat, 22 Apr 2023 09:26:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] usb: gadget: drop superfluous ':' in doc string
Content-Language: en-US
To:     =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Greg KH <greg@kroah.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-usb@vger.kernel.org
References: <ZEQFzMntIrwvZl4+@jo-einhundert>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZEQFzMntIrwvZl4+@jo-einhundert>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/23 09:05, Jó Ágila Bitsch wrote:
> There was one superfluous ':' that kernel-doc complained about.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/c718a490-028d-2682-9ad7-8256d16504bf@infradead.org/
> Fixes: fb6211f1584a ("usb: gadget: add doc to struct usb_composite_dev")
> Signed-off-by: Jó Ágila Bitsch <jgilab@gmail.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/usb/composite.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
> index a2448e98854f..07531c4f4350 100644
> --- a/include/linux/usb/composite.h
> +++ b/include/linux/usb/composite.h
> @@ -443,7 +443,7 @@ static inline struct usb_composite_driver *to_cdriver(
>   * @bcd_webusb_version: 0x0100 by default, WebUSB specification version
>   * @b_webusb_vendor_code: 0x0 by default, vendor code for WebUSB
>   * @landing_page: empty by default, landing page to announce in WebUSB
> - * @use_webusb:: false by default, interested gadgets set it
> + * @use_webusb: false by default, interested gadgets set it
>   * @os_desc_config: the configuration to be used with OS descriptors
>   * @setup_pending: true when setup request is queued but not completed
>   * @os_desc_pending: true when os_desc request is queued but not completed

-- 
~Randy

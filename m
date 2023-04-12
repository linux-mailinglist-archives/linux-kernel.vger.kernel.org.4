Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077CC6E0254
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 01:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDLXLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 19:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLXLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 19:11:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2199A10CE;
        Wed, 12 Apr 2023 16:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=Nxv7nWXdf7av7cxyh9xS1LvUe4PBtCtEiU6h+boNPdY=; b=bOZTS1tYJKP+HpSO1b8EOjH2lk
        EUxPl6IxufomX1XkdO7/s1fCgWR55A6/E7eg8tC2XiBkiWfgZCSz/EXOwfZ8oC3TH4SEcoA1uK3K5
        OqgkYfDxTTMKGLlajk3aH2qK6MvDvVllvqokJa908ckga+tS8PK9qM2kM1Hv7JmQWEBvtbk1UR32u
        CW6LmFHfPUf9s+5KwYicSyXyYp8dWMXQMtfsYRhMQD4BI3HnE37d0u8J6/HkYCwPX5AgdvaihE1as
        RUnQ44l8Zwh3IaxkBJvf4AZwCHGBk/QQqYc4ovpCzIo/mVW3MDyEC6cE6Sh8sN7XF6lDS8xKfH2hn
        03sKu/Gw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmjcc-004bcN-18;
        Wed, 12 Apr 2023 23:11:26 +0000
Message-ID: <c718a490-028d-2682-9ad7-8256d16504bf@infradead.org>
Date:   Wed, 12 Apr 2023 16:11:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] usb: gadget: add doc to struct usb_composite_dev
Content-Language: en-US
To:     =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Greg KH <greg@kroah.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-usb@vger.kernel.org
References: <Y95MRZZz3yC5lETB@jo-einhundert>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y95MRZZz3yC5lETB@jo-einhundert>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/4/23 04:15, Jó Ágila Bitsch wrote:
> Added documentation to new struct members for WebUSB:
> * bcd_webusb_version
> * b_webusb_vendor_code
> * landing_page
> * use_webusb
> to avoid warnings in the build of htmldocs
> 
> Fixes: 93c473948c58 ("usb: gadget: add WebUSB landing page support")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Jó Ágila Bitsch <jgilab@gmail.com>
> ---
> V0 -> V1: added Reported-By and Fixes Tags
> V1 -> V2: fixed Reported-by tag (capitalization of "-by" was wrong)
>           also post to linux-usb
> 
>  include/linux/usb/composite.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
> index 91d22c3ed458..7ef8cea67f50 100644
> --- a/include/linux/usb/composite.h
> +++ b/include/linux/usb/composite.h
> @@ -432,6 +432,10 @@ static inline struct usb_composite_driver *to_cdriver(
>   * @qw_sign: qwSignature part of the OS string
>   * @b_vendor_code: bMS_VendorCode part of the OS string
>   * @use_os_string: false by default, interested gadgets set it
> + * @bcd_webusb_version: 0x0100 by default, WebUSB specification version
> + * @b_webusb_vendor_code: 0x0 by default, vendor code for WebUSB
> + * @landing_page: empty by default, landing page to announce in WebUSB
> + * @use_webusb:: false by default, interested gadgets set it

Please drop one ':' above so that kernel-doc does not complain:

include/linux/usb/composite.h:523: warning: Function parameter or member 'use_webusb' not described in 'usb_composite_dev'

>   * @os_desc_config: the configuration to be used with OS descriptors
>   * @setup_pending: true when setup request is queued but not completed
>   * @os_desc_pending: true when os_desc request is queued but not completed

Thanks.
-- 
~Randy

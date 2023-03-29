Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8490A6CD0BE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjC2Dgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2Dgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:36:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889C1212E;
        Tue, 28 Mar 2023 20:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=M9TunKd1G1N8i08Qa3nbIbBIZrjzPf28LPaVrO9lrtY=; b=VhAGIKETJphnkp7TqQjN3cFg0f
        Qx9gpbrB7SqFuCU/jkYgYVCat/Oe/O4GTIr2CJNQOemF4KgX+Elg/ra/3C3qw1B2X/DvLguSba79n
        DKrpVWrOSlFroWBuxn7D6B+xpjoSway7ullkRTsEG/Run4U4hKp1pdOG+1gyQZbRm4dvwDqqal+Wr
        +DdKs+EAq7uqGtidMWLaeJLaK6gDrgeWIjoA00z8DfuqqA4HGvtw4WXxxlaCpP7MdaP3a93UUxhxA
        OQ/ekUey57m5AIR0cwtpgDXMGRbwivnm/SxpyGPKY3SAv3V1xicOpQhWNO3EFRA7rY1N9BiRR/e27
        K4R8inNQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phMc4-00GTBS-0a;
        Wed, 29 Mar 2023 03:36:40 +0000
Message-ID: <22e509fc-e250-29b3-e9f1-d62a6d10ec60@infradead.org>
Date:   Tue, 28 Mar 2023 20:36:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] usb:dwc:core.h Fixed warning of documentation
Content-Language: en-US
To:     Piyush Thange <pthange19@gmail.com>, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
References: <20230329032938.225211-1-pthange19@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230329032938.225211-1-pthange19@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/28/23 20:29, Piyush Thange wrote:
> While compiling documentation a following warning is generated.
> Function parameter or member 'resume_hs_terminations' not described 
> in 'dwc3'

This one appears to be fixed already.

> One more warning arises in the same file as follows
> Function parameter or member 'gfladj_refclk_lpm_sel' not described 
> in 'dwc3'
> 
> I need some insights on this.

The second one needs a line added, probably just after:

 * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
 *			instances in park mode.

like

 * @gfladj_refclk_lpm_sel: {some description here}

Thanks.

> Signed-off-by: Piyush Thange <pthange19@gmail.com>
> ---
>  drivers/usb/dwc3/core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 582ebd9cf9c2..4743e918dcaf 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1098,7 +1098,7 @@ struct dwc3_scratchpad_array {
>   *			change quirk.
>   * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
>   *			check during HS transmit.
> - * @resume-hs-terminations: Set if we enable quirk for fixing improper crc
> + * @resume_hs_terminations: Set if we enable quirk for fixing improper crc
>   *			generation after resume from suspend.
>   * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
>   *			instances in park mode.

-- 
~Randy

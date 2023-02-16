Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D89E698A72
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBPCUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBPCUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:20:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6F22A17F;
        Wed, 15 Feb 2023 18:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=kSGA/MlD2Xuj25JeBde+v37M89+xiA/8ymC62wNi/ao=; b=T214lDYwlH/i6uBH6BNzlCk6rx
        4nxUsEUyOjm+8Jmw+aXlMddrYn/laIc6xaoE+fU4xLZAbrRZBTC3LQERXZaHxqyaq3W1za55ImRLb
        oRJqgBk2bbAoKusoW8hJcWVjQvwN/GXXKPpP0KEx9Me1zbsMO5aAoQq3UZbhtS09vh3lJ5OBp+3p+
        ucDo5hPWB04m3UQNM2QNgXI+pMV5gVhPCK4n5Ey/HKW4DMh6xGS2Wb429iqZu0yUjZCOn2o30ASdw
        RjRw82BdCQgPjZHS1lWtlsnK8erByUyCysDqb5Q5dNk6Fbck51RiTbxF3aanEJLBMetCqMtAWFXLh
        C3zLEGgA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSTsb-008HVN-8k; Thu, 16 Feb 2023 02:20:13 +0000
Message-ID: <1ea2a91a-c724-04b2-6154-d0797273552c@infradead.org>
Date:   Wed, 15 Feb 2023 18:20:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] usb: fix some spelling mistakes in comment of gadget
Content-Language: en-US
To:     Zhou nan <zhounan@nfschina.com>, leoyang.li@nxp.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20230216013535.6399-1-zhounan@nfschina.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230216013535.6399-1-zhounan@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/23 17:35, Zhou nan wrote:
> usb: Fix spelling mistake in comments of gadget.
> 
> Signed-off-by: Zhou nan <zhounan@nfschina.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v2:
> - Modify the title and description text.
> ---
>  drivers/usb/gadget/udc/fsl_udc_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


-- 
~Randy

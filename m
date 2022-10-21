Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB5D606F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJUFvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUFvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:51:20 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 036981F042D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:51:17 -0700 (PDT)
Received: from [192.168.1.139] (unknown [122.171.21.142])
        by linux.microsoft.com (Postfix) with ESMTPSA id 92BC520FEB37;
        Thu, 20 Oct 2022 22:51:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 92BC520FEB37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666331477;
        bh=CFcGVabke10N4sdozPe+dsC/1jTkLgGjbxZzRiP6LrY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=LjFewnAZkJBKXQIVE6zN5NUUNryfM5sJj2TLS8RDl4CE/CEml+WwqPP6GKpLp5MFm
         1qLvLOyNeQDThuTY8vjswilA5A1Cs0f+ytV9vlEmDORlz+NWWIM8xowom6PAHTxmdQ
         slGZqaMV6MCOTxhHXsdO4+UlCarUF54sfbghXvf4=
Message-ID: <b038a335-29a3-5118-bda6-9b3230094f90@linux.microsoft.com>
Date:   Fri, 21 Oct 2022 11:21:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 11/11] staging: r8188eu: Remove unused macros
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurabh.truth@gmail.com
References: <cover.1666299151.git.drv@mailo.com>
 <efaf637a14b6f7fdd0178e2aecf8abf17e6922f6.1666299151.git.drv@mailo.com>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <efaf637a14b6f7fdd0178e2aecf8abf17e6922f6.1666299151.git.drv@mailo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-2022 03:02, Deepak R Varma wrote:
> Simple variants of macros PlatformEFIOWrite and PlatformEFIORead are
> defined but never used. As they do not appear to be designed for anything
> significant, we can remove them to avoid unexpected usage.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> 
> Changes in v4:
>    1. Patch newly added to the patch set.
> 
> 
>  drivers/staging/r8188eu/include/rtw_io.h | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
> index 87fcf6c94ff3..e9744694204b 100644
> --- a/drivers/staging/r8188eu/include/rtw_io.h
> +++ b/drivers/staging/r8188eu/include/rtw_io.h
> @@ -285,18 +285,4 @@ void bus_sync_io(struct io_queue *pio_q);
>  u32 _ioreq2rwmem(struct io_queue *pio_q);
>  void dev_power_down(struct adapter *Adapter, u8 bpwrup);
> 
> -#define PlatformEFIOWrite1Byte(_a, _b, _c)		\
> -	rtw_write8(_a, _b, _c)
> -#define PlatformEFIOWrite2Byte(_a, _b, _c)		\
> -	rtw_write16(_a, _b, _c)
> -#define PlatformEFIOWrite4Byte(_a, _b, _c)		\
> -	rtw_write32(_a, _b, _c)
> -
> -#define PlatformEFIORead1Byte(_a, _b)		\

Can the naming be reworked to make more Linux friendly ? something like PLATFORM_EFIO_READ1BYTE or better if there are other suggestions?
Rest others as applicable ?

> -		rtw_read8(_a, _b)
> -#define PlatformEFIORead2Byte(_a, _b)		\
> -		rtw_read16(_a, _b)
> -#define PlatformEFIORead4Byte(_a, _b)		\
> -		rtw_read32(_a, _b)
> -
>  #endif	/* _RTL8711_IO_H_ */
> --
> 2.30.2
> 
> 
> 
Regards,

~Praveen.

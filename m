Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC7A606F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJUFfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUFfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:35:03 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1DD98F25F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:34:56 -0700 (PDT)
Received: from [192.168.1.139] (unknown [122.171.21.142])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2717620FE651;
        Thu, 20 Oct 2022 22:34:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2717620FE651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666330496;
        bh=z9ChsFdjUlv52E4SjHOOEqJlyuV2FJx+BaOBRoJ3lBg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ZpWvyu/LfUUP0pAqQDJwtlJR20oWYeLmsqSFAEh0LXbS0GZKUHXzk6pNNuf8ZXxAi
         db2oYNbnN+Xu7WB7Cl4tOJvuqR7QC1hd+vtQZ/Xe6jekvKwnFg3SYIpEob84fJXH+D
         ZIeObB3x0O7FkZB2u23gBXFYRAmpSxGrNEXbH7eY=
Message-ID: <a1429a6a-1688-c30a-4fb2-3d575ffecbf1@linux.microsoft.com>
Date:   Fri, 21 Oct 2022 11:04:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 08/11] staging: r8188eu: replace leading spaces by tabs
To:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurabh.truth@gmail.com
References: <cover.1666299151.git.drv@mailo.com>
 <c32b702c61ea3367d60f0a4c2443093d6ce45a69.1666299151.git.drv@mailo.com>
Content-Language: en-US
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <c32b702c61ea3367d60f0a4c2443093d6ce45a69.1666299151.git.drv@mailo.com>
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

On 21-10-2022 03:01, Deepak R Varma wrote:
> Spaces are prohibited as per the Linux coding style guidelines. Replace
> those by tabs wherever possible to improve code alignment. Error
> reported by checkpatch script.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> 
> Changes in v4:
>    -- None.
> 
> Changes in v3:
>    1. Patch newly added in the patch set.
> 
>  drivers/staging/r8188eu/include/rtw_cmd.h      | 10 +++++-----
>  drivers/staging/r8188eu/include/rtw_mlme.h     |  2 +-
>  drivers/staging/r8188eu/include/rtw_mlme_ext.h |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
> index 61fb523afb08..4b6a91aefc1e 100644
> --- a/drivers/staging/r8188eu/include/rtw_cmd.h
> +++ b/drivers/staging/r8188eu/include/rtw_cmd.h
> @@ -592,14 +592,14 @@ struct setratable_parm {
>  };
> 
>  struct getratable_parm {
> -                uint rsvd;
> +	uint rsvd;
>  };
> 
>  struct getratable_rsp {
> -        u8 ss_ForceUp[NumRates];
> -        u8 ss_ULevel[NumRates];
> -        u8 ss_DLevel[NumRates];
> -        u8 count_judge[NumRates];
> +	u8 ss_ForceUp[NumRates];
> +	u8 ss_ULevel[NumRates];
> +	u8 ss_DLevel[NumRates];

Can this be reworked further like ss_ForceUp -> ss_force_up or ss_forceup ?
Similarly for other attributes.

> +	u8 count_judge[NumRates];
>  };
> 
>  /* to get TX,RX retry count */
> diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
> index 7658f864136e..ebf7168a7ef9 100644
> --- a/drivers/staging/r8188eu/include/rtw_mlme.h
> +++ b/drivers/staging/r8188eu/include/rtw_mlme.h
> @@ -528,7 +528,7 @@ void rtw_indicate_scan_done(struct adapter *padapter);
>  int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie,
>  			uint in_len);
>  int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie,
> -		        uint in_len, uint initial_out_len);
> +			uint in_len, uint initial_out_len);
>  void rtw_init_registrypriv_dev_network(struct adapter *adapter);
> 
>  void rtw_update_registrypriv_dev_network(struct adapter *adapter);
> diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> index be470f913a94..413b94e38744 100644
> --- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> +++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> @@ -449,7 +449,7 @@ void ERP_IE_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE);
>  void VCS_update(struct adapter *padapter, struct sta_info *psta);
> 
>  void update_beacon_info(struct adapter *padapter, u8 *pframe, uint len,
> -		        struct sta_info *psta);
> +			struct sta_info *psta);
>  int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len);
>  void update_IOT_info(struct adapter *padapter);
>  void update_capinfo(struct adapter *adapter, u16 updatecap);
> --
> 2.30.2
> 
> 
> 

Regards,

~Praveen.


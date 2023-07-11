Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03E674F960
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGKUyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGKUyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:54:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7DF10C2;
        Tue, 11 Jul 2023 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=y9TtE4g7o2v+KcMAj9H3Z0J7EU3TNcNzZLzEuWDqy+I=; b=ego2WBPn9o9RD26EmlY6wfKAV4
        vT8fvIIrVEoFDa9qboCZiLhXHqjhWVQCnQ5t+aP2s6A+IUeoO2BEukwUDfU3eggHtIazC22021751
        +loeTvEcLFcfWV1UECzj0vm4UQiJO9nR7haErLfJxGW3iUGUMuBsStYzmWg+wF3Fk1WvEvZQrOv8P
        NdZXKGY1YstrhC4rCtz2MYIQ9f8vx9MfvDU5GFmjTHylKYBbbd+G4+4AtrkqJHyIktJ0t7h5uo8y5
        ZbO75JIC1jW/8XVtz7TSyffjktpvqwrpqU3mOX9VXynSRoBA+o6cxuSTTUBFj/vQrFFctFzfpxEY6
        ARxDs7Aw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJKNO-00FsEz-1x;
        Tue, 11 Jul 2023 20:54:26 +0000
Message-ID: <cf0474e7-0cf5-d89a-9ea6-c6e0aec6b30c@infradead.org>
Date:   Tue, 11 Jul 2023 13:54:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 04/10] docs: ABI:
 sysfs-bus-event_source-devices-hv_gpci: Document processor_config sysfs
 interface file
Content-Language: en-US
To:     Kajol Jain <kjain@linux.ibm.com>, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, disgoel@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230710092717.55317-1-kjain@linux.ibm.com>
 <20230710092717.55317-5-kjain@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230710092717.55317-5-kjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/10/23 02:27, Kajol Jain wrote:
> Add details of the new hv-gpci interface file called
> "processor_config" in the ABI documentation.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  .../sysfs-bus-event_source-devices-hv_gpci    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
> index 2eeeab9a20fa..aff52dc3b05c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
> @@ -112,3 +112,35 @@ Description:	admin read only
>  			   more information.
>  
>  		* "-EFBIG" : System information exceeds PAGE_SIZE.
> +
> +What:		/sys/devices/hv_gpci/interface/processor_config
> +Date:		July 2023
> +Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
> +Description:	admin read only
> +		This sysfs file exposes the system topology information by making HCALL
> +		H_GET_PERF_COUNTER_INFO. The HCALL is made with counter request value
> +		PROCESSOR_CONFIG(0x90).
> +
> +		* This sysfs file will be created only for power10 and above platforms.
> +
> +		* User needs root privileges to read data from this sysfs file.
> +
> +		* This sysfs file will be created, only when the HCALL returns "H_SUCESS",

		                                                                H_SUCCESS

> +		  "H_AUTHORITY" and "H_PARAMETER" as the return type.

		           s/and/or/

> +
> +		  HCALL with return error type "H_AUTHORITY", can be resolved during

		                  Drop the comma:           ^

> +		  runtime by setting "Enable Performance Information Collection" option.
> +
> +		* The end user reading this sysfs file must decode the content as per
> +		  underlying platform/firmware.
> +
> +		Possible error codes while reading this sysfs file:
> +
> +		* "-EPERM" : Partition is not permitted to retrieve performance information,
> +			    required to set "Enable Performance Information Collection" option.
> +
> +		* "-EIO" : Can't retrieve system information because of invalid buffer length/invalid address
> +			   or because of some hardware error. Refer getPerfCountInfo documentation for

			                                      Refer to

> +			   more information.
> +
> +		* "-EFBIG" : System information exceeds PAGE_SIZE.

-- 
~Randy

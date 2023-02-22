Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE81869F7B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjBVPZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBVPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:25:48 -0500
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8298BBDE2;
        Wed, 22 Feb 2023 07:25:47 -0800 (PST)
Received: by mail-pg1-f175.google.com with SMTP id s18so4273686pgq.1;
        Wed, 22 Feb 2023 07:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb07wK5FsL14HyzturGKlywOeZi+MsC8SWgfjTaL0t8=;
        b=bsZ3dnT6gxHmrcTNXPYq8wSbQE4SbWbBeP+xdalRPYJIXu5AncXcgZ9pjLJWCS596b
         HY5i8wKwDJbj3HV4Je7JDRurGayXLGzzOCbgx186GK+0hplgDwJO11+b/iHXK16B1WSE
         r+iidIB3vxP00UtAg7fdQjnUHZ4xLUW0WKQds+oSQ53BlvWlf50kBjB/0ZZCdf27KVNm
         Mfg8t6MrQIJFDOuVKgdqhubGA377H2TAwxG6fJPf8+4/7Ks3cf67Qq2r3C5iabUUL/wP
         L6jEkscn4Bt4xccMmB24rAg+V0Sxi0EflE8uno54M8ldRft2gJvr88Zxrj1SljIqLeKP
         bH7g==
X-Gm-Message-State: AO0yUKVBxRARxzawE2oXKBgpHtLOvM539qBeccNCH6CLsd4riDw5URiW
        5xzvPFTLJ6gjIUJ4YvvEiUeIVvKYIqQ=
X-Google-Smtp-Source: AK7set9OFH8kbmGgofK8w57SUzgduc7OUgNTQhobNzWqK2de26EP+MkMl2qb406C48QkJDiKM23DIQ==
X-Received: by 2002:a62:384e:0:b0:5a8:ea06:662 with SMTP id f75-20020a62384e000000b005a8ea060662mr8378979pfa.20.1677079546839;
        Wed, 22 Feb 2023 07:25:46 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j18-20020aa78dd2000000b0058b927b9653sm177382pfr.92.2023.02.22.07.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 07:25:45 -0800 (PST)
Message-ID: <b1f0ed44-d707-5593-7449-8a6bd23c9902@acm.org>
Date:   Wed, 22 Feb 2023 07:25:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] include: uapi: scsi: Change utp_upiu_query struct
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1677078770-30994-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1677078770-30994-2-git-send-email-Arthur.Simchaev@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1677078770-30994-2-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 07:12, Arthur Simchaev wrote:
> diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bsg_ufs.h
> index 2801b65..cccc07d 100644
> --- a/include/uapi/scsi/scsi_bsg_ufs.h
> +++ b/include/uapi/scsi/scsi_bsg_ufs.h
> @@ -54,20 +54,21 @@ struct utp_upiu_header {
>    * @idn: a value that indicates the particular type of data B-1
>    * @index: Index to further identify data B-2
>    * @selector: Index to further identify data B-3
> - * @reserved_osf: spec reserved field B-4,5
> - * @length: number of descriptor bytes to read/write B-6,7
> - * @value: Attribute value to be written DW-5
> - * @reserved: spec reserved DW-6,7
> + * @osf4: spec field B-5
> + * @osf5: spec field B 6,7
> + * @osf6: spec field DW 8,9
> + * @osf7: spec field DW 10,11
>    */
>   struct utp_upiu_query {
>   	__u8 opcode;
>   	__u8 idn;
>   	__u8 index;
>   	__u8 selector;
> -	__be16 reserved_osf;
> -	__be16 length;
> -	__be32 value;
> -	__be32 reserved[2];
> +	__u8 osf3;
> +	__u8 osf4;
> +	__be16 osf5;
> +	__be32 osf6;
> +	__be32 osf7;
>   };

All changes in UAPI headers must be backwards compatible. The above 
doesn't look like a backwards compatible change to me.

Bart.


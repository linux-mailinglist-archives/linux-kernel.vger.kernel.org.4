Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5D36BFA1B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCRNBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCRNBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:01:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7512C66F;
        Sat, 18 Mar 2023 06:00:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z21so30303526edb.4;
        Sat, 18 Mar 2023 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679144457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6vdkOe9PDpkNSQ/x0t7vPqLMcU3kTL7t8MTur54JSuE=;
        b=DQk+rU8btnnaErKEz5K1gVJ9Hw7fP07Vmbro03HZD+a2YFbGWV/cCLBOogDECPwgS4
         pboT0zq1vQvbLROmaE3sA10QyXJkPBn9ZK4mk6fukaA37ITBxvCtGG9rJIVZ8T7d7Xj1
         WSdRtNsEip0n1dKqQhOUA8OoiIFYPKjVUlFPLjIxNSwMqQAkims2SGix0r/r7a640P26
         Xi1kcHBQtAE+dTeXnEkow/eEP356zUobRSIclGwCO2mYKE8ZpzZCHrXWLr3C7yIhU/Pf
         3+NsZEtTUXdrAc/MZBCWCEtOdC5Nv9WcQHQFuNQRFuUhDCci1DX13Wzq+P4Vhfnauy2d
         Lrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679144457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vdkOe9PDpkNSQ/x0t7vPqLMcU3kTL7t8MTur54JSuE=;
        b=B365gAnxwRvePfUXVwOkp7EIAFnfoN5lXOracH95hwAExz9tyBJ0cMgamEvNa6k3XM
         89rw74WHD6FKVBZXsWT8h2AELzzSPsabu8MW9khV55mv2giO64nTdi1K5DXZ44JZ9lms
         KaA34qGwuUkEnyrz7wrHCAr63W+2P7zhIGJPfxEZOeiXcmXt9NEXcmvjE55+M2W1qj2F
         iJV7+xDk6FB3ygGEpL6TLkFwvRv2Pn4+jesfXbEDnz0qg2xMTmXH9jMJTWtnYveK1z8n
         7QDDzKUZiP54WU5pDCc7LFSmJKHzVXIxTBIWN5swt4++H7wQkOdUinWWA6QW7123Ccwr
         4s7Q==
X-Gm-Message-State: AO0yUKVCDUQKTneuag7U7jpzV7Pn6/9HtVOwBNl6J9Cm8VyER0vJgV1F
        KpcfI8c/XfV3QoIaei5OIyS2VEWAbPg=
X-Google-Smtp-Source: AK7set81wi7yHnNaHILHOCoa40of7SYjOnHmyp851kgJqe2pbcV2r3HjIQrkjTNlowzS4caq80rCfg==
X-Received: by 2002:a17:907:a066:b0:92a:7178:ab56 with SMTP id ia6-20020a170907a06600b0092a7178ab56mr2664232ejc.39.1679144456993;
        Sat, 18 Mar 2023 06:00:56 -0700 (PDT)
Received: from [192.168.178.40] (ip5f5b4297.dynamic.kabel-deutschland.de. [95.91.66.151])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906309600b0092f289b6fdbsm2149277ejv.181.2023.03.18.06.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 06:00:56 -0700 (PDT)
Message-ID: <d563cca7-57c6-289a-f551-a378f219aed4@gmail.com>
Date:   Sat, 18 Mar 2023 14:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH][next] uapi: target: Replace fake flex-array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZBSchMvTdl7VObKI@work>
Content-Language: en-US
From:   Bodo Stroesser <bostroesser@gmail.com>
In-Reply-To: <ZBSchMvTdl7VObKI@work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.23 17:59, Gustavo A. R. Silva wrote:
> Zero-length arrays as fake flexible arrays are deprecated and we are
> moving towards adopting C99 flexible-array members instead.
> 
> Address the following warning found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
>    CC      drivers/target/target_core_user.o
> drivers/target/target_core_user.c: In function ‘queue_cmd_ring’:
> drivers/target/target_core_user.c:1096:15: warning: array subscript 0 is outside array bounds of ‘struct iovec[0]’ [-Warray-bounds=]
>   1096 |         iov = &entry->req.iov[0];
>        |               ^~~~~~~~~~~~~~~~~~
> In file included from drivers/target/target_core_user.c:31:
> ./include/uapi/linux/target_core_user.h:122:38: note: while referencing ‘iov’
>    122 |                         struct iovec iov[0];
>        |                                      ^~~
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/270
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   include/uapi/linux/target_core_user.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/target_core_user.h b/include/uapi/linux/target_core_user.h
> index fbd8ca67e107..f925a77f19ed 100644
> --- a/include/uapi/linux/target_core_user.h
> +++ b/include/uapi/linux/target_core_user.h
> @@ -119,7 +119,7 @@ struct tcmu_cmd_entry {
>   			__u64 cdb_off;
>   			__u64 __pad1;
>   			__u64 __pad2;
> -			struct iovec iov[0];
> +			__DECLARE_FLEX_ARRAY(struct iovec, iov);
>   		} req;
>   		struct {
>   			__u8 scsi_status;

Looks good. Thank you.

Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>

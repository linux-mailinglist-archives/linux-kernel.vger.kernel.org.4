Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08758714BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjE2OXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjE2OXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:23:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4190FA0;
        Mon, 29 May 2023 07:23:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2566e60cc5aso1217693a91.3;
        Mon, 29 May 2023 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685370230; x=1687962230;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqJeUFI0e/XUEdlHTY4e2wDrM7CepfDC9k/Dx+kj8ME=;
        b=b+E42wo3vgI4jYGQ3xuQ9baGkNjBVT1Kt5aR+UQ0p2b8Fln0i8SIoxVZDgLgpfSulN
         zsmDLiWsxJfjgX9laEEmTKAcQ0e7Vd/Raii9SNkwCEauNF19mzefCuZPT+xdNLPND9RV
         JGd/dJ9+oSoaUtEfyoHWdZfv0FajPjkp9gCvFulxVr04ke7Gq+WWzuDQOibektfWx+Sf
         pCKTLK7CT9RFBrdD97d6KaEQ4uc9QcI6jtWt6eCbNsqG3E6saQagHN+q9+rNtznE6Gi0
         C+jUSLACU5VuZ0ofiuRBSy7gJlTcuiBbFrB8j95CahtlVUlG9V2YLvZM52+M3elMCvYx
         PEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685370230; x=1687962230;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqJeUFI0e/XUEdlHTY4e2wDrM7CepfDC9k/Dx+kj8ME=;
        b=eL2/vflUl17UqlH9IPsJYJoIMu9VXmfI/nvrU8dvkHSaTdpyUuSQA1CMPwjuFkmWIg
         wXD8Ky9E7890eCeZs3i3g0RiNkbO6xnot4Hqh2cuTsJmwWEN2Phq5+9jLr5wBiJZlfdZ
         y3dt7pTXXDRBo/pxHT27sMiznExdTgZDKUcM3zR7RA5jPdGbWiMBK/a3ujH9EHDBRwCN
         fio9ZhvKnb20j2MNu4kEJ5rCEC37PJXnwOBLhMORFIaxIVBc5JZUN9LTTl8QIYdwli+N
         9iHzEs+OyIKTSEQkYDF6/ZXQcXm+T2gQh399mDRLIp926RGbJgYsjh/QJYUF6t+f8WYu
         yIIQ==
X-Gm-Message-State: AC+VfDxaozpLBRybV57UUZEGHCFpk6TnwYyodyAsxsT281lOcRdV1GON
        gJD6eobKwitChR81XUafbkU=
X-Google-Smtp-Source: ACHHUZ6/DiWFb6+BGVzq9xdTbPAP5aNtypk8M4u2Z+kqbqRBFIXQBRs7+9cy1Ks97fWUToCt7hYrAQ==
X-Received: by 2002:a17:90a:748:b0:24d:f992:5286 with SMTP id s8-20020a17090a074800b0024df9925286mr10873036pje.36.1685370229465;
        Mon, 29 May 2023 07:23:49 -0700 (PDT)
Received: from [172.30.1.35] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a199900b0024e4f169931sm9846519pji.2.2023.05.29.07.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 07:23:48 -0700 (PDT)
Message-ID: <1d8df8d2-f44a-dd66-8e01-7e50fa147660@gmail.com>
Date:   Mon, 29 May 2023 23:23:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] PM / devfreq: Reorder fields in 'struct
 devfreq_dev_status'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <6b1611f1440c8b73feb475723ad25f390cad3480.1683531691.git.christophe.jaillet@wanadoo.fr>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
In-Reply-To: <6b1611f1440c8b73feb475723ad25f390cad3480.1683531691.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 5. 8. 16:42, Christophe JAILLET wrote:
> Group some variables based on their sizes to reduce holes.
> On x86_64, this shrinks the size of 'struct devfreq_dev_status' from 72 to
> 64 bytes.
> 
> This structure is used both to allocate static variables or is embedded in
> some other structures. In both cases, reducing its size is nice to have.
> 
> Moreover, the whole structure now fits in a single cache line on x86_64.
> 
> Finally, it makes the order of code match the order of the above kernel
> doc.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Using pahole
> 
> Before:
> ======
> struct devfreq_dev_profile {
> 	long unsigned int          initial_freq;         /*     0     8 */
> 	unsigned int               polling_ms;           /*     8     4 */
> 	enum devfreq_timer         timer;                /*    12     4 */
> 	bool                       is_cooling_device;    /*    16     1 */
> 
> 	/* XXX 7 bytes hole, try to pack */
> 
> 	int                        (*target)(struct device *, long unsigned int *, u32); /*    24     8 */
> 	int                        (*get_dev_status)(struct device *, struct devfreq_dev_status *); /*    32     8 */
> 	int                        (*get_cur_freq)(struct device *, long unsigned int *); /*    40     8 */
> 	void                       (*exit)(struct device *); /*    48     8 */
> 	long unsigned int *        freq_table;           /*    56     8 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	unsigned int               max_state;            /*    64     4 */
> 
> 	/* size: 72, cachelines: 2, members: 10 */
> 	/* sum members: 61, holes: 1, sum holes: 7 */
> 	/* padding: 4 */
> 	/* last cacheline: 8 bytes */
> };
> 
> 
> After:
> =====
> struct devfreq_dev_profile {
> 	long unsigned int          initial_freq;         /*     0     8 */
> 	unsigned int               polling_ms;           /*     8     4 */
> 	enum devfreq_timer         timer;                /*    12     4 */
> 	int                        (*target)(struct device *, long unsigned int *, u32); /*    16     8 */
> 	int                        (*get_dev_status)(struct device *, struct devfreq_dev_status *); /*    24     8 */
> 	int                        (*get_cur_freq)(struct device *, long unsigned int *); /*    32     8 */
> 	void                       (*exit)(struct device *); /*    40     8 */
> 	long unsigned int *        freq_table;           /*    48     8 */
> 	unsigned int               max_state;            /*    56     4 */
> 	bool                       is_cooling_device;    /*    60     1 */
> 
> 	/* size: 64, cachelines: 1, members: 10 */
> 	/* padding: 3 */
> };
> ---
>  include/linux/devfreq.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 7fd704bb8f3d..d312ffbac4dd 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -108,7 +108,6 @@ struct devfreq_dev_profile {
>  	unsigned long initial_freq;
>  	unsigned int polling_ms;
>  	enum devfreq_timer timer;
> -	bool is_cooling_device;
>  
>  	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
>  	int (*get_dev_status)(struct device *dev,
> @@ -118,6 +117,8 @@ struct devfreq_dev_profile {
>  
>  	unsigned long *freq_table;
>  	unsigned int max_state;
> +
> +	bool is_cooling_device;
>  };
>  
>  /**


Applied it.

Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


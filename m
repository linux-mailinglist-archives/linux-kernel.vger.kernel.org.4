Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE24695353
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjBMVoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjBMVoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:44:32 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB740273B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:44:31 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id nd22so6660976qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4fCmzCmDsrJ2j5aedYy/G0P8hgi4osOgCMNfN8jBU5k=;
        b=inuv8RcvJwjwLO2HRK4GYTKDCCLNCSNE3pBm++f9HVfEhz/j/2CcaLiLPg8rt+LM4G
         7ZYe9P0Th159eS3PeDuF4EokCWXxL8bju8joiwuHpMnQkT1t8qgb1YulyVUBfI1yK1Hx
         3WFGU4g5uLXpja6n5SQhm58JHalZMFz+V3TkrlYGIoZrFm6v6kZulufp0GkAYJSDmCM1
         3UxsUViITOB4H03wN96Zb+1LosfGnU6adSVCX07tT0tgq6VVz6SuR9tx79d36xWpo33U
         df8gXK4rPtffNnouiO7w7N34Zn3WjDje5Kog4eRQMUL7vruvgMY7LmYheSPPr+J9SjFU
         zvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fCmzCmDsrJ2j5aedYy/G0P8hgi4osOgCMNfN8jBU5k=;
        b=FqXKDaV7IxcM10/PcxuRgn2ij5nuf/i7Q2QCL1I5yt0r1wRLopEwPf3GkTqmmoOfJi
         clIIEE/9hcQEvj7bCuwG2LaANN6eRuSRy/usH64KBIMgIXubaE08Ejr1uAO5jqLgjyjC
         V/MuOjsBWrxxSLFJsrzzW9N1v33VeZ2UJkE/0Ge2ieflhUXj018q5e/zgw/6lPBQGb7z
         bxte1SQkx81vE7V+XYCITnfoSKdIIlRB3zPctfMcxhQ6+tDd4WPFtY9IIWhm3lEYvrJZ
         xUTWQVlrXuZrMuE+bD2I6Q9+G+i1WlmQcIqAoHRY06Bzum/R4tqvT7KDV5Yp6TcevNwY
         qLTg==
X-Gm-Message-State: AO0yUKVsgvW6iEa5eu+XSN8hfeXTcvqpnSPUPRhTykiZi4tMWDLRAHsw
        WxIhyY88GYeLm9Gnh2voxG8=
X-Google-Smtp-Source: AK7set/W9eLxRuvUyaFiyAh7UJh0BS6EvtVuO7CO5SbwA6YfUHuB9HZvQN6PBmjN4Ae7r642ESi0fA==
X-Received: by 2002:a05:6214:623:b0:537:6529:2218 with SMTP id a3-20020a056214062300b0053765292218mr641833qvx.30.1676324670766;
        Mon, 13 Feb 2023 13:44:30 -0800 (PST)
Received: from [10.4.10.86] (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id t3-20020a379103000000b0070617deb4b7sm10502477qkd.134.2023.02.13.13.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 13:44:30 -0800 (PST)
Message-ID: <cd0faa52-fda9-7b8b-7ce1-8ad33236c430@gmail.com>
Date:   Mon, 13 Feb 2023 16:44:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/3] riscv: configs: Add nommu defconfig for RV32
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20230212205506.1992714-1-Mr.Bossman075@gmail.com>
 <20230212205506.1992714-4-Mr.Bossman075@gmail.com> <Y+qUVbhFUrb289xG@spud>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <Y+qUVbhFUrb289xG@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/23 14:49, Conor Dooley wrote:
> Hey Jesse,
> 
> On Sun, Feb 12, 2023 at 03:55:06PM -0500, Jesse Taube wrote:
>> 32bit risc-v can be configured to run without MMU. This patch adds
>> an example configuration for RV32 nommu virtual machine.
> 
> There's a patch on the list (I think it came in after you sent v1) that
> pointed out that the rv32_defconfig in the tree is not actually used if
> you do `make ARCH=riscv rv32_defconfig`, but instead a make target is
> used. 
Oh that's interesting. Why is it still int the tree?
How would you feel about replacing this final patch with the
> below? That way rv32_nommu_virt_defconfig would always be kept in sync
> with the rv64 version.
Sounds good! The only gripe I have is the nommu_virt_defconfig is not 
very minimal, but that's not my problem.

Thanks,
Jesse Taube
> 
> Cheers,
> Conor.
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 7123511d977c..785d438ae5fe 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -173,3 +173,7 @@ rv64_randconfig:
>   PHONY += rv32_defconfig
>   rv32_defconfig:
>   	$(Q)$(MAKE) -f $(srctree)/Makefile defconfig 32-bit.config
> +
> +PHONY += rv32_nommu_virt_defconfig
> +rv32_nommu_virt_defconfig:
> +	$(Q)$(MAKE) -f $(srctree)/Makefile nommu_virt_defconfig 32-bit.config
> 

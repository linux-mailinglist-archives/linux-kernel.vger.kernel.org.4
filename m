Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1031A695AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBNHkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBNHkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:40:05 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0EE19F2A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:40:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id z13so10337436wmp.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MfAKDwWJ43uFMrmQCmp4cmYVyE9a/ZNUU9+gyhO73kk=;
        b=Wm4NDDwPgFj2N8AhEGdtG7Dk6poXCBt+/LRu8lqvLRpGJfDIXMNYWR/f31pUxPxChD
         dQDJ00ytooDrCNR3EybyI7px9PcoUmHseqyyTJf8yMFrHHGRBcXCIevd5gFuCmHAe2IV
         rku8wWWBlnDbnlzTRJPGZkL7csljK846s18eTu/wmdqqdkcML+/Yf8BDOYvTqGZ8HXm+
         6rBzVteyCjeFNxnZ8IhXvT1xx4I1fMJVzxn5EXLt0PkLOpVy5tgIoEaU7rMG4YzvN39f
         llTKto+ozJAYbbW7R+evJr+DRvXUm1MPzoXmq0bFrpp/rnIZmkVMx1WedYOtabFPZ6BT
         vxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfAKDwWJ43uFMrmQCmp4cmYVyE9a/ZNUU9+gyhO73kk=;
        b=3IRsM8JaEABfe1Xu3i5ytp9UErW2WXNg+jVY8jShEHEZSa2MCSOPnG+QBRvZOZQPfc
         6koKZWn6XfojsWEsHE+d2Okm/eJFoa3auGnxjdCEy6R+I1Srm29CSzjmZW3DQ+PxxZPN
         lwETa5108bQ9o1t+l6ZFGLx8YH7mZM7iynZjo0SxHgxvuyt3Lfn1M0Dqt2CfnJPJ3oRv
         279F6TQ9Ue8J0RI3Csitux3+NvGFRnbJ6jyoBHs8BiCnLT8J+6NJCI4cLcmhFDMNfMz3
         0lr8zP8NM7Lrfq9YDNkpF0slE9fpTdl/xY+mTC5Jct19+nbb/Q7VWbHPlg2Gsl8wuSpE
         /Xpg==
X-Gm-Message-State: AO0yUKW4rA/L+iBuk82wIepkENQRcjXF3EGLtbPWchZLoLsnWm6owwOi
        nzUptiiBYqFhEsPmCA60g8ojvg==
X-Google-Smtp-Source: AK7set8nUaCpcrcYlg0w3N6yvmYAWAs/RHYXPBxo1cIRik5qDPXHQ8TOHnIg5Z74kyzqZY9p4kiuzw==
X-Received: by 2002:a05:600c:4d97:b0:3de:1d31:1042 with SMTP id v23-20020a05600c4d9700b003de1d311042mr1128996wmp.23.1676360402677;
        Mon, 13 Feb 2023 23:40:02 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id k7-20020a05600c080700b003daf672a616sm15378729wmp.22.2023.02.13.23.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:40:02 -0800 (PST)
Message-ID: <7a2eca01-8420-dd98-9d4d-edf192f099fb@linaro.org>
Date:   Tue, 14 Feb 2023 08:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] MIPS: vpe-mt: provide a default 'physical_memsize'
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
References: <20230214010942.25143-1-rdunlap@infradead.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230214010942.25143-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 14/2/23 02:09, Randy Dunlap wrote:
> When neither LANTIQ nor MIPS_MALTA is set, 'physical_memsize' is not
> declared. This causes the build to fail with:
> 
> mips-linux-ld: arch/mips/kernel/vpe-mt.o: in function `vpe_run':
> arch/mips/kernel/vpe-mt.c:(.text.vpe_run+0x280): undefined reference to `physical_memsize'
> 
> Fix this by declaring a 0-value physical_memsize with neither LANTIQ
> nor MIPS_MALTA is set, like LANTIQ does.
> 
> Fixes: 1a2a6d7e8816 ("MIPS: APRP: Split VPE loader into separate files.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202302030625.2g3E98sY-lkp@intel.com/
> Cc: Dengcheng Zhu <dzhu@wavecomp.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> ---
> How has this build error not been detected for 10 years?
> 
>   arch/mips/kernel/vpe-mt.c |    9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff -- a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
> --- a/arch/mips/kernel/vpe-mt.c
> +++ b/arch/mips/kernel/vpe-mt.c
> @@ -22,6 +22,15 @@ static int major;
>   /* The number of TCs and VPEs physically available on the core */
>   static int hw_tcs, hw_vpes;
>   
> +#if !defined(CONFIG_MIPS_MALTA) && !defined(CONFIG_LANTIQ)
> +/* The 2 above provide their own 'physical_memsize' variable. */

Which seems dubious. The variable should be defined once, likely in
arch/mips/kernel/vpe-mt.c, since arch/mips/include/asm/vpe.h declares
it.

I'm surprised CONFIG_MIPS_MALTA always links malta-dtshim.o, but
malta-dtshim.o depends on MIPS_VPE_LOADER_MT, and I can't find a
CONFIG_MIPS_MALTA -> MIPS_VPE_LOADER_MT Kconfig dep.

> +/*
> + * This is needed by the vpe-mt loader code, just set it to 0 and assume
> + * that the firmware hardcodes this value to something useful.
> + */
> +unsigned long physical_memsize = 0L;

I agree this is where this variable has be be declared / initialized,
but having this dependent on CONFIG_MIPS_MALTA/CONFIG_LANTIQ machines
doesn't seem right.

> +#endif
> +
>   /* We are prepared so configure and start the VPE... */
>   int vpe_run(struct vpe *v)
>   {

Regards,

Phil.

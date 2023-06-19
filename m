Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D7E735175
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjFSKFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjFSKE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:04:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A6B2;
        Mon, 19 Jun 2023 03:04:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31122c346f4so3647838f8f.3;
        Mon, 19 Jun 2023 03:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687169097; x=1689761097;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm6Cc0Xss4W5//0ZUjHiKCDlCfy0uqiGU3h1YW8MZmA=;
        b=BIRA7Agk086POUiuAEZ0sF2Wftvy/CH+EyMwtcjvrDy/6f/A6+S1sO8E1lMLdJlmL9
         ZzoMKnprlQw7dOFc0Xc6/kIuz6qzl2MZEr/+F9HzbPDnxhnqOIRWmQyAEuxMlg8SKT6U
         7H9TlKK6Hf4Sxxqv0yBzHyI95PKIOWPE+GQFCigAJlWRdGRaKXjA11u4noj8F8umUrwl
         asShwh2UDZOF96NPKmW8sp/18VGSgcW0xsp84Haqy+kWOJRunRXxNzj92JGjNGZ9qvib
         dyuaGZNsyQuiwVyLYZxS7k5p5iLK5qqyzL9Ow58TfC9PR5ECZ8KZPfoSdXNAEmbFnP2x
         csYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169097; x=1689761097;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zm6Cc0Xss4W5//0ZUjHiKCDlCfy0uqiGU3h1YW8MZmA=;
        b=JPX/XinH6YF6PXSOtKBqV8oEej20/cGcRrXxTwR8FsO9Mi/iYD/81kdNm0PufcCxaZ
         gwE07IApdI9ERxuqTG7/quR7Q+8PaPMJLTjrB95j8FPyFDi4mPx9TamKCb+q/Ec/sewT
         ko0L08SR28xrOLUyDaIco0jh8T49sL7Zv03uO1Ug2JoT5JO5KdVkfXaqKz5Bmdmsee7D
         yEODyL3NV0j+lJXEKjqsnsn9fLaGeqd0uYFjUZSojg3B0WoPzoO4rZF+uQnrhHhK9eAe
         hfQz9uCiuyGfJ+DKmj1l1t5qRdJFL00AcwFD+Ccq+GDP2h3kCI72xc9AxjxI1Y+Wkx4A
         ZW4w==
X-Gm-Message-State: AC+VfDzlgLCmxjN+x2CtL3yo4VnLdSgfX23tVvpYVPTOyFqwp93CVqtY
        3SaEQnvECOIPPI3we3v5z66bKoZXh4g=
X-Google-Smtp-Source: ACHHUZ4X595QXTYGwIlqZlVK88XhzjZlp8pvYNZr/u5h00iVPvUfwT1VeZFJ154LPDdp1UUNnKo+nA==
X-Received: by 2002:a5d:6452:0:b0:307:7ae6:fe98 with SMTP id d18-20020a5d6452000000b003077ae6fe98mr8372048wrw.22.1687169097006;
        Mon, 19 Jun 2023 03:04:57 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d6112000000b003112dbc3257sm6081956wrt.90.2023.06.19.03.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 03:04:56 -0700 (PDT)
Subject: Re: [PATCH 1/3] [v2] sfc: add CONFIG_INET dependency for TC offload
To:     Arnd Bergmann <arnd@kernel.org>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jiri Pirko <jiri@resnulli.us>,
        Alejandro Lucero <alejandro.lucero-palau@amd.com>,
        netdev@vger.kernel.org, linux-net-drivers@amd.com,
        linux-kernel@vger.kernel.org
References: <20230619091215.2731541-1-arnd@kernel.org>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <4a249806-cfdf-9634-cfe6-6263c38ed0a3@gmail.com>
Date:   Mon, 19 Jun 2023 11:04:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230619091215.2731541-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 10:12, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver now fails to link when CONFIG_INET is disabled, so
> add an explicit Kconfig dependency:
> 
> ld.lld: error: undefined symbol: ip_route_output_flow
>>>> referenced by tc_encap_actions.c
>>>>               drivers/net/ethernet/sfc/tc_encap_actions.o:(efx_tc_flower_create_encap_md) in archive vmlinux.a
> 
> ld.lld: error: undefined symbol: ip_send_check
>>>> referenced by tc_encap_actions.c
>>>>               drivers/net/ethernet/sfc/tc_encap_actions.o:(efx_gen_encap_header) in archive vmlinux.a
>>>> referenced by tc_encap_actions.c
>>>>               drivers/net/ethernet/sfc/tc_encap_actions.o:(efx_gen_encap_header) in archive vmlinux.a
> 
> ld.lld: error: undefined symbol: arp_tbl
>>>> referenced by tc_encap_actions.c
>>>>               drivers/net/ethernet/sfc/tc_encap_actions.o:(efx_tc_netevent_event) in archive vmlinux.a
>>>> referenced by tc_encap_actions.c
>>>>               drivers/net/ethernet/sfc/tc_encap_actions.o:(efx_tc_netevent_event) in archive vmlinux.a
> 
> Fixes: a1e82162af0b8 ("sfc: generate encap headers for TC offload")
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306151656.yttECVTP-lkp@intel.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Additionally
Fixes: 7e5e7d800011 ("sfc: neighbour lookup for TC encap action offload")

The subject line doesn't specify a target tree; this should be for net-next.

> ---
> v2: add Fixes and Closes tags
> ---
>  drivers/net/ethernet/sfc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 4af36ba8906ba..3eb55dcfa8a61 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -50,6 +50,7 @@ config SFC_MCDI_MON
>  config SFC_SRIOV
>  	bool "Solarflare SFC9100-family SR-IOV support"
>  	depends on SFC && PCI_IOV
> +	depends on INET
>  	default y
>  	help
>  	  This enables support for the Single Root I/O Virtualization
> 


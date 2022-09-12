Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C65B5EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiILRIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiILRIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:08:35 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27CE24972;
        Mon, 12 Sep 2022 10:08:29 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-12b542cb1d3so15322317fac.13;
        Mon, 12 Sep 2022 10:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=P+yj0kZpxLF92Zt+kauiwSdiWfemO2wE95nLrqA9W9g=;
        b=Z+ayOWvmsu8vRITrDbJq0RkLWQ3mUC7tmXdtNUINpPdu5534cn6ruEqEHmV7WqV2du
         gvxBoEknXm2exATFDqepzbLUkGUPgpO4tOVlxrqzXaCndo/MQTtvCDa3PHQoK3tTWK4N
         WTMeunVVjE5vDOMiZ1XUfOhWTZP8/h5txF2Zp3fSEI1VcPoGxLu4ayy3XO8GY18/vMyx
         /d8XNB8Pi3veWtRli26xha4H/xMhU7cVjoEDwbkYpbLD3dLxpgafJii3DZWS8BmZYpBr
         kC+j1s5CNQ3wLQe9zXAwDoyRh0W4r37pEkaMeOX3UgIE2rHlwjv/wb4z3k1WAksJ4mdN
         0utQ==
X-Gm-Message-State: ACgBeo0nw+n6Sn12vWLFvOlndxjcqLcWb2O5Mlml01HkbbtDFZ2H4R5T
        11unv478SDIQ1NQHk/69VQ==
X-Google-Smtp-Source: AA6agR7J9pJ2OlqzfgNnmyVk42/RHOvyVTQyXTmGkII8KZ+jW58vAZ5PNrH7nPCuEBlqGXp0Vt7ulg==
X-Received: by 2002:a05:6870:63aa:b0:126:1c2b:82c5 with SMTP id t42-20020a05687063aa00b001261c2b82c5mr11720607oap.215.1663002508551;
        Mon, 12 Sep 2022 10:08:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z26-20020a9d7a5a000000b006370abdc976sm4871926otm.58.2022.09.12.10.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 10:08:28 -0700 (PDT)
Received: (nullmailer pid 1478814 invoked by uid 1000);
        Mon, 12 Sep 2022 17:08:27 -0000
Date:   Mon, 12 Sep 2022 12:08:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 00/10] misc: fastrpc: Add audiopd support
Message-ID: <20220912170827.GA1470954-robh@kernel.org>
References: <20220909133938.3518520-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909133938.3518520-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:39:28PM +0300, Abel Vesa wrote:
> This patchset adds audiopd support to fastrpc.
> 
> The v2 of this patchset is here:
> https://lore.kernel.org/all/20220902154900.3404524-1-abel.vesa@linaro.org/
> 
> Abel Vesa (10):
>   misc: fastrpc: Rename audio protection domain to root
>   misc: fastrpc: Add reserved mem support
>   dt-bindings: misc: fastrpc: Document memory-region property
>   misc: fastrpc: Add fastrpc_remote_heap_alloc
>   misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
>   misc: fastrpc: Rework fastrpc_req_munmap
>   misc: fastrpc: Add support for audiopd
>   misc: fastrpc: Safekeep mmaps on interrupted invoke
>   misc: fastrpc: Add mmap request assigning for static PD pool
>   misc: fastrpc: Add dma_mask to fastrpc_channel_ctx

How do you expect this series to be merged? Please spell it out to the 
maintainers. If you don't, Greg is just going to tell you the series 
doesn't apply (because qcom,fastrpc.yaml only exists in my tree), drop 
it, and move on to the next thing in his queue.

Anyways, I've applied the binding patch. Who knew fastrpc was going to 
be so popular this cycle...

Rob

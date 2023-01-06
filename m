Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF29B660278
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjAFOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjAFOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:47:20 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FA4FD30;
        Fri,  6 Jan 2023 06:47:17 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id x22so3868023ejs.11;
        Fri, 06 Jan 2023 06:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGI/LvjNJZyvuVyOwGG4SA1RPUvOcydsyd6I+qw6Ee0=;
        b=MjK3J9tcBOf8BQfILNEnwmwuH17L5GDPnvfDqOLQT5ksyCcaZ3GKvjWBrL8iIZigQx
         Ye4RdGrdMAzx1C12ERBoS2ndO/DUAMAMy+FsXTbVz7YAw0poYfZex+wdsErRAoSU+t+n
         cTioQDehb/zOQpdjoUC3umMKbYcHNfKQXqZFU7ztW5M9cqKSE8sAvmYz3cEDxHyn7dAB
         bdCN2KTOKAasbn1SxDK5ZgMi83Viztwnwx2j1YmbIu8FOy5RX7KqXzTM8WyB3VKa3Qsy
         2m/UsNcEml2L/4m6FN1/kA2lHynn9v2qsKzzmRDo353xkpSfLgM3izUB+n2skUizIqlc
         LPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGI/LvjNJZyvuVyOwGG4SA1RPUvOcydsyd6I+qw6Ee0=;
        b=oAriHF2wfu5lamoqnT49jlRFJ0GqGr2RcRoEzuf4s8OtdcHleXsAK5D56+seZT6oBH
         ZLHk2da5tdaeMDjVXMgVyTvie6q/jIJsmIuHO2xsimCcpQkOwKlB+HI2TbK3FJSHk0OR
         CF6a0QJPpciE6TOxnX2ERg4WTrTum0usjdj5e7oslIg9zChGG2zdUwaesiM7nIPEaQR7
         fF5KLP7EJq6tb7IUtTjcL5Ji4IZAVxNg48bP/MMNUxc+e3/mPxL4xte4ERYXnW6/t6Ix
         R2maOvOcQ6ozC9aWKj869D8Uk/RUe2eyFe1A99QdvsC6wXCfgX5CMebQ2BNMSFx3hjL8
         SQaw==
X-Gm-Message-State: AFqh2kr+CcBQO3dvsGs3qi/ijOIaPK+QPjq6dbxlTPdVl5r9XYcNEMJG
        u+AO0PlFDEM+UdPSYvlvEzo=
X-Google-Smtp-Source: AMrXdXvx6Bvn7l/DptvKVayjW74nPtCxqRKtOC1jLHYcyK3kujhVYz5ERYpmabasHnURVkOlOGd+6Q==
X-Received: by 2002:a17:906:f6c1:b0:7cd:ffd:51f2 with SMTP id jo1-20020a170906f6c100b007cd0ffd51f2mr59518067ejb.57.1673016435568;
        Fri, 06 Jan 2023 06:47:15 -0800 (PST)
Received: from ?IPV6:2003:c5:871f:9991:347a:5e94:efcc:e24? (p200300c5871f9991347a5e94efcc0e24.dip0.t-ipconnect.de. [2003:c5:871f:9991:347a:5e94:efcc:e24])
        by smtp.gmail.com with ESMTPSA id z22-20020a170906669600b0084c465709b7sm468729ejo.74.2023.01.06.06.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 06:47:14 -0800 (PST)
Message-ID: <5d8624ea-306c-2ab4-882a-f543c316c539@gmail.com>
Date:   Fri, 6 Jan 2023 15:47:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 7/7] ufs: core: Add advanced RPMB support in ufs_bsg
To:     Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@iokpp.de>,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221201140437.549272-1-beanhuo@iokpp.de>
 <20221201140437.549272-8-beanhuo@iokpp.de>
 <81a10cd9-7b0b-e982-5d24-5f0438e37b63@acm.org>
Content-Language: en-US
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <81a10cd9-7b0b-e982-5d24-5f0438e37b63@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

Thanks for your report, I will fix it along with cleanup patch. Sorry 
for this issue!!


Kind regards,

Bean


On 05.01.23 11:37 PM, Bart Van Assche wrote:
> Hi Bean,
>
> I think this patch is the first patch that adds a declaration in 
> ufshcd.h that uses the enum dma_data_direction data type. That leads 
> to the following compiler warning:
>
> In file included from drivers/ufs/host/tc-dwc-g210-pci.c:10:
> ./include/ufs/ufshcd.h:1282:72: warning: ‘enum dma_data_direction’ 
> declared inside parameter list will not be visible outside of this 
> definition or declaration
>  1282 |                                      struct scatterlist 
> *sg_list, enum dma_data_direction dir);
>       |        ^~~~~~~~~~~~~~~~~~
>
> Can you please post a patch to fix this? Adding the following line is 
> probably sufficient:
>
> #include <linux/dma-direction.h>
>
> This has been detected with the following script:
> https://github.com/bvanassche/build-scsi-drivers/blob/main/build-scsi-drivers 
>
>
> Thanks,
>
> Bart. 

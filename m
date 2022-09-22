Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3BC5E65C0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiIVOeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiIVOd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:33:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8092DF2740
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:33:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a3so14981592lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JxU3uKVUWz+9uazTKxzXKSZw/vdNYr+DWen17yUI8Jk=;
        b=UzRNr1HH172T/6Hta/GANHerNgkfJHmBMe9uw+ywAaTpTi2qPayhfmmRTtUZNWBxdS
         +qt1hjin1V8oFIv3vkfFXaeAon/rqqNm9dB8ANbt+O+/6vW0BC/hWtKV/iJnxZ5AP9g1
         jxC1QSjg7FIqU+lJlPq6gJXdz0VKO5XdnAqoBJHIjI81/4y0326iUeioV0TljBBlqGkD
         Dh4/n3phj6QmamyVgATL9y0RC6bpZBJFcCDdf+sRWEnvTawA4HqwRlI6dCOLD2K5oCHe
         iQlN5ArVdox5uwSC/vqFm3k8AsKFpraHMHrtzAs7cDm26O1DIAhRZPg467B5pMlsTXWM
         +m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JxU3uKVUWz+9uazTKxzXKSZw/vdNYr+DWen17yUI8Jk=;
        b=Hh8iN0B6pbBgiyShI+RK3l4QVoeYP+SGUJRlf2Dp/9B4j5ugp7x2EgfdPMTEMwcWaQ
         CwFyZHUZKoWFk1bfYXKwQnWWFcxvoBYf1w/eW57y91n5VlDqtE5Vkjp09Y9TLzC8Egx9
         DYZCwVBjgRevlakRCliWqT5xVib6m7CABQnT3CTzq5w7nVApCVKUHt41pnmDOZuoEkcO
         17wz4dZqNyX91DoADlV/94XH7rqKj7xAOhxx4c68xtuN55Krl9nKCeO6xaHeO/7aaIvU
         vK35VN5KvN9s3sgi1UBWMdIauvcXWlv8y/EIvQlE8JGZkg/9F2KoGgQCSfAcgU1b/g9i
         Cm5g==
X-Gm-Message-State: ACrzQf2SifK3Hg2gT0D0NCvhPIB5BUS6DBVPCXCPzdE0eyxQ3X8kYEVQ
        N/btfP1sYS0f1RSYHMk3WQrY8A==
X-Google-Smtp-Source: AMsMyM4NGpSqJPgoG+mfWgdzhFHm14FMjK4eGJDPejgN+ufox6PMD6+NsIo0h3SwZCrkBLk3uRDaJg==
X-Received: by 2002:a05:6512:409:b0:49a:eadb:5ec9 with SMTP id u9-20020a056512040900b0049aeadb5ec9mr1285259lfk.253.1663857233608;
        Thu, 22 Sep 2022 07:33:53 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d4-20020a05651233c400b004994c190581sm960728lfg.123.2022.09.22.07.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:33:53 -0700 (PDT)
Message-ID: <f3f740c7-1463-28fa-bd64-4da6612e3f09@linaro.org>
Date:   Thu, 22 Sep 2022 17:33:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 04/17] phy: qcom-qmp-usb: drop unused type from config
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-5-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220920073826.20811-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:38, Johan Hovold wrote:
> The configuration PHY type is no longer needed since the QMP driver
> split so drop it from the configuration and suspend callbacks.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 26 -------------------------
>   1 file changed, 26 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


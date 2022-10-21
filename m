Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6956072D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiJUIsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJUIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:48:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF8025435B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:48:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n12so3690602wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSFNtkmfg5HJGnBwVwzK/brsjkame9Rk59n6irgj5pM=;
        b=hmfrtnIGVaaRMtrlog0YzHsyBeJA2EzgROZJfEoPMuQdQXJGU8aAnXDAKZxaPt6dkl
         yyHA5KZCCx5gc+laIOM1n10V7loJ+VUVWYC8Oik+QHKAXuXjpj/ScnAM6PuqwhdYDLyR
         YiuKz8ydfjIruyteC0CWxt0/yHKMWB7+AQ2DU24amqRrwG1pF6Iy39Kosp07PpR7vqCe
         pj5ZA9Qqx/9WDCyHWWuVwErpPzDo31zmpVosboE39CqpheeqiRw/2Q8LtiRTIu846JY4
         L097IJocRxCepZrapKUFmutFgQ8ix9mraF5/na+v9zE7phBods3GsLACP11izA0Y+WkZ
         uPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSFNtkmfg5HJGnBwVwzK/brsjkame9Rk59n6irgj5pM=;
        b=1LNr0YJ5kKjmVZhhq/oZkLPr1M9vd0kXpvweLTAruUDgGsCrH+J+hUgSPE3pSiHzUT
         2MRyMmzbrHWY04h/XtWPY3UliN2PcHJnnIURzpw9n8FWUsZq+jtlaRYLxnroTmztZ+ED
         E7A2TphczFbF+yNCjq5Z59lXT2XQYuhetOaYlzLHKkeQDmPTuWLQUCvghej1jnGPLuyd
         d6m6FQLgKqk/51UcD3/LKCqoIw+KgEITe4/36SDt4/ck9ZoG7UOjCH7V1px4VaHRjuUv
         WsAksAaBk4iY1N9DOFq0zz59mc1vIjam0JDdEGDW7JcuY3NgEbqrACO1vmjH2VLm8ZKo
         P2EA==
X-Gm-Message-State: ACrzQf0ZdK1KjUfFg+gVun17JikAza2HY3IlxmaS6cIPzmyi0kyX6JFf
        Ka55PKJSWQCOcUGMoS5eIG/YNA==
X-Google-Smtp-Source: AMsMyM4CtTtuik587JkMUytvmJE7afQk+yiC7JQqU8FAhViA76vW2nVRZxhPZgnC65hg4zVSvnJfGA==
X-Received: by 2002:adf:f842:0:b0:236:555f:fc66 with SMTP id d2-20020adff842000000b00236555ffc66mr942435wrq.140.1666342081811;
        Fri, 21 Oct 2022 01:48:01 -0700 (PDT)
Received: from [10.50.0.10] (ec2-54-194-108-71.eu-west-1.compute.amazonaws.com. [54.194.108.71])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c350700b003c7084d072csm2187899wmq.28.2022.10.21.01.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 01:48:01 -0700 (PDT)
Message-ID: <56af191f-ffe5-57f9-2b44-cb99544b5b9b@linaro.org>
Date:   Fri, 21 Oct 2022 10:47:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH 1/2] virtio_pci: use helper function is_power_of_2()
Content-Language: en-US
To:     shaoqin.huang@intel.com, mst@redhat.com, jasowang@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20221021062734.228881-1-shaoqin.huang@intel.com>
 <20221021062734.228881-2-shaoqin.huang@intel.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221021062734.228881-2-shaoqin.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/22 08:27, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> Use helper function is_power_of_2() to check if num is power of two.
> Minor readability improvement.
> 
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> ---
>   drivers/virtio/virtio_pci_modern.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


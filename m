Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD23689837
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjBCMFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjBCMFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:05:00 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45ED712F7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:04:59 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso5874486wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 04:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SYT3sTcIk876TXaPuefnagCBbWeZUJQ7kBk1wp2K4rg=;
        b=W/055KT+v9ds9x+6vtJuT0/sDIbq4vQ+Cid0SA5RmwtnRz7FGnvDS+5zMAqD7f8aBI
         CEqmNSyMQgC0pzSFFL83fVjJRJ3TCSP8t8biH5kF3EI5qLOiVAwAS4bgPCnSuxxSZ+IV
         uVkDjbn+ao1gWMrVq1YrAkIZlhEn1ptvW1p8Mj8d9wY2GDbXglFlUIea93oPvOJudWz7
         GBPv+89T1Hi+Jku4b67lSTIoMvb2zUMVlfJeaAujWFEO2KlZAjcmM0BXyGTwwuSpxlgB
         16AVFgPFoEmeQl+KwFjAtC1GkT4LkHL5UOlnXIS2bumEqQi75OpW5YUpN8ykGQdIWkzX
         kK9g==
X-Gm-Message-State: AO0yUKWdvW/mXsRuc9HHUQfYKAhVhBTtpfqxNG3gJs6E6K2jI7pLfWSA
        QpXrN9wB22K0Cnb7/UG88jMGYU5k8xv4bbBD
X-Google-Smtp-Source: AK7set9jwrBjLJp8wyCMNEtcXEsITGFXDxtwUBAivuS8WF+rAvwLQVO3Dsw1PjVl9QOe9ssgfT2Uxg==
X-Received: by 2002:a05:600c:3ac7:b0:3dc:557f:6123 with SMTP id d7-20020a05600c3ac700b003dc557f6123mr9340368wms.1.1675425898201;
        Fri, 03 Feb 2023 04:04:58 -0800 (PST)
Received: from ?IPV6:2620:10d:c0c3:1136:1486:5f6c:3f1:4b78? ([2620:10d:c092:400::5:a43e])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b003dfeea6a85csm18113wmo.31.2023.02.03.04.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 04:04:57 -0800 (PST)
Message-ID: <ff2ac80f-222b-4aad-8fa5-c8f5835b3564@debian.org>
Date:   Fri, 3 Feb 2023 12:04:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Cc:     leit@meta.com, tglx@linutronix.de, bp@alien8.de,
        paul@paul-moore.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cpu/bugs: Disable CPU mitigations at compilation time
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20230202180858.1539234-1-leitao@debian.org>
 <20230202214442.ffqwk2can6b5ivpz@desk>
From:   Breno Leitao <leitao@debian.org>
In-Reply-To: <20230202214442.ffqwk2can6b5ivpz@desk>
Content-Type: text/plain; charset=UTF-8
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

On 02/02/2023 21:44, Pawan Gupta wrote:
> On Thu, Feb 02, 2023 at 10:08:58AM -0800, Breno Leitao wrote:
>> Right now it is not possible to disable CPU vulnerabilities mitigations
>> at build time. Mitigation needs to be disabled passing kernel
>> parameters, such as 'mitigations=off'.
>>
>> This patch creates an easy way to disable mitigation during compilation
> 
> s/This patch creates/Create/

Thanks for the review!

I am more curious if creating a new CONFIG option would be an acceptable
approach, and it seems so. I will send a non-RFC patch soon.

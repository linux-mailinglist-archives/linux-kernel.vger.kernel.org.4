Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFF670618F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjEQHph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjEQHpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:45:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EFEDA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:45:09 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae454844edso4214505ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684309509; x=1686901509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCBuutMUthJUkRrQzXH4Xqy8Klmtx8q2e1YC7kem8c0=;
        b=eK1QcMtOsl5ToHovu5tsM7JExtjBJ86QgIclyJ8n81kuf+2FCQA+0rZcuiWzlXxeFM
         h1aTmPWyYzmJ6skW6nJyTbLu0WDaO5cDGPo1JTbCFDPIDBuhJsY0J8RMpwu3ewF7lQPx
         lXQoTf9ld9pMEIsNpWgkPmTtCUjKfuYdd1cV9Dzd8d7n9bLNChVQbi13ZUJ4425pp8ET
         L1xi9TMe/nIFjFnfzP8s6b2Vvu5f2axKoHJg4LRzq2i9O6q1ABti3rcTF0725ZRJFHKb
         iCj3ub0vJWtfptJ+jJ9kodq9Hqd7HGUi7ca3KF5SubUmGBwObiaV2vWebNGWfUV4/Yuu
         r1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309509; x=1686901509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCBuutMUthJUkRrQzXH4Xqy8Klmtx8q2e1YC7kem8c0=;
        b=cwmug3Bq5Wt4ajPfyahFNnisTFEUMhzJoTjIjWCt6fAE/Okmyh5w0XW5dKbtrsP49p
         bEARuBRE7YzhdfBvo5Smf5pnhxlGxq9oY8Y6RVQ6UQ0QDPznEj3F281CEdTtDZBXXWsk
         ReGpkXaKmJN8Mie06WKPx8NDXsD9F1aREUX3RZWx6tdRF5Mb4LIqvUFR+1rSOduewobm
         +OOJ0fTHibtKhpPCvmVouS3rcESfRx3x3j/9nNyt0S4gjYJ2e4J8YQIEN/TnACGwYm4c
         AEeKdmohi262Rjcl/qRxWoIIDut9AT366ENYk6ZKglBzBm6sCoIacSyVGdr9Zt96Pg1U
         G+IQ==
X-Gm-Message-State: AC+VfDw0aNbaG+UaDKBte5A8N20dyFLoc0mMbaJh1jdm1yUzCGsDIZAZ
        2TtOmz/BIgcwbs0kLkwqEf1B+g==
X-Google-Smtp-Source: ACHHUZ59o1PVcTyaXxyJ82AFrbJ53xaFnzi9MfcVaV6F1bFEMs+c14sYqVIUt5CSyciEEGyXPKHfuQ==
X-Received: by 2002:a17:903:2451:b0:1ab:142a:3dd7 with SMTP id l17-20020a170903245100b001ab142a3dd7mr48163501pls.68.1684309508941;
        Wed, 17 May 2023 00:45:08 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id bi2-20020a170902bf0200b001a6b2813c13sm16878970plb.172.2023.05.17.00.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:45:08 -0700 (PDT)
Message-ID: <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
Date:   Wed, 17 May 2023 15:43:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <ZGSEq197W8VvOWCc@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 15:39, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 10:54:23AM +0800, zhenwei pi wrote:
>> All the vring based virtqueue methods could be abstratct in theory,
>> MST suggested that add/get bufs and kick functions are quite perfmance
>> sensitive, so export these functions from virtio_ring.ko, drivers
>> still call them in a fast path.
> 
> Who is going to use this?  And why do you think every virtio users
> would want to pay for indirect calls just for your shiny new feature?
> 
> This seems like an amazingly bad idea to me.

Hi,

I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio 
transport, as mentioned in cover letter of this series:
3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html

Jason and Stefan pointed out that a non-vring based virtqueue has a
chance to overwrite virtqueue instead of using vring virtqueue.

-- 
zhenwei pi

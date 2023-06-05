Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323E7721BA1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 03:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjFEBvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 21:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjFEBvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:51:40 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C2DC7
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 18:51:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33b00ce51caso16409015ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 18:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1685929898; x=1688521898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nn/2raZaCEyxkUMRUrTbO96sBipL80hG5ePyrz6qFx0=;
        b=vLTLo9Hga0Ar/isQv1thQ6LMwe4TSJJTmb7rjkogfP78xWUerUFwJaFlInNN9Rsbzl
         dV3v3LxF/3LdvZNssfF5mechwpN6sod6eFwCoqa7HtKcHPuPRa7K45x+vrJl8H7NSh7J
         SKxSlhKhnaKyUjqxey0rcUj2iDvQ4aqXRWBlGgBtJemIoMoJdEJhtkzT/XbQDP0vyvWO
         UzKUdFE+vNvkmZQlYZF0/l/ScJmT7Axe37yNY59/I/EzH1+1zDSZx78qAuTda7bY1vuH
         G+oPjEz37oRdwRPJZL7qx321ELEIQWoAeqUm5KJBPrMQAUQkpq3YuWiKkabMXOAjRaI5
         BqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685929898; x=1688521898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nn/2raZaCEyxkUMRUrTbO96sBipL80hG5ePyrz6qFx0=;
        b=irGPYkIhmquxBDxMG0j7sLIyM2FBdPrq8aKoVNL9mrJU84BKYnbhqZJCP7AJFeE02v
         SmGEBnlksFsIZCCOuZ9qeOqCf8CViJNoN4qJ4DIHq0pC3rHZAih1bMy+RT6biALAGib2
         GtHnnOruT26ZSQ9whGOTOfJep885S3a/JwqOF0hJM9pH7GOwh5V2plT0gRW7AckAKBcS
         qH/XSFn5gzi6QKNKKcz0tDKkQD04ixPAd4XhuXlEuwa2yndX9Y3gx35l6jMTt4JKRLgF
         vkAIoVZAfIb0Y8DMx0ZSbTxZgDL9rxkwxNB2WzlL4q9u/7QInM4TlagmCotlrkuMUlqD
         kQNQ==
X-Gm-Message-State: AC+VfDwlqSInjdBK4sNdkirDVuvXKc3UKoHawPDHLJSm6py7UV1USAma
        fEPlUx76/DZrJ5UlNjaXQegbbQ==
X-Google-Smtp-Source: ACHHUZ6j59fPcF9quNXpef0zZealPMWzACLlBgD6zknXufz/5SoUGHY373Tr8l3QoY7c6Dv6Vp7NDg==
X-Received: by 2002:a92:d20d:0:b0:33d:ab70:3447 with SMTP id y13-20020a92d20d000000b0033dab703447mr3111921ily.19.1685929898002;
        Sun, 04 Jun 2023 18:51:38 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79244000000b0065d2f009f9esm56628pfp.115.2023.06.04.18.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 18:51:37 -0700 (PDT)
Message-ID: <78f77d87-5499-b68c-298d-d49e740a2cc1@igel.co.jp>
Date:   Mon, 5 Jun 2023 10:51:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/1] vringh: IOMEM support
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230602055211.309960-1-mie@igel.co.jp>
 <20230602055211.309960-2-mie@igel.co.jp> <ZHtQybyy3qg+xw10@corigine.com>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <ZHtQybyy3qg+xw10@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon-san,

On 2023/06/03 23:40, Simon Horman wrote:
> On Fri, Jun 02, 2023 at 02:52:11PM +0900, Shunsuke Mie wrote:
>> Introduce a new memory accessor for vringh. It is able to use vringh to
>> virtio rings located on io-memory region.
>>
>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ...
>
>> +/**
>> + * vringh_iov_pull_iomem - copy bytes from vring_iov.
> Hi Mie-san,
>
> as it looks like there will be a v2,
> please consider documenting the vrh parameter here.
It was missing an explanation. I will address that and review this patch.
Thank you.
>
>> + * @riov: the riov as passed to vringh_getdesc_iomem() (updated as we consume)
>> + * @dst: the place to copy.
>> + * @len: the maximum length to copy.
>> + *
>> + * Returns the bytes copied <= len or a negative errno.
>> + */
>> +ssize_t vringh_iov_pull_iomem(struct vringh *vrh, struct vringh_kiov *riov,
>> +			      void *dst, size_t len)
>> +{
>> +	return vringh_iov_xfer(vrh, riov, dst, len, xfer_from_iomem);
>> +}
>> +EXPORT_SYMBOL(vringh_iov_pull_iomem);
>> +
>> +/**
>> + * vringh_iov_push_iomem - copy bytes into vring_iov.
> And here.
I do the same.
>> + * @wiov: the wiov as passed to vringh_getdesc_iomem() (updated as we consume)
>> + * @src: the place to copy from.
>> + * @len: the maximum length to copy.
>> + *
>> + * Returns the bytes copied <= len or a negative errno.
>> + */
>> +ssize_t vringh_iov_push_iomem(struct vringh *vrh, struct vringh_kiov *wiov,
>> +			      const void *src, size_t len)
>> +{
>> +	return vringh_iov_xfer(vrh, wiov, (void *)src, len, xfer_to_iomem);
>> +}
>> +EXPORT_SYMBOL(vringh_iov_push_iomem);
> ...

Best regards,

Shunsuke


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B030A6D06CE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjC3Ndf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjC3Nda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:33:30 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB0A5FE;
        Thu, 30 Mar 2023 06:33:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A9B2D3200940;
        Thu, 30 Mar 2023 09:33:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 30 Mar 2023 09:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680183203; x=1680269603; bh=8hK5O/2ZsARKmnZz4VEMmRHLiu7nMyGL3+T
        uIN4XVgQ=; b=jkcd9H00JGWhv/pd59Iu685SIJlwV7PUYONt+BWzN5jVDU4qiGG
        Ih66IhJZL/hEwJj+RhygbubQ9M6fdjOw7mHFZ+QHyZCe2iA36rNyojWNW0QpFjK6
        3CPoo3Ldo7vo94k+sCMtFkamYI0DApM030PMe93IceLsAukRMMuPdkCGBBoq+GxW
        WW9aPhkKbMEcM4oz+AdXGSIgkEBFxfw6md9XcdhKBewSTg3bGcq/02WppBWRVLaZ
        uh80aM4PnkwVh9eZ2Jn93BKry2qN2Eo3R89mu8yE+BjJypMbhBj0m6vguBz522Zj
        2U35ek8OmchECtvLojlKiei/tC0vbnLnxXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680183203; x=1680269603; bh=8hK5O/2ZsARKmnZz4VEMmRHLiu7nMyGL3+T
        uIN4XVgQ=; b=nRt5WBj6zh2NVesK4wfJXrHeustij60o4CQM1Z8ap0WbhxoBR9p
        X6Qib0PAB/kghz9C6bLv7dBGddMr1FtFjVMT/QDUz/Y8Wq8EIecp5RxU9DItivBC
        HF7rZS0PXRwcI4bB0G1sFzu7TEUFIise0eZ+3kmut5Ct/MN0I4CojB1xkWSOk7K3
        Uvvf+/UqoJIP8XbfY53WF9YF2eME73ZY4oUj3Mw7dPDVuQje6VZixuhbJ/OT+P/G
        ZTw2lj+/hvoe008mycs83U6XLMsH+BOHUYKeILgMjONkxkHxGi4H0IzDxTfFIwwy
        XBPXTJWzrJUK/Sq9q0D2kVO9Z6Jok1dMQ/Q==
X-ME-Sender: <xms:oo8lZEMS8RfF1Uxg6VwxMHZ6A2t44DZVOI_63KhsPdUpMQEfbA1WbA>
    <xme:oo8lZK8Ux__8YCQdzm4GeJjFejfyAb28YERpJfs12nKqBkmCJaJB4G1z0tERokhuw
    wpwI7FMkbLdb8ffZQ>
X-ME-Received: <xmr:oo8lZLRgDY8TVy1O4Q8BHiW4aWv6lez7FNewHvdu0lAElA8gaZI4H-8HuTVDdBKHnCFdBuAfQpieja3rUXhozSETdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehkedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfhuffvvehfjggtgfesth
    ejredttdefjeenucfhrhhomheptehlihgtvgcutfihhhhluceorghlihgtvgesrhihhhhl
    rdhioheqnecuggftrfgrthhtvghrnhephfehueeileevjeefkeetvdffveffudeuhffgte
    dvuefgiefgiedvjeegvdejleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheprghlihgtvgesrhihhhhlrdhioh
X-ME-Proxy: <xmx:o48lZMtQZ3ABcnNQPYB5XFStMvFossMCTkwFAVnhu3b7JoIsTtcJ0A>
    <xmx:o48lZMeM-28uuPzF4lmak4UE9rhpFk1hgAT5aux8v6ddIw5WmumPZA>
    <xmx:o48lZA1X8IgzUHr2vjmRqrz9Nbb7MHDoQsbFQG_p_ggEhgjHamo79w>
    <xmx:o48lZNrLalpSzehHpXur1td9XLHGcnN0_H5rJWhx7XzC7Y66OLvQkg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 09:33:22 -0400 (EDT)
Message-ID: <8df770e5-5493-b43b-6245-a5701f50c64f@ryhl.io>
Date:   Thu, 30 Mar 2023 15:33:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH v3 02/13] rust: sync: add `assume_init` to `UniqueArc`
To:     y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-3-y86-dev@protonmail.com>
Content-Language: en-US
In-Reply-To: <20230329223239.138757-3-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 00:32, y86-dev@protonmail.com wrote:
> From: Benno Lossin <y86-dev@protonmail.com>
> 
> Adds the `assume_init` function to `UniqueArc<MaybeUninit<T>>` that
> unsafely assumes the value to be initialized and yields a value of type
> `UniqueArc<T>`. This function is used when manually initializing the
> pointee of an `UniqueArc`.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

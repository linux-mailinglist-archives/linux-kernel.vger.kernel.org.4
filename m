Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A72C6C9D14
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjC0IBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjC0IBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:01:17 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7D104C15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:01:11 -0700 (PDT)
Received: from 8bytes.org (p5b006afb.dip0.t-ipconnect.de [91.0.106.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 5D96D242DAA;
        Mon, 27 Mar 2023 10:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1679904070;
        bh=SitBpKf8nbidQaG4tIolq8qtBfFDS6LQ8NO9TeDNB60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7PQbXZ9T4M/1zISpiv7nTUGWX93V+Nbafyy2pimAgsaHHzqwWvHepNh5MvMcw8Yl
         YzlklaOQKE8l/96tYLcVL+hcAGhu+UqR+7nnAanSFWby55xo/6Z7i3uThwFeECYEKx
         UDtqZ2cLiiHmmUHTj0b+ofIDj/ul+cG+cwh9BtPxjyOdR8vNmNeV97cysLDfnUFoWc
         ldHoQXa38VT4VT4z/TH/iNvDM852YeHBWV7QflpH/RCZVIdOO944uUOBXxXTC17bhF
         Z8DTQPoMZCnIxvnO4T1BRC+Mj+S90Z+dGpXxi25HGPEh0u+B1kJgNCou0jvRIMny9D
         WtdymEN2oX6bw==
Date:   Mon, 27 Mar 2023 10:01:09 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev, Baolu Lu <baolu.lu@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V3 0/2] Add reattaching support and fix memory leak issue
Message-ID: <ZCFNRfpUHbaGBvJb@8bytes.org>
References: <20230313075017.668204-1-chunyan.zhang@unisoc.com>
 <CAAfSe-tg7JwakdCcoLn3Ws_164HcsT21pWHkjjw0Qqwy8PWkhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfSe-tg7JwakdCcoLn3Ws_164HcsT21pWHkjjw0Qqwy8PWkhQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chunyan,

On Mon, Mar 27, 2023 at 10:47:18AM +0800, Chunyan Zhang wrote:
> Not sure if you received this patchset, since I received a rejection
> letter from mail.8bytes.org.
> 
> If you didn't receive it, I can resend it with another email address.
> 
> Otherwise, would you please pick up this series if there are no more comments.

I didn't receive it, can you please send me the error message you got
from my mail server?

Regards,

	Joerg

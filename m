Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7877872F425
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbjFNFaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242850AbjFNFaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:30:00 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3E198D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1686720598;
        bh=YMi7ui8mUgZ7xFFkJ5jRHmFFR0KM3n2BdmtqWjBfWoo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Xm3mi4uk+1eGjNtyboS8Ys6bgrLGRlC4yCrd64p73sBzfviEPL79mlXvS+ty1EIZx
         c3NIg3m+762aqr0b0naNw31oAYo+3RNevZfM7fhbw3i9tP92eHySeW105s5t5tmU9O
         fbBaZ439bPjEjOP+ya4F1+TuuDvWqaZXNyh7pJWSTzCzSGUmMRwGgkaBxckMEvGUU4
         V7zKLi8g3qFoV5Gki7QVAmzu8NbH3Ma3NqgWTr5tBs6Qm78U6IF6Y9Y9jstSJuPRXX
         GgOGDN4PqTDANYMBY46TF6pb7Zg/jK2nPK82ZgQXAnKFgyZSQ+pBjaDi9O7HiBPmx1
         QxvYxdXEOphcw==
Received: from [10.20.0.2] (unknown [182.253.126.223])
        by gnuweeb.org (Postfix) with ESMTPSA id ACF79249C00;
        Wed, 14 Jun 2023 12:29:52 +0700 (WIB)
Message-ID: <5844e20e-843d-f65e-107a-8fd4cff48e32@gnuweeb.org>
Date:   Wed, 14 Jun 2023 12:29:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] amd/display/dc:remove repeating expression
To:     Wang Ming <machel@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        opensource.kernel@vivo.com
References: <20230614034936.876-1-machel@vivo.com>
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230614034936.876-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 10:49 AM, Wang Ming wrote:
> Identify issues that arise by using the tests/doubletest.cocci
> semantic patch.Need to remove duplicate expression in if statement.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>

Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

-- 
Ammar Faizi

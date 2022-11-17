Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F8F62E275
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbiKQRB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240433AbiKQRBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:01:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5637C033;
        Thu, 17 Nov 2022 09:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Vmi6/RojD9d1OxFKL4E7Z1ad9Xu2eaOWEvbqfcXEucU=; b=atuTIcZYof2OikVaDi2a/irx4/
        k/aN4pt24Bz1QrGqRk3h+E2CnMAVSEGu5d+kLIFJ1ihdP+n6Q+m29Dl9hTpVGd8XLyqWuGzhHgDHJ
        NKEMrfT5+mrPjNLhvfUFVvZFyK9kum1Ll2G1bak/fNSuGNgE5wSlq7QDcYpW7ywnrjBFtrvz8wBlI
        x5SoItlev/9/36Wp+yzpsOHBnT9AbxU0ed+MU65fDJwcHGadtJ/rSceZIrTziOTkFzvOywMKeDIkd
        jbMOotCoxmhRJdd3Ql1zItsDWsEeWH2fNXXgCT5L0hBI14qD0+exyOjwKv3Dzey48OS/1OeLqAS3P
        gd69Ktaw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oviGF-00GH03-Jy; Thu, 17 Nov 2022 17:01:11 +0000
Message-ID: <e2948e8b-6e00-abbb-0948-017e7fd584f6@infradead.org>
Date:   Thu, 17 Nov 2022 09:01:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/2] math64: favor kernel-doc from header files
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221117023510.2338176-1-liambeguin@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221117023510.2338176-1-liambeguin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 11/16/22 18:35, Liam Beguin wrote:
> Fix the kernel-doc markings for div64 functions to point to the header
> file instead of the lib/ directory.  This avoids having implementation
> specific comments in generic documentation.  Furthermore, given that
> some kernel-doc comments are identical, drop them from lib/math64 and
> only keep there comments that add implementation details.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>

LGTM.

Could you also fix these 2 warnings?

math64.h:126: warning: No description found for return value of 'div_u64'
math64.h:139: warning: No description found for return value of 'div_s64'

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/core-api/kernel-api.rst |  3 ---
>  include/linux/math64.h                | 12 ++++++------
>  lib/math/div64.c                      | 15 ++-------------
>  3 files changed, 8 insertions(+), 22 deletions(-)

-- 
~Randy

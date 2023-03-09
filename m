Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EC46B26EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCIOch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCIOce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:32:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E82E6D85
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:32:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A45DB81F19
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E483CC433D2;
        Thu,  9 Mar 2023 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678372347;
        bh=M9nBZUKdAbo7aqhUgYcmb5vUfX+KWQ3bKb7HjgwvMms=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RsXUbPU2wJ0ZZHbaci+AdPqdWRIFlQeMTCGpk6kw2nDbgjrPaKV1nswhz3+VGjds1
         07lEfdc7xIVPwQUrgfA+Q6zeBMG8XkDsmCNbLxaA86WZ74OeBpfIUyjUJD20dzpktz
         rIbYwXdcgFRg2Y0YGLOkPAKOtwEyNqYW7XRtgWuypHSlWk8ccTIwtJjzSipGaFn1bG
         qSJPu8FeX+QiDruDgELBaPQECknbR+BgiC4csSCm7RG183IxpFvxGz+V3GvBz2gEWf
         /BhsT6gnZLkxpK36eCKYGD/RhdhVLnYrNDHU9jTlCKi/4v+NgM7NLnlRefn0Z7xCao
         iN4fPVyPU/BgA==
Message-ID: <c62316f1-ef98-84cb-8a59-e5880b664ea7@kernel.org>
Date:   Thu, 9 Mar 2023 22:32:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/
 __init
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, xiang@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230303063731.66760-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230303063731.66760-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/3 14:37, Yangtao Li wrote:
> They are used during the erofs module init phase. Let's mark it as
> __init like any other function.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

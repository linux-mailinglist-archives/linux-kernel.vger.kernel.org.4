Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82F86DCD94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjDJWkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDJWkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:40:05 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEA22694;
        Mon, 10 Apr 2023 15:39:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1EF2D774;
        Mon, 10 Apr 2023 22:39:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1EF2D774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1681166379; bh=6eDX70pXfu8exeQjJyVzkDJBCFe2BFg+SPl9U895Ey0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UA6bLRNVpXgHbt3KdtqejYqSASP0hBTVmpARCX98AhvJd9CtyFGl5gijjE0UPOeld
         /Yt+6WqEprCpl5bhMt8UHNeiSppyzusAiQ/Li/1W8PcRcTnO3s9Xab682o5iQArtdD
         41/rSkEoWu8X6ktmIbkFTwdcC1N5jJrkJpzGcfywAPXbOzoH1D5jRVYX7ngHw4GCVA
         H5fDcoslOD0FKHfZp9iKC5Q0q+FOBMp3uFrctTxAr2UAYqfTEFtYOKCufnsy8+ZuGu
         9wY3ZkUlTLT6XGd2CL3SxZGi/PE2M8RpiqtooiHtVmLSMyU6NSsXY8nqH0f0RLc+tF
         HvldD89qLSl7g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Takahiro Itazuri <itazur@amazon.com>, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Dunn <daviddunn@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Takahiro Itazuri <zulinx86@gmail.com>,
        Takahiro Itazuri <itazur@amazon.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] docs: kvm: x86: Fix broken field list
In-Reply-To: <20230404101401.25012-1-itazur@amazon.com>
References: <20230404101401.25012-1-itazur@amazon.com>
Date:   Mon, 10 Apr 2023 16:39:38 -0600
Message-ID: <873557e505.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takahiro Itazuri <itazur@amazon.com> writes:

> Add missing ":" to fix a broken field list.
>
> Fixes: ba7bb663f554 ("KVM: x86: Provide per VM capability for disabling PMU virtualization")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304041708.siWlxmyD-lkp@intel.com/
> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> ---
> v3 -> v4
> * Add "Reported-by:" tag.
> * Link to v3: https://lore.kernel.org/all/20230404090052.9872-1-itazur@amazon.com/
>
> v2 -> v3
> * Add another missing ":"
> * Link to v2: https://lore.kernel.org/all/20230331093116.99820-1-itazur@amazon.com/
>
> v1 -> v2
> * Fix commit message to say "Do foo" instead of "This commit does foo".
> * Add "Fixes:" tag.
> * Link to v1: https://lore.kernel.org/all/20230330233956.78246-1-itazur@amazon.com/
>
>  Documentation/virt/kvm/api.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 62de0768d6aa..a5c803f39832 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -8296,11 +8296,11 @@ ENOSYS for the others.
>  8.35 KVM_CAP_PMU_CAPABILITY
>  ---------------------------
>  
> -:Capability KVM_CAP_PMU_CAPABILITY
> +:Capability: KVM_CAP_PMU_CAPABILITY
>  :Architectures: x86
>  :Type: vm
>  :Parameters: arg[0] is bitmask of PMU virtualization capabilities.
> -:Returns 0 on success, -EINVAL when arg[0] contains invalid bits
> +:Returns: 0 on success, -EINVAL when arg[0] contains invalid bits

Applied, thanks.

jon

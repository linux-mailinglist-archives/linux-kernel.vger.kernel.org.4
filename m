Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDB26C95FD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjCZPJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCZPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:09:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7FB5BB2;
        Sun, 26 Mar 2023 08:08:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8570B80B72;
        Sun, 26 Mar 2023 15:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27E9C433D2;
        Sun, 26 Mar 2023 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679843336;
        bh=UuAkJgrrMzOljvaJjRW718aSixBHPPc3IjEWtYC7A9Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f/B9byChMZTmaJJP9ijbaTO+ce49FfvP8GvPeoZzw2odAmf5v4dRtpNLc6JRv5N0v
         VNKfvvmgW4aBmSCQVEDZ2fYIzPVT1qAVw5OBLHyAUhAytElRHCoZzYv4PabwY8jSpO
         1HZYTVuqleb4aDmFkzZ88dk3gG/EUtcU2gNnTWHk60NuA/JuQtIgd6ocVkYhjO1zGU
         gLSFp+rbGVTgX/l6nL4Dgth4jmeX1SUyfbqrDED3QANfP8Rh3bgmliLHqzy3Dy596F
         HjvBQsJaX6hGlcLf3aBSUKbWmXOPm41PvjU+5ENduTTr7RL1T9eQWAXELLPaBK2c+y
         jCWVBFCH+pm2w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 347D11540431; Sun, 26 Mar 2023 08:08:56 -0700 (PDT)
Date:   Sun, 26 Mar 2023 08:08:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     zhouzhouyi@gmail.com
Cc:     rcu@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org
Subject: Re: [PATCH] rcu: torture: ppc: Remove duplicated argument
 --enable-kvm
Message-ID: <7286a0ab-c8a3-407f-b242-7e823fc39814@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1679790274-1309-1-git-send-email-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679790274-1309-1-git-send-email-zhouzhouyi@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 08:24:34AM +0800, zhouzhouyi@gmail.com wrote:
> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> 
> The argument --enable-kvm is duplicated because qemu_args
> in kvm-test-1-run.sh has already give this.
>           
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Good catch!  Applied, thank you!

							Thanx, Paul

> ---
> Dear RCU and PPC developers
> 
> I discover this possible minor flaw when I am performing RCU torture
> test in PPC VM of of Open Source Lab of Oregon State University.
> 
> But I can't test my patch because I am in a VM.
> 
> Thanks for your time
> 
> Cheers ;-)
> Zhouyi                                           
> --    
>  tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
> index b52d5069563c..48b9147e8c91 100644
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -250,7 +250,7 @@ identify_qemu_args () {
>  		echo -machine virt,gic-version=host -cpu host
>  		;;
>  	qemu-system-ppc64)
> -		echo -enable-kvm -M pseries -nodefaults
> +		echo -M pseries -nodefaults
>  		echo -device spapr-vscsi
>  		if test -n "$TORTURE_QEMU_INTERACTIVE" -a -n "$TORTURE_QEMU_MAC"
>  		then
> -- 
> 2.34.1
> 

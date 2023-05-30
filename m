Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8A6716528
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjE3Owt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjE3Owo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:52:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866F99D;
        Tue, 30 May 2023 07:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0879562F71;
        Tue, 30 May 2023 14:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0811C491FD;
        Tue, 30 May 2023 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685458362;
        bh=lrGvDMEg7tRfc8Rot9o9QuAmWL8TRRNHnQdJdjzRMgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTNaMYXmzsTeL6EDs0zHzAJK5Mi3J6iQU5zP6C2CXI7v4g75+jdW+A+Qlr3A+NI+x
         sDccb2AEViFilCdPyLapitGVRBRfFZU76Q3OK7YUI+FmiR2BVRduYIeU/cV10/Ts0V
         jA/hFQGOIMNNC1GSFiTyolBxImCMRlefMMtgq5UQiee0+rLqawXejFnrFnczs1p/P0
         clLfQBs7iuGXZpObYbZ9BH8frlR64gJ/LAOr1nKFYiWGGRl9AkGamhMwPqsvN4b9v2
         VGmdDfm5w2qlt0DSguNta0Qs+L6o72BfXT90u0IZruB0x1QHdB5U6MFpzuMDKIcohS
         Dmwof2lgs3kyw==
Date:   Tue, 30 May 2023 07:56:25 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20230530145625.2znyjfd2bujfii5l@ripper>
References: <20230530074943.5b196424@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530074943.5b196424@canb.auug.org.au>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 07:49:43AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   8b9ca2f3ea45 ("ARM: dts: qcom-apq8060: Fix regulator node names")
> 
> Fixes tag
> 
>   Fixes: 04715461abf7 ("ARM: dts: qcom-msm8660: align RPM regulators node name with bindings")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 85055a1eecc1 ("ARM: dts: qcom-msm8660: align RPM regulators node name with bindings")
> 

Thank you Stephen, the tag has now been corrected.

Regards,
Bjorn

> -- 
> Cheers,
> Stephen Rothwell



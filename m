Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708A472CD9B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjFLSNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbjFLSNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:13:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B510E2;
        Mon, 12 Jun 2023 11:13:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A16C762CAE;
        Mon, 12 Jun 2023 18:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8623CC433D2;
        Mon, 12 Jun 2023 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686593622;
        bh=0vMAS5XT6J0YOY/P6/h4ZZSt7CogaFpg8bXoq4Ri2nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiPfxUYP14W7ult6tJFHOYve3cAaGvoH4MbQ6X7FimDYlIAE6iKbOBu1nMmw2KZMf
         FTf479bDppoh1uIYm52UDLE+SSI+khzGEAHK7art2f8oni/DvMdZimpoTCVjyyvBqs
         UuM9kv4uUbF9MQ8yUjR0f+DjRkHB+smcRzkpsGgo=
Date:   Mon, 12 Jun 2023 20:13:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/132] 6.1.34-rc1 review
Message-ID: <2023061224-bubble-violator-ef08@gregkh>
References: <20230612101710.279705932@linuxfoundation.org>
 <ZIde9VarEXi/BkzI@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIde9VarEXi/BkzI@duo.ucw.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 08:07:49PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is the start of the stable review cycle for the 6.1.34 release.
> > There are 132 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> I notice that origin/queue/6.1 was not updated. Is that an oversight?
> It was quite useful to see what is coming.

I have no idea what creates that branch, sorry, it's nothing that I do
on my end.

greg k-h

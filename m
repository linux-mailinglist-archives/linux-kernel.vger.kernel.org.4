Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF46672E9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbjFMRgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238213AbjFMRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5581BF0;
        Tue, 13 Jun 2023 10:36:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B18F86391B;
        Tue, 13 Jun 2023 17:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F954C433F0;
        Tue, 13 Jun 2023 17:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686677787;
        bh=xy1yTj6seRW8BuGw7Z4OCxdr4C+LviTrNPkRVIZHTPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7aWFk0ucExIQgy7aMeu+4TxMdzseTHtuhvDXVoD691Io1Fs3SDY9WteJt/Qauzxq
         OM9b3Y7ApZG/qD8ky+cQV8o91ZF4nWkOSXYmKn9vFm01zxWciDkdUh0a5vf0MIBdyb
         CAlZWjp8iLL+uWNZySqzSk+t1lRB4HDzIDS5ZdNk=
Date:   Tue, 13 Jun 2023 19:36:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 00/68] 5.10.184-rc1 review
Message-ID: <2023061300-cardstock-buckshot-0ccc@gregkh>
References: <20230612101658.437327280@linuxfoundation.org>
 <ab4e5232-ccc4-144a-cb72-2a0cce825f31@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab4e5232-ccc4-144a-cb72-2a0cce825f31@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 09:35:37AM -0700, Guenter Roeck wrote:
> On 6/12/23 03:25, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.184 release.
> > There are 68 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Am I the only one seeing this problem ?
> 
> Build reference: v5.10.183-69-g32cae866b182
> Compiler version: x86_64-linux-gcc (GCC) 11.3.0
> Assembler version: GNU assembler (GNU Binutils) 2.39
> 
> Building x86_64:allyesconfig ... failed
> --------------
> Error log:
> x86_64-linux-objcopy: vmlinux: unsupported relocation type 0x44
> x86_64-linux-objcopy: vmlinux[.text]: relocation count is negative: bad value
> make[3]: *** [arch/x86/boot/compressed/Makefile:114: arch/x86/boot/compressed/vmlinux.bin] Error 1
> make[3]: *** Waiting for unfinished jobs....
> Unsupported relocation type: unknown type rel type name (-1939958716)
> make[3]: *** [arch/x86/boot/compressed/Makefile:122: arch/x86/boot/compressed/vmlinux.relocs] Error 1
> make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> make[2]: *** [arch/x86/boot/Makefile:115: arch/x86/boot/compressed/vmlinux] Error 2
> make[1]: *** [arch/x86/Makefile:274: bzImage] Error 2
> make: *** [Makefile:192: __sub-make] Error 2
> 
> It affects 5.4.y and 5.10.y for me.

Odd.  Let me go build with gcc-11, I have just moved to gcc-12 on those
two branches locally...

thanks,

greg k-h

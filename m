Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189126F240D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 11:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjD2Jz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 05:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD2JzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 05:55:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB67C1998;
        Sat, 29 Apr 2023 02:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8930A6092A;
        Sat, 29 Apr 2023 09:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EFAC433EF;
        Sat, 29 Apr 2023 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682762122;
        bh=IFjWI4e/LGyg+cIKqlJF9QFaroYhfR116QVhSACAVS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0kP3jOVAGvtMyN+BIgjCI/QXDhtbqgQ6oVHq7qJRzPbkNSpPt8d5IofQ1It3mj/p
         W9oCFjoitBudXlNDXeJaVWbeIkDz6GqVKAnmeMssM2hrJBsjxjuP8nDw1ynU7/50Gj
         B99E9ikg/UAv43xN5Vox0GZaK2ErbM8vw1Fzm0ql+zRuD0PlYzl+bvDaFqsYgD1+CP
         SHd9W/c3CDeHbcgU2KUqJmJTUBjzwVzc9YU7lGFyUrkvs3XPHlwx3Yx70wIG9zhCVT
         XPjuMTTdF1BPqgEXqRuenmBGyEPRuwb4cs23HcF1OWnGG08QRABmdry3uW2A6ukmt5
         rWjd0MUxm44mw==
Date:   Sat, 29 Apr 2023 10:55:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 00/15] 6.2.14-rc1 review
Message-ID: <20230429-uneven-issue-c22086e02487@spud>
References: <20230428112040.137898986@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NvEdwSXYuuUrp8ip"
Content-Disposition: inline
In-Reply-To: <20230428112040.137898986@linuxfoundation.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NvEdwSXYuuUrp8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 28, 2023 at 01:27:44PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.14 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Ditto here,
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--NvEdwSXYuuUrp8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEzphAAKCRB4tDGHoIJi
0oJFAQCC7sYeXBhGZZQJbn3T40D2W8z+sQwYC9DLTnXCYqI8/AD/fxPohtWrPJCE
iMOQ3UJIyOa2VKt9PZ5eBFpVZheV5QQ=
=mNaH
-----END PGP SIGNATURE-----

--NvEdwSXYuuUrp8ip--

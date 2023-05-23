Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41C970DFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbjEWOzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237400AbjEWOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEF911B;
        Tue, 23 May 2023 07:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 015C76298F;
        Tue, 23 May 2023 14:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50030C433EF;
        Tue, 23 May 2023 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684853699;
        bh=zdl3AS29MyWrLEmOP0SSKeqNHJlZoqqwYHXogpqPUXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jKc2zzzlsLy56Yi49H7pkqwLeJClCqkpF6fm0ZtPJRzjnQvemi58FolIFHeG19WMc
         nhgv38Dqfayym2AojOBN3nBqO+KD77DuyatEZZK0ckyszE/FMbo4wya7bvTpFI1Bmd
         NA0U7U7EeXvX9ut8dJo88w+6mKrvOGmA7xIbvWiwpUPfLBUHUUcJ+qQZR0aVCSNJaN
         eAtdRcdyGr2nEcJtRFIYmI5HNKexH3kpOTZ5GBJGTR3PWoJUF7pASaKDLXcqwnZ5Ws
         CTtv4LKyhnqPXXe32vv6OECAqrDt3ad+pJZ+6wENQGeePi3Nq4QBIIYUG0kX/ZW5IJ
         MRmRY1gM4PJXw==
Date:   Tue, 23 May 2023 15:54:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/292] 6.1.30-rc1 review
Message-ID: <20230523-swapping-tracing-90ed17441023@spud>
References: <20230522190405.880733338@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QU4KWqIybnCs5+Gi"
Content-Disposition: inline
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QU4KWqIybnCs5+Gi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 22, 2023 at 08:05:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.30 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--QU4KWqIybnCs5+Gi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGzTvQAKCRB4tDGHoIJi
0uPjAQCUCWcOuk/Ir+if2RbUuyJhXoBsiMaPdx1ZnANDOqQ48QD/V6WATUmaHG1h
DwZW4S47uBtiAZ3h537ew1tsbd62Ggc=
=bTzy
-----END PGP SIGNATURE-----

--QU4KWqIybnCs5+Gi--

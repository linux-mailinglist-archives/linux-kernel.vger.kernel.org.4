Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D376E122E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjDMQYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjDMQYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB07A243
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C22CE60B2B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45EAC433D2;
        Thu, 13 Apr 2023 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681403041;
        bh=0QBSOSsFxyYPkRFs0LrG48A5TdQZmpspoIRiqn2doL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+LOmdTJPxOAUqVODueDkeGiPdbckmrlsLPz678m6x3CZNAwrzfZftEjLsVPDqTXg
         SbowcuHGMFgJipj8zImC/yPJ6ydGs5esOYGEo/g2YOeb5bope+L6cZHRw043NXxU7B
         Ax4PbN4H5IoDbIUyaT1OeC/z0m77E8r6IL56IyVgdAsIEggj95G/d6hnbxgbVS6iLA
         YZu6/ZJQpgM6Rai8eDS8hEs89KUH7zv5jUc7b7fWWfXge/nL1pAbzFQV3kcVYxoVgy
         Q+rIJYcy/8u6ieXa00WD2T293WS82SCFj6B2Hr6oYGPgOr5+t7Ar85+02H2AmnHkfx
         0aagkGweJNL5w==
Date:   Thu, 13 Apr 2023 17:23:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 3/4] arch_topology: Remove early cacheinfo error
 message
Message-ID: <20230413-proving-carport-cbd5188e573b@spud>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
 <20230413091436.230134-4-pierre.gondois@arm.com>
 <20230413-prudishly-unruly-090f5297fd54@wendy>
 <78419d88-1114-e58e-aeec-6a991a8fdb37@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+eOzTgcwHz5xj5a4"
Content-Disposition: inline
In-Reply-To: <78419d88-1114-e58e-aeec-6a991a8fdb37@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+eOzTgcwHz5xj5a4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 13, 2023 at 05:25:25PM +0200, Pierre Gondois wrote:

> Is it ok to do this and keep your Reviewed-by ?

Yah, should be grand chief.

--+eOzTgcwHz5xj5a4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDgsnAAKCRB4tDGHoIJi
0jxLAP0Vc/xwI8EXMVSiMgFaFFebqsFnzHP9Dh33+KE3/X0V4gEAhC07zYnpcZzm
WTst17jFGKfeXCTbl7DvlM29ar+6ggA=
=0TMD
-----END PGP SIGNATURE-----

--+eOzTgcwHz5xj5a4--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BF6704DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjEPM2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjEPM2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:28:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E56365B5;
        Tue, 16 May 2023 05:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684240089; x=1715776089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JSFHhNBo3Q5iXL83yY9BoSV9Vwb6Ca/x4uu+gldcZW0=;
  b=AETDR/FQohl5/tgAlQA2uDAqIGzPuDYJp7MMAYsUhiNBfZd0QffDC1Tw
   3pekCySxvALjKnAsnWPox8FodzhpEvwoF5Q+ZnP+KGeFDDy4kSh8G04k4
   JRh/EY5mzIwTvrfwW3kob9ans4ebAB3ZFfO8NB/GvGQ2meljtoA+dvrfl
   x7qLmUiy/nOaCG5G0cn2ADclqMP7W3tb0buRUSN60k9TqrdjlmR44b53T
   9dFkTKnWrCJEmE5Hbq6SVogNfZ4CAaAIuDx+veqAMnUYKFIHE35AkGQPn
   4yyaz82OEgCG9J8kHHPIO0uHLIaoolK3XpQnCLxkvMTPe3HufpS1bKznM
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="asc'?scan'208";a="152310228"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 05:28:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 05:28:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 16 May 2023 05:28:05 -0700
Date:   Tue, 16 May 2023 13:27:44 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>
Subject: Re: [PATCH 6.1 000/239] 6.1.29-rc1 review
Message-ID: <20230516-blunt-sneer-9dca68322e3e@wendy>
References: <20230515161721.545370111@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ytfdsV2r3cBhfVZ"
Content-Disposition: inline
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--3ytfdsV2r3cBhfVZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 06:24:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.29 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Looks grand here too.
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--3ytfdsV2r3cBhfVZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGN2wAAKCRB4tDGHoIJi
0lkwAPwMOlCmSYJNVWVgj8kGzFd8V64yvQMMnOaoQqPUd7KZDwEA9/I5XUD9Lwyr
aedluvVmH4iujCCBQMYtXZms9Lc+3wM=
=u0IC
-----END PGP SIGNATURE-----

--3ytfdsV2r3cBhfVZ--

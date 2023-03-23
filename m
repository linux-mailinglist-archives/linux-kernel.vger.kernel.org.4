Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70216C6AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCWOVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjCWOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE32236FC0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 687986273C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0189EC4339B;
        Thu, 23 Mar 2023 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679581228;
        bh=APEr/cl++fNE36UfS6xPTNgz2hzS1cXNDRWKehUN1pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9pkcHIl1LFeSm9+5zK9o7nqSsasvOgEqlA4K5GYuJXHuRefJicoNADl5WEMnMX4N
         sx+AGdseTKrWBTHGuAlJZFJTPg5MQK3ijtI11abIzBQcobm5DNlZDakiYhwYp/6C8Y
         XywHlsSSDTS7wdxWMBST5XDptogyCgnu84cHj6rkLj5jI5vio/lSV7I/V9qato15rb
         8AT3envn4AGYZVUpwpozsRGxh8/Q6CbG1XCDJVYkyqDLDky6hdml13sfPIO9GgcNlT
         CxhEmN0gfiy3S2Cne7AXDMkVeQrgEhWN+CKvGPCx8VKCtQPvZIgdrrSM79KYag+soE
         oHA+MA3gqqmKg==
Date:   Thu, 23 Mar 2023 14:20:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: Re: [PATCH 08/20] ASoC: SOF: Intel: hda: retrieve SoundWire eml_lock
 and pass pointer
Message-ID: <d35022ce-3922-4198-a040-003fbbbd0135@sirena.org.uk>
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
 <20230323054452.1543233-9-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IN+JnGwO/FMaIQao"
Content-Disposition: inline
In-Reply-To: <20230323054452.1543233-9-yung-chuan.liao@linux.intel.com>
X-Cookie: A lie in time saves nine.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IN+JnGwO/FMaIQao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 01:44:40PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> Use new helper and interface to make sure the HDaudio and SoundWire
> parts use the same mutex when accessing shared registers.

Acked-by: Mark Brown <broonie@kernel.org>

--IN+JnGwO/FMaIQao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQcYCYACgkQJNaLcl1U
h9Aa+gf9GXa/tSkShN5hlAgVFMfPL1BuU+z9gPd1Ui3M7xeU1mOw5RPq04XsM5qL
D0TQL3b7Y3d6snNNyhRB8PiS8HqT4NTh1kEaFZWEkkAqE6RNvYrB7z9YtnflDy8S
wcJd8fkOGBs/X4uJYYodQ0C/qlcB1CCamWlB7CsnteV4pmuP1ZdHIXqg3hz5/hBi
pIeU+k3DOuRTnLRJeZds/6rJDyUJNpZlur4QtNghckU98vKap80z+K31ena+P+dE
pmVhaD9s33Nfc2ZfMCBAw6cWKFAqUzWiA1Nh2a6jodEBSSfNSBb0YpIlNpcgYAtd
wnti8BNQDbimn3gVfyDb1PGVqtT5dw==
=ySuG
-----END PGP SIGNATURE-----

--IN+JnGwO/FMaIQao--

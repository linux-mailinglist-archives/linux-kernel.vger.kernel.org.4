Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267B6BC33A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjCPBS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCPBSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:18:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3360C38B4C;
        Wed, 15 Mar 2023 18:18:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PcTtC6WZVz4x8y;
        Thu, 16 Mar 2023 12:18:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678929524;
        bh=rnFBpHYVb+miKgOWyaufPIxNMiKQuJ+xTmGc0LGgw5I=;
        h=Date:From:To:Cc:Subject:From;
        b=jotae6KFb67x5z8ge5UYp9RZm0OfSn6RavleAAcN9BtadEt/DO2kxEqNnGmKPCE6y
         LH+INJzZSW+yNCie6kJP34v9lzJ7BNkpsRp6AQ32fcp+DXHbYjuksUIqtqony8kQv+
         vS4JxjDR3JDzoyQeCDU+rKdVoAEiNtLKHoNBCdaQKnS6byQWntsHUZ4oaTVIXZpK2Z
         ogjbqizXbCRvNlMRf6jRdVIC7+KWIxwjdw9WrGyTmyAQtsHOkr7DhqkpdMLq+mcE/F
         bgGHDj+LDGIQvaciEoEqfLJ/VdpbkFfYv8OFzNVgnVfFSEAn7ykDVKZ50e+URyi/sd
         2SoUp3cqmBMMQ==
Date:   Thu, 16 Mar 2023 12:18:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Hawking Zhang <Hawking.Zhang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the amdgpu tree
Message-ID: <20230316121843.23b21695@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WxqvbzyzqnU3.4_FsoNBV2k";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WxqvbzyzqnU3.4_FsoNBV2k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced these warnings:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:754: warning: Excess function pa=
rameter 'pcie_index' description in 'amdgpu_device_indirect_wreg'
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:754: warning: Excess function pa=
rameter 'pcie_data' description in 'amdgpu_device_indirect_wreg'
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:785: warning: Excess function pa=
rameter 'pcie_index' description in 'amdgpu_device_indirect_wreg64'
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:785: warning: Excess function pa=
rameter 'pcie_data' description in 'amdgpu_device_indirect_wreg64'

Introduced by commit

  3069956c8cfb ("drm/amdgpu: Move to common indirect reg access helper")

--=20
Cheers,
Stephen Rothwell

--Sig_/WxqvbzyzqnU3.4_FsoNBV2k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQSbnMACgkQAVBC80lX
0GxvBggAhJvY4GVszUG8z/ExK/DrtWTBQwVHbaMC+u32Agq+o2pA6F7U/bkvZr1P
Z/eU+S4XNsxZUvqQ4OW68/vokxcfZt12JPAOWrKOqPUZnGH0WtMOgMbp13nKXr5G
al3Q2AeEInrN6tM1I2ykuT5Bb7tf0XyIv+UNt7s8GpT+W/1QPwKidJ8B7O0QITNa
99VncUPSRjMNOMoz/B2DMKjY7B12uWy4PAmXmqUzuW2uccb2MyPb6/r18gwyIIP9
ITrDlFZuLfc96tUhD3rzWcaFq2cGrL+Y0S/YCLZaH5JInG/K3CdABbGQ2OIkYcH7
t3SJzvpYKG/RuhUQ+1b16SIU5kjqXw==
=eTq4
-----END PGP SIGNATURE-----

--Sig_/WxqvbzyzqnU3.4_FsoNBV2k--

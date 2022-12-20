Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543C06520E4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiLTMo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiLTMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:44:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA29216596;
        Tue, 20 Dec 2022 04:41:15 -0800 (PST)
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FBE4660035B;
        Tue, 20 Dec 2022 12:41:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671540074;
        bh=vcofDtvgGSQwoQWEQaw0YQls3ZMtwb+RUV1w+HRNNzM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RbQ0jlpvFUTW+nC36fMlzEhALhExfUY9AiIDaVgBR5KEP20Xk3ecswSXfxnSDotS3
         A2X/HVVzgMqDG6iDR5VyQOHpa2q+r6/Kwfhr6RRUvq0YCR6ZrKYnyA2JhHKOSMUVMz
         NPomXdhkFaC5hNtGNx7PD3p732BLexKTtH40QGVCgibVCofVC34EcFBbb+dzwbIdKQ
         fdJaGG2Sz/vPQQLoEinluusPYHz8k0VQegEFSxg1ccAqyH0QLGpTImXZiTg98jZz63
         0O+QjqV1MnoPX3IGSr+8mMls0tFaRdXHn5pl3IPR2jbaNBIkkeHSQh2ckq+DPPlX//
         d3usQsgwsCeIQ==
Received: by beast.luon.net (Postfix, from userid 1000)
        id C97E35E817D0; Tue, 20 Dec 2022 13:41:11 +0100 (CET)
Message-ID: <8d874a1bb2ba974cdaed5fe47c1b92c76ac3e364.camel@collabora.com>
Subject: Re: [PATCH 0/3] Improve K3-am625-sk support (USB, MMC)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Cc:     martyn.welch@collabora.com, Nitin Yadav <n-yadav@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Dec 2022 13:41:11 +0100
In-Reply-To: <d882df13-33e6-db53-e59e-53419db4255d@ti.com>
References: <20221216143624.23708-1-sjoerd@collabora.com>
         <d882df13-33e6-db53-e59e-53419db4255d@ti.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Vignesh,

On Tue, 2022-12-20 at 17:02 +0530, Vignesh Raghavendra wrote:
> Hi,
>=20
> On 16/12/22 8:06 pm, Sjoerd Simons wrote:
> >=20
> > This series picks up a few patches from the TI BSP tree that
> > unfortunately didn't make it upstream thusfar.
...
> > 0:
> > https://lore.kernel.org/lkml/f714ee55-ef47-317d-81b9-57020dda064b@ti.co=
m/T/
> >=20
> >=20
> Really appreciate porting and posting these patches to mainline!
> Wondering what tree are these patches based on?
> I cannot apply cleanly on linux-next.

These are against Linux 6.1 ; I'll happy rebase agains next for the
next round or is there a specific tree you prefer to base against?

Regards,
--=20
Sjoerd Simons
Collabora Ltd.

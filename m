Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6182C6EBA87
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDVRDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 13:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDVRDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 13:03:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90061701;
        Sat, 22 Apr 2023 10:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8596C608D4;
        Sat, 22 Apr 2023 17:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1EDC433D2;
        Sat, 22 Apr 2023 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682183018;
        bh=gc26S9cqU0PFbOm6w14GURCD59L4xJO5grpgxyojgJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dq06XiDSKLsbC6r+geZkon6RS4Gml0+eKO612trHFM2XeLVk/zJovGTCIdQtK8V35
         eqB49+I6mvPnSTzeoXnlWLmu89E1fS8y9IDSGou0gJmU18JiGoCqM+iKhhe1OAaIMy
         UlvY4IJn/BoT2sZxWoHpN/WJZLGROvb/QdhCBSuLfoUB3sj6AtYmcRkFUixkRtND96
         12uD6BGbjJGHQKh940aSaAmNnT6W04KYn0298lmUkYhr7zw/fZt51RuovY9HQy5waG
         yd8X8/G9yi89orv+HT0ami/fgMPeF+H/HXnAptmdAMtRWu6BxLmdEjFtvKZsXTEcOP
         s45mn3KkU7iJw==
Date:   Sat, 22 Apr 2023 18:19:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hermes Zhang <chenhuiz@axis.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        "Jean-Baptiste Maneyrol" <jmaneyrol@invensense.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: mpu6050: Add icm20600
 bindings to mpu6050
Message-ID: <20230422181914.24810cc0@jic23-huawei>
In-Reply-To: <d92007ac-61e1-4328-f387-2b4e394977a8@axis.com>
References: <20230421071630.524822-1-chenhuiz@axis.com>
        <20230421071630.524822-3-chenhuiz@axis.com>
        <b406dd13-fedb-0e6e-2f1b-ad3ebb617dc4@linaro.org>
        <d92007ac-61e1-4328-f387-2b4e394977a8@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Apr 2023 14:14:49 +0800
Hermes Zhang <chenhuiz@axis.com> wrote:

> =E5=9C=A8 2023/4/21 16:23, Krzysztof Kozlowski =E5=86=99=E9=81=93:
> > Didn't we start switching to compatible groups of devices? This looks
> > compatible with 20602. =20
>=20
> Hi Krzysztof,
>=20
> Sorry, I may not aware of this. Could you give some more info about the=20
> compatible groups? Yes, the icm20602 is quite similar as icm20600.

If it's compatible enough that a device tree that lists
compatible =3D "invensense,icm20600", "invensense,icm20602"
would work correctly with an old kernel by first checking for invensense,ic=
m20600
then falling back to invense,icm20602 then it should be listed with that fa=
llback.

See the existing block that covers the fallback form icm20608d to icm20608


       - items:
          - const: invensense,icm20608d
          - const: invensense,icm20608

Note it is fine if the driver 'warns' that it's found a WHOAMI value it doe=
sn't
know as long as it then goes on and works correctly.  Thus there can't be
any incompatibilities between the two parts when we consider the functional=
ity the
driver implements today.  If we add features in future that aren't compatib=
le, that's
fine because we will be matching against the more specific compatible you a=
re
adding here.

Jonathan



>=20
> Thanks & Best Regards,
>=20
> Hermes
>=20


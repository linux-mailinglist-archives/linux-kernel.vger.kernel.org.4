Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D304E6AC5B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjCFPm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCFPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:42:51 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC351FCC;
        Mon,  6 Mar 2023 07:42:15 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B37C4240009;
        Mon,  6 Mar 2023 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678117328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+e/cUqhhX/VA/vt11SGpFMg3F+XphXS1/Hro38i4j0=;
        b=Y7pgUr7QHXRIZk9xlTpsJCwpUTN6J93viTIZPEPSAu5ZhECKJ2jOfMP9JFBqxLQNuei34Z
        tKLWB7FoAqSYE1PTY6ROhpqYUfgTlToyScGeKDgIVmUER65rZTwF9S1kKKWTu/P2Wrno5b
        fjLhWcgMRzdMyJCOtqls3mPQbmf6lgBIJJzqhScg+Vc5VY+ufSUGvRYmuaHL/vScl+JD+h
        5iPYWJhDzoQX5TLjFPLfFYWP8nErrdcYz0KDIE1sjeJcH67gkRx79N2SEaiVlz/MkMJK4L
        UwV37a+dm/zpn1w7yGKYoqjcPjwxlcQ7wOcVaX2spOpnPyfxvvOgD5jlmJbnAg==
Date:   Mon, 6 Mar 2023 16:41:58 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 01/10] dt-bindings: soc: fsl: cpm_qe: Add TSA
 controller
Message-ID: <20230306164158.767e6420@bootlin.com>
In-Reply-To: <20230226174833.GA76710-robh@kernel.org>
References: <20230217145645.1768659-1-herve.codina@bootlin.com>
        <20230217145645.1768659-2-herve.codina@bootlin.com>
        <20230226174833.GA76710-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
On Sun, 26 Feb 2023 11:48:33 -0600
Rob Herring <robh@kernel.org> wrote:

[...]
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  '#fsl,serial-cells': =20
>=20
> #foo-cells is for when there are differing foo providers which need=20
> different number of cells. That's not the case here.
>=20

Ok, I will remove the #fsl,serial-cells property on the next iteration.

On the next series iteration, I will also remove the #fsl,chan-cells proper=
ty
present later on a patch related to the QMC binding. The #fsl,chan-cells ne=
eds
to be removed exactly for the same reason.

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    const: 1
> > +    description:
> > +      TSA consumers that use a phandle to TSA need to pass the serial =
identifier
> > +      with this phandle (defined in dt-bindings/soc/fsl,tsa.h).
> > +      For instance "fsl,tsa-serial =3D <&tsa FSL_CPM_TSA_SCC4>;". =20

Thanks for the review.
Herv=C3=A9

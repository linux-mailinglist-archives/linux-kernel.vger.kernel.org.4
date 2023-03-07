Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB5C6AF0D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjCGSgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCGSef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:34:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B16A92C5;
        Tue,  7 Mar 2023 10:26:47 -0800 (PST)
Received: from [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820] (unknown [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DFA196602ED2;
        Tue,  7 Mar 2023 18:26:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678213588;
        bh=u6mJpttFNSifR4K1NDRG4h+hJGm9NmqmYCl2Fbq1kzI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ds0gjBfyKIZ+m7yI8L5IG9U749Wc6eqcDlHJ3x4hGYnSXOxZHWGOxMr2k++fFhhb7
         4pF+ryVZIhGJkCR1bI8Wz8/1JpSru79h4AijS/u15zKpZY+QDd78HWAOZ+aiCg0Qeh
         6AC6OT7IylvBuwdDOx+vXbCWsHSpdGtar9Cfy0TUAy4aE253TlcDT+r5dnxJtSgvIR
         Ujkwzw6CLbA9LmI7vy01eR3WadHUfQEuuz7faGdstguTSZMihA04bM8oird5kLcsx3
         my+P41+1UrkAagw2B6VBVtuWejbMuPVaR95k7kAsmWwspZatdZUEjv5WEm3hA3YsLw
         OCdpZbCcV8f0A==
Message-ID: <c2bebcbf9d463d656ae69d489e0e5a88f2540c2e.camel@collabora.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: remoteproc: k3-m4f: Add bindings
 for K3 AM64x SoCs
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hari Nagalla <hnagalla@ti.com>
Cc:     kernel@collabora.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 07 Mar 2023 18:26:25 +0000
In-Reply-To: <5c9130de-5092-9446-6e00-d86de7dcd6b4@linaro.org>
References: <20230302171450.1598576-1-martyn.welch@collabora.com>
         <20230302171450.1598576-2-martyn.welch@collabora.com>
         <5c9130de-5092-9446-6e00-d86de7dcd6b4@linaro.org>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-03 at 09:06 +0100, Krzysztof Kozlowski wrote:
> On 02/03/2023 18:14, Martyn Welch wrote:
>=20
> > +
> > +=C2=A0 mboxes:
> > +=C2=A0=C2=A0=C2=A0 description: |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OMAP Mailbox specifier denoting the sub=
-mailbox, to be used
> > for
>=20
> OMAP?
>=20

This device uses a mailbox compatible with the OMAP Mailbox, as defined
in Documentation/devicetree/bindings/mailbox/ti,omap-mailbox.yaml.

I note that documents title reads "TI OMAP2+ and K3 Mailbox devices".
I'll drop the "OMAP" here.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 communication with the remote processor=
. This property
> > should match
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with the sub-mailbox node used in the f=
irmware image.
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 memory-region:
> > +=C2=A0=C2=A0=C2=A0 description: |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phandle to the reserved memory nodes to=
 be associated with
> > the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 remoteproc device. There should be at l=
east two reserved
> > memory nodes
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defined.=20
>=20
> Don't repeat constraints in free form text.
>=20
> > The reserved memory nodes should be carveout nodes, and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 should be defined with a "no-map" prope=
rty as per the
> > bindings in
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Documentation/devicetree/bindings/reser=
ved-memory/reserved-
> > memory.yaml
> > +=C2=A0=C2=A0=C2=A0 minItems: 2
> > +=C2=A0=C2=A0=C2=A0 maxItems: 8
> > +=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: region used for dynamic =
DMA allocations like
> > vrings and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vring buffers
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: region reserved for firm=
ware image sections
> > +=C2=A0=C2=A0=C2=A0 additionalItems: true
>=20
> And what is the purpose of the rest of reserved nodes?
>=20

Up to 8 regions can be specified with their purpose determined by the
firmware running on the M4F core. The suggestion (and the
implementation in the example firmware) is to use the first 2 regions
as defined above for remoteproc with the others available to be used
for other purposes if necessary. The address translation module used
can cope with up to 8 regions.

>=20

Martyn

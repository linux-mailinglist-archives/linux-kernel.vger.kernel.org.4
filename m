Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1B6C7CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjCXKcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjCXKb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:31:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30344212AB;
        Fri, 24 Mar 2023 03:31:50 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820] (unknown [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A37106603110;
        Fri, 24 Mar 2023 10:31:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679653908;
        bh=7oCSXyMGt70aqMG4sN//uCrCB0AjLT9Q3il4Ecy5Yww=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Lqhx74RCE+TtgyCIS1LLFdDkavrjt12MVGuaSuJsjBR0Tt+tcykEuH8oFJ46CPVDq
         oYH3VeACkqr9u5mmeyW4KYgOv83KRvDFGreY0aH4MmM/7gOIN2ZxOmO7maYKZ3vhkG
         hdabAD7rHXVpAu3QrMhLiQMXOflRWQSyi0o6RVmTV4plh75WvprqvW08KH9lyfGA4d
         oguYTn/nwag4L2IGycpiv6JKMG8Hw2ifS9HC6koBPQ1sc77TLviQUYLQbeiChbWdY6
         0dZlW1eNP6Um4C7wXsBI1VOaxaQdaXBIHtFLl2RIUgeQveQBHs9P7U+HWMCaWlhnea
         CRmHg0a9ATLJA==
Message-ID: <696985ccf4a1b85a478a980fdbd3cc31fb69619a.camel@collabora.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: remoteproc: k3-m4f: Add bindings
 for K3 AM64x SoCs
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Hari Nagalla <hnagalla@ti.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Mar 2023 10:31:46 +0000
In-Reply-To: <20230310154145.GA1882384@p14s>
References: <20230302171450.1598576-1-martyn.welch@collabora.com>
         <20230302171450.1598576-2-martyn.welch@collabora.com>
         <20230308205833.GA1768401@p14s>
         <8662e02b-9d28-8ffa-6ec2-5cc6348933fb@ti.com>
         <20230310154145.GA1882384@p14s>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-10 at 08:41 -0700, Mathieu Poirier wrote:
> On Thu, Mar 09, 2023 at 05:18:01PM -0600, Hari Nagalla wrote:
> > On 3/8/23 14:58, Mathieu Poirier wrote:
> > > > +required:
> > > > +=C2=A0 - compatible
> > > > +=C2=A0 - reg
> > > > +=C2=A0 - reg-names
> > > > +=C2=A0 - ti,sci
> > > > +=C2=A0 - ti,sci-dev-id
> > > > +=C2=A0 - ti,sci-proc-ids
> > > > +=C2=A0 - resets
> > > > +=C2=A0 - firmware-name
> > > > +=C2=A0 - mboxes
> > > The 'mboxes' property is marked as required but the description
> > > section above
> > > clearly state the M4F can operate without IPC.
> > >=20
> > Well, when the M4F is used as a safety processor it is typically
> > booted from
> > SBL/u-boot and may isolate the MCU domain from main domain/A53 to
> > function
> > in higher safety level. In these scenarios there is no remote proc
> > handling
> > of M4F life cycle management (LCM) and IPC. But, on the other hand,
> > when the
> > M4F is used as a non safety processor its LCM is handled by remote
> > proc(main
> > domain) and mailboxes for IPC are required.
>=20
> Well, what you wrote above is pretty much explained verbatim in the
> "description" section of the bindings.=C2=A0 Mailboxes are optional and a=
s
> such
> should not be found under the "required" section.
>=20

Which means the memory regions are also optional as in the isolated
case they're be no communications with the main domain.

Martyn

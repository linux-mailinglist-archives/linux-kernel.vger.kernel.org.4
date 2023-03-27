Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F636CA790
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjC0O2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjC0O1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:27:41 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727955A3;
        Mon, 27 Mar 2023 07:26:50 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PlZr51Rwfz9t6d;
        Mon, 27 Mar 2023 16:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679927189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rOAJ6mYjJCPRKt+lu0rKWy0FC1qYxXDWw3444VdaWE=;
        b=y8eULv06lBVmn/GXaB7wAZ9IFTinKqgYb15FTQZccKVKcLhDkG6AxkYJaLPLCjYLDlACKv
        UCbohsS1oFS0e9/OdkC9owIEycxFqJeP2DV6ZunxEyZTlDL+bPb87smd+qWTeCm+6e1gps
        R/lio4sh1rcYq8OTC82qVq5//wc7qNTu5yr/m5qhSxhESrNl0MIDHAWL6c/7WiuX8D3x2J
        yNdRK0b/ABEnblPJfFtZybpEutoYT3Hn0jhNuvNrAySvn9SBgEzjq87FNzPCwR8Ye4z1vc
        e10P+LN6LFcYsW4RyPlB3q/CXpzCamf4z0Oh4SkFcBwDNUrlYLhjFH6XAxyHRQ==
Message-ID: <1f3fb4bd5387c8d69a6eb068fb773b9273081c13.camel@dylanvanassche.be>
Subject: Re: [PATCH 1/2] dt-bindings: misc: qcom,fastrpc: add
 qcom,assign-all-memory property
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Date:   Mon, 27 Mar 2023 16:26:25 +0200
In-Reply-To: <44904ffc-83d4-1137-3479-737a81b31d16@linaro.org>
References: <20230325134410.21092-1-me@dylanvanassche.be>
         <20230325134410.21092-2-me@dylanvanassche.be>
         <883c3c48-c6e5-556d-431f-e92592b9106a@linaro.org>
         <b75b92bf64b55ba0ace0fbff65955c838a294dec.camel@dylanvanassche.be>
         <44904ffc-83d4-1137-3479-737a81b31d16@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, 2023-03-27 at 14:22 +0200, Krzysztof Kozlowski wrote:
> On 27/03/2023 13:37, Dylan Van Assche wrote:
> > Hi Krzysztof,
> >=20
> > On Sun, 2023-03-26 at 10:55 +0200, Krzysztof Kozlowski wrote:
> > > On 25/03/2023 14:44, Dylan Van Assche wrote:
> > > > Document the added qcom,assign-all-memory in devicetree
> > > > bindings.
> > > >=20
> > > > Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> > > > ---
> > > > =C2=A0Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6
> > > > ++++++
> > > > =C2=A01 file changed, 6 insertions(+)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > > > b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > > > index 1ab9588cdd89..fa5b00534b30 100644
> > > > --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > > > +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > > > @@ -57,6 +57,12 @@ properties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Virtual machine IDs for remote=
 processor.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 $ref: "/schemas/types.yaml#/definitions/ui=
nt32-array"
> > > > =C2=A0
> > > > +=C2=A0 qcom,assign-all-mem:
> > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Assign memory to all Virtual machin=
es defined by
> > > > qcom,vmids.
> > >=20
> > > This (neither commit msg) does not explain why this is needed and
> > > actually does not sound like hardware-related property.
> >=20
> > This is made a separate property to toggle different behavior in
> > the
> > driver if it is needed for some FastRPC nodes.=20
>=20
> Bindings are not for driver behavior.
>=20
> > Downstream does guard
> > this with a property 'restrict-access' as well, see [1] for a
> > random
> > SDM845 downstream kernel. On SDM845, this property is not present,
> > thus
> > the IF block runs. On SDM670, this property is present, then the IF
> > block is skipped. That's why I opt for this property to have this
> > behaviour conditionally. I'm not sure how to explain it better
> > though.
>=20
> Still you described driver... Please come with something more
> hardware
> related.

So just updating the description is enough then?

As this is all reverse engineered, I have no access to the
documentation of FastRPC, so best effort:

"""
Mark allocated memory region accessible to remote processor.
This memory region is used by remote processor to communicate
when no dedicated Fastrpc context bank hardware is available=C2=A0
for remote processor.
"""

Is this the description that is 'more hardware related'?

Kind regards,
Dylan Van Assche

>=20
> Best regards,
> Krzysztof
>=20


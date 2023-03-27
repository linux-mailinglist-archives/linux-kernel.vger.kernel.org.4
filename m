Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFF76CA297
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjC0LhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjC0LhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:37:15 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3744487;
        Mon, 27 Mar 2023 04:37:12 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PlW4f3Kz8z9sWL;
        Mon, 27 Mar 2023 13:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679917026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZriSGIooLktT9ELrcWQe/LSK859gMi66zy5pb+cbcQ=;
        b=KmjME9p2gnITYFFFtVviHLZ6DcG6LE9+yCHJNmMCaaRW9pLiRvyLAIuTJC3duxDNURXTdl
        8RBVHHs2Q/ObTYcYtjoUOs4SyaPX6PGk4P/9j3XCXPVRnOjyIRfud6l8neSLDapKXSRptq
        JGUVi3b/B1kyTpy5Y1WhyhkRzTZ+pQEa2DDlPlkawVUs71fa76EJq+u/KcviC2icG+AJng
        ShU3dlMruLlpmqtc9xac+Y6mRvZT3bWFnH3bvE2uxgvHvr5Y/WF8GBrO669ynEtqhxCcxf
        5hF3NzuREb+EPV6jwN5QuBa14tVc1PzGEAVjCJsy52T9sVHbKCJa9KwyhjeW/g==
Message-ID: <b75b92bf64b55ba0ace0fbff65955c838a294dec.camel@dylanvanassche.be>
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
Date:   Mon, 27 Mar 2023 13:37:03 +0200
In-Reply-To: <883c3c48-c6e5-556d-431f-e92592b9106a@linaro.org>
References: <20230325134410.21092-1-me@dylanvanassche.be>
         <20230325134410.21092-2-me@dylanvanassche.be>
         <883c3c48-c6e5-556d-431f-e92592b9106a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4PlW4f3Kz8z9sWL
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, 2023-03-26 at 10:55 +0200, Krzysztof Kozlowski wrote:
> On 25/03/2023 14:44, Dylan Van Assche wrote:
> > Document the added qcom,assign-all-memory in devicetree bindings.
> >=20
> > Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> > ---
> > =C2=A0Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6
> > ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > index 1ab9588cdd89..fa5b00534b30 100644
> > --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > @@ -57,6 +57,12 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Virtual machine IDs for remote pro=
cessor.
> > =C2=A0=C2=A0=C2=A0=C2=A0 $ref: "/schemas/types.yaml#/definitions/uint32=
-array"
> > =C2=A0
> > +=C2=A0 qcom,assign-all-mem:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Assign memory to all Virtual machines d=
efined by qcom,vmids.
>=20
> This (neither commit msg) does not explain why this is needed and
> actually does not sound like hardware-related property.

This is made a separate property to toggle different behavior in the
driver if it is needed for some FastRPC nodes. Downstream does guard
this with a property 'restrict-access' as well, see [1] for a random
SDM845 downstream kernel. On SDM845, this property is not present, thus
the IF block runs. On SDM670, this property is present, then the IF
block is skipped. That's why I opt for this property to have this
behaviour conditionally. I'm not sure how to explain it better though.

Any feedback is appreciated, thanks!

Kind regards,
Dylan Van Assche

[1]
https://github.com/SHIFTPHONES/android_kernel_shift_sdm845/blob/sos-3.x/dri=
vers/char/adsprpc.c#L4615-L4631

>=20
> > +=C2=A0=C2=A0=C2=A0 type: boolean
> > +
> > +
>=20
> Do not add double blank lines.
>=20
> > =C2=A0=C2=A0 "#address-cells":
> > =C2=A0=C2=A0=C2=A0=C2=A0 const: 1
> > =C2=A0
>=20
> Best regards,
> Krzysztof
>=20


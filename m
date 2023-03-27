Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCBF6CA9F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjC0QFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjC0QFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:05:49 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A53FD;
        Mon, 27 Mar 2023 09:05:45 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Pld2P5b4fz9sm8;
        Mon, 27 Mar 2023 18:05:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679933141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZXOuRUfihj3J9liLR8d+gKth5ezGtydGcMxJlFjyCM=;
        b=cfDNI7VWXRQ6vU0D3q4ei08NGh4lldtz5DdIpgqImxxGRRxVkiQInPQWyl7EiHW+T+tdAA
        k5Z3Qx0QU6AwtxyJ1U+3majbVMynW6k1+hMyNMF/zhgKCay3lUDEZXqJY/BpVM+gxDVsNd
        f38ffcKjUnQvhhhye7RNjk5mNGZszdF7jLw+T6d9dO5cBeSSBP6QRAGhVu4bxmdxgCkSVZ
        Yp00HHhjjB3nACHYoh/OM2Dz03xosOa9Gf7QfLOYMn+iNs0iPDYGpKnleJa4rtHZXcmLlH
        TAEGYKkF0owzA5aukQ9GwoYvQz6RxnCh9CbCm3QxTeHWikoiwQQkCubRx3SWXg==
Message-ID: <add6870af3eb9fa91512c67091b985e5d0ef8848.camel@dylanvanassche.be>
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
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Date:   Mon, 27 Mar 2023 18:05:24 +0200
In-Reply-To: <c540f72b-3fc9-f5c0-0cf4-20903e5f4625@linaro.org>
References: <20230325134410.21092-1-me@dylanvanassche.be>
         <20230325134410.21092-2-me@dylanvanassche.be>
         <883c3c48-c6e5-556d-431f-e92592b9106a@linaro.org>
         <b75b92bf64b55ba0ace0fbff65955c838a294dec.camel@dylanvanassche.be>
         <44904ffc-83d4-1137-3479-737a81b31d16@linaro.org>
         <1f3fb4bd5387c8d69a6eb068fb773b9273081c13.camel@dylanvanassche.be>
         <c540f72b-3fc9-f5c0-0cf4-20903e5f4625@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4Pld2P5b4fz9sm8
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry & Krzysztof,

On Mon, 2023-03-27 at 16:36 +0200, Krzysztof Kozlowski wrote:
> On 27/03/2023 16:26, Dylan Van Assche wrote:
> > > Bindings are not for driver behavior.
> > >=20
> > > > Downstream does guard
> > > > this with a property 'restrict-access' as well, see [1] for a
> > > > random
> > > > SDM845 downstream kernel. On SDM845, this property is not
> > > > present,
> > > > thus
> > > > the IF block runs. On SDM670, this property is present, then
> > > > the IF
> > > > block is skipped. That's why I opt for this property to have
> > > > this
> > > > behaviour conditionally. I'm not sure how to explain it better
> > > > though.
> > >=20
> > > Still you described driver... Please come with something more
> > > hardware
> > > related.
> >=20
> > So just updating the description is enough then?
> >=20
> > As this is all reverse engineered, I have no access to the
> > documentation of FastRPC, so best effort:
> >=20
> > """
> > Mark allocated memory region accessible to remote processor.
> > This memory region is used by remote processor to communicate
> > when no dedicated Fastrpc context bank hardware is available=C2=A0
> > for remote processor.
>=20
> This description does not explain here anything. The memory region is
> already accessible without this property.
>=20
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.
>=20
> Remember that any arguments to downstream are not really good
> arguments.
> Their design choices and bindings are usually totally not acceptable.
> They simply embed whatever driver needs in DT - policies, system
> configuration, driver behavior...
>=20
> Also, Dmitry made here good point.
>=20
>=20

I agree, downstream is not doing great on being upstreamable.
Thanks Dmitry, your explanation makes it pretty clear what I should
figure out. This helps a lot! As far as I know, this assignment is only
skipped when the sensors are not on the SLPI but on the ADSP e.g.
SDM670, thus mid range SoCs. So reading these comments, this looks more
like 'driver behavior' which should not end up in bindings as mentioned
above. As I now understand the problem with this property, I will
rework it for v2 and drop it. This is only done for the SLPI so by
guarding it with a domain ID check we should be able to avoid the
property in the bindings.

Thanks for the feedback & patience! I really learned a lot!

Kind regards,
Dylan Van Assche

>=20
> Best regards,
> Krzysztof
>=20


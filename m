Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8146D6A7BC1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCBHS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjCBHSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:18:50 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CC0D309;
        Wed,  1 Mar 2023 23:18:45 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id BC01D3200C42;
        Thu,  2 Mar 2023 02:18:43 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 02 Mar 2023 02:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1677741523; x=1677827923; bh=W1hdcOQxGQU0ebLTR8DQVhMf/+cpeg+06LD
        xY0b8rGw=; b=D+YIcU2j34lGBuWzqi9hNCT5A321ctynb+rncz9FW+0FgZOq6m5
        FTnJikUR9ynPIOyo+1Ua5y3jzZRENtQwP797kUDYe3Kmk49JwCXo3oVvRTenrWUP
        OJbFYgzmmEB/VV3EbDjsHFrBAB4230wjWSpsmXdwA0iSiCHkR2ct34XoMjjYplIR
        B6dfgGGG076O9Qre8Rde5xxqaddelftSPMYnsw8iiiG1umshV7yQmrYgXhwKw4F1
        SBwpORK03D1MgrdeXLP1t0SeCEWt76Ifr6xYBN7HcY6poqoh1xY522AGa541EZBB
        vr36Qg85SUGpvk6Eo5GRsoX0zXm9qg1jrJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677741523; x=1677827923; bh=W1hdcOQxGQU0ebLTR8DQVhMf/+cpeg+06LD
        xY0b8rGw=; b=DOmMZdkdzJ87q/MWvxhvyaY1AObra5az/eCIi4Bw/KBikhfnBj5
        1skrdule4Wj9kMPa41ZdzbFrcpqOh9oiCUZSuvcUwHf2vezqpLHam9CkD4vat61k
        DRDahFMDr9LqXAokhyBwHpHWY1Kg8YZSipJALT22jGRUWYQYGvcJ+iUwNZ7wBHMK
        ebielb1tj6m7fxWw/aNvRONJFY9mkCpWz4tCJJ/r3bf468b8kISoIdRVyLpk9ZDD
        L8w7b7Opfvd0PscELJbvp8lPiZ7VMiNHANLs3xZPBPElXkj8IWHw1/lNYIDGYcXN
        0B+AtayAY5Up3OhYSsV0DbIcvPWQtCl+zWA==
X-ME-Sender: <xms:000AZLSiIuhAjVGIx2lFU7JMDsEjBq50CfKOYYTj7iKBmRbiLw1GOA>
    <xme:000AZMwa01LBWHdjEEsfQ-29MlMKRLGLRxF9qEw-ihtBRKy_0S4EFyp7rbe5qu0i8
    7OFgKWVYtnJK-WJYWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeliedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:000AZA0JZoGQs_3zE-H29P78oQ7O7UdcjxLtw7YK_-e7n_ldrLSUQQ>
    <xmx:000AZLD0cqeG6pY6GuiKq_0Rk-eseM-kDuWW8DigquEJBrlFgvPH1g>
    <xmx:000AZEgTTAIV2GAEOnqQq1aqjzUU_HZ8Fv5SbDNS8pGgcTKcR9pjRQ>
    <xmx:000AZBZfmFl32G7ZevTse5RwWb53QCHt4kNPQG5tth3yf4iuc2WBQQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0A42BB60086; Thu,  2 Mar 2023 02:18:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <e449e759-ae59-4892-a453-75213d711ae1@app.fastmail.com>
In-Reply-To: <9003dd79-00eb-72d4-18e5-51c0f52833f8@quicinc.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214211229.3239350-4-quic_eberman@quicinc.com>
 <5d67ee67-e63f-1393-1455-bfb6b2ddaeb5@linaro.org>
 <9003dd79-00eb-72d4-18e5-51c0f52833f8@quicinc.com>
Date:   Thu, 02 Mar 2023 08:18:21 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Elliot Berman" <quic_eberman@quicinc.com>,
        "Alex Elder" <alex.elder@linaro.org>,
        "Alex Elder" <elder@linaro.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Prakruthi Deepak Heragu" <quic_pheragu@quicinc.com>
Cc:     "Murali Nalajala" <quic_mnalajal@quicinc.com>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 03/26] gunyah: Common types and error codes for Gunyah
 hypercalls
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023, at 02:40, Elliot Berman wrote:
> On 2/23/2023 1:58 PM, Alex Elder wrote:

>>> +enum gh_error {
>>> +=C2=A0=C2=A0=C2=A0 GH_ERROR_OK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0,
>>> +=C2=A0=C2=A0=C2=A0 GH_ERROR_UNIMPLEMENTED=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D -1,
>>> +=C2=A0=C2=A0=C2=A0 GH_ERROR_RETRY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D -2,
>>=20
>> Do you expect this type to have a particular size?
>> Since you specify negative values, it matters, and
>> it's possible that this forces it to be a 4-byte value
>> (though I'm not sure what the rules are).=C2=A0 In other
>> words, UNIMPLEMENTED could conceivably have value 0xff
>> or 0xffffffff.=C2=A0 I'm not even sure you can tell whether
>> an enum is interpreted as signed or unsigned.
>
> I'm not a C expert, but my understanding is that enums are signed.=20
> Gunyah will be returning a signed 64-bit register, however there's no=20
> intention to go beyond 32 bits of error codes since we want to work on=20
> 32-bit architectures.

This came up recently because gcc-13 changes the rules.

In GNU C, the enum type will have the smallest type that fits all
values, so if it contains a negative number it ends up as a signed
type (int, long or long long), but if all values are positive and at
least one of them exceeds the signed range (e.g. UINT_MAX), it is
an unsigned type. If it contains both UINT_MAX and -1, the enum
type gets changed to a signed 64-bit type in order to fit both.

Before gcc-13, the individual constants have the smallest type
(at least 'int') that fits their value, but in gcc-13 they have
the same type as the enum type itself.

     Arnd

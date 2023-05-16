Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F821704791
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjEPIQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjEPIQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:16:37 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F117E40C1;
        Tue, 16 May 2023 01:16:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6AE155C00EE;
        Tue, 16 May 2023 04:16:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 16 May 2023 04:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684224996; x=1684311396; bh=Mn
        K6iy6XdAXRsa/af1YZKd1tr76Wc4HEowjhsQQ4kQ0=; b=LVWtbtimYv0Ar/butY
        GH8qfTP1xWieWIV5sHR3BjErTXKhb3rCiXg54Cri1QbYyL8eT0kiF+ZUQL+VmX7o
        mk1IFaOAsJ1xcL/FnoqHu/m09YwlT/fQYuwXIN0d/TW75SkT6OpODU6yruMKCcI2
        zrd00ACenAfLrI2xtGZp1o1vZfv2Ne/F5jM/nfx+lC6kv4uYzVhNRBUAQNZ65AVr
        9q+w2iGMAYsxXFPwa7lRIYaWawqwDWxI2g0/AJ741bAMKIkdZGgIsvP39fN7YhjC
        BOZT67/JvCVbkucsJKjK5emdnB18t8NPXUSPicVfPt495I3qwAezbxvmZq6kG1xF
        43QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684224996; x=1684311396; bh=MnK6iy6XdAXRs
        a/af1YZKd1tr76Wc4HEowjhsQQ4kQ0=; b=XCNF9vd62Tr/FSJt9fD7YyLg6b309
        UeRFRepstQvOHBEBtOD3UkaKZIZJQqAhiw5etK2LIyOiBPHWjSUkymXNgVn2jGQA
        yrrhON9HeeMdmIcbx8ywDc1EBQvsLdedY8ZvhWWhfmHLg5XDEYS94wNqW68AhJPP
        d9KIV1Tec6Ms6fqcF0qIzIou8J7dwF+3kqAg9hI0YFKtiPhI/gvOssAd8ugkavYY
        6f2w4eLc6GlF83R2Z5d0EWpd9JFy/RozTyn1a6Cm4kf5uvMmZVb4XgMJf2f+gyx0
        +CYghhDBhWFOdopNNyVywqn1d2BXnikduJU0FEoWhiYFFkS+I8ce+emMg==
X-ME-Sender: <xms:4ztjZJ5SXx_PKnFtakjvWkyXcNlT_jKXXImLrMfcxESmQE-a1JVpgQ>
    <xme:4ztjZG49bnV1uYmlvGEkB2MHqUqk-EaJ89Og0pQuqAVibMRdw6q2rQ20ZhIuVByMD
    MzlMO4Ud0fLwIu7BBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4ztjZAdU6QcOE-FHTCJ6-AYjOJqjclmiZKCls3-Az-imCAhqQga3Ew>
    <xmx:4ztjZCJ9Ls2yWvGHXi3IvkzKh4Z4dkUXXukKgjesC33ncrXXl5jfnA>
    <xmx:4ztjZNKX0zSi8C9rSSYU4u3iwjXKKAdeCSmLoqjYGnUkE6AiTaG7xA>
    <xmx:5DtjZKDCdyz5ZPOABpBgt6kpiA2AJO1WWlwjrxWsOfWdB-sfo98Jmw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C4D55B60086; Tue, 16 May 2023 04:16:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com>
In-Reply-To: <CAA8EJpp2x2OEB2sg+caKmjkDYJp_NJ9mXo85FxTZr-9zRXHNhw@mail.gmail.com>
References: <cover.1683628357.git.quic_schowdhu@quicinc.com>
 <343182748e12b6a4ac57d336405c50e36fc5520c.1683628357.git.quic_schowdhu@quicinc.com>
 <CAA8EJpp2x2OEB2sg+caKmjkDYJp_NJ9mXo85FxTZr-9zRXHNhw@mail.gmail.com>
Date:   Tue, 16 May 2023 10:16:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Souradeep Chowdhury" <quic_schowdhu@quicinc.com>
Cc:     "Andy Gross" <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        "Sibi Sankar" <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V6 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region within
 IMEM
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023, at 13:35, Dmitry Baryshkov wrote:
> On Tue, 9 May 2023 at 13:53, Souradeep Chowdhury
> <quic_schowdhu@quicinc.com> wrote:
>>
>> All Qualcomm bootloaders log useful timestamp information related
>> to bootloader stats in the IMEM region. Add the child node within
>> IMEM for the boot stat region containing register address and
>> compatible string.
>
> I might have a minor vote here. Is there any reason why you have to
> instantiate the device from DT?
> It looks like a software interface. Ideally software should not be
> described in DT (e.g. this can be instantiated from imem
> driver-to-be).

There is nothing wrong with describing firmware in DT, if that
firmware is part of the platform, we do that for a lot of
other bits of firmware.

However, in this specific case, many things are wrong with the
implementation, and neither the DT binding nor the driver
makes sense to me in its current state.

>> +  "^stats@[0-9a-f]+$":
>> +    type: object
>> +    description:
>> +      Imem region dedicated for storing timestamps related
>> +      information regarding bootstats.
>> +
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - enum:
>> +              - qcom,sm8450-bootstats
>> +          - const: qcom,imem-bootstats
>> +
>> +      reg:
>> +        maxItems: 1

If I understand this right, this "qcom,imem-bootstats"
device serves as an indirection to store additional
properties of the system in a memory area, but the description
of that area is more complex than its contents, which
makes no sense to me.

Just create a binding for a firmware node in the devicetree
itself, and put the values in properties of that. The first
stage firmware can still use the same interface, but the
actual loader that assembles the DT can get it out of that
and store it in the properties. With that done, there is also
no need for a kernel driver, as userspace can just get the
values from /sys/firmware/devicetree/ directly.

      Arnd

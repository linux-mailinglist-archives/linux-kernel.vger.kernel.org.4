Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F247649DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiLLLez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiLLLc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:32:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83296465;
        Mon, 12 Dec 2022 03:32:05 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57A09660159C;
        Mon, 12 Dec 2022 11:32:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670844724;
        bh=aWtV/a5hztwYfZNOagzoZHV/7aXlFJiz7TQAx67yg6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxWvTwU5Bjp8OxfxVPnSlPtQpUL9vTnj7PD+8/wEFANQ+vVFr+G2nzIkWQCOmMy3r
         lxsLBtXZfT+VhDj8xCSQn6BR0JTrCDj1TIC0qTJJZ8sVGxI05N8PX02AaiP24FV8wh
         c0wG4XGF6BafjpXkMwy7fCvf1Arfd0yuJhshfQwy4WsMwRUjxTDChqAMV6Tv6omt3F
         OfTpnKcfZ277rOVr4WYz4UjIgGfK5meCqnmOPwcUEKvT84sDMAg5PjQxhE9zC7sgYC
         qVr1pay6JvsXhEOAkaezkncoRuD/CdTSpWvKgfR+gRz25/uvJlB85Et7ZZGtR12Qro
         wgvvqm1PSp0SQ==
Date:   Mon, 12 Dec 2022 12:32:01 +0100
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com, bob.beckett@collabora.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        nas.chung@chipsnmedia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 5/6] dt-bindings: media: wave5: add yaml devicetree
 bindings
Message-ID: <20221212113201.lyn33mzg5ausnh46@basti-XPS-13-9310>
References: <20221207121350.66217-1-sebastian.fricke@collabora.com>
 <20221207121350.66217-6-sebastian.fricke@collabora.com>
 <48d60bd0-4de1-4a5e-eca1-1f8a9303cce0@linaro.org>
 <20221207150925.frotwpm3ukwwlnig@basti-XPS-13-9310>
 <30166f9d-ebfa-ed8b-c08b-ff8e2599161f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <30166f9d-ebfa-ed8b-c08b-ff8e2599161f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,

On 07.12.2022 16:27, Krzysztof Kozlowski wrote:
>On 07/12/2022 16:09, Sebastian Fricke wrote:
>> Hello Krzysztof,
>>
>> On 07.12.2022 13:31, Krzysztof Kozlowski wrote:
>>> On 07/12/2022 13:13, Sebastian Fricke wrote:
>>>> From: Robert Beckett <bob.beckett@collabora.com>
>>>>
>>>> Add bindings for the wave5 chips&media codec driver
>>>>
>>>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>>>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>>>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>>>
>>> What's happening with this patch? Where is the changelog?
>>
>> The changelog is located in the cover letter.
>> https://lore.kernel.org/linux-media/20221207121350.66217-1-sebastian.fricke@collabora.com/
>
>
>Which you did not sent to us... so? How does it help us?

I completely agree, I simply forgot to add the devicetree@vger.kernel.org mail to the list of receivers.

>
>>
>>> Why it is v11 and first time I see it?
>>
>> You actually replied to V10:
>> https://lore.kernel.org/linux-media/20221023085341.s23qinjuw4qls3dn@basti-XPS-13-9310/
>>
>>> And why it is v11 with basic mistakes and lack of testing?!?
>>> I would assume that v11 was already seen and tested...
>>
>> Sorry I don't have a lot of experience with dt-bindings, thank you for
>> highlighting the issues, I will correct them. And I forgot to build the
>> documentation during my testing runs.
>> I took over the patch set from another contributor and as no one
>> complained about the dt-bindings for the last 10 versions, I concentrated
>> my energy on other problems.
>
>Because they were never sent to maintainers...
>
>>
>>>
>>>
>>>> ---
>>>>  .../devicetree/bindings/cnm,wave5.yml         | 72 +++++++++++++++++++
>>>>  1 file changed, 72 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/cnm,wave5.yml
>>>
>>> Wrong directory. It wasn't here at all before, so I am really confused
>>> how this could happen.
>>
>> Thanks for the highlight.
>>
>> I will move it to:
>> Documentation/devicetree/bindings/media/cnm,wave5.yml
>>
>>>
>>> Subject: drop redundant pieces: yaml, devicetree and bindings.
>>
>> I call it:
>>
>> dt-bindings: media: chips-media: add wave5 bindings
>>
>> in V12
>>
>And the rest questions? Lack of response means agreement, which is fine,
>so in v12 questionable parts will be removed?

Yes, I will completely rework this part, thus I try to take all of your
highlights into consideration.

>
>Best regards,
>Krzysztof

Sincerely,
Sebastian Fricke

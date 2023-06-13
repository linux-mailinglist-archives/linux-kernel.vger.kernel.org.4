Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E59E72DC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbjFMINq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbjFMINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:13:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754C4E7D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:13:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so6550343e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686644020; x=1689236020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G10YWCyOXabdWRYrOwBriUlnbhUfH57ylNZgr18R1i4=;
        b=WaoszjIxIcGdErpo/Ws3J6wu8H+teKwGjsY58ggTyi1j4OcLyuRrGUMRcqvMev4Yu3
         Gcdrpltlbm7z9BpRmG7Tjvu37/1Wy6xjnCA7JA0RJP3tngEozD9g35oPR6CavE5vmgVC
         Y0gC2bi+CJNJZxoB6m4lzpdn0lqQDRZhI6OZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644020; x=1689236020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G10YWCyOXabdWRYrOwBriUlnbhUfH57ylNZgr18R1i4=;
        b=EQ3zJ2DbaL74V6OeUpd7bkC4W3NXTP8ukmtARN9eEzHmy60/wPHSGIqyZzGblFlUCc
         YiMIJhezbzkrfdYQ1enKZWak55PiqWv78OsUWvzNZpM9v2Jc9vIDJp+SNnTUGNNuyWBp
         SC3jBW74LYp2HpRH2E/kzVj6WLFVbOA8dWZw0Nkl53C3Unl7jL2byZRG+5CrWd2bDY0D
         zE0+LAT/DEBZI04orOJsturcurJ4kRBmZyn93vdosfqtXeg+r2VM7V4I4ovtQQ3Lv3WA
         i2T2yprHUO7Of4oEXANcy+UQLXq2GJc3ECb818XbO7WA+fwFJlSnFIZasC+oDBqaImwC
         k4rw==
X-Gm-Message-State: AC+VfDwGCshI/vOanoK8gburBFNJS9Rbbh/m1uPEyre5ccs2HrFD7kQw
        kxpce5bK37a5VI8uVyaBQ53Z7Q==
X-Google-Smtp-Source: ACHHUZ4stTV1xejNy4ucGu7g3RAB7hefsykZ9PbdkJLhcOA51SZsZnhuEoz3CIus7pfquxbux2huzg==
X-Received: by 2002:ac2:5b9a:0:b0:4f6:47a2:7bb4 with SMTP id o26-20020ac25b9a000000b004f647a27bb4mr5456456lfn.60.1686644019733;
        Tue, 13 Jun 2023 01:13:39 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w12-20020ac254ac000000b004ec6252aa37sm1704686lfk.116.2023.06.13.01.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:13:39 -0700 (PDT)
Message-ID: <8a5e693f-3024-900a-5f00-ba4fe994e710@rasmusvillemoes.dk>
Date:   Tue, 13 Jun 2023 10:13:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/8] dt-bindings: rtc: Move isil,isl12022 from
 trivial-rtc.yaml into own schema file
Content-Language: en-US, da
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-3-linux@rasmusvillemoes.dk>
 <168657279982.4044345.9896354759743085279.robh@kernel.org>
 <2a2fa3c5-739c-6bcf-3c41-3db1aac5ccca@rasmusvillemoes.dk>
 <20230612142027.GA4185135-robh@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230612142027.GA4185135-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 16.20, Rob Herring wrote:
> On Mon, Jun 12, 2023 at 02:36:03PM +0200, Rasmus Villemoes wrote:
>> On 12/06/2023 14.26, Rob Herring wrote:
>>>
>>> On Mon, 12 Jun 2023 13:30:52 +0200, Rasmus Villemoes wrote:
>>>> Move the isil,isl12022 RTC bindings from trivial-rtc.yaml into its own
>>>> intersil,isl12022.yaml file, in preparation for adding more bindings.
>>>>
>>>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>>> ---
>>>>  .../bindings/rtc/intersil,isl12022.yaml       | 42 +++++++++++++++++++
>>>>  .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
>>>>  2 files changed, 42 insertions(+), 2 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
>>>>
>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml: 'maintainers' is a required property
>>> 	hint: Metaschema for devicetree binding documentation
>>> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
>>
>> Hm ok. Can/should I copy the value from the trivial-rtc.yaml? Alexandre,
>> would that be ok with you?
> 
> Alexandre agreed, but in general the maintainer here should be someone 
> that has the h/w and/or cares about it, not subsystem maintainers.

OK. Right now I have the hardware and care about it because I've been
hired to work on it.

Incidentally, my backlog for this project/product also contains
upstreaming of a new gpiochip driver and DT bindings. I assume I should
just list myself as maintainer in that new .yaml file, even if I can't
promise to have time to review changes and/or even hardware to test on
12 months from now.

Rasmus


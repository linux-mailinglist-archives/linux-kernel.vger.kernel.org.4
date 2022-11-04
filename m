Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A88619A41
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiKDOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKDOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:39:17 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0473A31EF9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:36:58 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 6731B3F6D6;
        Fri,  4 Nov 2022 15:36:56 +0100 (CET)
Message-ID: <7f5218ef-7c68-dc2c-27f8-eeb01ba3813a@somainline.org>
Date:   Fri, 4 Nov 2022 15:36:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v10 3/4] arm64: dts: qcom: sc7280: Add touchscreen and
 touchpad support for evoker
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221104061941.2739938-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221104141515.v10.3.I3ac715e729f6f9b5a3e3001b155df4f9d14e6186@changeid>
 <139c06eb-14b8-10b5-80b7-ba8ec8579846@somainline.org>
 <CAD=FV=VwP_s5y0MVNLs+WGD_=nJtJe7h=n+Xu4Ky5RvgdkAw9Q@mail.gmail.com>
 <b6e8da04-f5bf-8e27-e4b7-3854d4168a08@somainline.org>
 <CAD=FV=Xsd6Do_RGN-F_Ef0uxBOqERNGUjme9nCE6Xu49kTOzcw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <CAD=FV=Xsd6Do_RGN-F_Ef0uxBOqERNGUjme9nCE6Xu49kTOzcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/11/2022 15:32, Doug Anderson wrote:
> Hi,
> 
> On Fri, Nov 4, 2022 at 7:28 AM Konrad Dybcio
> <konrad.dybcio@somainline.org> wrote:
>>
>>
>> On 04/11/2022 15:25, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Fri, Nov 4, 2022 at 2:35 AM Konrad Dybcio
>>> <konrad.dybcio@somainline.org> wrote:
>>>>
>>>> On 04/11/2022 07:19, Sheng-Liang Pan wrote:
>>>>> Change touchpad and touchscreen node for evoker
>>>>> Touchpad: SA461D-1011
>>>>> Touchscreen: GT7986U
>>>> What's the reasoning? Were they changed post r0? Is r0 support
>>>> effectively dropped?
>>>>
>>>> The changes look ok, but I feel like this needs more of a comment in the
>>>> commit msg.
>>> As I understand it r0's toucscreen/touchpad were not right to start
>>> with. We are moving towards getting things upstream sooner and that
>>> means that hardware hasn't always been fully tested out.
>>>
>>> I certainly wouldn't object to a better commit message here, but in
>>> this case there are no real world users (yet) and thus nobody is
>>> really affected by this churn. ...so IMO if the series needs to be
>>> spun for some other reason then the commit message could be updated,
>>> but I wouldn't object to it landing as-is either.
>>
>> If there are no real (read: not-an-internal-devboard) devices using it,
>> then I
>>
>> agree, it's fine to merge as-is.
> 
> I can confirm that. There are no evoker devices in the wild.
> 
> -Doug
In this case:

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Please include explanations like these in the commit message next time.

Konrad

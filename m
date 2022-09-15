Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5E75B942F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiIOGQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 02:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIOGQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:16:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E5C923D1;
        Wed, 14 Sep 2022 23:16:16 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MKc0o-1otYR01EL6-00Kxco; Thu, 15 Sep 2022 08:15:50 +0200
Message-ID: <5b64f4ef-a62e-80df-80a6-3ab52589588b@i2se.com>
Date:   Thu, 15 Sep 2022 08:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/7] clk: bcm: rpi: Add a function to retrieve the
 maximum
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Dom Cobley <popcornmix@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220815-rpi-fix-4k-60-v1-0-c52bd642f7c6@cerno.tech>
 <20220815-rpi-fix-4k-60-v1-2-c52bd642f7c6@cerno.tech>
 <20220914155035.88E45C433C1@smtp.kernel.org>
 <50e8f1e8-806a-3599-7cbe-0c7d4bec1c51@i2se.com>
 <20220914180508.0EDD9C433D6@smtp.kernel.org>
 <c221873f-f230-0cce-e120-7e3cc732cf00@i2se.com>
 <20220914182101.92286C433D6@smtp.kernel.org>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220914182101.92286C433D6@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:73zk18NJSgeRmQb2Le65uElTFxV3rTYUitHoBJvve+UbuXV4Lq/
 85iX824f09JsP5yFcmk4/RIlNWFowhB/BncseVNTc6qrcF8txSpdtPq8u5IZ7sCxMfBxpN6
 z0dLdnnRVvhA/8kB41r59RcxfVXw6/fGOAbNnGJw/IZ/o+uELNlnhR6DZZgaOu/RLBvfDUW
 8AOLcw+RuwLR7iUjhmH9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WMDYiwxPIpk=:xpy+5yMq1PfEjq9b17sO70
 q7hFz/LlwEwfONudWfiLk/MW8KhokFIf+78te2ULq+n3phlE6U5SHyACBF2ABwWNd8ZAQ2Yx+
 cK8QxpBeYM65D0bSJvAtibGdbWB1vQMEsbDcOo/YRRMOLibpdUaWJOv4FoZ3DuEag1C2TnJtQ
 d8bVQRCor/lCyISpxl/+GKDdVUeGdSOig6YKkZ5QDq+5pbqP1c5uWXKM3vjhjU9Fbec0WKXib
 gK4kJi/avNqHK/Mvd+vTZ+Lm/lLykciLtydrkKoUeF+/Ap37BSB1e7Be9+unCpbXtVNJTAVx+
 JBdcpCJ8yB3d401FJpYKRBva4gKlTAr+KNSq59+rgvigiUHKWvpmdGyxPqfkSGQmJhIFhgsam
 SNV9gYv2kySJkBk89jeN41NB6Zw8VYuUc3WrRLJHuXyTARFK5RyhA6ZjzlvoeALAEIas7AQiu
 tKVJEjyVbdHjhu4RJ14tkyhuOLDJ/oKngCV0U2QnDSnOi4hnJmKnePBF2MBifGlXfJcR2HPXG
 Q7tY41DwYj0OLlrLp5CvnokoM0yP1Tvyp9vL6rfGb8Iwul/K7efzKMEg0auMAXWrJxeXoIVeq
 ngJBi5FG5ZZ3Lrp0CtQ5h5yUc9QH0StRMiPYA35jiBhqZap/wjfd/drzl+VuDoD5IUsx6d6Li
 zOBzj5zbya2mJdjpxHg4RV+S9rdoadp7w3WZFuocPeVfWUXDg5Cyb1zSJblhH1V+nk3KVTAo2
 8/e1GxDdwZLxHT7BMuV4FrF6AuJKFU2JoH6DWP4GVWGRxVRYQR8RdY2zNeFA/a34Scn58gY8M
 +vS0GCVJETNnb4HXnOK3fpeQF8ANg==
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Am 14.09.22 um 20:20 schrieb Stephen Boyd:
> Quoting Stefan Wahren (2022-09-14 11:09:04)
>> Am 14.09.22 um 20:05 schrieb Stephen Boyd:
>>> Quoting Stefan Wahren (2022-09-14 10:45:48)
>>>> Am 14.09.22 um 17:50 schrieb Stephen Boyd:
>>>>> Furthermore, I wonder if even that part needs to be implemented.  Why
>>>>> not make a direct call to rpi_firmware_property() and get the max rate?
>>>>> All of that can live in the drm driver. Making it a generic API that
>>>>> takes a 'struct clk' means that it looks like any clk can be passed,
>>>>> when that isn't true. It would be better to restrict it to the one use
>>>>> case so that the scope of the problem doesn't grow. I understand that it
>>>>> duplicates a few lines of code, but that looks like a fair tradeoff vs.
>>>>> exposing an API that can be used for other clks in the future.
>>>> it would be nice to keep all the Rpi specific stuff out of the DRM
>>>> driver, since there more users of it.
>>> Instead of 'all' did you mean 'any'?
>> yes
> Another idea is to populate an OPP table in the rpi firmware driver for
> this platform device with the adjusted max frequency. That would be an
> SoC/firmware agnostic interface that expresses the constraints.
Do you mean in the source code of this driver or in the DT?
> I'm
> almost certain we talked about this before.
I'm not sure about the context. Do you mean the CPU frequency handling? 
I remember it was a hard decision. In the end it was little benefit but 
a lot of disadvantages (hard to maintain all theses OPP tables for all 
Raspberry Pi boards, doesn't work with already deployed DT). So yes, i'm 
part of the problem i mentioned before ;-)


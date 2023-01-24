Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7621F678C79
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjAXACq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjAXACo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:02:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C4913B;
        Mon, 23 Jan 2023 16:02:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7125661185;
        Tue, 24 Jan 2023 00:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE1FC433EF;
        Tue, 24 Jan 2023 00:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674518561;
        bh=7ooN/zdnBQml/4YUgBf9nDQlZ6ILhJkNlwfGgWR6VmA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jbyxq8idG+tPMy2tMXwuxpoef3LkIfreIyUgeD3JjkljIzoNsMdqPAZqLJU4GUhYp
         70T72Okc2ZB14Jd/07fCVnF0wY2LEarnwPFurnjcgrZoSMb0o6+tqf7jadxDLPNxjO
         Ixfr9TX2zgsrnSEPcRpvS+Xp+41UEzJK7q/bPhvekqiPC1/wnoa3XQaJ4gB/qGWNDV
         mzqeiQxM7UEtELlcKyNSxTn/engo1HozghiuYd6/KsJ6hWx9UyhNE4yPvDl17UaqXh
         a8+0GqKZExkMk/2AkGP1awpfR4bGQL9f1mDf+AhvoBPCLdJhEnsD8ReJzRfB2rzm1f
         qOkS7xBSrCQ/w==
Message-ID: <2d064077-d4ec-31c4-19a9-4cc9aec8d85b@kernel.org>
Date:   Tue, 24 Jan 2023 02:02:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc7280: Add cpu and llcc BWMON
 (=> interconnect issue)
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20220902043511.17130-1-quic_rjendra@quicinc.com>
 <20220902043511.17130-5-quic_rjendra@quicinc.com>
 <Y8Ggh6RObbB1cxSS@google.com>
 <dc5487d8-d31e-28c6-07e8-8d1ff54a4ba4@linaro.org>
 <Y8baZWlKB9vNGYJw@google.com>
 <754f8193-09ec-8bbf-e0d4-898525dc242f@linaro.org>
 <Y8bfIv6GJU1TD4Dh@google.com> <Y8sIf+41EGJuPQrP@google.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <Y8sIf+41EGJuPQrP@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 20.01.23 23:32, Matthias Kaehlcke wrote:
> On Tue, Jan 17, 2023 at 05:47:14PM +0000, Matthias Kaehlcke wrote:
>> On Tue, Jan 17, 2023 at 06:33:41PM +0100, Krzysztof Kozlowski wrote:
>>> On 17/01/2023 18:27, Matthias Kaehlcke wrote:
>>>>
>>>>>> which would set the initially bandwidths to 0 and determine the actually
>>>>>> needed bandwidth. But since the driver isn't probed the initial
>>>>>> bandwidths stay at INT_MAX.
>>>>>>
>>>>>> This isn't actually an issue with this patch, but how the interconnect
>>>>>> framework deals with devices that are registered on the bus, but aren't
>>>>>> probed (yet). Not sure how this would be best fixed. Georgi, do you have
>>>>>> any ideas?
>>>>>
>>>>> Why the device is not probed (yet)? If it is registered, it will come
>>>>> soon during boot up.
>>>>
>>>> Because CONFIG_QCOM_ICC_BWMON is not enabled for the board in question (see
>>>> above). It could be enabled as a short term mitigtion, however we shouldn't
>>>> require drivers to be enabled just because the DT has a corresponding node.
>>>
>>> It's the same case as with all other interconnect leafs/consumers. The
>>> same behavior if you do not have it enabled, right? If not, I wonder
>>> what is here different?
>>
>> Right, this is a general issue. The problem on sc7280 (and probably other
>> Qualcomm SoCs) is that the interconnect link at full throttle prevents the
>> SoC from entering its low power mode (AOSS sleep) during system suspend.
>> On many boards this might go unnoticed, on herobrine the condition is
>> detected by the embedded controller (EC) and considered a failed suspend,
>> which results in waking up the system.
> 
> I did some hackery to convince the EC to enter/stay in S3, despite AOSS
> no entering sleep mode. That allowed me to take power measurements. With
> the kernel suspended but the AOSS remaining on the power consumption of
> the Qcard is more than 7x higher than when the AOSS enters sleep mode!
> On a Qcard system I can't break the power consumption further down, but
> I think the extra power consumption must be coming mostly from the SoC
> itself, since the kernel and the EC are essentially in the same state as
> during a suspend with AOSS in sleep mode.
> 
> The enormous increase in power consumption suggests that this is a serious
> issue for non-Chrome OS platforms as well. On herobrine and trogdor boards
> we have the 'luxury' of being able to detect that AOSS stays awake (though
> it comes with the caveat that the system can't suspend when that happens).
> On other boards this goes likely unnoticed until someone measures suspend
> power or notices a significant regression in S3 battery life.
> 
> It seems something needs to be done at the interconnect core to fix this.
> Is it really necessary to init all link to max bandwidth? Maybe it is
> needed for certain links, but not all of them? What is the background
> here?

The basic idea here is to do some initial configuration of the system and
enable the interconnect buses until all consumers have probed. Otherwise
it might disable the bus to some hardware, whose driver (module) is not
loaded yet (and didn't had a chance to express it's bandwidth needs).

The max bandwidth is the default, but we can implement the get_bw() for a
given platform to return the current (or initial) value. It would be best
if we could read this value from the hardware, but as this is not possible
on this board, maybe we can implement get_bw() to return something else.

I guess that you see some int_max values in interconnect_summary for the
ebi and llcc nodes that stay forever?

BR,
Georgi

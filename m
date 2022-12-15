Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DF164E2DA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLOVNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLOVMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:12:54 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C201554EF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:12:52 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m29so183695lfo.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDfDciBtjqio6Aoq7U3wQ0SeOeVeyEYOG//I4W1fW38=;
        b=UnXXlWM8X/g13GA0rI98mTs2FE1YDDEZD2wA/ssKIOF7/XkbeKEv9UstQYRte2vasf
         CCLXPKyjny6tD96g+fMA8chLChQ0H+zUN4owm0zKn9Z3unBEJDx5SvAq2g4vrVqK9Q9B
         EM9Kdenx2jK/NYzjrQ632TtlcjJXXNdV4IQXiQPp5p6KcRy7eZugU8zM/FUrsuIetAeX
         a+gZG+sfl+HastflB3ripCVU0UuQhypmXVdetGhSotKDC27MOGnio2dDkWbHd/sLBpH+
         8QGyUISJ24T9E1UAdNlV1uoxRHEDvozJEp5994KysBuRF8rACvgh7XppkYhpllmam8Rs
         0C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDfDciBtjqio6Aoq7U3wQ0SeOeVeyEYOG//I4W1fW38=;
        b=yd7v5X6z8MrOZPlnP9eCK6R1wK5mkv/pl8yeaWRnlLh3/gwyvkOr1XUTJWWD4pguvm
         14aP45ISh/lIRE8JlFoQuNMKW9MV8VvnrDamyFVuV5h3JxDH0+niuTawYLk+X2HeYHOX
         NZQF4Z6Y78N89U/t+E6S2bfxgV4wHoG6fahHl48Ur+GgUeAnKu9Rn8Q4FVxALtDzyZEH
         KP+WyXn2w22/xc1rgF/J3ggyjdXBzigd74yNCIk/eRienDR2sP/ZKkHKJQOuPHCvoDpn
         51WZBbT8iHjH8Gmi0kape4jDH9n3981q0fNrHVjbUMbQg/2lMev2yM1biuie4K9Y/9Wq
         ScYw==
X-Gm-Message-State: AFqh2kp4VbpgE3S9bBwZQo2BEdqWS/dxJngIe1sz/Im+rptHsmeqFa6d
        e8kuzSiy9X+216K6OnkUHYKpNg==
X-Google-Smtp-Source: AMrXdXvcBK0ZRDgSr8CNfaYfL6EIyq4QaWK6endXNbC4xNmAE0sgU4YT/cpftdG7G9hAOqvPWOR0tw==
X-Received: by 2002:a05:6512:1048:b0:4bc:df73:445c with SMTP id c8-20020a056512104800b004bcdf73445cmr1302727lfb.32.1671138770365;
        Thu, 15 Dec 2022 13:12:50 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a15-20020a056512200f00b004a46a9cebe2sm12674lfb.289.2022.12.15.13.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 13:12:49 -0800 (PST)
Message-ID: <011c1ce3-605a-1ad5-d7df-b91e8c6808bc@linaro.org>
Date:   Thu, 15 Dec 2022 23:12:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v12 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@gmail.com, andersson@kernel.org, daniel@ffwll.ch,
        devicetree@vger.kernel.org, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        robh+dt@kernel.org, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1670967848-31475-1-git-send-email-quic_khsieh@quicinc.com>
 <1670967848-31475-3-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52eHYCqxUJqQXoaQ8vyqCk-QfouSun+zUp3yo5DufWbwg@mail.gmail.com>
 <b38af164-08bc-07e7-dfaf-fb4d6d89d7db@quicinc.com>
 <CAE-0n53Cb6TFGfM6AYup5aP4=24j0ujVPi463oVqmzfNV2B4RA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAE-0n53Cb6TFGfM6AYup5aP4=24j0ujVPi463oVqmzfNV2B4RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2022 02:38, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-12-14 14:56:23)
>>
>> On 12/13/2022 3:06 PM, Stephen Boyd wrote:
>>> Quoting Kuogee Hsieh (2022-12-13 13:44:05)
>>>> Add both data-lanes and link-frequencies property into endpoint
>>> Why do we care? Please tell us why it's important.
> 
> Any response?
> 
>>>> @@ -193,6 +217,8 @@ examples:
>>>>                    reg = <1>;
>>>>                    endpoint {
>>>>                        remote-endpoint = <&typec>;
>>>> +                    data-lanes = <0 1>;
>>>> +                    link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
>>>>                    };
>>> So far we haven't used the output port on the DP controller in DT.
>>>
>>> I'm still not clear on what we should do in general for DP because
>>> there's a PHY that actually controls a lane count and lane mapping. In
>>> my mental model of the SoC, this DP controller's output port is
>>> connected to the DP PHY, which then sends the DP lanes out of the SoC to
>>> the next downstream device (i.e. a DP connector or type-c muxer). Having
>>> a remote-endpoint property with a phandle to typec doesn't fit my mental
>>> model. I'd expect it to be the typec PHY.
>> ack
>>>
>>> That brings up the question: when we have 2 lanes vs. 4 lanes will we
>>> duplicate the data-lanes property in the PHY binding? I suspect we'll
>>> have to. Hopefully that sort of duplication is OK?
>> Current we have limitation by reserve 2 data lanes for usb2, i am not
>> sure duplication to 4 lanes will work automatically.
>>>
>>> Similarly, we may have a redriver that limits the link-frequencies
>>> property further (e.g. only support <= 2.7GHz). Having multiple
>>> link-frequencies along the graph is OK, right? And isn't the
>>> link-frequencies property known here by fact that the DP controller
>>> tells us which SoC this controller is for, and thus we already know the
>>> supported link frequencies?
>>>
>>> Finally, I wonder if we should put any of this in the DP controller's
>>> output endpoint, or if we can put these sorts of properties in the DP
>>> PHY binding directly? Can't we do that and then when the DP controller
>>> tries to set 4 lanes, the PHY immediately fails the call and the link
>>> training algorithm does its thing and tries fewer lanes? And similarly,
>>> if link-frequencies were in the PHY's binding, the PHY could fail to set
>>> those frequencies during link training, returning an error to the DP
>>> controller, letting the training move on to a lower frequency. If we did
>>> that this patch series would largely be about modifying the PHY binding,
>>> updating the PHY driver to enforce constraints, and handling errors
>>> during link training in the DP controller (which may already be done? I
>>> didn't check).
>>
>>
>> phy/pll have different configuration base on link lanes and rate.
>>
>> it has to be set up before link training can start.
>>
>> Once link training start, then there are no any interactions between
>> controller and phy during link training session.
> 
> What do you mean? The DP controller calls phy_configure() and changes
> the link rate. The return value from phy_configure() should be checked
> and link training should skip link rates that aren't supported and/or
> number of lanes that aren't supported.

I'd toss another coin into the argument. We have previously discussed 
using the link-frequencies property in the context of limiting link 
speeds for the DSI. There we have both hardware (SoC) limitations and 
the board limitations as in some cases the DSI lanes can not sustain 
some high rate. I still hope for these patches to materialize at some point.

For the DP this is more or less the same story. We have the hardware 
(SoC, PHY, etc) limitations, but also we have the board/device 
limitations. For example some of the board might not be able to support 
HBR3 e.g. because of the PCB design. And while it might be logical to 
also add the 'max bit rate' support to the eDP & combo PHYs, it 
definitely makes sense to be able to limit the rate on the DP <-> 
`something' link.

Now, for all the practical purposes this `something' for the DP is the 
DP connector, the eDP panel or the USB-C mux (with the possible 
redrivers in the middle).

Thus I'd support Kuogee's proposal to have link-frequencies in the DP's 
outbound endpoint. This is the link which will be driven by the data 
stream from the Linux point of view. The PHY is linked through the 
'phys' property, but it doesn't participate in the USB-C (or in the 
connector/panel) graph.

Now let's discuss the data lanes. Currently we have them in the DP 
property itself. Please correct me if I'm wrong, but I think that we can 
drop it for all the practical purposes. Judging by the DP compat string 
the driver can determine if it uses 2 lanes (eDP) or 4 lanes 
(full-featured DP). In case of USB-C when the altmode dictates whether 
to use 2 or 4 lanes, the TCPM (Type-C Port Manager) will negotiate the 
mode and pin configuration, then inform the DP controller about the 
selected amount of lanes. Then DP informs the PHY about the selection 
(note, PHY doesn't have control at all in this scenario).

The only problematic case is the mixed mode ports, which if I understand 
correctly, can be configured either to eDP or DP modes. I'm not sure who 
specifies and limits the amount of lanes available to the DP controller.

-- 
With best wishes
Dmitry


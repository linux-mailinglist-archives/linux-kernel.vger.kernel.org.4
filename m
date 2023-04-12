Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A86E6DFE25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjDLS5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDLS5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:57:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CDA76AE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:56:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a23so16508083lfk.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681325805; x=1683917805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5z6ALtnkqQIU3y5ZY3pIlz4ku7rT3ITrLr0QsFXG2Y=;
        b=aGoJM9p7Ptc4m/eTbdWKOfK5MvWBtp+ARqN8LvN/lk0Ye8pYB+Ze2CTMEuwbDnrSme
         8DTYJMFSX4KhvPlDv2Aj65cf7JYzMmnloEWu77aRIxcuIrUFhg6pDxDtyTJcSI++PgDr
         yh5hzfrTJsjHAsAIbZftnnAphoLPwwq0lK1e/mEsGckdrNbThfVbaHxYJopZQKhjQmXi
         1N5M/dwt+n5kGL0ZLqHDx9iWeFBXeFBvl6uo9CffblpSU/AQYyrL9PX3D/FvN74/7EVj
         NSmk2GmaBZ8jD6R6aJhXecZ3wZE0x0TA3R3qHDnr60t+e6CVTDVPLbpsenAJqNN904Qw
         WhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325805; x=1683917805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5z6ALtnkqQIU3y5ZY3pIlz4ku7rT3ITrLr0QsFXG2Y=;
        b=dkDOFUb40hvJwLrs1CKg6duIKvr3XZREC+f0+JIGcmLF6oimemvixs+Y3tzDdgleGs
         o6blGkk3EVCEZU+DyLfjVLJ54k3kam1nGOIdgJvUanBLOII4eY2mFo0bVNsxg+8SONYX
         15kYRcBZpuW69EHxfdb3cW8kBuI0Ene9y80oCVgzaJCZ2qzDd4LpzHdRdT/5eHZT6ugr
         bFbVYyh+kGxBr4EUPft1o92d6RevAZ/0/XU6k65g6Y++sNjgZH7FV99cTowrfm+081ov
         85iO1qoXxi9ErgM8WjsneUb5md6+ASCXQCI73cmuYgI8iL+RCyolFXVG+ZrAjOtd/QQt
         DVsA==
X-Gm-Message-State: AAQBX9dLtm/0Kq4YD86/UFk9t57UrdT1w4ULrUaYy6Wki9tPvqcKzF/E
        8uZjhEwJuXEWPzwv9D4n+chpkg==
X-Google-Smtp-Source: AKy350ao4rmhhDumVfgkjPVSLhysiqVD+pmuxHRfWRdnCHuI1t2y2OjLNbo71u3JFqF9Gl64lguc3Q==
X-Received: by 2002:ac2:44d2:0:b0:4e8:44a5:6018 with SMTP id d18-20020ac244d2000000b004e844a56018mr4062890lfm.44.1681325805075;
        Wed, 12 Apr 2023 11:56:45 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id r7-20020ac25a47000000b004e846175329sm3108976lfn.202.2023.04.12.11.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 11:56:44 -0700 (PDT)
Message-ID: <83fb974f-2c5a-0792-30f7-a317813f0eed@linaro.org>
Date:   Wed, 12 Apr 2023 21:56:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Freedreno] [PATCH] drm/msm/dpu: add DSC range checking during
 resource reservation
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        freedreno@lists.freedesktop.org, quic_sbillaka@quicinc.com,
        airlied@gmail.com, andersson@kernel.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, dianders@chromium.org,
        vkoul@kernel.org, agross@kernel.org, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        sean@poorly.run, linux-kernel@vger.kernel.org
References: <1681247380-1607-1-git-send-email-quic_khsieh@quicinc.com>
 <qvgbm3wimai3jytnikbcixipvwqn2uywqpg4mn6mjh5atergfx@wa4edsrp7y22>
 <96416911-bca3-b007-b036-1c4463e83aaa@quicinc.com>
 <24c5aa23-9b3c-787c-10aa-e9d5ad91512b@linaro.org>
 <49479b93-b364-d882-7a77-08223a94ed36@quicinc.com>
 <tczt5alqbadkodgorqm4pljpqkn5bc4efpxiy3em7bgu7gqaka@3cdszu4k6rhk>
 <8310d7ce-7ac0-05a6-b95a-c18a498f7644@quicinc.com>
 <szwu75yxcfxeyvfvrsyuoc3jeoaylydwtlzm3cevmpr3zpmfpo@wrdgbf3w3de2>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <szwu75yxcfxeyvfvrsyuoc3jeoaylydwtlzm3cevmpr3zpmfpo@wrdgbf3w3de2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 21:50, Marijn Suijten wrote:
> On 2023-04-12 10:48:18, Abhinav Kumar wrote:
> [..]
>>> The only way to trigger this newly introduced range check is by omitting
>>> the DSC_x constants and manually writing e.g. an out-of-range value 10
>>> here, or setting DSC_NONE.  This is only allowed for interfaces.
>>>
>>
>> Correct, its just working on an implicit understanding that the indices
>> in the catalog
> 
> .. this sentence appears to be incomplete: what did you want to say? ..
> 
>> which might still be right stick to the RM limits.
>>
>> Thats why this is not bad to have.
> 
> What do you mean by "RM limits"?  We have constants in the kernel that
> both define the maximum number of blocks in these arrays and a
> predefined set of ids that block can have.  These are all used in
> constant structs in the catalog, so there's nothing "software" or
> SoC-specific limiting about this (except what is available in the
> arrays).
> 
> [..]
>> I think kuogee just added this to keep it consistent with other checks
>> present in the RM. So I didnt see any harm with that.
> 
> Yep, that's the only reason
> 
>> If he did see an issue, i will let him report that here.
> 
> If so an out-of-bounds constant was hardcoded in dpu_hw_catalog.c.
> 
>> Otherwise, I dont want to spend more time discussing this bounds check
>> when other blocks already have it.
> 
> I'll whip up a patch to clear out the extraneous lookup (assuming there
> is no other reason/dependency for it to be there...) and can follow that
> up with removing these range checks of known-good values in `const
> struct` fields.

Yes, please.

> 
> - Marijn

-- 
With best wishes
Dmitry

